Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F435CBB0;
	Tue, 27 Jan 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527203; cv=none; b=S+osO6pzTcw8GNjU6b6NGaGPgfc1BYaIUN1ERH1BE3hwpMsZeXgH+evd/Vc81qRDW9JHAdypUImFhtHP6nmt6ycJqh2aMXplBgJziqDmZnymaqqSvf7owcXjMZLXwpxPWWXobnT4EfZH/QDu3+13CaGV+pElbLMXNhR0rzMIEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527203; c=relaxed/simple;
	bh=NX1lub2wg02nrRuvM/eEfc4uFVh0nxxekKzTNLP34Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcNMCiZEMQNV3XI3lf50tiP2OwrMHv9631Rol3q5wWywzTvrdtH8RBiCNlzu//6EQnQ/WGmkT7zCxy9oxI8qIfj+LHDHPUGqHB8quyTvJG2tPKKRPPEeRhfHyXVmrNqActg9y7EuTo2tqiJNmi8xlkOjI3UdJLjt9Ntj/CqSDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WTnJzchK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTnJzchK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6nRoW030212;
	Tue, 27 Jan 2026 15:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TA9Fyu/N//vwb3hoz
	5GJXxji6d+3johNsY9O2zhB5m4=; b=WTnJzchKYRiUkb5+024ssRHvU3fO1l2kR
	pYrKvsal+Yo5/yjqVkEvqyexOGl7Igf7yAwye+BB8MR+tp0xvPt9kOrvWaREkAG/
	VmPOBnkJd+UmFjsDFsKx339XlvWNTOCVH1ZpFA47BTpq3HcWxTxy0lD0b+sRLMnG
	CEcr5AU24ceY7ZZ2+liPby+QAlv5b5awBTzwf2ofpHSLlz3XCOjNe3AX79+kmUVn
	ho8lh+uT8Jb1E+qUaCMghNOXkOaoH4OBlLdLqix5R0Js64w5hzEN3BFyGD4AbYba
	QSvM4C9ff6JyP/EOmpJPP40GjfSU5qbVsYu0GCGQp86ZEzTb0NF9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFJbep008249;
	Tue, 27 Jan 2026 15:19:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte1v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REptfF017960;
	Tue, 27 Jan 2026 15:19:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41rvgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJW0u60883424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A6D20040;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 736782004D;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:32 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v4 04/12] s390/vdso: Enable SFrame V3 generation in vDSO
Date: Tue, 27 Jan 2026 16:19:17 +0100
Message-ID: <20260127151926.2805123-5-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lfu8Mof5g3CdoScifPWLHUtF_nYHVS_N
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978d78a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=aCsQZq_vhc4F8yeggjQA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: -C89hkHOri2E7tocAabfmdej8sBQF5UY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX2IxyCzz44tC+
 yAACqJAY2u7UsL0izW/LgMXbRI0sN5s7c31bazC2Zy9c7lcExHTr+uo4iwFNpn6ZNluFPBtd1fQ
 Z50ALI7znTxOElzf41kOrgAs3vmRwK3mPILuovgaZca6uQWKK2wFTzbO9iYpr5HGrRBqr5ov4yI
 3qTMNu73kxRmP9gqaJgUYgjFgf/tbiY46zklPs2IiiG0xIwe6w+aqA5KL47UcI2j4qlTusB+ouu
 +qhKvc+aQ2NVWXGlWmqF6F3BQRXTn4i8EhFILKPzkAS5wwzhPNVMLpVB/ZCrDOzEA7+3pcdqfL/
 l53yxXdN/z1DoPNzwN5vSp9eKpM7MzZy21jkS+ZCkmVOrxcPSuH/26LMo1a9vAjgUbRqi0qdQ7l
 UriU7lbIjib1FOcN981vq0nSzIeuUqG/WQWyPC5l+ijGmT4phUmBas0DWA+kGuIN1913hDEnUUM
 GR/2opxRRKzqm3yyVPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

This replicates Josh's x86 patch "x86/vdso: Enable sframe generation
in VDSO" [1] for s390.

Test whether the assembler supports generating SFrame V3 stack trace
information.  Note that it is insufficient to test whether the assembler
supports option --gsframe-3, as GNU assembler supports that regardless
of whether it is actually capable of generating SFrame V3 stack trace
information for the architecture.

If so enable SFrame V3 stack trace information generation in the vDSO
library so kernel and user space can unwind through it.

[1]: x86/vdso: Enable sframe generation in VDSO,
     https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - Test for and generate SFrame V3 using assembler option --gsframe-3.
    
    Changes in RFC v2:
    - Introduce config option AS_SFRAME instead of requiring Josh's x86
      patch as pre-requisite.
    - Reword commit message.
    
    Link to Josh's latest x86 patch:
    https://lore.kernel.org/all/20250425024023.173709192@goodmis.org/

 arch/Kconfig                     | 7 +++++++
 arch/s390/include/asm/dwarf.h    | 4 ++++
 arch/s390/kernel/vdso/Makefile   | 7 ++++++-
 arch/s390/kernel/vdso/vdso.lds.S | 9 +++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index dcb553136e0c..b5b3a83072f7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -479,6 +479,13 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config AS_SFRAME
+	bool
+
+config AS_SFRAME3
+	def_bool $(as-instr,.cfi_startproc\n.cfi_endproc,-Wa$(comma)--gsframe-3)
+	select AS_SFRAME
+
 config UNWIND_USER
 	bool
 
diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 6bcf37256feb..2f148b15fd7d 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -16,7 +16,11 @@
 	 * symbols for the .dbg file.
 	 */
 
+#ifdef CONFIG_AS_SFRAME
+	.cfi_sections .eh_frame, .debug_frame, .sframe
+#else
 	.cfi_sections .eh_frame, .debug_frame
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index 3a8bde5716f4..d604839756d0 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -20,7 +20,11 @@ targets := $(obj-vdso) $(obj-cvdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 obj-cvdso := $(addprefix $(obj)/, $(obj-cvdso))
 
-KBUILD_AFLAGS_VDSO := $(KBUILD_AFLAGS) -DBUILD_VDSO
+ifeq ($(CONFIG_AS_SFRAME3),y)
+	SFRAME_CFLAGS := -Wa,--gsframe-3
+endif
+
+KBUILD_AFLAGS_VDSO := $(KBUILD_AFLAGS) -DBUILD_VDSO $(SFRAME_CFLAGS)
 
 KBUILD_CFLAGS_VDSO := $(KBUILD_CFLAGS) -DBUILD_VDSO -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS_VDSO := $(filter-out -mpacked-stack,$(KBUILD_CFLAGS_VDSO))
@@ -29,6 +33,7 @@ KBUILD_CFLAGS_VDSO := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_VDSO))
 KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_VDSO))
 KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
 KBUILD_CFLAGS_VDSO += -fno-stack-protector
+KBUILD_CFLAGS_VDSO += $(SFRAME_CFLAGS)
 ldflags-y := -shared -soname=linux-vdso.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 7bec4de0e8e0..13d20fcede2f 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -51,6 +51,11 @@ SECTIONS
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+#ifdef CONFIG_AS_SFRAME
+	.sframe		: { *(.sframe) }		:text	:sframe
+#endif
+
 	.gcc_except_table : { *(.gcc_except_table .gcc_except_table.*) }
 
 	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
@@ -77,6 +82,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -88,6 +94,9 @@ PHDRS
 	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
 	note		PT_NOTE FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+#ifdef CONFIG_AS_SFRAME
+	sframe		PT_GNU_SFRAME;
+#endif
 }
 
 /*
-- 
2.51.0

