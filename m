Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711761CA8B;
	Sat, 13 Apr 2024 03:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979954; cv=none; b=G58SUkkYKVeV2m4UfCpztP+RYjfdaw3BqF7hyCvVVtotwyBDHJp5TQPPfp8I+HivKvhma5wjrrz7Zbx2Dh2WXwQadZTZhuQwr/EwTEAlbCN5HDGLNLqgMbczU6lmDxrr/hCfSvBPVhqNgISOM7MD2Q8MvGYXdKUFUDV8jgnpZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979954; c=relaxed/simple;
	bh=/ejGiVcUig8QB++zDGVUnFoHvRSF0CKBsYK5yhBULZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KplbIAwP7z5bVzLYgLdqzqiQnlz4YcPXy/VPLZo38uTP//w0R+ee4JW84UxofNl/6LIZIouL/2rR0lOohApR+kH1LgjwdNHhNx0Wiv7mixAIECtM5aD98/nCCvo2nVbPIfEpaLzTu1GvLLNEPH3qEyWfgz/2OC0U5TqZo7XYD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VGfRP3RQ4zNnqh;
	Sat, 13 Apr 2024 11:43:29 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 88E8C1403D3;
	Sat, 13 Apr 2024 11:45:48 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 13 Apr
 2024 11:45:47 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>, <tangchengchang@huawei.com>
Subject: [PATCH net] net/smc: fix potential sleeping issue in smc_switch_conns
Date: Sat, 13 Apr 2024 11:51:50 +0800
Message-ID: <20240413035150.3338977-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)

Potential sleeping issue exists in the following processes:
smc_switch_conns
  spin_lock_bh(&conn->send_lock)
  smc_switch_link_and_count
    smcr_link_put
      __smcr_link_clear
        smc_lgr_put
          __smc_lgr_free
            smc_lgr_free_bufs
              __smc_lgr_free_bufs
                smc_buf_free
                  smcr_buf_free
                    smcr_buf_unmap_link
                      smc_ib_put_memory_region
                        ib_dereg_mr
                          ib_dereg_mr_user
                            mr->device->ops.dereg_mr
If scheduling exists when the IB driver implements .dereg_mr hook
function, the bug "scheduling while atomic" will occur. For example,
cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.

Fixes: 20c9398d3309 ("net/smc: Resolve the race between SMC-R link access and clear")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/smc/af_smc.c   |  2 +-
 net/smc/smc.h      |  2 +-
 net/smc/smc_cdc.c  | 14 +++++++-------
 net/smc/smc_core.c |  8 ++++----
 net/smc/smc_tx.c   |  8 ++++----
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ad5bab6a44b6..c0a228def6da 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -386,7 +386,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
 	INIT_LIST_HEAD(&smc->accept_q);
 	spin_lock_init(&smc->accept_q_lock);
-	spin_lock_init(&smc->conn.send_lock);
+	mutex_init(&smc->conn.send_lock);
 	sk->sk_prot->hash(sk);
 	mutex_init(&smc->clcsock_release_lock);
 	smc_init_saved_callbacks(smc);
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 18c8b7870198..ba8efed240e3 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -194,7 +194,7 @@ struct smc_connection {
 	atomic_t		sndbuf_space;	/* remaining space in sndbuf */
 	u16			tx_cdc_seq;	/* sequence # for CDC send */
 	u16			tx_cdc_seq_fin;	/* sequence # - tx completed */
-	spinlock_t		send_lock;	/* protect wr_sends */
+	struct mutex		send_lock;	/* protect wr_sends */
 	atomic_t		cdc_pend_tx_wr; /* number of pending tx CDC wqe
 						 * - inc when post wqe,
 						 * - dec on polled tx cqe
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 3c06625ceb20..f8ad0035905a 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -186,10 +186,10 @@ static int smcr_cdc_get_slot_and_msg_send(struct smc_connection *conn)
 	if (rc)
 		goto put_out;
 
-	spin_lock_bh(&conn->send_lock);
+	mutex_lock(&conn->send_lock);
 	if (link != conn->lnk) {
 		/* link of connection changed, try again one time*/
-		spin_unlock_bh(&conn->send_lock);
+		mutex_unlock(&conn->send_lock);
 		smc_wr_tx_put_slot(link,
 				   (struct smc_wr_tx_pend_priv *)pend);
 		smc_wr_tx_link_put(link);
@@ -199,7 +199,7 @@ static int smcr_cdc_get_slot_and_msg_send(struct smc_connection *conn)
 		goto again;
 	}
 	rc = smc_cdc_msg_send(conn, wr_buf, pend);
