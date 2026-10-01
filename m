Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54E4E4C26;
	Thu,  1 Oct 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850800; cv=none; b=ssx9ARGObr4Qf2Jsb9mqzpeGFuUN+LOHU69fnE9j/sp52P3QZ/s8aPuiLaI32aBR+q5BUH4+/twxc+mKziZnuV/F1ohenyUJbBmdsHb+AA+PSMhWoO1Ua5KJYOFCggjCmtwOtVpRUji/ADgMSJsdVX0v4OPWQIIBLUNlaNEqzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850800; c=relaxed/simple;
	bh=wz2ZUsuZvjwX0prGpeDKfQiM8totcPIZfaDSTCVQWgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCYE/BC8Q994pHiUdIfLQ8tc6V2xDewBxezZyPQC7RIJQg/uEjNTgnhF1iZqt/ksXFSODpb4suUtKlS+gAPFhJ2/tMzV1WLYBfOAR8mflxG8IJB5P03pHDaBpo+fbUKraaUmnWT+Is+wZaDKz7WJJhpwJPl9892iz6LjT5kjygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oMIhpWIw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oMIhpWIw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175XRK1086069;
	Thu, 1 Oct 2026 10:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+JmvrHWWJybBoSKAb
	dN3wgadYA26ifJWrv6kZmEt4/E=; b=oMIhpWIwdFfjLP30TBiJnhNGvB3SIoI//
	IePpCoa9i0mQ4m/iHldb4vy+jXVRwTszWWkFDFCk0ueX0y+obkikuEAhGrBd77kw
	pPx2rZatWHX9q9VDfi3L80EfVA22GxUIVXsyZeJMAZ2eptC4Ns4ZfcgWJchn4T1Z
	hHGs7rKNGTGuZH1OmyHgaum+2w/Qxy/4ZDtJ8bgawM0e4kW6DYzGUw1TdOTdCaJG
	hmLQv6c2qI7mTV0UibAJM8ESprF6OeCwqlTRMG6q8L+fXUd6URf6/UujOvnjQljy
	5MqzjLr4LXj1FK/Uq1h0WT9+aMy3m8y2dPlm0T8BKHXb1oCtz5bfw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthche-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172VUk589647;
	Thu, 1 Oct 2026 10:33:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa7tf5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:33:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWvMs42336516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DC9920040;
	Thu,  1 Oct 2026 10:32:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187FF2004B;
	Thu,  1 Oct 2026 10:32:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:57 +0000 (GMT)
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
Subject: [PATCH 32/32] s390/extable: Remove EX_TABLE macros and fallback extable search
Date: Thu,  1 Oct 2026 12:32:47 +0200
Message-ID: <20261001103247.1989111-33-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vAZ_geALm157IMRgrThNbdx6G7UweDjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3bXDRpYzbliD
 jrCkeiJ+177Jf+turUR3No7dd5iPMiHOxR18P12/YMXVJ9sSNiJcX+Yfztek5rFMAhlSXpAJiGf
 67rZonPNG5A43VSZ8tq8ovBFUH+xXmZMD+GzvtfZ4Uz5Q/fIJ1g9NDRW3t+TkCZAJjBzJqf6/hj
 NfSFikUarVPGlBVhSHz0AeAv750zUsV/7D5I4/tgYNNFoD9yL76uMkL5U0jWA0W29qaWguINXPK
 OJM3m/4GNv+Vw3a984TCpG0r3qM4L2VKB4SZ1YcrK+1gwG1ngq8WYYX2QAgHkcUK8ai2WXi0rSm
 a8/b9TCRmMBR7oc/TTmA6BPKC5pWAH4SfrzJoj2BDbchjjnguAUKEL69U0eJVi2VRVyvaHxvSH0
 JsWy2Z5K2GAPVL8eA1bfMi9ZtOnxw/oYOiRJbw5ZUXHfBr9I0LZlDOOgHhsCWGnf5bKn67/4r8x
 0eSNxbWSj336umb2D+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX1whMKqItZOTH
 v9a5ZeKzTxpSy0EZLvTNnOJsqkVF2nTi3nIobhUwhXm/GQYl+bqwaS/AjqB3bOWLBhqEkzQmAUU
 CNClaDdP9aMZX48Mr8awO1zGBvtEQVE=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36dd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=s4zfVSsjitEiAOX-CbkA:9
