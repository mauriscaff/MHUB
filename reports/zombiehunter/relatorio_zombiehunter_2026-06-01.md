# Relatorio ZombieHunter - Higienizacao e exclusoes

Gerado em: 2026-06-01 15:47:37
Fonte principal: `C:\Users\mscaff\MHUB\teste de interface\vmdk_scanner.db`

## Resumo executivo

- O banco atual tem evidencias de varreduras, snapshots, aprovacoes, dry-runs, execucoes e verificacoes pos-exclusao.
- Eventos brutos de verificacao pos-exclusao: **63** eventos, **183** VMDKs, **41.100,111 GB** (**40,14 TB**) registrados como removidos/limpos.
- Visao consolidada pela ultima verificacao de cada datastore/vCenter: **41** datastores, **139** VMDKs, **35.717,331 GB** (**34,88 TB**) registrados como removidos/limpos.
- Visao conservadora por maior ganho ja registrado por datastore/vCenter: **41** datastores, **150** VMDKs, **37.444,578 GB** (**36,57 TB**).
- Execucoes individuais aprovadas: **28** execucoes, sendo **27 DELETE** e **1 QUARANTINE**, com **1.147,639 GB** (**1,12 TB**) somados nos tokens executados.

> Leitura correta: use o total bruto para auditoria de eventos, use o consolidado por maior ganho para evitar perder limpezas antigas em LUN revalidada, e use a tabela de approval tokens para rastrear exclusoes individuais do ZombieHunter antigo.

## Consolidado por status

### Eventos brutos
| Status | Eventos | VMDKs | Volume | Volume TB | Restante VMDKs | Restante |
| --- | --- | --- | --- | --- | --- | --- |
| datastore_removed | 35 | 154 | 28.933,906 GB | 28,26 TB | 5 | 171,600 GB |
| partial_cleanup | 9 | 29 | 12.166,205 GB | 11,88 TB | 73 | 34.125,124 GB |
| no_cleanup | 19 | 0 | 0,000 GB | 0,00 TB | 110 | 62.724,778 GB |

### Ultima verificacao por datastore/vCenter
| Status | Datastores | VMDKs | Volume | Volume TB | Restante VMDKs | Restante |
| --- | --- | --- | --- | --- | --- | --- |
| datastore_removed | 27 | 113 | 23.784,654 GB | 23,23 TB | 5 | 171,600 GB |
| partial_cleanup | 6 | 26 | 11.932,677 GB | 11,65 TB | 7 | 4,665 GB |
| no_cleanup | 8 | 0 | 0,000 GB | 0,00 TB | 28 | 11.360,673 GB |

## Por vCenter

### Ultima verificacao por datastore/vCenter

| vCenter | Datastores | Removidos | Parcial | Sem limpeza | VMDKs | Volume | Volume TB |
| --- | --- | --- | --- | --- | --- | --- | --- |
| s2001.ms | 32 | 23 | 4 | 5 | 112 | 34.658,887 GB | 33,85 TB |
| s2000.ms | 6 | 4 | 1 | 1 | 26 | 1.056,846 GB | 1,03 TB |
| s1589.ms | 3 | 0 | 1 | 2 | 1 | 1,598 GB | 0,00 TB |

### Maior ganho registrado por datastore/vCenter

| vCenter | Datastores | Removidos | Parcial | Sem limpeza | VMDKs | Volume | Volume TB |
| --- | --- | --- | --- | --- | --- | --- | --- |
| s2001.ms | 32 | 24 | 4 | 4 | 122 | 35.894,170 GB | 35,05 TB |
| s2000.ms | 6 | 4 | 1 | 1 | 26 | 2.580,042 GB | 2,52 TB |
| s1589.ms | 3 | 0 | 2 | 1 | 2 | 970,366 GB | 0,95 TB |


## Maiores ganhos por datastore

