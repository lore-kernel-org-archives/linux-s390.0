Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFB471CF0;
	Wed,  5 Aug 2026 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936996; cv=none; b=nm4/lV8I1UhXl5hBu+r8StaUNSbAoGnvBqlgAIT7IlexhdV6psFIxUlo4x/VSU6PNv2Fx47RNmOCUBrDtRlJ8wNCuJ/8mgvCo8QDp8wpZncTikRczhbRPNSTZx3v51Z52jilheO7f3kyO1rh5CcTgHHhFe72mGvmDgF0T7IkItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936996; c=relaxed/simple;
	bh=Nd1kCbjS6DjyiQUeEp5JQBA3E+JbcJvq6eSHAW27iqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWIQ+trX/ls4OfMWQ22aSdtGftE4dCeAD5H/IOJL8wl4+Pog2re237nINhRJYJotyWvS6KSTQb81lYIwLz4R1zh1kqMyynB1AsDsk86S8CE2laRxbvyAo4G/pIkB2Tzo8afs1Ep+oe+TMQMJCgUWFSJ+CvizBnG5FWqWkOgqE+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+0WJjrJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+0WJjrJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHcYx3825244;
	Wed, 5 Aug 2026 13:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d/rKO0V/9Je4Vlvfu
	P4mGZc9y9/FOzVINEuDVu8jQWw=; b=S+0WJjrJfioTl16cYj2tPSvF8jvIRrZMF
	5oqinJfJjvEsPzIvZrgx6cou3s7h+NtMfg/cJt1iCLLuAYYzG2ZRGAYiElYOl2BP
	w7EqOw9ATuOlaWTd039a5dnwEA2Y+Un8cSQA5OXPA37m21yw3voZr2dPOafiEzfy
	tj5akFsY02iPyUgc9PlUVIESVXuc+KGh7DLFJZ4uSGSX2DGuJMLOtvab8Az1J5j0
	9L1TGHyABBbKMg/no5UqE/V+lxHwYgCp+KIi+pGVFIsf397Uyzubn9TNx4Qiz7Zd
	xqSbk2dLYoZBJXoslpU0/aaSlK4cfbZSfcSb0pIqACeQqutXzgrYg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h539aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DQHnn004402;
	Wed, 5 Aug 2026 13:36:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qpvjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:36:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DaSX149545726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:36:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A24C20040;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44CC52004D;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:36:28 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] s390/pci: Enable CONTEXT_ANALYSIS
Date: Wed,  5 Aug 2026 15:36:27 +0200
Message-ID: <20260805133627.1216607-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805133627.1216607-1-hca@linux.ibm.com>
References: <20260805133627.1216607-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX83rtpIwTZqDx
 YnAJEu7VwwUoXrazvXVZG7l5xCyUp4uo2aR8w07V3LRGzGRg442TVURz5gDszZ0H3whfUGtfHAw
 GrqjQITn77H7A0To22oouNxDC49sZ40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfXwHHKhomF0O6S
 GnqbtYa0+6yB5QsxQ97hlRvM1AcMi7V6Hi+/xYfxiOFp5pr9eF44jIiwvBXwgNyDFv9nBJS0PqK
 YVR4OHvOWnjUQyg6uMl7dpktT10jlTwr6Qk+U68ncKTzGzOqQZJ0Zc3cruZ1WUEQBasaWZfoE6W
 BhZpkH4rJ4Xp3eZ70d0dwafeVRod+wrlF+Ry1sr5X1UlxV1c5NZpi5sNar1icj1H3hjCbx6RN+0
 uZ3wba270whmVuZ0xy9NExevHaRLMUBPxvyDCnE4mMlw7t6oHn9b/i29t7KwrtF4gUe/IKQ0/0W
 cAablTM7mu48luBysBs84UyxXLcdovQ3/doPMywwUC/PkgIV8aPPHFTwl/6MQ/UxmLJBj7BsGlH
 WPxqHUbJSoROBsaT0/25G+dTucnrsphJtBw/2wCsjyC7XjJ1SCxyw7NhYBxuypJ/0lb/wNBgDK4
 ALU4MdvAd+XANr1zBxw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a733c61 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=BVUoiYlOf69TRVgg-NoA:9
X-Proofpoint-ORIG-GUID: 6_chB8N_bDvffaQjInKEPvgGmQdh7gLr
X-Proofpoint-GUID: 6_chB8N_bDvffaQjInKEPvgGmQdh7gLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050107

Enable CONTEXT_ANALYSIS since s390's pci code compiles now without
warnings.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/pci/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/pci/Makefile b/arch/s390/pci/Makefile
index 1810e0944a4e..b8be1316491b 100644
--- a/arch/s390/pci/Makefile
+++ b/arch/s390/pci/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the s390 PCI subsystem.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_PCI)	+= pci.o pci_irq.o pci_clp.o \
 			   pci_event.o pci_debug.o pci_insn.o pci_mmio.o \
 			   pci_bus.o pci_kvm_hook.o pci_report.o pci_fixup.o
-- 
2.53.0

