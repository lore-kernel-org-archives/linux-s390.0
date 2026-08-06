Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFE48035A
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031598; cv=none; b=SP554sk1OWolVd/iEjqbc7n1LNg5AffscT7YGBRYv9zsoNyvLaM1dHtVznmMfRmN0jwm4GN3AhvSodvdDaBy/J0UOY0TjbvJ2ZImNviqiQEh25c64ehJ1sM346nPE4pbCDsBovTBNeAlTquYC/3tyx5dAUHg4naNMvZ+KqZULSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031598; c=relaxed/simple;
	bh=Yy97q+WWvbed7ENAiuv9IAWqiGkjw7EhcXg9HJl/orc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8/nfm6gexr1UjVbDxYt4ifBYoF+QH4qFrWcdoQh900Klzqc3e0bC/zdRwDHC58w64uIAcgI+wVH7EkGDu87tJiziMug+UY/r/34SrDW2+RyKUgL1CemlokXTYQ4/dN34usab/iiqFsnNFOY3aHPukUzp2UwT8r0IsHBmy/95Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bC15cRS4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bC15cRS4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnQFw2872725
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1qTLURWQ61el06gpE
	jRr7s1Y5s+QeMRxJPOiV6z21Yk=; b=bC15cRS4lxugzkU+KQkvIyM71769mst4n
	ruXBtIsEfbMqMjGPKR/2nLnut68TC/RgDS+ez7Vmnvg/BAr4riMgjSXFW2Jw0Tc+
	qBAzfNL1egjE7n/OLqOBvIx7+tLpCmC+M2KxaUO2zAeqYDO/rXcte0XYTLth02zC
	6dRE2gYFidGYBnxZVmTv3hs/0bsMz7C/HfYleH7WCn6/iKL/l6c7dHWnignOLNH9
	ySLwnIBTtwgDZZ44IOvFldTg1o6WR3fH4NTJA1zyqjuAb3MG3APGJ9zPPa9s1Vnw
	prwLQmneR3D9wS+A5Tsc/wtU8hLxm8A0EndixjyQPI9WAWJ4/Mbjw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67j0rjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:53:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676FfGq3009969
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 15:53:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyuku9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 15:53:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Fr4aK26280392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 15:53:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 063CF20049;
	Thu,  6 Aug 2026 15:53:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D75952004D;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 15:53:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390/char: Enable CONTEXT_ANALYSIS
Date: Thu,  6 Aug 2026 17:53:03 +0200
Message-ID: <20260806155303.2675932-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806155303.2675932-1-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfXx+UbvAHCr5p6
 UfQaLIpFcJns51VJjp3bfqABw809o5Do2mMjlhwImWa+I+lRCL7TVwtZd0TNR8/sxiUWug58shY
 Wo0NCq+uMedeCogXW3cJBh/YJNq1E1A=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a74ade4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=F-nILArENMjig5taxAYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMiBTYWx0ZWRfX4TXRhADXbsKz
 camZueMC+c/8Y0q8UoFZY9io7kLBapEP23662rRD+uCk9cwANqTXiLnEljheqcrjt7qxcdHyxDz
 WSr0hs8kR/Tvm1L8fRG+ajqo+d36nGuEQHfP1W+w+hXsyyJhOwIMdDxfadZqnvXzurpUYUHxxHY
 nmGUcSoKbQSovBxpfAGTCfFqxRpi9H/REQzuAvcdDo29FOODmBb9yZRE1U2SQXU30IYY8yJmU69
 3l3MKsBex75YedziplU7u59hTWP1xcFbv/e9o26rR/cInx65IrjZq5WmWg7L2Dtxmu8Ru/bJH8d
 4GGAoYSvLldbfEdedi4DkcvUFyr4nWOEjR4DEqYls91wU1BbZQGTTQazW85ObQQqoBYxV4MlZo/
 /Y5LU8mwst6IRNaInVdOLXN+GF01Do6z/B0VXL0pHgqg6uDO4TtgjbA8DABAbeNBQYdN7vfnRmv
 wnmdTM2uoLN+zNZe9+Q==
X-Proofpoint-ORIG-GUID: 4DoLuaqlaxos266jwww-XlPiRsgZm1jF
X-Proofpoint-GUID: 4DoLuaqlaxos266jwww-XlPiRsgZm1jF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060122

All character drivers pass clang's compile time context analysis.
Therefore enable CONTEXT_ANALYSIS.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/char/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
index 126a87c3c6f8..0ad960d000a2 100644
--- a/drivers/s390/char/Makefile
+++ b/drivers/s390/char/Makefile
@@ -3,6 +3,8 @@
 # S/390 character devices
 #
 
+CONTEXT_ANALYSIS := y
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early setup code
 CFLAGS_REMOVE_sclp_early_core.o	= $(CC_FLAGS_FTRACE)
-- 
2.53.0

