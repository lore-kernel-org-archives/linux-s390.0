Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D28821;
	Tue, 30 Jul 2024 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302814; cv=none; b=E6TyiYz4zSOreSLlKcHP9dVa4OFbyWDcaLooIDsA9uVKcdH/yr/kIkizbvt2s7jhS+H8ODwoJfj7nszQrI/zqhYId9/LGlZFbdnLuxCa5pu3GEzGm+qFVWJg5OnjT3U+faxlTNgdWioRUB7UPqW9RBndcQ8RBGGjyhpEFP572s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302814; c=relaxed/simple;
	bh=a+FhVQfrxbo7swIPC/6+TQEKmI4o6icFBkchvBs8GiE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPs6UWC/PvCmYsCBRtaFyxmNW1LMnbx/7oVvwFLBNB/Q9YdwzQb+IrWPNGYaPOr1jUvUzs/DkVMmTRYZT4N0Gq4yZIOz58/DkAQWU1YIABvFR7tvsMCJTgJbmZDc0cE9FDFTo2BedwwgWEexbPc5FaU9eGduqFbeBR3xnZVO39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXyGm64d5znbXn;
	Tue, 30 Jul 2024 09:25:52 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 325A11800A1;
	Tue, 30 Jul 2024 09:26:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 09:26:49 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 4/4] net/smc: remove unused input parameters in smcr_new_buf_create
Date: Tue, 30 Jul 2024 09:25:06 +0800
Message-ID: <20240730012506.3317978-5-shaozhengchao@huawei.com>
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

The input parameter "is_rmb" of the smcr_new_buf_create function
has never been used, remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/smc/smc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3b95828d9976..71fb334d8234 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2250,7 +2250,7 @@ int smcr_buf_reg_lgr(struct smc_link *lnk)
 }
 
 static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
-						bool is_rmb, int bufsize)
+						int bufsize)
 {
 	struct smc_buf_desc *buf_desc;
 
@@ -2398,7 +2398,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		if (is_smcd)
 			buf_desc = smcd_new_buf_create(lgr, is_rmb, bufsize);
 		else
-			buf_desc = smcr_new_buf_create(lgr, is_rmb, bufsize);
+			buf_desc = smcr_new_buf_create(lgr, bufsize);
 
 		if (PTR_ERR(buf_desc) == -ENOMEM)
 			break;
-- 
2.34.1