X-Proofpoint-GUID: vAZ_geALm157IMRgrThNbdx6G7UweDjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Now that all exception table entries point to the faulting instruction,
rename all EX_TABLE* macros to EX_TABLE_INSN* and remove the
EX_TABLE_INSN* aliases.

Also remove the fallback extable search via instruction_pointer() which
was only needed to handle the old EX_TABLE entries that pointed to the
instruction after the faulting instruction.

Add a comment above the EX_TABLE_INSN macros that documents the usage
rule and describe the difference to the previous EX_TABLE macros. This
might be helpful in case of backporting to old kernels.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/pgm_check.c          | 23 +++++------------
 arch/s390/include/asm/asm-extable.h | 38 ++++++++++++++---------------
 arch/s390/include/asm/extable.h     | 25 ++++++-------------
 arch/s390/mm/extable.c              |  2 --
 4 files changed, 32 insertions(+), 56 deletions(-)

diff --git a/arch/s390/boot/pgm_check.c b/arch/s390/boot/pgm_check.c
index 56d0be7e2823..e5a454b21669 100644
--- a/arch/s390/boot/pgm_check.c
+++ b/arch/s390/boot/pgm_check.c
@@ -51,31 +51,20 @@ static unsigned long boot_get_trap_ip(struct pt_regs *regs)
 	return __rewind_psw(regs->psw, regs->int_code >> 16);
 }
 
-static const struct exception_table_entry *search_boot_extable(unsigned long ip)
+static bool ex_handler(struct pt_regs *regs)
 {
 	const struct exception_table_entry *ex;
+	unsigned long ip = boot_get_trap_ip(regs);
 
 	for (ex = __start___ex_table; ex < __stop___ex_table; ex++) {
 		if (extable_insn(ex) != ip)
 			continue;
 		if (ex->type != EX_TYPE_FIXUP)
-			return NULL;
-		return ex;
+			return false;
+		regs->psw.addr = extable_fixup(ex);
+		return true;
 	}
-	return NULL;
-}
-
-static bool ex_handler(struct pt_regs *regs)
-{
-	const struct exception_table_entry *ex;
-
-	ex = search_boot_extable(boot_get_trap_ip(regs));
-	if (!ex)
-		ex = search_boot_extable(instruction_pointer(regs));
-	if (!ex)
-		return false;
-	regs->psw.addr = extable_fixup(ex);
-	return true;
+	return false;
 }
 
 void do_pgm_check(struct pt_regs *regs)
diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index 488bd10452b3..fd43ecd3e491 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -65,41 +65,41 @@
 	stringify_in_c(.purgem	extable_reg;)					\
 	stringify_in_c(.previous)
 
-#define EX_TABLE(_fault, _target)					\
+/*
+ * EX_TABLE_INSN usage rules:
+ *
+ * _fault must point to the faulting instruction, never behind it.
+ *
+ * This differs from the former EX_TABLE convention, where usually two entries
+ * were needed. One that pointed to the faulting instruction (for nullifying
+ * exceptions), and a second one that pointed behind the instruction (for
+ * suppressing, completing, and terminating exceptions).
+ */
+#define EX_TABLE_INSN(_fault, _target)					\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FIXUP, __stringify(%%r0), __stringify(%%r0), 0)
 
-#define EX_TABLE_AMODE31(_fault, _target)				\
+#define EX_TABLE_INSN_AMODE31(_fault, _target)				\
 	__EX_TABLE(.amode31.ex_table, _fault, _target, EX_TYPE_FIXUP, __stringify(%%r0), __stringify(%%r0), 0)
 
