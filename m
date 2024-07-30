Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D8FC1D;
	Tue, 30 Jul 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302814; cv=none; b=sCY+zaD9Fo/X4Ri5vsuTve7Jk2CkalxWPDl134uNx3tKnEg5fqfaC0qf+Nr+Ngh6RvEKNggyUTDzkub4VNXsqYXon8SWctr9TUsgOfPy/yAoFYDkSLFYEGPM3/NoVctNy9J9EiQfMm368LIiMoOeJOQhN/DGPoHv47HGakK8CUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302814; c=relaxed/simple;
	bh=iWGSzo43KxDdANSxUzF0CpLwSuh5p6IxhlTs6EuXPY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS9m5x3oxUKXg6teEw7TFSz/Ej/HFkxe5Jzojs/inNChhelSimQWGTY5AylyAn4I0ewCC9BhRpbCauLW0CyCyOXwxhiq9hK5dpR3sk9z9TNOrXYf3MUcXbG+UAZ7eAr8Hn8tgRCG1b/r3uJu7cbjasi4xg9MeEdCm3vyAwb7v6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WXyDf0yW7z1HFLb;
	Tue, 30 Jul 2024 09:24:02 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 883A61A0188;
	Tue, 30 Jul 2024 09:26:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 09:26:48 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 3/4] net/smc: remove redundant code in smc_connect_check_aclc
Date: Tue, 30 Jul 2024 09:25:05 +0800
Message-ID: <20240730012506.3317978-4-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730012506.3317978-1-shaozhengchao@huawei.com>
References: <20240730012506.3317978-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)

When the SMC client perform CLC handshake, it will check whether
the clc header type is correct in receiving SMC_CLC_ACCEPT packet.
The specific invoking path is as follows:
__smc_connect
  smc_connect_clc
    smc_clc_wait_msg
      smc_clc_msg_hdr_valid
        smc_clc_msg_acc_conf_valid
Therefore, the smc_connect_check_aclc interface invoked by
__smc_connect does not need to check type again.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/smc/af_smc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 83f5a1849971..6f82e4d8fda4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1466,10 +1466,6 @@ static int smc_connect_ism(struct smc_sock *smc,
 static int smc_connect_check_aclc(struct smc_init_info *ini,
 				  struct smc_clc_msg_accept_confirm *aclc)
 {
-	if (aclc->hdr.typev1 != SMC_TYPE_R &&
-	    aclc->hdr.typev1 != SMC_TYPE_D)
-		return SMC_CLC_DECL_MODEUNSUPP;
-
 	if (aclc->hdr.version >= SMC_V2) {
 		if ((aclc->hdr.typev1 == SMC_TYPE_R &&
 		     !smcr_indicated(ini->smc_type_v2)) ||
-- 
2.34.1

