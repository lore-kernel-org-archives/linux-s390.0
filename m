Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA81CE6CF;
	Mon, 25 Mar 2024 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329494; cv=none; b=CeBV89O+8/CP6PZeTVh8sbgS8al4GD3DA4VGV2Lek+nAHicJZL16Lwc7ztp9cuTnpJc/4o7Pms4JbqHXletUgiCG1S734ac8yQOcQkf8T5iK+jAVxxAFH47udZuhgmROJ9C6GmsgVVha4j2OmyOrs8b4Jg2cnxoH73H1A1wbb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329494; c=relaxed/simple;
	bh=ZBfF+osgJm2Wg9ggI3txNKvwTJ+kuieWkhGQMztWILM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OLOG96n1FaQjTHIWOXZ0n7Ecb2jzsuGdRK6VWkQTh1RERXx+CGgp/9bz0meIwUEQwMCpsGaW5ZEp1uLZ/LwNgk0fmXM4nbpSEqcxfJEZsK3JWepDuY8ECe3NQwdAlyWSMVGOvAiFawgQX4TIEQ1Ghm1RCbVTQ3OLbX9eJsM5FJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V2w3Q0n1Lz1R83Z;
	Mon, 25 Mar 2024 09:15:30 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id DDC2F140158;
	Mon, 25 Mar 2024 09:18:07 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 09:18:07 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next] net/smc: make smc_hash_sk/smc_unhash_sk static
Date: Mon, 25 Mar 2024 09:25:01 +0800
Message-ID: <20240325012501.709009-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)

smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
static and remove the output symbol. They can be called under the path
.prot->hash()/unhash().

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 include/net/smc.h | 3 ---
 net/smc/af_smc.c  | 6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index c9dcb30e3fd9..10684d0a33df 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -26,9 +26,6 @@ struct smc_hashinfo {
 	struct hlist_head ht;
 };
 
-int smc_hash_sk(struct sock *sk);
-void smc_unhash_sk(struct sock *sk);
-
 /* SMCD/ISM device driver interface */
 struct smcd_dmb {
 	u64 dmb_tok;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 4b52b3b159c0..e8dcd28a554c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -177,7 +177,7 @@ static struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
 };
 
-int smc_hash_sk(struct sock *sk)
+static int smc_hash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 	struct hlist_head *head;
@@ -191,9 +191,8 @@ int smc_hash_sk(struct sock *sk)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(smc_hash_sk);
 
-void smc_unhash_sk(struct sock *sk)
+static void smc_unhash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 
@@ -202,7 +201,6 @@ void smc_unhash_sk(struct sock *sk)
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	write_unlock_bh(&h->lock);
 }
-EXPORT_SYMBOL_GPL(smc_unhash_sk);
 
 /* This will be called before user really release sock_lock. So do the
  * work which we didn't do because of user hold the sock_lock in the
-- 
2.34.1