| vCenter | Datastore | Status | VMDKs | Volume | Volume TB | Validacoes | Ultima verificacao |
| --- | --- | --- | --- | --- | --- | --- | --- |
| s2001.ms | STA_LUN_0000 | datastore_removed | 12 | 16.762,880 GB | 16,37 TB | 2 | 2026-03-10 12:17:26 |
| s2001.ms | STD_LUN_07 | partial_cleanup | 1 | 10.240,000 GB | 10,00 TB | 1 | 2026-06-01 18:39:14 |
| s2001.ms | STB_LUN_03 | datastore_removed | 9 | 2.810,851 GB | 2,74 TB | 2 | 2026-04-07 00:07:07 |
| s2001.ms | STB_LUN_02 | partial_cleanup | 2 | 1.024,001 GB | 1,00 TB | 1 | 2026-03-27 12:33:31 |
| s2001.ms | STB_LUN_04 | datastore_removed | 29 | 931,534 GB | 0,91 TB | 1 | 2026-03-27 12:35:41 |
| s2000.ms | STA_LUN_11 | datastore_removed | 5 | 653,134 GB | 0,64 TB | 1 | 2026-03-16 12:20:35 |
| s2001.ms | STB_LUN_05 | datastore_removed | 6 | 518,244 GB | 0,51 TB | 1 | 2026-03-27 12:36:38 |
| s2001.ms | STD_LUN_02 | partial_cleanup | 13 | 448,876 GB | 0,44 TB | 1 | 2026-06-01 18:06:55 |
| s2001.ms | STA_LUN_10 | datastore_removed | 2 | 355,738 GB | 0,35 TB | 1 | 2026-03-13 19:20:22 |
| s2001.ms | STB_LUN_10 | datastore_removed | 8 | 341,081 GB | 0,33 TB | 3 | 2026-04-08 15:14:20 |
| s2001.ms | STA_LUN_08 | datastore_removed | 4 | 316,021 GB | 0,31 TB | 3 | 2026-03-13 13:34:31 |
| s2000.ms | STA_LUN_01 | partial_cleanup | 8 | 217,202 GB | 0,21 TB | 1 | 2026-05-26 11:45:05 |
| s2001.ms | STB_LUN_08 | datastore_removed | 3 | 200,001 GB | 0,20 TB | 1 | 2026-04-08 19:41:33 |
| s2000.ms | STA_LUN_12 | datastore_removed | 6 | 184,488 GB | 0,18 TB | 1 | 2026-03-16 12:20:56 |
| s2001.ms | STC_LUN_04 | datastore_removed | 1 | 175,928 GB | 0,17 TB | 1 | 2026-05-20 14:44:35 |
| s2001.ms | STA_LUN_05 | datastore_removed | 0 | 174,760 GB | 0,17 TB | 1 | 2026-03-10 12:17:26 |
| s2001.ms | STB_LUN_09 | datastore_removed | 3 | 130,001 GB | 0,13 TB | 2 | 2026-04-08 15:08:12 |
| s2001.ms | STA_LUN_15 | datastore_removed | 2 | 88,804 GB | 0,09 TB | 1 | 2026-03-17 15:13:06 |
| s2001.ms | STA_LUN_14 | datastore_removed | 1 | 50,819 GB | 0,05 TB | 2 | 2026-03-17 15:14:47 |
| s2001.ms | STC_LUN_03 | datastore_removed | 11 | 49,577 GB | 0,05 TB | 1 | 2026-05-20 14:43:07 |
| s2001.ms | STA_LUN_09 | datastore_removed | 1 | 28,549 GB | 0,03 TB | 2 | 2026-03-13 13:35:42 |
| s2001.ms | STA_LUN_06 | datastore_removed | 0 | 7,180 GB | 0,01 TB | 1 | 2026-03-10 12:17:26 |
| s2001.ms | STB_LUN_06 | datastore_removed | 2 | 3,041 GB | 0,00 TB | 2 | 2026-04-08 15:11:39 |
| s2000.ms | STA_LUN_03 | datastore_removed | 6 | 2,000 GB | 0,00 TB | 1 | 2026-03-10 12:17:26 |
| s1589.ms | DE800192700032-01-01-service-datastore1 | partial_cleanup | 1 | 1,598 GB | 0,00 TB | 1 | 2026-03-25 17:21:04 |

## Execucoes individuais por approval token

