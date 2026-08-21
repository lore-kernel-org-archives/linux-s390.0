Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890B3B813A
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302017; cv=none; b=kqgXraRWhlACjMCmoxPrNniHy1zJcMZoJCmO8/Y10dhpCiZkv1r3hs8n5fKeTnu7elUhAe0IMkGHhjR3YwzT1ywjU4B8eKq5JOnVDL+rRF0AXi+C7nZu+PLZfoKaf8lVs7qMcDsR6fy7NRYWsryDRIbltPQm0hpk8p4OBsITPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302017; c=relaxed/simple;
	bh=ejzB1iKMIn4u9bg7Cq13/HRXh+7B+Fi6D9F5qX/CXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPEdwo6Gj5nSTYL48aBI3G5bgnvZfBhzbJIkHtUQZTSlvrp7osKXFq1HDpJjJ+IThRXLBEAvE1eJD5Que1C/PuaG4RXA9o9MsmtsXNZFqxIrccgGS1g1TQqAtgKQKFzQnCGkmRBTYpebvLmnzgqNs4acttu734M+bFMNIcOkOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fR5tKFx2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fR5tKFx2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WM3b981597
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Tj0u80JoJJMYZZcGH
	iCpophjZNtpmxztHG40MT/itcE=; b=fR5tKFx2Hn/I3NFTj2H1OMYLiZZIWyzSX
	ftvtyMTW7piBtT0epAHiyuEcBJ2vkKYsrT7UyEfOjlMxUOX+UVndx+2W6AG5nakZ
	iQFomjttsztxClqPfcFKVrXU8+M6+t0mtmvBy+UT6uYKADjwiSoaRe/g9k5NlCWU
	+cysRZKvwhm6c78KtQ1PjhHJX5y4vEBapFwsRU7JDPujNMNBzNu8E3AGBbB4k15J
	wCKjif7ksF7wYo2GvQK+g7ZEq2vWy2MDIoCibQoTPy+aCJpDcHqCdCIgocB650j8
	oxPqwe/B5J+gyDMbN0Y5Qp5d30bZ2/fDwaZlUIzs7G8j7pbe2Gc/Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0rafr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67L8fgEs030872
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhkjw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:46:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67L8kn4253739798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 08:46:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C5CC2004B;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E7282004D;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.162.88])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 08:46:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org, dengler@linux.ibm.com
Subject: [PATCH v6 9/9] s390/crypto: Enable CONTEXT_ANALYSIS
Date: Fri, 21 Aug 2026 10:46:48 +0200
Message-ID: <20260821084648.23222-10-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821084648.23222-1-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88107e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=76iW4yKgqpReaEcOz0EA:9
X-Proofpoint-ORIG-GUID: qlrMCokflY2Dgb8aSf5N6d0_p3HGus0y
X-Proofpoint-GUID: qlrMCokflY2Dgb8aSf5N6d0_p3HGus0y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXxU9n8GxLwdEg
 mMpsfUlb9pzI8Mg8jFdD4IPZRIi7GPyLWdjCI09Zquimpx0RseKHOxQVOeZ1Io63Cb2OZHLIlot
 6/aR+k4RLpJ4UcCFqW2vOB0tzNT+wJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfXzpTaV2ZxkQaB
 HsD0Bd3fzOqWDub/z19lEnu3LmlHBTszTbLOiLp2iauxFdbEJBvFq9EX6M8LgH/ODb0wHRHBlDt
 6nIRXvY5xsdc9yqOZQmHc/h9FEUkySP+cWx+94YwSWli9qZAGb6jmAeKX05TQDcPDnTyoAErOOB
 9TZ1h78ZS4wqPtGnPV5kF4b9eVZ4UbPhNOwvFsQtDWNwBxdL7DKdaBQ7R35dhD1h7Qy9ScKwoGG
 SllRaduEQnlcmgZz7CXAEdGc4BPqbl9p1VFvyRoSp+jSrw9YMKNbWMf2CmTP97KvX/Hk45D1jyw
 l3FgTipbqoJFLW8VobDA0HdBck4yHyumTAvIML4XSuaHQeVtIEYaWYi3cy68KUzjqWIj2nApTFA
 xSD4fC6EiTEYx/TAIwpdDHI/Iv258A8rujthD+kgU5BOtsMDaRl67BMIOqlo2d+NGLhwK/tmHXd
 o3nl6+JZwFax/k13QnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210061

From: Heiko Carstens <hca@linux.ibm.com>

Enable CONTEXT_ANALYSIS since s390's crypto code compiles now without
warnings.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/crypto/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index 48aeb0c0ffbd..1d6420813935 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -3,6 +3,8 @@
 # Cryptographic API
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
 obj-$(CONFIG_CRYPTO_PAES_S390) += paes_s390.o
 obj-$(CONFIG_S390_PRNG) += prng.o
-- 
2.43.0

