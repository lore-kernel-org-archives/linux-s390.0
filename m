Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55418A6BC;
	Mon, 28 Oct 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104068; cv=none; b=md3YpPu1CAikABA9bEgWPj4bX+JIcx1yozXzLaBeSsUlvr42qaHITkA+jN7b8iF869IJ8A2rEMfCGKJwlFx8W3mrX/RN+eAvvBr1wyaLh1BvTWf/rMgaOnFjlIw3ydoe/6mNHI8s2stg0C8xBG95iVCVHnBW+fJfN6dYDXApjUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104068; c=relaxed/simple;
	bh=kArG2O7+yUO2p3VAusqwyCk/HZiO6i0gZ7XooVgYW8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvbOTFR2DA2fJcZ3gedH2IMU713hjudJdXRuTlLBMdX4qULisNw3pG+0LMqpezYBfHZhHJvWaja8jP8Q49knGwui4lfH5g79l4oQr7Bl7TyG40tbA1xTPpZ3KQXhnhUm0iLxYu97KXW7vUjG2IoOBiia9Z8NqVTS4x2o6ydDOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=teDEEWGw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="teDEEWGw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S51WRm026525;
	Mon, 28 Oct 2024 08:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mf0DrKaFsAsYNIH+E
	OAfJ/m4PWzcsTsfQ1Rt/3wzbrc=; b=teDEEWGwhANE99eh7XEgw86xEZyNOl/z7
	hnyt2mgAIAn/N4n8NZImOaxdxhR8eLiIFIMQbGfNa9WP/+CLtk+Gxzovx7FoikDA
	4oc8UkTu7SR4cwlPVePdRcm0L7EuDnHO5eIriEpJEwPQopDg6Oc+RqkAx9vbLUqW
	6PSgsl/dgIXjdp2/bMZSuH3PAgyaSepnwVqP3GmsdztjA1fbbMkAtzBnqJBjq/IE
	eKli6eXMbIFa6lXCv+ddGzhySjGhYS3JDkWuGQMMttOpeHBYq+4IALsbu00QHdY3
	m+B/OhvgfGWtUDAX8l7ntemrsoyjAoDCR6yvmVhXuwx//nLkpCOBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43fryyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:27:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S70v6e017386;
	Mon, 28 Oct 2024 08:27:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hars5j51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:27:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49S8ReGr53084440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 08:27:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3455A20043;
	Mon, 28 Oct 2024 08:27:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2488120040;
	Mon, 28 Oct 2024 08:27:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Oct 2024 08:27:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id F3A1FE0733; Mon, 28 Oct 2024 09:27:39 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        "Heiko Carstens" <hca@linux.ibm.com>
Subject: [PATCH 1/1] s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
Date: Mon, 28 Oct 2024 09:27:38 +0100
Message-ID: <20241028082738.3293096-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <172991731968.443985.4558065903004844780.stgit@devnote2>
References: <20241028082738.3293096-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6n7F5oHJDQK4K42GiEMNqP7VjsZYHP3Z
X-Proofpoint-ORIG-GUID: 6n7F5oHJDQK4K42GiEMNqP7VjsZYHP3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=967 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280068

Add ftrace_graph_func() which is required for fprobe to access registers.
This also eliminates the need for calling prepare_ftrace_return() from
ftrace_caller().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/ftrace.h |  5 ++++
 arch/s390/kernel/entry.h       |  1 -
 arch/s390/kernel/ftrace.c      | 48 ++++++++++------------------------
 arch/s390/kernel/mcount.S      | 11 --------
 5 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index eeb95342ddeb..87178183f952 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -182,6 +182,7 @@ config S390
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 8c94a330c70c..a3b73a4f626e 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -39,6 +39,7 @@ struct dyn_arch_ftrace { };
 
 struct module;
 struct dyn_ftrace;
+struct ftrace_ops;
 
 bool ftrace_need_init_nop(void);
 #define ftrace_need_init_nop ftrace_need_init_nop
@@ -128,6 +129,10 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	return !strcmp(sym + 7, name) || !strcmp(sym + 8, name);
 }
 
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 21969520f947..a1f28879c87e 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -41,7 +41,6 @@ void do_restart(void *arg);
 void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
 int setup_profiling_timer(unsigned int multiplier);
-unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
 
 struct s390_mmap_arg_struct;
 struct fadvise64_64_args;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 51439a71e392..c0b2c97efefb 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -261,43 +261,23 @@ void ftrace_arch_code_modify_post_process(void)
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-/*
- * Hook the return address and push it in the stack of return addresses
- * in current thread info.
- */
-unsigned long prepare_ftrace_return(unsigned long ra, unsigned long sp,
-				    unsigned long ip)
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
+	unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
+	int bit;
+
 	if (unlikely(ftrace_graph_is_dead()))
-		goto out;
+		return;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
-		goto out;
-	ip -= MCOUNT_INSN_SIZE;
-	if (!function_graph_enter(ra, ip, 0, (void *) sp))
-		ra = (unsigned long) return_to_handler;
-out:
-	return ra;
-}
-NOKPROBE_SYMBOL(prepare_ftrace_return);
-
-/*
- * Patch the kernel code at ftrace_graph_caller location. The instruction
- * there is branch relative on condition. To enable the ftrace graph code
- * block, we simply patch the mask field of the instruction to zero and
- * turn the instruction into a nop.
- * To disable the ftrace graph code the mask field will be patched to
- * all ones, which turns the instruction into an unconditional branch.
- */
-int ftrace_enable_ftrace_graph_caller(void)
-{
-	/* Expect brc 0xf,... */
-	return ftrace_patch_branch_mask(ftrace_graph_caller, 0xa7f4, false);
-}
-
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	/* Expect brc 0x0,... */
-	return ftrace_patch_branch_mask(ftrace_graph_caller, 0xa704, true);
+		return;
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
+		*parent = (unsigned long)&return_to_handler;
+	ftrace_test_recursion_unlock(bit);
 }
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 2b628aa3d809..1fec370fecf4 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -104,17 +104,6 @@ SYM_CODE_START(ftrace_common)
 	lgr	%r3,%r14
 	la	%r5,STACK_FREGS(%r15)
 	BASR_EX	%r14,%r1
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-# The j instruction gets runtime patched to a nop instruction.
-# See ftrace_enable_ftrace_graph_caller.
-SYM_INNER_LABEL(ftrace_graph_caller, SYM_L_GLOBAL)
-	j	.Lftrace_graph_caller_end
-	lmg	%r2,%r3,(STACK_FREGS_PTREGS_GPRS+14*8)(%r15)
-	lg	%r4,(STACK_FREGS_PTREGS_PSW+8)(%r15)
-	brasl	%r14,prepare_ftrace_return
-	stg	%r2,(STACK_FREGS_PTREGS_GPRS+14*8)(%r15)
-.Lftrace_graph_caller_end:
-#endif
 	lg	%r0,(STACK_FREGS_PTREGS_PSW+8)(%r15)
 #ifdef MARCH_HAS_Z196_FEATURES
 	ltg	%r1,STACK_FREGS_PTREGS_ORIG_GPR2(%r15)
-- 
2.45.2

