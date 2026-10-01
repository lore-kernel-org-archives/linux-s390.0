Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CC3B14D4;
	Thu,  1 Oct 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850784; cv=none; b=S+BtV8ioZMzCdKy+bPzQ/fuCWy/gh1FCO1lGDhYFnt/Bhd+HD5kTDK/pWS+wwzKdPVzEGJiP8837wt200dgwONWSHD8BruYLcodRxUE9V/Hv2Oqcdaqpg7xnhx3lfKZtTcDDSzV+m2R/rnDhxLs5bFsAaHBZI/myY3IktJCERTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850784; c=relaxed/simple;
	bh=Y0PvQyutKHqaQtIMSOhQdFa8HvgdjmLyyvO0e+Xzy4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOY0PX/21UNunwhkvc/6vK3cM33Nygqy+PNJYcaCa5U5hmjcl3Elgv+AUntHUdHkCKaBxrCKM9Ue8E9Z7nQBxOBGX+i43Ajlo/SxbaiVuK7UVlCk4wCzl7lUGuSTAk9ErE5rqhN7mhkmq5iLwUExhSgm5z7jFhexX0mJAgW/1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hM41kKeq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hM41kKeq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175gtb1086145;
	Thu, 1 Oct 2026 10:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7pGi7tHyDacownkdG
	NZ1hvbgU7e5FUAgdLF7CQdtfEo=; b=hM41kKeqcjF5n1mURkmXM3cKLV65nIXPm
	/ZtNihGLyrSwl8udpAktP0x0LJxU1UdJXrODDdNHaSoNZ7J9Fu0IVmqOlBokgDvE
	AOu+2wUYi82xhdS1S+8vnB+9wHw3Ou2eSoD6LbHxGnkJdl5sVfluHPm28BP3mf/Z
	LO8lDcHXfzIk9M9st0rGnfspODQ8v/Vzc2Cc0hC4iauWoYSZhCIQGIW26XGQmFCJ
	xQRvmaidNhDTEyYacH7iDwpuCdkfI04X8NXzuS7hVq/NxsqwVDKQynoPvzDMLao/
	PRMOymqOMgGH/6A5Os3W4VjYW7m+Jq/bbq1JLnkitSWrC7clM9SMg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthcgq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172s123460471;
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pexb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWokO39125398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B273520043;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 769452004B;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
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
Subject: [PATCH 09/32] s390/extable: Rework exception handling logic
Date: Thu,  1 Oct 2026 12:32:24 +0200
Message-ID: <20261001103247.1989111-10-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nbz44dwEeHIaiQ2KlvsHidJPYJCBh2IF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXx8ofNfWpYdUo
 KgxcnLQ57D4FNCd32LJ6k3ubUcBVengjfMKjOAZ9h39jWCCWkAMd2qbT0uKdyfDO8TX7XpgmeSX
 WjH761SgZiPkW9aRdAsKhlr0oI5g2nClJX1UxOz4zK/Hec4K7DSp/j8wWfXrgkUFssTGXhYlUi2
 hRF9lxz/WCWKpX8UQHd1X7vgymji+qXP1f7DA8nLH9scP0ETnDXyhKI/buFPeCqLDbS2xWkCQty
 zkZYFlPyfT6Z0kcw0hRbWlybIlj6ImENovblpYggEKuR7agMfbPHovkIZmfAyHX+PhQr5msBgZa
 JDdYrH0CTZuOMU4chQM13e3GOdMRf/t+h/T1MKjuGzc7j1YmyGjVw7oqFNlkpcAvoAqjShQrVc7
 p5N2c8dQRmb3AxrEckOiEjSlflLy80gwMINFRCDy7oLul40mX21r3BFDXmlUfjnsYWJ/oGbXYkA
 XBvmzMAiBxfe5acylRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX3kmPyAUZhRUS
 zT1N7CkErveNMYk/Kwzf98cyM8QWYyojUpSaP06rlOCo/YKV0jDEDNS/4IgeZ9eCKVRghY6Nf2m
 XYTfLBstGRG12tS7uqVncDpRo85BHHM=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe36d7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=zA0FmRQ007t9RPfKMkQA:9
X-Proofpoint-GUID: nbz44dwEeHIaiQ2KlvsHidJPYJCBh2IF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Add EX_TABLE_INSN macros which will replace the existing EX_TABLE
macros. The macros come with new semantics for the whole exception
handling: with the new exception handling the exception table entries
always point to the instruction which may cause an exception. This is
regardless of exception type, and whether an exception is nullifying,
suppressing, completing, or terminating.

This improves the current situation where exception table entries are
required which point to the instruction (nullifying) and/or behind the
instruction (suppressing, completing, or terminating), since depending
on usage an instruction can generate different exceptions.

