Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80175881E;
	Mon, 18 Nov 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936117; cv=none; b=UM7fTILWoBozyxcChDN4CzewHpWlaq7URAhKOec9UNyfhsAnnmRWdrOtbj+ooN0agGrt39EiYNxvwTMp44vjviKHTxa0WzXMYCK/CRc4Q9T8TdkC3iJTuwbzVNLg5eNLcfmdvrvmvK80lTPlHgCjndV6cZa1B+E93nKv4AlxvE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936117; c=relaxed/simple;
	bh=oq91IVbWrLtgx588ljOpmdm19FTZCsv3AqoE9KQjznE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o/dsAl/jI/O7CE93Lq3+hwrxDGgPnJARuJ1Hr8rOssMBCNEkcrdaCyJglhx3zGbYEvEEvKqiYiwevuSS2d122b89aLP+g5A0IijKJpvkC4yTMMC+Ppo2KLjqFQ454Qi7mjGrJyqu14kGIoOD96FPP2YNtpT/1PLvqXZdglzDE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XsSsL4xv5z10W7q;
	Mon, 18 Nov 2024 21:19:50 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 84220140360;
	Mon, 18 Nov 2024 21:21:50 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Nov
 2024 21:21:49 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<dust.li@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <liqiang64@huawei.com>
Subject: [PATCH net-next 0/1] net/smc: Optimize rmbs/sndbufs lock
Date: Mon, 18 Nov 2024 21:21:46 +0800
Message-ID: <20241118132147.1614-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200001.china.huawei.com (7.202.181.227)

This patch changes the global lock used by the buf_desc linked list
array in the smc link group to a smaller granularity, which can
reduce competition between links using different bufsizes and make
them perform better.

After applying this patch, the main scenarios that generate benefits
are as follows: multiple threads use different socket buffers
(sk->sk_sndbuf/sk_rcvbuf) to establish connections concurrently.

I constructed the above scenario and compared the performance of
socket buffer distribution in 4 sizes when multi-threaded in
parallel (tested using nginx/wrk):

On server:
smc_run nginx

On client:
smc_run wrk -t <2~128> -c 200 -H "Connection: close" http://127.0.0.1

+-------------------+--------+--------+--------+--------+--------+~
|conns/qps          |  -t 2  | -t 4   | -t 8   | -t 16  | -t 32  |
+-------------------+--------+--------+--------+--------+--------+~
|loopback-ism origin|6824.01 |9011.71 |11571.07|12179.72|11576.88|
+-------------------+--------+--------+--------+--------+--------+~
|loopback-ism after |7280.63 |9508.53 |13173.27|16368.93|14664.51|
+-------------------+--------+--------+--------+--------+--------+~

~--------+--------+
  -t 64  | -t 128 |
~--------+--------+
 11080.98|11909.36|
~--------+--------+
 14664.51|13112.89|
~--------+--------+

Test environment:
QEMU emulator version 1.5.3 @ Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz

liqiang (1):
  Separate locks for rmbs/sndbufs linked lists of different lengths

 net/smc/smc_core.c | 66 +++++++++++++++++++-------------------
 net/smc/smc_core.h |  9 +++---
 net/smc/smc_llc.c  | 79 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 51 deletions(-)

-- 
2.43.0