-	spin_unlock_bh(&conn->send_lock);
+	mutex_unlock(&conn->send_lock);
 put_out:
 	smc_wr_tx_link_put(link);
 	return rc;
@@ -214,9 +214,9 @@ int smc_cdc_get_slot_and_msg_send(struct smc_connection *conn)
 		return -EPIPE;
 
 	if (conn->lgr->is_smcd) {
-		spin_lock_bh(&conn->send_lock);
+		mutex_lock(&conn->send_lock);
 		rc = smcd_cdc_msg_send(conn);
-		spin_unlock_bh(&conn->send_lock);
+		mutex_unlock(&conn->send_lock);
 	} else {
 		rc = smcr_cdc_get_slot_and_msg_send(conn);
 	}
@@ -308,10 +308,10 @@ static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
 	if (diff < 0) { /* diff larger than 0x7fff */
 		/* drop connection */
 		conn->out_of_sync = 1;	/* prevent any further receives */
-		spin_lock_bh(&conn->send_lock);
+		mutex_lock(&conn->send_lock);
 		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 		conn->lnk = link;
-		spin_unlock_bh(&conn->send_lock);
+		mutex_unlock(&conn->send_lock);
 		sock_hold(&smc->sk); /* sock_put in abort_work */
 		if (!queue_work(smc_close_wq, &conn->abort_work))
 			sock_put(&smc->sk);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9b84d5897aa5..21e0d95ab8c8 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1083,9 +1083,9 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		    smc->sk.sk_state == SMC_PEERFINCLOSEWAIT ||
 		    smc->sk.sk_state == SMC_PEERABORTWAIT ||
 		    smc->sk.sk_state == SMC_PROCESSABORT) {
-			spin_lock_bh(&conn->send_lock);
+			mutex_lock(&conn->send_lock);
 			smc_switch_link_and_count(conn, to_lnk);
-			spin_unlock_bh(&conn->send_lock);
+			mutex_unlock(&conn->send_lock);
 			continue;
 		}
 		sock_hold(&smc->sk);
@@ -1095,10 +1095,10 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		if (rc)
 			goto err_out;
 		/* avoid race with smcr_tx_sndbuf_nonempty() */
-		spin_lock_bh(&conn->send_lock);
+		mutex_lock(&conn->send_lock);
 		smc_switch_link_and_count(conn, to_lnk);
 		rc = smc_switch_cursor(smc, pend, wr_buf);
-		spin_unlock_bh(&conn->send_lock);
+		mutex_unlock(&conn->send_lock);
 		sock_put(&smc->sk);
 		if (rc)
 			goto err_out;
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3cbcf9a..b6790bd82b4e 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -573,7 +573,7 @@ static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 		return rc;
 	}
 
-	spin_lock_bh(&conn->send_lock);
+	mutex_lock(&conn->send_lock);
 	if (link != conn->lnk) {
 		/* link of connection changed, tx_work will restart */
 		smc_wr_tx_put_slot(link,
@@ -597,7 +597,7 @@ static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 	}
 
 out_unlock:
-	spin_unlock_bh(&conn->send_lock);
+	mutex_unlock(&conn->send_lock);
 	smc_wr_tx_link_put(link);
 	return rc;
 }
@@ -607,7 +607,7 @@ static int smcd_tx_sndbuf_nonempty(struct smc_connection *conn)
 	struct smc_cdc_producer_flags *pflags = &conn->local_tx_ctrl.prod_flags;
 	int rc = 0;
 
-	spin_lock_bh(&conn->send_lock);
+	mutex_lock(&conn->send_lock);
 	if (!pflags->urg_data_present)
 		rc = smc_tx_rdma_writes(conn, NULL);
 	if (!rc)
@@ -617,7 +617,7 @@ static int smcd_tx_sndbuf_nonempty(struct smc_connection *conn)
 		pflags->urg_data_pending = 0;
 		pflags->urg_data_present = 0;
 	}
-	spin_unlock_bh(&conn->send_lock);
+	mutex_unlock(&conn->send_lock);
 	return rc;
 }
 
-- 
2.34.1

