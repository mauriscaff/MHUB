# Relatorio executivo ZombieHunter

Gerado em: 2026-06-01 15:56:29
Fonte: `C:\Users\mscaff\MHUB\teste de interface\vmdk_scanner.db`

## Valor principal

**Total principal excluido/limpo registrado: 41.100,111 GB (40,14 TB).**

Esse valor vem dos **63 eventos brutos de verificacao pos-exclusao**, onde o ZombieHunter registrou **183 VMDKs** como removidos/limpos entre **2026-03-06 19:52:39** e **2026-06-01 19:43:39**.

Para leitura de auditoria, mantenho tambem dois numeros auxiliares:
- **36,57 TB** como consolidado por maior ganho ja registrado por datastore/vCenter, evitando contar a mesma LUN varias vezes.
- **34,88 TB** como fotografia da ultima verificacao de cada datastore/vCenter.
- **1,12 TB** em execucoes individuais por approval token do fluxo antigo de DELETE/QUARANTINE.

## Resumo executivo

- O banco atual tem evidencias de varreduras, snapshots, aprovacoes, dry-runs, execucoes e verificacoes pos-exclusao.
- Eventos brutos de verificacao pos-exclusao: **63 eventos**, **183 VMDKs**, **41.100,111 GB (40,14 TB)** registrados como removidos/limpos.
- Foram identificados **41 datastores** com historico de verificacao; **28** aparecem como removidos em algum momento e **7** tiveram limpeza parcial.
- Maior impacto individual: **STA_LUN_0000** em **s2001.ms**, com **16.762,880 GB (16,37 TB)**.
- Segundo maior impacto: **STD_LUN_07** em **s2001.ms**, com **10.240,000 GB (10,00 TB)**.
- Os **5 maiores datastores** concentram **32.360,928 GB (31,60 TB)**, ou **78,7%** do total bruto registrado.
- Os **10 maiores datastores** concentram **35.268,454 GB (34,44 TB)**, ou **85,8%** do total bruto registrado.

## Maiores ganhos por datastore

| # | vCenter | Datastore | Status | VMDKs | Volume | Volume TB | % do total | Validacoes | Ultima verificacao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | s2001.ms | STA_LUN_0000 | datastore removido | 12 | 16.762,880 GB | 16,37 TB | 40,8% | 2 | 2026-03-10 12:17:26 |
| 2 | s2001.ms | STD_LUN_07 | limpeza parcial | 1 | 10.240,000 GB | 10,00 TB | 24,9% | 1 | 2026-06-01 18:39:14 |
| 3 | s2001.ms | STB_LUN_03 | datastore removido | 9 | 2.810,851 GB | 2,74 TB | 6,8% | 2 | 2026-04-07 00:07:07 |
| 4 | s2000.ms | STB_LUN_01 | datastore removido | 10 | 1.523,196 GB | 1,49 TB | 3,7% | 2 | 2026-05-27 13:23:51 |
| 5 | s2001.ms | STB_LUN_02 | limpeza parcial | 2 | 1.024,001 GB | 1,00 TB | 2,5% | 1 | 2026-03-27 12:33:31 |
| 6 | s2001.ms | STB_LUN_04 | datastore removido | 29 | 931,534 GB | 0,91 TB | 2,3% | 1 | 2026-03-27 12:35:41 |
| 7 | s2000.ms | STA_LUN_11 | datastore removido | 5 | 653,134 GB | 0,64 TB | 1,6% | 1 | 2026-03-16 12:20:35 |
| 8 | s2001.ms | STB_LUN_05 | datastore removido | 6 | 518,244 GB | 0,51 TB | 1,3% | 1 | 2026-03-27 12:36:38 |
| 9 | s2001.ms | STD_LUN_02 | limpeza parcial | 13 | 448,876 GB | 0,44 TB | 1,1% | 1 | 2026-06-01 18:06:55 |
| 10 | s2001.ms | STA_LUN_10 | datastore removido | 2 | 355,738 GB | 0,35 TB | 0,9% | 1 | 2026-03-13 19:20:22 |
| 11 | s2001.ms | STB_LUN_10 | datastore removido | 8 | 341,081 GB | 0,33 TB | 0,8% | 3 | 2026-04-08 15:14:20 |
| 12 | s2001.ms | STA_LUN_08 | datastore removido | 4 | 316,021 GB | 0,31 TB | 0,8% | 3 | 2026-03-13 13:34:31 |
| 13 | s2000.ms | STA_LUN_01 | limpeza parcial | 8 | 217,202 GB | 0,21 TB | 0,5% | 1 | 2026-05-26 11:45:05 |
| 14 | s1589.ms | VxRail-Virtual-SAN-Datastore-8bad6ded-468e-41cb-b0ed-7c447d9c4689 | limpeza parcial | 1 | 204,051 GB | 0,20 TB | 0,5% | 7 | 2026-03-26 11:44:40 |
| 15 | s2001.ms | STB_LUN_08 | datastore removido | 3 | 200,001 GB | 0,20 TB | 0,5% | 1 | 2026-04-08 19:41:33 |
| 16 | s2000.ms | STA_LUN_12 | datastore removido | 6 | 184,488 GB | 0,18 TB | 0,4% | 1 | 2026-03-16 12:20:56 |
| 17 | s2001.ms | STC_LUN_04 | datastore removido | 1 | 175,928 GB | 0,17 TB | 0,4% | 1 | 2026-05-20 14:44:35 |
| 18 | s2001.ms | STA_LUN_05 | datastore removido | 0 | 174,760 GB | 0,17 TB | 0,4% | 1 | 2026-03-10 12:17:26 |
| 19 | s2001.ms | STB_LUN_09 | datastore removido | 3 | 130,001 GB | 0,13 TB | 0,3% | 2 | 2026-04-08 15:08:12 |
| 20 | s2001.ms | STA_LUN_15 | datastore removido | 2 | 88,804 GB | 0,09 TB | 0,2% | 1 | 2026-03-17 15:13:06 |
| 21 | s2001.ms | STA_LUN_14 | datastore removido | 1 | 50,819 GB | 0,05 TB | 0,1% | 2 | 2026-03-17 15:14:47 |
| 22 | s2001.ms | STC_LUN_03 | datastore removido | 11 | 49,577 GB | 0,05 TB | 0,1% | 1 | 2026-05-20 14:43:07 |
| 23 | s2001.ms | STA_LUN_09 | datastore removido | 1 | 28,549 GB | 0,03 TB | 0,1% | 2 | 2026-03-13 13:35:42 |
| 24 | s2001.ms | STA_LUN_06 | datastore removido | 0 | 7,180 GB | 0,01 TB | 0,0% | 1 | 2026-03-10 12:17:26 |
| 25 | s2001.ms | STB_LUN_06 | datastore removido | 2 | 3,041 GB | 0,00 TB | 0,0% | 2 | 2026-04-08 15:11:39 |
| 26 | s2000.ms | STA_LUN_03 | datastore removido | 6 | 2,000 GB | 0,00 TB | 0,0% | 1 | 2026-03-10 12:17:26 |
| 27 | s1589.ms | DE800192700032-01-01-service-datastore1 | limpeza parcial | 1 | 1,598 GB | 0,00 TB | 0,0% | 1 | 2026-03-25 17:21:04 |
| 28 | s2001.ms | STD_LUN_01 | limpeza parcial | 1 | 1,000 GB | 0,00 TB | 0,0% | 1 | 2026-06-01 18:04:56 |
| 29 | s2000.ms | STA_LUN_13 | datastore removido | 1 | 0,022 GB | 0,00 TB | 0,0% | 1 | 2026-03-16 12:21:21 |
| 30 | s2001.ms | STB_LUN_07 | datastore removido | 1 | 0,001 GB | 0,00 TB | 0,0% | 2 | 2026-04-08 15:09:19 |