The new EX_TABLE_INSN macros are aliases to the existing EX_TABLE
macros. The exception handling logic is changed to first perform a lookup
in the exception tables with get_trap_ip() / boot_get_trap_ip(). If that
finds nothing, it falls back to looking up with instruction_pointer().

This is a temporary solution until all EX_TABLE usages have been
converted to EX_TABLE_INSN. When that work is complete EX_TABLE will
be removed, exception tables will only be searched by using the return
value of get_trap_ip() / boot_get_trap_ip().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/boot/pgm_check.c          | 35 ++++++++++++++++++++++++-----
 arch/s390/include/asm/asm-extable.h | 10 +++++++++
 arch/s390/mm/extable.c              |  4 +++-
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/s390/boot/pgm_check.c b/arch/s390/boot/pgm_check.c
index fa621fa5bc02..56d0be7e2823 100644
--- a/arch/s390/boot/pgm_check.c
+++ b/arch/s390/boot/pgm_check.c
@@ -3,9 +3,11 @@
 #include <linux/stdarg.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <asm/pgmcheck-defs.h>
 #include <asm/stacktrace.h>
 #include <asm/boot_data.h>
 #include <asm/lowcore.h>
+#include <asm/processor.h>
 #include <asm/setup.h>
 #include <asm/sclp.h>
 #include <asm/uv.h>
@@ -40,19 +42,40 @@ static inline unsigned long extable_insn(const struct exception_table_entry *x)
 	return (unsigned long)&x->insn + x->insn;
 }
 
-static bool ex_handler(struct pt_regs *regs)
+static unsigned long boot_get_trap_ip(struct pt_regs *regs)
+{
+	static const unsigned long nullified[2] = { PGM_CHECKS_NULLIFIED };
+
+	if (test_bit(regs->int_code & PGM_INT_CODE_MASK, nullified))
+		return regs->psw.addr;
+	return __rewind_psw(regs->psw, regs->int_code >> 16);
+}
+
+static const struct exception_table_entry *search_boot_extable(unsigned long ip)
 {
 	const struct exception_table_entry *ex;
 
 	for (ex = __start___ex_table; ex < __stop___ex_table; ex++) {
-		if (extable_insn(ex) != regs->psw.addr)
+		if (extable_insn(ex) != ip)
 			continue;
 		if (ex->type != EX_TYPE_FIXUP)
-			return false;
-		regs->psw.addr = extable_fixup(ex);
-		return true;
+			return NULL;
+		return ex;
 	}
-	return false;
+	return NULL;
+}
+
+static bool ex_handler(struct pt_regs *regs)
+{
+	const struct exception_table_entry *ex;
+
+	ex = search_boot_extable(boot_get_trap_ip(regs));
+	if (!ex)
+		ex = search_boot_extable(instruction_pointer(regs));
+	if (!ex)
+		return false;
+	regs->psw.addr = extable_fixup(ex);
+	return true;
 }
 
 void do_pgm_check(struct pt_regs *regs)
diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
index d23ea0c94e4e..488bd10452b3 100644
--- a/arch/s390/include/asm/asm-extable.h
+++ b/arch/s390/include/asm/asm-extable.h
@@ -92,4 +92,14 @@
 #define EX_TABLE_UA_MVCOS_FROM(_fault, _target)				\
 	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_MVCOS_FROM, __stringify(%%r0), __stringify(%%r0), 0)
 
+#define EX_TABLE_INSN				EX_TABLE
+#define EX_TABLE_INSN_AMODE31			EX_TABLE_AMODE31
+#define EX_TABLE_INSN_UA_FAULT			EX_TABLE_UA_FAULT
+#define EX_TABLE_INSN_UA_LOAD_REG		EX_TABLE_UA_LOAD_REG
+#define EX_TABLE_INSN_UA_LOAD_REGPAIR		EX_TABLE_UA_LOAD_REGPAIR
+#define EX_TABLE_INSN_ZEROPAD			EX_TABLE_ZEROPAD
+#define EX_TABLE_INSN_FPC			EX_TABLE_FPC
+#define EX_TABLE_INSN_UA_MVCOS_TO		EX_TABLE_UA_MVCOS_TO
+#define EX_TABLE_INSN_UA_MVCOS_FROM		EX_TABLE_UA_MVCOS_FROM
+
 #endif /* __ASM_EXTABLE_H */
diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 7498e858c401..ca6a1efa49ee 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -120,7 +120,9 @@ bool fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *ex;
 
-	ex = s390_search_extables(instruction_pointer(regs));
+	ex = s390_search_extables(get_trap_ip(regs));
+	if (!ex)
+		ex = s390_search_extables(instruction_pointer(regs));
 	if (!ex)
 		return false;
 	switch (ex->type) {
-- 
2.53.0