-#define EX_TABLE_UA_FAULT(_fault, _target, _regerr)			\
+#define EX_TABLE_INSN_UA_FAULT(_fault, _target, _regerr)		\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_FAULT, _regerr, _regerr, 0)
 
-#define EX_TABLE_UA_LOAD_REG(_fault, _target, _regerr, _regzero)	\
+#define EX_TABLE_INSN_UA_LOAD_REG(_fault, _target, _regerr, _regzero)	\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REG, _regerr, _regzero, 0)
 
-#define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
+#define EX_TABLE_INSN_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero) \
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
 
-#define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
+#define EX_TABLE_INSN_ZEROPAD(_fault, _target, _regdata, _regaddr)	\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
 
-#define EX_TABLE_FPC(_fault, _target)					\
+#define EX_TABLE_INSN_FPC(_fault, _target)				\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
 
-#define EX_TABLE_UA_MVCOS_TO(_fault, _target)				\
+#define EX_TABLE_INSN_UA_MVCOS_TO(_fault, _target)			\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_MVCOS_TO, __stringify(%%r0), __stringify(%%r0), 0)
 
-#define EX_TABLE_UA_MVCOS_FROM(_fault, _target)				\
+#define EX_TABLE_INSN_UA_MVCOS_FROM(_fault, _target)			\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_MVCOS_FROM, __stringify(%%r0), __stringify(%%r0), 0)
 
-#define EX_TABLE_INSN				EX_TABLE
-#define EX_TABLE_INSN_AMODE31			EX_TABLE_AMODE31
-#define EX_TABLE_INSN_UA_FAULT			EX_TABLE_UA_FAULT
-#define EX_TABLE_INSN_UA_LOAD_REG		EX_TABLE_UA_LOAD_REG
-#define EX_TABLE_INSN_UA_LOAD_REGPAIR		EX_TABLE_UA_LOAD_REGPAIR
-#define EX_TABLE_INSN_ZEROPAD			EX_TABLE_ZEROPAD
-#define EX_TABLE_INSN_FPC			EX_TABLE_FPC
-#define EX_TABLE_INSN_UA_MVCOS_TO		EX_TABLE_UA_MVCOS_TO
-#define EX_TABLE_INSN_UA_MVCOS_FROM		EX_TABLE_UA_MVCOS_FROM
-
 #endif /* __ASM_EXTABLE_H */
diff --git a/arch/s390/include/asm/extable.h b/arch/s390/include/asm/extable.h
index af6ba52743e9..5032c648781b 100644
--- a/arch/s390/include/asm/extable.h
+++ b/arch/s390/include/asm/extable.h
@@ -5,25 +5,14 @@
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
 
-/*
- * The exception table consists of three addresses:
- *
- * - Address of an instruction that is allowed to fault.
- * - Address at which the program should continue.
- * - Optional address of handler that takes pt_regs * argument and runs in
- *   interrupt context.
- *
- * No registers are modified, so it is entirely up to the continuation code
- * to figure out what to do.
- *
- * All the routines below use bits of fixup code that are out of line
- * with the main instruction path.  This means when everything is well,
- * we don't even have to jump over them.  Further, they do not intrude
- * on our cache or tlb entries.
+/**
+ * struct exception_table_entry - entry in exception table
+ * @insn:  Relative pointer to faulting instruction
+ * @fixup: Relative pointer to instruction where execution resumes
+ * @type:  Exception type
+ * @data:  handler-specific data
  */
-
-struct exception_table_entry
-{
+struct exception_table_entry {
 	int insn, fixup;
 	short type, data;
 };
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index ca6a1efa49ee..6bed074f1c5f 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -121,8 +121,6 @@ bool fixup_exception(struct pt_regs *regs)
 	const struct exception_table_entry *ex;
 
 	ex = s390_search_extables(get_trap_ip(regs));
-	if (!ex)
-		ex = s390_search_extables(instruction_pointer(regs));
 	if (!ex)
 		return false;
 	switch (ex->type) {
-- 
2.53.0

