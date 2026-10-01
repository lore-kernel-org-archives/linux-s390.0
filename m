Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F823F5BD6;
	Thu,  1 Oct 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850784; cv=none; b=b9ZmALQTwUQ7SJznJVrbbRoBeBDLnG5uehvgXKznZGiTyonYO35NWLpPcl7YgG6tSynBBpzvhldrkAVMfxM18BiqbqQhg/rMqA0OxZ8UXrrLo+P3TFA7guW5JeXkq4nP4+aHdvpXIwGX+D+YRR4QpnoPMLQdtOs+7XaPa8rBLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850784; c=relaxed/simple;
	bh=HjAYlT+/3G1HDisxfpJiZGYzPxRA3pGkg2v+jRaYxB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ivc+QwrDTqRGDqhZ3abPMa2SweR0ILTd+MzlOAVlHukos2OmrFS7NAXIK0Q7B4jM6jjR0ilbK93jy7eB+j5iyRQya6zx4RKBBo8YyNi1R9CATqgDrOsLk6MOviBzoVDxqKlJUogeI+kHAWqUdI+DKrrLx2ULa5dkKKCT3a52H6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QQikx2DH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QQikx2DH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175UED1086045;
	Thu, 1 Oct 2026 10:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=R7z4WzCRH4E+t4PHh
	a0+xhMJRZzQeU9VXESA600uIzE=; b=QQikx2DHR1pApTWduXvxJza7k80qxIBlz
	MXi9io45pgy2EcC+AKZIn3jIYNNOFPL94eM8PbVVK0vBP5hma5T5/kZQjhueAEN1
	OE5xNCbQPXf0QIWKmjQCVA35PPzCYJv1SuztFfOBZFNFJjWIdL6QC0fm0XYo9Fxp
	+3nElhrAZmiO5NH/CvSfyhhlvF5bUfQMv/AtVBWA5VqzgNa4thsRRVoLhuYE3/cn
	1iL1KxM0lmLaDIxxjWq1aTLYom7d72WH5VG/fhPF9K9xle/oiLDU28Ol/ptGpYi9
	cYjVJeNAfqSKP8pMBg+yLVXlN8ZFvUktcBf43Js0mTe8G+nENAMnA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthcgr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172VKB520696;
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpga5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWoAr39125394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2518120043;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDBF42004E;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
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
Subject: [PATCH 07/32] s390/traps: Handle nullifying program checks in get_trap_ip()
Date: Thu,  1 Oct 2026 12:32:22 +0200
Message-ID: <20261001103247.1989111-8-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hrtMVyk2GRGOXBoUTlGLBsCzIDtvID8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXy5KjbwD+blwP
 jkQING/xEahG8wNCB7A+VS/DFvfyly3XJ8lLffbMAnJJFes71vjdwHGFPqmH5WBeFnfQQxE4y2E
 ai4q6TUA3SEK87IeaYghqmx7OPvEForJTW1CGoFoF5+SEqdaMucf8YjUULP3f6+eU/t5XS0ohzC
 4BCci6N6JuvOI6xIeOTj3R0WBzlksLFwYlfp/GynttOsk0/FHWn7nLi7YZB7zTqiQbqQvuvaOAX
 Ld+Js9uOzGoqDo9Cski1BZcFuck3dkMzB9LjaiwJQga2V4BwihevyH43QisNiN+aDAONIPoqDjs
 3HC9upheSmkHBfYWOWLZeZwkHVgQ5+ViJSy/BWxTD/oN1qcyOO5HcNiBbvVrT9OxcZ4pjzqrGdN
 y+fGvyDYB00ONbUTwipT4sn+AvqBz7vxZ4vGg2CZOeCOrobSqV2XRrhMEC7XAqDJYe26lqF1J+M
 DfiU2tKPW2piKdS7a6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX0kF9gBIggJyK
 u42dS118obJs7GFA4HlkyRfDbhLu27fkzMohMGunkGKcRZE1fFjxfW3AYAPTbbInEiSGvtDPsiw
 /bICcLQRnA+dLG5eljglg+IkMwfT3E0=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36d7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=fKu-LFWVd_A3OLCxid0A:9
X-Proofpoint-GUID: hrtMVyk2GRGOXBoUTlGLBsCzIDtvID8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

get_trap_ip() always rewinds the PSW address by the instruction length
from the interruption code. For nullifying program checks the PSW
already points at the faulting instruction, so rewinding is wrong.

Add a nullified[] bitmap and return the unchanged PSW address for
nullifying cases, or if PIF_PSW_ADDR_ADJUSTED is set.

No functional change for existing callers, which only deal with
suppressing, terminating, or completing program checks.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/traps.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index bfcab4592299..5e63032a56db 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/entry-common.h>
 #include <linux/kmsan.h>
 #include <linux/bug.h>
+#include <asm/pgmcheck-defs.h>
 #include <asm/entry-percpu.h>
 #include <asm/asm-extable.h>
 #include <asm/irqflags.h>
@@ -41,15 +42,19 @@ struct pgm_stat {
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct pgm_stat, pgm_stat);
 
-static inline void __user *get_trap_ip(struct pt_regs *regs)
+static inline unsigned long get_trap_ip(struct pt_regs *regs)
 {
-	unsigned long address;
+	static const unsigned long nullified[2] = { PGM_CHECKS_NULLIFIED };
+	psw_t psw = regs->psw;
 
+	if (test_pt_regs_flag(regs, PIF_PSW_ADDR_ADJUSTED))
+		return psw.addr;
 	if (regs->int_code & 0x200)
-		address = current->thread.trap_tdb.data[3];
-	else
-		address = regs->psw.addr;
-	return (void __user *)(address - (regs->int_code >> 16));
+		psw.addr = current->thread.trap_tdb.data[3];
+	if (test_bit(regs->int_code & PGM_INT_CODE_MASK, nullified))
+		return psw.addr;
+	psw.addr = __rewind_psw(psw, regs->int_code >> 16);
+	return psw.addr;
 }
 
 #ifdef CONFIG_GENERIC_BUG
@@ -62,7 +67,7 @@ int is_valid_bugaddr(unsigned long addr)
 void do_report_trap(struct pt_regs *regs, int si_signo, int si_code, char *str)
 {
 	if (user_mode(regs)) {
-		force_sig_fault(si_signo, si_code, get_trap_ip(regs));
+		force_sig_fault(si_signo, si_code, (void __user *)get_trap_ip(regs));
 		report_user_fault(regs, si_signo, 0);
 	} else {
 		if (!fixup_exception(regs))
@@ -152,7 +157,7 @@ static void illegal_op(struct pt_regs *regs)
 	int signal = 0;
 	u16 opcode;
 
-	location = get_trap_ip(regs);
+	location = (void __user *)get_trap_ip(regs);
 	if (user_mode(regs)) {
 		if (get_user(opcode, location))
 			return;
-- 
2.53.0

