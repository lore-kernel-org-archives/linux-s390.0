Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61776148FF3;
	Fri, 25 Oct 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842398; cv=none; b=cB1IXQYYTR/5x5YVjqq7DTOu9eoH1fNYWgAro9NpWAqXw31fLwVF2sH2ZLvkXOyoFyGqWuTn7Z2MftZCBzYhoVQSpW5s1Qj84KWILPdXjA1m+al033CDpdtXkR4HKxEyFuOWVSwztWzUEsfepcAsLZNMxgFiBvqMn0ag4J58Itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842398; c=relaxed/simple;
	bh=46MXDe2oTR5tffSoLrEsCteBeotT4JBOIRndU2OINzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5ZLiQUuY9S40P0wHUu+fbBlZ4/SRDSaeaBqovZ3xjA70xSsXfQnmcfzVV9BM2f2fsR3Yr9fMqcYQBiED/Gq7tCY4u1B+JHH/pLZGO98G5zaWDZ/18cCLKkzcqDVyAfuwaHkkIx4+MdNJGR5o/F9OKWlyys/H1IqqZ04PRlXpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SH9fK3dj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SH9fK3dj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P30jPE014296;
	Fri, 25 Oct 2024 07:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uwaR3RYfk9Tj2r3BcmralzZk7+7rVauBARMK/l5Qd
	2s=; b=SH9fK3dj4bdyFJFwlqmn6wy7/kQM/jy/zg5c7duQA75zf3MylfyKtPxus
	KNfxTyZsVEAlKnHYRCgr6tSHhDP2NMGADF7JUJbIsQMnI1Qc12BgDkwKtXvRGVmk
	Z8MlaX6uQCEuclLzuZeRvmcaEiDpJ+vP2p12zMNEU9FxeBakBFjlfblyfpibMcCQ
	5w9kGjlNY56MqA/AJ+7mmbZM1pVeYWpoIRIBztfM4g8khqCukBjbzpXc2hR+vXJ4
	OHXMsKzVMuHszPSZ3TJq2YOqN9CVHZPVxUbNXn5w5ok8+w7vR3ks8vFP7Lr6ZN25
	Nf7a3EFbMMc/t7ftw98Bfb4sSX9TQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw46ygb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:46:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49P7kR0m015323;
	Fri, 25 Oct 2024 07:46:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw46yg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:46:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49P6cT75012603;
	Fri, 25 Oct 2024 07:46:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfmmy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 07:46:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49P7kNXi47186242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 07:46:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BFFE20040;
	Fri, 25 Oct 2024 07:46:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FF322004B;
	Fri, 25 Oct 2024 07:46:22 +0000 (GMT)
Received: from MacBook-Pro-von-Wenjia.fritz.box.com (unknown [9.171.42.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Oct 2024 07:46:22 +0000 (GMT)
From: Wenjia Zhang <wenjia@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Subject: [PATCH net-next] net/smc: increase SMC_WR_BUF_CNT
Date: Fri, 25 Oct 2024 09:46:19 +0200
Message-ID: <20241025074619.59864-1-wenjia@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QGKfT0R2RIvsGq2lnraKdazLX4GY4LZ8
X-Proofpoint-GUID: ruVvwzFt31K5PuObxpMAqFDFZbiP9UOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250058

From: Halil Pasic <pasic@linux.ibm.com>

The current value of SMC_WR_BUF_CNT is 16 which leads to heavy
contention on the wr_tx_wait workqueue of the SMC-R linkgroup and its
spinlock when many connections are  competing for the buffer. Currently
up to 256 connections per linkgroup are supported.

To make things worse when finally a buffer becomes available and
smc_wr_tx_put_slot() signals the linkgroup's wr_tx_wait wq, because
WQ_FLAG_EXCLUSIVE is not used all the waiters get woken up, most of the
time a single one can proceed, and the rest is contending on the
spinlock of the wq to go to sleep again.

For some reason include/linux/wait.h does not offer a top level wrapper
macro for wait_event with interruptible, exclusive and timeout. I did
not spend too many cycles on thinking if that is even a combination that
makes sense (on the quick I don't see why not) and conversely I
refrained from making an attempt to accomplish the interruptible,
exclusive and timeout combo by using the abstraction-wise lower
level __wait_event interface.

To alleviate the tx performance bottleneck and the CPU overhead due to
the spinlock contention, let us increase SMC_WR_BUF_CNT to 256.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Nils Hoppmann <niho@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 net/smc/smc_wr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index f3008dda222a..81e772e241f3 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -19,7 +19,7 @@
 #include "smc.h"
 #include "smc_core.h"
 
-#define SMC_WR_BUF_CNT 16	/* # of ctrl buffers per link */
+#define SMC_WR_BUF_CNT 256	/* # of ctrl buffers per link */
 
 #define SMC_WR_TX_WAIT_FREE_SLOT_TIME	(10 * HZ)
 
-- 
2.43.0

