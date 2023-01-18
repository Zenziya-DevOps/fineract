--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements. See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership. The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License. You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, either express or implied. See the License for the
-- specific language governing permissions and limitations
-- under the License.
--

UPDATE `stretchy_report` SET `report_sql` = 'SELECT c.id AS \"id\", \n c.firstname AS \"firstName\",\n c.middlename AS \"middleName\",\n c.lastname AS \"lastName\",\n c.surname AS \"surName\",\n c.display_name AS \"fullName\",\n c.mobile_no AS \"mobileNo\", CONCAT(REPEAT(\"..\", ((LENGTH(ounder.`hierarchy`) - LENGTH(\n REPLACE(ounder.`hierarchy`, \'.\', \'\')) - 1))), ounder.`name`) AS \"officeName\", \n o.id AS \"officeNumber\"\n FROM m_office o\n JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\n JOIN m_client c ON c.office_id = ounder.id\n LEFT JOIN r_enum_value r ON r.enum_name = \'status_enum\' AND r.enum_id = c.status_enum\n WHERE o.id = ${officeId} AND c.status_enum = 300 AND (IFNULL(c.staff_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId})\n GROUP BY c.id\n ORDER BY ounder.hierarchy, c.account_no' WHERE (`report_name` = 'Active Clients');
UPDATE `stretchy_report` SET `report_sql` = 'SELECT \n c.id AS \"id\", \n c.firstname AS \"firstName\",\n c.middlename AS \"middleName\",\n c.lastname AS \"lastName\",\n c.surname AS \"surName\",\n c.display_name AS \"fullName\",\n c.mobile_no AS \"mobileNo\", \n l.principal_amount AS \"loanAmount\", \n (IFNULL(l.principal_outstanding_derived, 0) + IFNULL(l.interest_outstanding_derived, 0) + IFNULL(l.fee_charges_outstanding_derived, 0) + IFNULL(l.penalty_charges_outstanding_derived, 0)) AS \"loanOutstanding\",\n l.principal_disbursed_derived AS \"loanDisbursed\",\n ounder.id AS \"officeNumber\", \n l.account_no AS \"loanAccountId\", \n gua.lastname AS \"guarantorLastName\", COUNT(gua.id) AS \"numberOfGuarantors\",\n g.display_name AS \"groupName\"\n \n FROM m_office o\n JOIN m_office ounder ON ounder.hierarchy LIKE CONCAT(o.hierarchy, \'%\')\n JOIN m_client c ON c.office_id = ounder.id\n JOIN m_loan l ON l.client_id = c.id\n JOIN m_product_loan pl ON pl.id = l.product_id\n LEFT JOIN m_group_client gc ON gc.client_id = c.id\n LEFT JOIN m_group g ON g.id = gc.group_id\n LEFT JOIN m_staff lo ON lo.id = l.loan_officer_id\n LEFT JOIN m_currency cur ON cur.code = l.currency_code\n LEFT JOIN m_guarantor gua ON gua.loan_id = l.id\n WHERE o.id = ${officeId} AND (IFNULL(l.loan_officer_id, -10) = ${loanOfficerId} OR \"-1\" = ${loanOfficerId}) AND l.loan_status_id = 300 AND (DATEDIFF(CURDATE(), l.disbursedon_date) BETWEEN ${cycleX} AND ${cycleY})\n GROUP BY l.id\n ORDER BY ounder.hierarchy, l.currency_code, c.account_no, l.account_no' WHERE (`report_name` = 'Active Loan Clients');
