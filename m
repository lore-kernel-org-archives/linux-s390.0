Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BEA3B;
	Mon,  5 Aug 2024 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722832867; cv=none; b=IqfBRsyc93mlgjnP5UWThDnhIuM97CHuQXhlyjUItndzOptjuk+BHNX4GlZ1IZqCUrsKAWdltrVF2HyZnidIcOhcoiBCiYviLEGzYfMAFyG1bQ+9ETtsuz2tMNnwVq4IgGJ0oqPeOFUp+eT2VWUZIweIn5rZjZor6o2LcZUGRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722832867; c=relaxed/simple;
	bh=ujQG2XEqVZwYkOIRa4LyyVhtGPrNSUpH64Ga5eWCKEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFOYTnOPuJd6AKjhmBfR5BVOfzoCxL3HU8tP79Sww9/ZAD2dpp2C+rSRVkzzdClcWpTJy0khKJcaSfXlvxmhKvAjpRiQti52E/hukwZg6M6wR6fDa4QbA9AHWphzd0zd/jIzjuSFvDy6lSWrXE/IZ9bufdQLTbKDapU5jBmfLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WckCy3snXzQnt4;
	Mon,  5 Aug 2024 12:36:30 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id BE5D118009F;
	Mon,  5 Aug 2024 12:40:54 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 5 Aug
 2024 12:40:54 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<guangguan.wang@linux.alibaba.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net,v2] net/smc: add the max value of fallback reason count
Date: Mon, 5 Aug 2024 12:38:56 +0800
Message-ID: <20240805043856.565677-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
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

The number of fallback reasons defined in the smc_clc.h file has reached
36. For historical reasons, some are no longer quoted, and there's 33
actually in use. So, add the max value of fallback reason count to 36.

Fixes: 6ac1e6563f59 ("net/smc: support smc v2.x features validate")
Fixes: 7f0620b9940b ("net/smc: support max connections per lgr negotiation")
Fixes: 69b888e3bb4b ("net/smc: support max links per lgr negotiation in clc handshake")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v2: add fix tag and change max value to 36
---
 net/smc/smc_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 9d32058db2b5..e19177ce4092 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -19,7 +19,7 @@
 
 #include "smc_clc.h"
 
-#define SMC_MAX_FBACK_RSN_CNT 30
+#define SMC_MAX_FBACK_RSN_CNT 36
 
 enum {
 	SMC_BUF_8K,
-- 
2.34.1

