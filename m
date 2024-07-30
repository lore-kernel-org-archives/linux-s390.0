Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2988FC08;
	Tue, 30 Jul 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302813; cv=none; b=BRlyMwhljvgSSO+4u/Ph0sIm24VvOej6Qg7ulwXi40YlFTLSYj3t2emMiJZtfl2U5LjwaqNLPuS3EiEoNtUmuiY7lXaReAT0+ABQaPUrPdgl79Vo2PdQ+aFkD5djIMYI3Qn57v1AyksYJDuY0g+xNAsnwyceBcvaKgYOppXeJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302813; c=relaxed/simple;
	bh=xqntZRHuA0dVyn1JWE5Rt+Da9H2J5cf1NseRDAXOdsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zmb2mAdfgR5sJM2WbNjORv523Omqt1k8d6iS2Pk7YqR4cyr9FVCw+jleimDOuQJaNhyJyvbXDql5E+hTqO7TJ+o/oMNYvY2S0MBX/L7uPNGegNKBfkyO9Lv4Pj++cmGfWYteIHOZdShSzNrkp7GIoegI/gRo546ovjw+vDAt4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WXyBv3KXgzPtDr;
	Tue, 30 Jul 2024 09:22:31 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id E1222140FA7;
	Tue, 30 Jul 2024 09:26:48 +0800 (CST)
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
Subject: [PATCH net-next 2/4] net/smc: remove the fallback in __smc_connect
Date: Tue, 30 Jul 2024 09:25:04 +0800
Message-ID: <20240730012506.3317978-3-shaozhengchao@huawei.com>
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

When the SMC client begins to connect to server, smcd_version is set
to SMC_V1 + SMC_V2. If fail to get VLAN ID, only SMC_V2 information
is left in smcd_version. And smcd_version will not be changed to 0.
Therefore, remove the fallback caused by the failure to get VLAN ID.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/smc/af_smc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 73a875573e7a..83f5a1849971 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1523,10 +1523,6 @@ static int __smc_connect(struct smc_sock *smc)
 		ini->smcd_version &= ~SMC_V1;
 		ini->smcr_version = 0;
 		ini->smc_type_v1 = SMC_TYPE_N;
-		if (!ini->smcd_version) {
-			rc = SMC_CLC_DECL_GETVLANERR;
-			goto fallback;
-		}
 	}
 
 	rc = smc_find_proposal_devices(smc, ini);
-- 
2.34.1