## Total por vCenter

| vCenter | Datastores | Removidos | Parciais | Sem limpeza | VMDKs | Volume | Volume TB | % do total |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| s2001.ms | 32 | 23 | 4 | 5 | 112 | 34.658,887 GB | 33,85 TB | 84,3% |
| s2000.ms | 6 | 5 | 1 | 0 | 36 | 2.580,042 GB | 2,52 TB | 6,3% |
| s1589.ms | 3 | 0 | 2 | 1 | 2 | 205,649 GB | 0,20 TB | 0,5% |

## Linha do tempo das limpezas

| Mes | Eventos | VMDKs | Volume | Volume TB |
| --- | --- | --- | --- | --- |
| 2026-03 | 20 | 90 | 24.144,151 GB | 23,58 TB |
| 2026-04 | 12 | 58 | 5.823,377 GB | 5,69 TB |
| 2026-05 | 3 | 20 | 442,707 GB | 0,43 TB |
| 2026-06 | 3 | 15 | 10.689,876 GB | 10,44 TB |

## Status das verificacoes

| Status tecnico | Leitura | Eventos | VMDKs | Volume | Volume TB |
| --- | --- | --- | --- | --- | --- |
| datastore_removed | datastore removido/sem itens restantes | 35 | 154 | 28.933,906 GB | 28,26 TB |
| partial_cleanup | limpeza parcial registrada | 9 | 29 | 12.166,205 GB | 11,88 TB |
| no_cleanup | sem ganho nessa verificacao | 19 | 0 | 0,000 GB | 0,00 TB |

## O que foi feito pelo ZombieHunter

- **Varreduras:** 140 jobs registrados; 114 concluídos, 11 com falha e 15 ainda marcados como running no banco.
- **Volume analisado nas varreduras:** 4.538.189,530 GB registrados em jobs de scan.
- **Aprovacoes:** 28 tokens executados; 27 DELETE e 1 QUARANTINE.
- **Auditoria:** 172 registros no `audit_log`, cobrindo criacao de token, dry-run, delete, quarantine, snapshots e falhas.
- **Snapshots e verificacoes pos-exclusao:** usados para comparar antes/depois e provar a reducao por datastore.

## Observacoes importantes

- O **valor principal** deste relatorio e o total bruto de eventos pos-exclusao: ele responde diretamente “quanto foi excluido/limpo segundo o historico registrado”.
- O consolidado por datastore evita dupla contagem quando a mesma LUN foi conferida mais de uma vez, mas pode esconder delecoes antigas se uma verificacao posterior teve outro escopo.
- `limpeza parcial` nao significa erro automaticamente; significa que houve ganho registrado, mas a verificacao nao fechou como datastore totalmente removido.
- Alguns datastores aparecem com VMDKs igual a zero e volume positivo porque a evidencia historica gravada veio de comparacao/snapshot de datastore, nao de lista individual final de VMDKs.

## Arquivos

- Relatorio HTML: `C:\Users\mscaff\MHUB\reports\zombiehunter\relatorio_zombiehunter_executivo_2026-06-01.html`
- Ranking completo em CSV: `C:\Users\mscaff\MHUB\reports\zombiehunter\top_datastores_excluidos_2026-06-01.csv`
- Banco fonte: `C:\Users\mscaff\MHUB\teste de interface\vmdk_scanner.db`