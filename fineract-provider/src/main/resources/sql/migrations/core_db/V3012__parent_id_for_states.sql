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
SET FOREIGN_KEY_CHECKS=0;
UPDATE `m_code` SET `parent_code_id` = '28' WHERE (`id` = '27');

UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21755');
UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21756');
UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21758');
UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21757');
UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21760');
UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21759');
UPDATE `m_code_value` SET `parent_code_value_id` = '21780' WHERE (`id` = '21754');
SET FOREIGN_KEY_CHECKS=1;