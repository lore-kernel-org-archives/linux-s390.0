Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A81CEE8C;
	Thu, 26 Dec 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735215748; cv=none; b=U4oct6XJ/dyGOiFGomI0T6QABkHu8ZYHVDg9mKKtGJXwPinbR9uFSMhp/f9V8XUxkrm6aSjy50e/gNJTZ3bPaZKpmc+w9aIapb/SkJGx6p7w47D0EgkYTO0zDyN1Q4RAIGqpHtaEHFCVojvm005VDs0LTusT0wY2S77RS8dZc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735215748; c=relaxed/simple;
	bh=rcj295rZMETQ/yazzX2P6QFNz0LkGj5DCURbU0FN4hs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kaz+ZEABmH5KMnJYN9CnuSRi7uKQ2XpS14mmXr+PyjKnFBFPfwW/iJfoC4Zl+ThSPESN9/cUmf3QeB5BK9pgTULfMEqFNHetmgIdOmXgF6HgK8PtJZaZYIdh2/yAKjOhv7R+/lNZjfmllfyx+n4UPAFSAIcypBiN5Ti/ya7AcI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YJnlS4V4kzrRlT;
	Thu, 26 Dec 2024 20:20:36 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id C3C2D180A9E;
	Thu, 26 Dec 2024 20:22:20 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Dec
 2024 20:22:19 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <liqiang64@huawei.com>
Subject: [PATCH net-next 0/1] net/smc: An issue of smc sending messages
Date: Thu, 26 Dec 2024 20:22:16 +0800
Message-ID: <20241226122217.1125-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
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

This problem can be reproduced using netperf and netserver.

On server:
smc_run netserver

On client:
smc_run netperf -H 127.0.0.1 -l 1
[]# smc_run netperf -H 127.0.0.1 -l 1
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) ...
Recv   Send    Send
Socket ...     Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

131072 131072 131072    0.00     1723.79

This is because netperf obtains the smc sndbuf size as 131072 
through getsockopt. It calls sendmsg to send 131072 bytes of 
data at a time, but smc actually returns after only sending 
65504 bytes (65536 - sizeof(cdc head)), and then netperf 
terminates the test.

In smc_tx_sendmsg, the processing after the sending ring buf 
is full is to return directly, so the above phenomenon is caused.

I would like to ask if here after the sending ring buf is full, 
enter smc_tx_wait and wait for the peer to read before continuing 
to send.

When I delete the judgment of send_done in front of smc_tx_wait, 
it seems to work normally:

[]# smc_run netperf -H 127.0.0.1 -l 1
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) ...
Recv   Send    Send
Socket ...     Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

131072 131072 131072    1.00     11543.80

liqiang (1):
  Enter smc_tx_wait when the tx length exceeds the available space

 net/smc/smc_tx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.43.0

