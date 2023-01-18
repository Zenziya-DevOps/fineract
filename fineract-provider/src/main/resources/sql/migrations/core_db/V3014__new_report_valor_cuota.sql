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

INSERT INTO `stretchy_report` (`report_name`, `report_type`, `report_sql`, `core_report`, `use_report`, `self_service_user_report`) VALUES ('Valor Cuota - Control Migracion', 'Table', 'select c.display_name as \"Nombre cliente\", ia.`Codigo Fenix`, l.id as \"Id de Prestamo\",
pl.name as \"Nombre de producto\", l.principal_amount as \"Monto original\", l.number_of_repayments as \"Nro de cuotas\", 
(select IFNULL(lrs.principal_amount,0)+IFNULL(lrs.interest_amount,0)+IFNULL(lrs.fee_charges_amount,0)+IFNULL(lrs.penalty_charges_amount,0) from m_loan_repayment_schedule lrs where lrs.loan_id=l.id and lrs.installment=1) as \"Valor de cuota\"
from m_loan l
join m_client c on c.id=l.client_id
join m_product_loan pl on pl.id=l.product_id
left join `Informacion Adicional` ia on ia.client_id=c.id
where l.loan_officer_id=${loanOfficerId} OR ${loanOfficerId}=-1', '0', '1', '0');

INSERT INTO `stretchy_report_parameter` (`report_id`, `parameter_id`, `report_parameter_name`) VALUES (((select id from `stretchy_report` where report_name='Valor Cuota - Control Migracion')), '5', 'officeId');
INSERT INTO `stretchy_report_parameter` (`report_id`, `parameter_id`, `report_parameter_name`) VALUES (((select id from `stretchy_report` where report_name='Valor Cuota - Control Migracion')), '6', 'loanOfficerId');

UPDATE `stretchy_parameter` SET `parameter_sql` = 'select lo.id, lo.display_name as `Name` \r from m_office o \r join m_office ounder on ounder.hierarchy like concat(o.hierarchy, \'%\')\r join m_staff lo on lo.office_id = ounder.id\r where lo.is_loan_officer = true\r and o.id = ${officeId}' WHERE (`id` = '6');

