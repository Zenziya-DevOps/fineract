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

ALTER TABLE `m_client_identifier` 
ADD COLUMN `client_office_id` BIGINT(20) NULL;

UPDATE `m_client_identifier` ci SET `client_office_id` = (SELECT office_id from m_client c where c.id=ci.client_id);

ALTER TABLE m_client_identifier
DROP INDEX unique_identifier_key; 

ALTER TABLE m_client_identifier
ADD CONSTRAINT unique_identifier_key UNIQUE (document_type_id,document_key,client_office_id); 