| ID | Acao | Analista | vCenter | Volume | Arquivos | Executado em | Sucesso | Path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | DELETE | Mauricio Scaff | s1589.ms:443 | 204,051 GB | 1 | 2026-03-17 13:42:51.822066 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 2 | QUARANTINE | Mauricio Scaff | s1589.ms:443 | 0,374 GB | 1 | 2026-03-25 14:42:00.315614 | True | [DE800192700031-01-01-service-datastore1] images/log-insight-original/VMware-vRealize-Log-Insight-4.6.0-8080673-cloud-co... |
| 4 | DELETE | Mauricio Scaff | 5 | 0,374 GB | 1 | 2026-03-25 17:08:46.051099 | True | [DE800192700031-01-01-service-datastore1] images/log-insight-original/VMware-vRealize-Log-Insight-4.6.0-8080673-cloud-co... |
| 5 | DELETE | Mauricio Scaff | 5 | 1,598 GB | 1 | 2026-03-25 17:19:03.595350 | True | [DE800192700032-01-01-service-datastore1] images/vcsa-restore-original/VMware-vCenter-Server-Appliance-6.7.0.21000-11726... |
| 29 | DELETE | Mauricio Scaff | 5 | 2,442 GB | 1 | 2026-03-25 17:35:14.999411 | True | [DE800192700031-01-01-service-datastore1] images/evorail-restore-original/VXRAIL_Manager-4.7.110.00000-12663824-system.v... |
| 28 | DELETE | Mauricio Scaff | 5 | 2,442 GB | 1 | 2026-03-25 17:37:08.661932 | True | [DE800192700032-01-01-service-datastore1] images/evorail-restore-original/VXRAIL_Manager-4.7.110.00000-12663824-system.v... |
| 27 | DELETE | Mauricio Scaff | 5 | 2,442 GB | 1 | 2026-03-25 18:15:18.518365 | True | [DE800192700030-01-01-service-datastore1] images/evorail-restore-original/VXRAIL_Manager-4.7.110.00000-12663824-system.v... |
| 26 | DELETE | Mauricio Scaff | 5 | 2,442 GB | 1 | 2026-03-25 18:15:20.236352 | True | [DE800192700029-01-01-service-datastore1] images/evorail-restore-original/VXRAIL_Manager-4.7.110.00000-12663824-system.v... |
| 25 | DELETE | Mauricio Scaff | 5 | 2,442 GB | 1 | 2026-03-25 18:15:21.943451 | True | [DE800192700033-01-01-service-datastore1] images/evorail-restore-original/VXRAIL_Manager-4.7.110.00000-12663824-system.v... |
| 24 | DELETE | Mauricio Scaff | 5 | 6,652 GB | 1 | 2026-03-25 18:39:16.123565 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] 01f58c62-8a51-4697-baa4-e4434b799e80TEMPLATE - AlmaL... |
| 23 | DELETE | Mauricio Scaff | 5 | 10,215 GB | 1 | 2026-03-25 18:39:33.088507 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] 1615455f-64fa-a4ed-df4d-e4434b799930TEMPLATE - Linux... |
| 22 | DELETE | Mauricio Scaff | 5 | 11,285 GB | 1 | 2026-03-25 18:43:08.327484 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 21 | DELETE | Mauricio Scaff | 5 | 16,766 GB | 1 | 2026-03-25 18:44:47.444737 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] 04c2cb5e-4e72-b17f-2743-e4434b799e80TEMPLATE - Windo... |
| 18 | DELETE | Mauricio Scaff | 5 | 20,426 GB | 1 | 2026-03-25 18:49:44.568585 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 19 | DELETE | Mauricio Scaff | 5 | 20,426 GB | 1 | 2026-03-25 18:51:04.984998 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 20 | DELETE | Mauricio Scaff | 5 | 20,426 GB | 1 | 2026-03-25 19:00:06.062220 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 17 | DELETE | Mauricio Scaff | 5 | 30,629 GB | 1 | 2026-03-25 19:02:14.788760 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 16 | DELETE | Mauricio Scaff | 5 | 30,629 GB | 1 | 2026-03-25 19:02:17.047993 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 15 | DELETE | Mauricio Scaff | 5 | 40,832 GB | 1 | 2026-03-25 19:02:19.479191 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 14 | DELETE | Mauricio Scaff | 5 | 51,035 GB | 1 | 2026-03-25 19:02:21.711834 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 13 | DELETE | Mauricio Scaff | 5 | 51,035 GB | 1 | 2026-03-25 19:02:24.147752 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 12 | DELETE | Mauricio Scaff | 5 | 51,035 GB | 1 | 2026-03-25 19:02:26.362667 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 11 | DELETE | Mauricio Scaff | 5 | 51,332 GB | 1 | 2026-03-25 19:02:28.570943 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] 804cf25e-ce30-7787-682b-e4434b79a100S0777 - MS DOCKE... |
| 10 | DELETE | Mauricio Scaff | 5 | 97,957 GB | 1 | 2026-03-25 19:02:31.005821 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 9 | DELETE | Mauricio Scaff | 5 | 102,043 GB | 1 | 2026-03-25 19:02:33.198346 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 8 | DELETE | Mauricio Scaff | 5 | 102,043 GB | 1 | 2026-03-25 19:02:35.435828 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 7 | DELETE | Mauricio Scaff | 5 | 204,051 GB | 1 | 2026-03-25 19:02:37.653388 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] f1f3a95f-2051-810b-5e35-e4434b79a070S1589 - SGI VSA ... |
| 6 | DELETE | Mauricio Scaff | 5 | 10,215 GB | 1 | 2026-03-25 19:02:40.071244 | True | [VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689] 61f7d661-68d1-5037-399d-e4434b799e80S0560 - MS DOCKE... |

