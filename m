Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B091AE877;
	Sun, 19 Jul 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466017; cv=none; b=FfifMa4IiIeW0ArBSfnQCCpPCr/yY+rrmGLvGQ19U2M0+QlrBayDPiugnuSURkGosfGiyYIjGjsQ1FYW58EhPYyPiA1N3xe790mU6yI8FJWtFEk2WeQ3NjZs89G66H5FHUuCn3+U9X/UbKXIPaki07p7cJjRUQrD5/toP32lnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466017; c=relaxed/simple;
	bh=MWTPZS5lx0atrLjiEqr3hlHJCq2JP9RkV1czBmu0Vgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMTAYduK/YNIbzObi9POndBQabPYhJbIqVF8DRmu5cnyyG3utdd1A0VLbyTWIvB7WvqPPQJE8BFmpUnjlRWq2WSJNCr/eDMpsxeBK+tTx9/be9OsJIQiVcmDLEnctIJbAJpnmTOOWCGPsXvDpFP2eXOLGln62k6zh6ZxDATrtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZsLfxPE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZsLfxPE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBC1Ea3271757;
	Sun, 19 Jul 2026 13:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Rx96jILEkXTyn7zof
	u7vcAVAXb1hJZc/0eVKU1nhskE=; b=OZsLfxPE4cTPc1NyctoHDd3SSQl5G8+NW
	6keHdgzypOJUghz3HJFrccK+zXOBkSu3Hx54wkcsICFBrXYNtfNTKs0KzLAxsQyp
	CJjHr1HZBo362VoMQEv6IVswdvhyt+TNRwNS6y3nOQkvtePObtkwjbj7wPAN625a
	89ZinLANGJfKQktVfNL+1sDyoKhCaCOxA6TtS0V0jGlci3B0yVQgJDAOJUQgjaxd
	Wn8doqsDLkszK57uRndWYwyK4V+hc9ONxY6i3jMt3PqLfmfDrAp84jrZ5FS0Wj2u
	kut7Dz9SiLrGxdFsBNvZP3RKRzPo7tGFQZTxyVr1N0ZFHIrk1ggLg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jucq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCneZY016714;
	Sun, 19 Jul 2026 13:00:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpstjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:00:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD079q15925664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:00:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8EF20043;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587032004B;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:00:07 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
Date: Sun, 19 Jul 2026 15:00:04 +0200
Message-ID: <20260719130006.3882764-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130006.3882764-1-hca@linux.ibm.com>
References: <20260719130006.3882764-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5cca5c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=aTeQ_7Lur19LOBhsqlcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX3pMSSe1YvNSQ
 TfBOXKtHZeMw45HnZYP+LSj+jhXUboWyFs+7ovZg8T193kbd0IsUyEklSyqm+s1icBA9hCf5Bci
 0/TiTQse622yxlTPFRW47tL41eQb65StOP8CTOoO9Eu8CLidGnyx0n3sFoSt5FQjVzleYdUidhr
 j6+tC7ZgEIa4ZyYNDhKzd/FO9mKHof60Puz5EdJSirIeKLy0+woSqkkhm5Ku07hnOboTAloxy+l
 N2bO5Ww8JruR3WIxXNkrCnjFVC/oMaZ2M0Z3Q5MpCbkI3jeVsAAC06eLAqYJanDdRJDujzZkbJ4
 J8NSuC5OVXkRs3ysV/RCqUTaeE9KOFZorSXRaCEW90XlEaYo8eo/Sfp5Z3NBtqWIQKse64a9WqS
 Aoh5+Gv474B/H1kW3bb0Ymbf0NrO3+wzrsKwsiHwqhH/LROzRlGBH3FU4bX28e3c638/EYEaT14
 S2eAm2LPQTls/jFxXlg==
X-Proofpoint-ORIG-GUID: tKgeSyEP82UEHlq3EB15K0l10Tgvu5HH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX9vt35M65N2eR
 BdKOlgXRnriS5uLhH1nQA+iMdS5qv/RZp8jmG9Pjf3oMCow8zZidwnViDKo42WJKv6D5fRerp5B
 scfrBm0d7xyg9LuQPluP/8GZf2+OXjQ=
X-Proofpoint-GUID: tKgeSyEP82UEHlq3EB15K0l10Tgvu5HH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190139

Secure storage access exceptions in vmalloc area need to be handled
separately since folio_try_get() or virt_to_phys() do not work on such
addresses. Given that there cannot be a valid access let such exceptions
fail immediately. The kernel will either fixup or crash.

Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index f150d97cac2e..e650cdfa2523 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		panic("Unexpected PGM 0x3d with TEID bit 61=0");
 	}
 	if (is_kernel_fault(regs)) {
+		if (is_vmalloc_addr((void *)addr))
+			return handle_fault_error_nolock(regs, 0);
 		folio = virt_to_folio((void *)addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-- 
2.53.0

