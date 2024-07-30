Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C23E573;
	Tue, 30 Jul 2024 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302812; cv=none; b=V31aCOdX2sHT1WD1Lb3pR5bFFvTPznZ5144gDhB3O1jzxyQyytdMM89/tLcSSVOflIunrNEAFdUMqG+9ngLgEy1ioUv4+7nPNJKMQg1jDk3S8jJuncV0fXKN+Whr9dxrFkMm/aH0twn1PS5rzESB5SzFEIuRWhM5cbSWztFvg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302812; c=relaxed/simple;
	bh=w/HlD+Uo2oJworvVD1lQNRqBwkR3R/giQTDTJzf0MTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzGzwIgZWh2VqZcdy/gBpEoyprKSFUdXSR+hxaxYiUpQPf1lMzI9OfyzxaSJ9SVdS4TynD9eGutaj4ob5NdtuS62k5O1IC+FiCNeuW1YyGH4TF8ZV4TOQeMZkP5+g+7c87wa3N7EXeG4RrrJtiJQIogm+Dyf6w4L+3n6C5H64WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WXyB72x0DzyNCM;
	Tue, 30 Jul 2024 09:21:51 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 3893F140FA7;
	Tue, 30 Jul 2024 09:26:48 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 09:26:47 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 1/4] net/smc: remove unreferenced header in smc_loopback.h file
Date: Tue, 30 Jul 2024 09:25:03 +0800
Message-ID: <20240730012506.3317978-2-shaozhengchao@huawei.com>
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

Because linux/err.h is unreferenced in smc_loopback.h file, so
remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/smc/smc_loopback.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 6dd4292dae56..04dc6808d2e1 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -15,7 +15,6 @@
 #define _SMC_LOOPBACK_H
 
 #include <linux/device.h>
-#include <linux/err.h>
 #include <net/smc.h>
 
 #if IS_ENABLED(CONFIG_SMC_LO)
-- 
2.34.1