## Resumo de aprovacoes e auditoria

### Approval tokens
| Status | Acao | Qtd | Volume |
| --- | --- | --- | --- |
| cancelled | DELETE | 1 | 0,000 GB |
| executed | DELETE | 27 | 1.147,265 GB |
| executed | QUARANTINE | 1 | 0,374 GB |

### Audit log
| Acao | Status | Qtd |
| --- | --- | --- |
| CANCEL | cancelled | 1 |
| CREATE_TOKEN | created | 29 |
| DATASTORE_SNAPSHOT | generated_snapshot | 5 |
| DELETE | executed_delete | 27 |
| DELETE | failed | 44 |
| DRY_RUN | dry_run_completed | 59 |
| QUARANTINE | executed_quarantine | 1 |
| QUARANTINE | failed | 6 |

## Varreduras registradas

| Status | Jobs | VMDKs | Volume | Primeiro inicio | Ultimo fim |
| --- | --- | --- | --- | --- | --- |
| completed | 114 | 15432 | 4.538.189,530 GB | 2026-02-25 17:36:07.078473 | 2026-06-01 19:43:37.836135 |
| failed | 11 | 0 | 0,000 GB | 2026-02-25 17:45:50.197177 | 2026-05-19 17:34:36.686484 |
| running | 15 | 0 | 0,000 GB | 2026-02-25 17:46:26.481406 | None |

## Snapshots de descomissionamento

| vCenter | Datastore | Itens | Volume | Criado em | Job origem |
| --- | --- | --- | --- | --- | --- |
| s2001.ms | STA_LUN_06 | 1 | 4,438 GB | 2026-03-06 14:49:18 | ab8dde3c-3dc5-403e-b939-aa5610d3ba03 |
| s2001.ms | STA_LUN_0000 | 12 | 16.744,000 GB | 2026-03-06 15:04:50 | d50fbce4-1647-4f2e-8f3c-ee8f09b1933b |
| s2001.ms | STA_LUN_0000 | 12 | 16.744,000 GB | 2026-03-06 15:07:16 | bf2d4c54-0be3-4a36-ae0a-12854dc4c711 |
| s2001.ms | STA_LUN_0000 | 12 | 16.744,000 GB | 2026-03-06 17:58:37 | bf2d4c54-0be3-4a36-ae0a-12854dc4c711 |
| s2001.ms | STA_LUN_0000 | 12 | 16.744,000 GB | 2026-03-06 18:39:08 | bf2d4c54-0be3-4a36-ae0a-12854dc4c711 |

## Arquivos gerados

- Consolidado por datastore: `C:\Users\mscaff\MHUB\reports\zombiehunter\datastores_consolidado_2026-06-01.csv`
- Eventos de verificacao: `C:\Users\mscaff\MHUB\reports\zombiehunter\datastore_eventos_2026-06-01.csv`
- Maior ganho por datastore: `C:\Users\mscaff\MHUB\reports\zombiehunter\datastores_maior_ganho_2026-06-01.csv`
- Execucoes por approval token: `C:\Users\mscaff\MHUB\reports\zombiehunter\vmdk_execucoes_2026-06-01.csv`
- Audit log completo: `C:\Users\mscaff\MHUB\reports\zombiehunter\audit_log_2026-06-01.csv`

## Observacoes

- `datastore_removed` indica que a verificacao pos-exclusao marcou o datastore como removido/sem itens restantes relevantes.
- `partial_cleanup` indica ganho registrado, mas sem fechamento total do escopo ou com verificacao parcial.
- `no_cleanup` indica que a verificacao nao encontrou ganho/remocao naquele par baseline x verificacao.
- Existem registros de teste antigos no banco, mas o consolidado principal agrupa por `vcenter_host_scope + datastore` e evidencia os ambientes reais registrados.