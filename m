Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADB1CEE8C;
	Thu, 26 Dec 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735215755; cv=none; b=WR0jzq1TlyS71AA9LZsvMEn4Ov6eMyOH+HmuMGuLR2uNtvpC+grl80m/jBPp5LEvc5J5x+aVs1oacCyFvcYiAWfjiWps5nlzPxBKOUw9w1bTP7eh+N/1Wz6EO+gT3DiZoUTSV3eMuprVFZleUypDgeaB2VDGIceRWhroj2a+HAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735215755; c=relaxed/simple;
	bh=bA8a35/ybyqUXVBoXpK5cSD+M3UpA0YvDSqocPV5EKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRNNs9uq0QP7OBFQ6ou74qbphNYOoJic8eVfVgzzcVe5hS36tbvjiW4s1MsZSb8KzMECtMkHQfrwlKEuORz/AOk1cCvYfx0I7FrjVC/VhUs8rj2dqHTH4EweZr/q/pbf6OTWol/RCBZMJH8HeuYj2RBNOx7MDK9PBLhGPzsyMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YJnl85qw5z22jv1;
	Thu, 26 Dec 2024 20:20:20 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E483E1802E8;
	Thu, 26 Dec 2024 20:22:21 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Dec
 2024 20:22:20 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <liqiang64@huawei.com>
Subject: [PATCH net-next 1/1] Enter smc_tx_wait when the tx length exceeds the available space
Date: Thu, 26 Dec 2024 20:22:17 +0800
Message-ID: <20241226122217.1125-2-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20241226122217.1125-1-liqiang64@huawei.com>
References: <20241226122217.1125-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200001.china.huawei.com (7.202.181.227)

The variable send_done records the number of bytes that have been 
successfully sent in the context of the code. It is more reasonable 
to rename it to sent_bytes here.

Another modification point is that if the ring buf is full after 
sendmsg has sent part of the data, the current code will return 
directly without entering smc_tx_wait, so the judgment of send_done 
in front of smc_tx_wait is removed.

Signed-off-by: liqiang <liqiang64@huawei.com>
---
 net/smc/smc_tx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3cbcf9a..6ecabc10793c 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -180,7 +180,7 @@ static bool smc_tx_should_cork(struct smc_sock *smc, struct msghdr *msg)
  */
 int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 {
-	size_t copylen, send_done = 0, send_remaining = len;
+	size_t copylen, sent_bytes = 0, send_remaining = len;
 	size_t chunk_len, chunk_off, chunk_len_sum;
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor prep;
@@ -216,14 +216,12 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		    conn->killed)
 			return -EPIPE;
 		if (smc_cdc_rxed_any_close(conn))
-			return send_done ?: -ECONNRESET;
+			return sent_bytes ?: -ECONNRESET;
 
 		if (msg->msg_flags & MSG_OOB)
 			conn->local_tx_ctrl.prod_flags.urg_data_pending = 1;
 
 		if (!atomic_read(&conn->sndbuf_space) || conn->urg_tx_pend) {
-			if (send_done)
-				return send_done;
 			rc = smc_tx_wait(smc, msg->msg_flags);
 			if (rc)
 				goto out_err;
@@ -250,11 +248,11 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 					     msg, chunk_len);
 			if (rc) {
 				smc_sndbuf_sync_sg_for_device(conn);
-				if (send_done)
-					return send_done;
+				if (sent_bytes)
+					return sent_bytes;
 				goto out_err;
 			}
-			send_done += chunk_len;
+			sent_bytes += chunk_len;
 			send_remaining -= chunk_len;
 
 			if (chunk_len_sum == copylen)
@@ -287,7 +285,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		trace_smc_tx_sendmsg(smc, copylen);
 	} /* while (msg_data_left(msg)) */
 
-	return send_done;
+	return sent_bytes;
 
 out_err:
 	rc = sk_stream_error(sk, msg->msg_flags, rc);
-- 
2.43.0

