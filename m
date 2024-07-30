Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9371DF78;
	Tue, 30 Jul 2024 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302812; cv=none; b=gVfsouYy2Nc+249+ZQ19a8ee4iQzr5U2fcqttFX6cHznETTBhBjvkInB2rYdY4FRooP6Tn0V5MHYDRTSiHH9UEFIyVx2gDS4V4mdvIsbcA2phEiLVw0tdex/yQc9ez+TcpBZqJCQsIb6B52viuJk6URJQrJRwfy0ktbpg5dD/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302812; c=relaxed/simple;
	bh=bcDj7it1hvvpmCwdRaNbJu3tAmtB7B+6bV9OD5vN2o8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNpKjimUVSeAyZd44Moj9NeNSyBYAH5XerL2zCfeBCMoKhronf0tZiv3ihZw55jiet6haLGIONNlfx9bcIqDWLZYKii+VwCVbKCcaQ7YTo4qblHhwhvZhGhyJiAtaMH7/+aGeGejdWQu6S/A5rUweMBsyQHe6V3H3V9nXJfnsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXyFj5BPWzgYPy;
	Tue, 30 Jul 2024 09:24:57 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DC98180AE5;
	Tue, 30 Jul 2024 09:26:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 30 Jul
 2024 09:26:46 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 0/4] net/smc: do some cleanups in smc module
Date: Tue, 30 Jul 2024 09:25:02 +0800
Message-ID: <20240730012506.3317978-1-shaozhengchao@huawei.com>
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

Do some cleanups in smc module.

Zhengchao Shao (4):
  net/smc: remove unreferenced header in smc_loopback.h file
  net/smc: remove the fallback in __smc_connect
  net/smc: remove redundant code in smc_connect_check_aclc
  net/smc: remove unused input parameters in smcr_new_buf_create

 net/smc/af_smc.c       | 8 --------
 net/smc/smc_core.c     | 4 ++--
 net/smc/smc_loopback.h | 1 -
 3 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.34.1

