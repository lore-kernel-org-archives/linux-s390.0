Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726334AbgIPPzt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:49 -0400
Subject: Re: [bug report] net/smc: dynamic allocation of CLC proposal buffer
References: <20200916144349.GA766931@mwanda>
From: Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <486c8ade-033e-ca2e-4ec7-122e295392cf@linux.ibm.com>
Date: Wed, 16 Sep 2020 17:55:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200916144349.GA766931@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>



On 9/16/20 4:43 PM, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch 6bb14e48ee8d: "net/smc: dynamic allocation of CLC proposal
> buffer" from Sep 10, 2020, leads to the following static checker
> warning:
> 
> 	net/smc/af_smc.c:1390 smc_listen_work()
> 	warn: 'buf' was already freed.
> 
> net/smc/af_smc.c
>   1363  
>   1364          /* receive SMC Confirm CLC message */
>   1365          rc = smc_clc_wait_msg(new_smc, &cclc, sizeof(cclc),
>   1366                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
>   1367          if (rc) {
>   1368                  if (!ism_supported)
>   1369                          goto out_unlock;
>   1370                  goto out_decl;
>   1371          }
>   1372  
>   1373          /* finish worker */
>   1374          kfree(buf);
>                 ^^^^^^^^^^
> freed.
> 
>   1375          if (!ism_supported) {
>   1376                  rc = smc_listen_rdma_finish(new_smc, &cclc,
>   1377                                              ini.first_contact_local);
>   1378                  if (rc)
>   1379                          goto out_unlock;
>                                 ^^^^^^^^^^^^^^^
> 
>   1380                  mutex_unlock(&smc_server_lgr_pending);
>   1381          }
>   1382          smc_conn_save_peer_info(new_smc, &cclc);
>   1383          smc_listen_out_connected(new_smc);
>   1384          return;
>   1385  
>   1386  out_unlock:
>   1387          mutex_unlock(&smc_server_lgr_pending);
>   1388  out_decl:
>   1389          smc_listen_decline(new_smc, rc, ini.first_contact_local);
>   1390          kfree(buf);
>                 ^^^^^^^^^^
> Double free.
> 
>   1391  }
> 
> regards,
> dan carpenter
> 

Thanks Dan for reporting this issue in the net-next kernel!

Our plan is to come up with this follow-on patch:


net/smc: fix double kfree in smc_listen_work()

If smc_listen_rmda_finish() returns with an error, the storage
addressed by "buf" is freed a second time.
Move freeing in case of success after the smc_listen_rdma_finish()
call.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 6bb14e48ee8d ("net/smc: dynamic allocation of CLC proposal buffer")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1371,7 +1371,6 @@ static void smc_listen_work(struct work_
 	}
 
 	/* finish worker */
-	kfree(buf);
 	if (!ism_supported) {
 		rc = smc_listen_rdma_finish(new_smc, &cclc,
 					    ini.first_contact_local);
@@ -1380,6 +1379,7 @@ static void smc_listen_work(struct work_
 		mutex_unlock(&smc_server_lgr_pending);
 	}
 	smc_conn_save_peer_info(new_smc, &cclc);
+	kfree(buf);
 	smc_listen_out_connected(new_smc);
 	return;


Regards, Ursula Braun
