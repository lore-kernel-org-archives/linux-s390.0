Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDCF1798F;
	Sat, 30 Nov 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955200; cv=none; b=YH9ngv2S/CE1eXeG5iaN8MYV2t85wVUi/9dNJTZXrhCqtpKsjdZkqSGKazeS305j0z74x97T1MJiNette8EnPK32Xo+chI1ORSFY5y15m2MzWDoahr4CdeBdaAaOsgHc7x8j08sFwMOmkB085iidn0jXtA3/5V3scKFxbKvGATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955200; c=relaxed/simple;
	bh=Y8SJTUIMR06Xgi5e3gMvJXWnCrwtiJRS1rmMj72Rvew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tbV8dUZNk7GkxefpmU33QQzwxWF7RnXEoaqd5exD7kU5TvOF2vM782MBEOU/f3axSjWiCVZBlAWIhd2qX1LBpqEtfAL0i6p3/jrQ/EdjMc/XkJlrf1HAtTdwpedYLE92K2quz/XM2SWn0hJ7y7/fkDCpivIPvhdlZqf6464YtOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y0jkt0GMTz1k0nZ;
	Sat, 30 Nov 2024 16:24:22 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 772D11A016C;
	Sat, 30 Nov 2024 16:26:33 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 30 Nov
 2024 16:26:32 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<luanjianhai@huawei.com>, <zhangxuzhou4@huawei.com>,
	<dengguangxing@huawei.com>, <gaochao24@huawei.com>, <liqiang64@huawei.com>
Subject: [PATCH net-next] net/smc: Optimize the timing of unlocking in smc_listen_work
Date: Sat, 30 Nov 2024 16:26:30 +0800
Message-ID: <20241130082630.2007-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf200001.china.huawei.com (7.202.181.227)

The optimized code is equivalent to the original process, and it releases t=
he=0D
lock early.

Signed-off-by: liqiang <liqiang64@huawei.com>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9d76e902fd77..7fa80be1ea93 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2526,9 +2526,9 @@ static void smc_listen_work(struct work_struct *work)
 	if (!ini->is_smcd) {
 		rc =3D smc_listen_rdma_finish(new_smc, cclc,
 					    ini->first_contact_local, ini);
-		if (rc)
-			goto out_unlock;
 		mutex_unlock(&smc_server_lgr_pending);
+		if (rc)
+			goto out_decl;
 	}
 	smc_conn_save_peer_info(new_smc, cclc);
=20
--=20
2.43.0

