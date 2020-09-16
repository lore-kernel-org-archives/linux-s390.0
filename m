Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:53290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgIPSnL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Sep 2020 14:43:11 -0400
Date: Wed, 16 Sep 2020 17:43:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] net/smc: dynamic allocation of CLC proposal buffer
Message-ID: <20200916144349.GA766931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: ubraun@linux.ibm.com
Cc: linux-s390@vger.kernel.org

Hello Ursula Braun,

The patch 6bb14e48ee8d: "net/smc: dynamic allocation of CLC proposal
buffer" from Sep 10, 2020, leads to the following static checker
warning:

	net/smc/af_smc.c:1390 smc_listen_work()
	warn: 'buf' was already freed.

net/smc/af_smc.c
  1363  
  1364          /* receive SMC Confirm CLC message */
  1365          rc = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
  1366                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
  1367          if (rc) {
  1368                  if (!ism_supported)
  1369                          goto out_unlock;
  1370                  goto out_decl;
  1371          }
  1372  
  1373          /* finish worker */
  1374          kfree(buf);
                ^^^^^^^^^^
freed.

  1375          if (!ism_supported) {
  1376                  rc = smc_listen_rdma_finish(new_smc, &cclc,
  1377                                              ini.first_contact_local);
  1378                  if (rc)
  1379                          goto out_unlock;
                                ^^^^^^^^^^^^^^^

  1380                  mutex_unlock(&smc_server_lgr_pending);
  1381          }
  1382          smc_conn_save_peer_info(new_smc, &cclc);
  1383          smc_listen_out_connected(new_smc);
  1384          return;
  1385  
  1386  out_unlock:
  1387          mutex_unlock(&smc_server_lgr_pending);
  1388  out_decl:
  1389          smc_listen_decline(new_smc, rc, ini.first_contact_local);
  1390          kfree(buf);
                ^^^^^^^^^^
Double free.

  1391  }

regards,
dan carpenter
