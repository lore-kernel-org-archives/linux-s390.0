Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06E3DD86B;
	Thu,  1 Oct 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850790; cv=none; b=GjTjY8MjvvXi+Yz4NFt91RnzIOUzBGuP5JeNjFX4RasQb4hDzCYUJ0Zm5geg3aT+AB9bUoalgQIBQXS6LdxVe+mwfvU8Uud7taFjPTx79YAKhpBQ/Dc4uBDLc/fLahcXCdVXr150jgqYNhw0Omh1RSv7sA7IY70/jyZGM8eZ4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850790; c=relaxed/simple;
	bh=uViMBcScRNQKBCsJQ8YxDpkV4cjNl6KyEBl1QgQEwVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FULRxNn75bfm9K+WPfz6rKS7LIuzFjXtq3oqs8ZRl/K/J0SYxcmiFTf7udKCLflMb3ai3FUEs05Yb+Vn+ERC6fP36iI7APPgZriYFO4PPs5vTvjxNC5kgboQX9ZL9NxaD/xs12JbLQkNz25KhMEViv2oXgz97voy0awIEmveqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GWxDq13t; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GWxDq13t"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Qj3907213;
	Thu, 1 Oct 2026 10:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VSzFr7RoYIS0Hchfq
	WmGIXW8xAn/ciwQZgf6yS9ekm8=; b=GWxDq13tF6INE6/H61EZP0yLnkxL5YrzG
	ZDggzhPLZPl8S4m4mD9kcVrzhNAJJUp6KWKKup4uABiMFtjsBnsTS6yDZq+lQL3D
	eio+5CTsF0jtwhnROEDhR53L66v9/DHbu6zpHduLvI7kWkNw+xyycwItLQIHx8Hs
	4CqnjHmfUaKq4OJobo7lf5C4IHQbAhM/9IS0zjAaUVbj0WU9FIUhc3RuI802SoFr
	qSeKKO1WJpNoZMP22j582FCBE0I4go4nG+r1oAj8lJbn8PqM9P0U0t1pazmzQva3
	OsvFFtD1G2t5zzMqbSFppsG+AlBHnb/fEi/YvbkirkpH5PsKLeTJg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhsq1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Yrh589689;
	Thu, 1 Oct 2026 10:32:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWqm341943374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E8B20043;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 150572004B;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 15/32] s390/mm/pfault: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:30 +0200
Message-ID: <20261001103247.1989111-16-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lK6yK1ceumKsvkJUxBOQpm6f_Gy2H8LQ
X-Proofpoint-GUID: lK6yK1ceumKsvkJUxBOQpm6f_Gy2H8LQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX/sZ6bGuI+9cz
 5jg0oXyWETy4frAx7LyVFxBnqr0FR7ldsEVtfmFrbnBUGz7ZybPVToV39yb092k0AAnhscWJAYJ
 NYA4hS/tADHVgOIY2iodEv0iSWJMayk=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36d8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3Mkypv_2sK6Eo9g2t0oA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX+AIOSUsivoed
 5smWEoacZgwgJq4t/++GYpPBeHRiMquout097YnzL8TGe1EU+8vAo53BHAQBARl0bQ7l2NPvMwh
 DeOWPC5tU8LVzmR0acAS7IDU1vYnIVGNgFD/7Goi4s58aRgowrG5F78Q4BBqyfD9XlR5cK+Uwgr
 tLfRsyuZpdwXwstF8CQFTfWtAs8lyWQsxVtEbfKtzZ6A5PysyrCScH0PGlAfIhLDtaJpK1KFFrq
 eHQVodnbiGWPGRhSuWme+6Ts6+xMB+7rKTGvRYAD0jaxnTsJ+0eY3ejPZKyTWEsdglqMIaBdr8S
 y1KRGnGEUdqDuO4pl/eoZkeg6nnVD8SAQmozc1jKaigMyixtPCCJ1l1bMkRMJA3HDE+cJ6GhoLx
 NOzAVDeGtBASgSX/RCqOVoWJ6RvrBpLB+JiVVgZFSd4lwiTjiK6js2TwhpUavr2TeIoR0gDM8O+
 XKp8U08df+z5e/sK7hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all pfault exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so nopr padding is no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/pfault.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/pfault.c b/arch/s390/mm/pfault.c
index 6ecd6b0a22a8..8f37741471e2 100644
--- a/arch/s390/mm/pfault.c
+++ b/arch/s390/mm/pfault.c
@@ -58,9 +58,9 @@ int __pfault_init(void)
 		return rc;
 	diag_stat_inc(DIAG_STAT_X258);
 	asm_inline volatile(
-		"	diag	%[refbk],%[rc],0x258\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b, 0b)
+		"0:	diag	%[refbk],%[rc],0x258\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [rc] "+d" (rc)
 		: [refbk] "a" (virt_to_phys(&pfault_init_refbk)), "m" (pfault_init_refbk)
 		: "cc");
@@ -80,9 +80,9 @@ void __pfault_fini(void)
 		return;
 	diag_stat_inc(DIAG_STAT_X258);
 	asm_inline volatile(
-		"	diag	%[refbk],0,0x258\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b, 0b)
+		"0:	diag	%[refbk],0,0x258\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		:
 		: [refbk] "a" (virt_to_phys(&pfault_fini_refbk)), "m" (pfault_fini_refbk)
 		: "cc");
-- 
2.53.0

