Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211A35F8A3;
	Tue, 27 Jan 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527202; cv=none; b=KyYOwtyFcOoqb4pEoVV8+UsfJpgnvcL6wU9g9acvSlLw8FYNxUbWYo++LJzW1OxlZgTYFleFuCW0qxM84FXSu/asA05KHQeZNV5XZz9i0fyptWE2p8AszuhVl+m90OmyN8rDmWDVsAV+JbU4l6ReK+163D7bueTkfYElwJOmvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527202; c=relaxed/simple;
	bh=gmcluVRdPAJ1NG6VlNqtxyM27ANShcw9L2i/GfJzdo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuQJLT2FVEn1GEaE6Vc4MW8UrUcN2GEV+OPQeS/bwfZS0Z+9jwwp+Qs8C7GqDmDjpF+4+NxKoL386E90nDnNCgKKOf8lwoKzwDzGWrazgv/0DJz0nQGfzX3OiU0lnu+kiUgpJOkgp08LwOOv+ebk4ZCu4SA2BXZAuKYWlKMasik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KS88Db5G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KS88Db5G"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6uQiH031862;
	Tue, 27 Jan 2026 15:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=280g+6
	Hai+7g9ZIuQWaVCWEmjVCE/Ja3nHYE00m10iE=; b=KS88Db5GN/bmvu8o14OnT3
	zr62i4esg8xr5Qr5F+3lCJwhJwIPHBcac/QFf+Ssp75tXh3nKnLJ2vvYm3jpULjR
	t43pC2t8XlBWVO4nm6jrNUbXKJkyh2VhEzNTqMvT+r9vKEPk9ZjCcNX18cGthAHw
	YSUtmhNLxAGvnZRXuRRnz6zp7L9zRUpgvdP8/A7HSKNcByAAxSsELlp1DDFj9AnP
	o4VSFddj/YiLH6j6XKSRVW6/lSOqtvEITX+fpTX1HMSFzhEVk0qXv4pqQVtfi4pq
	xN5UPzspj1yK/Mfgn4Nj5VreopTonPD8zeCvAjQOj2LGp6F3R5EmVdwbs/e1RCWA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmkpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFJc6o000308;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmkp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCxjAj019653;
	Tue, 27 Jan 2026 15:19:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dn1541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJXgo24904260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13252004B;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB4A2004D;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
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
Subject: [PATCH v4 07/12] s390/ptrace: Convert function macros to inline functions
Date: Tue, 27 Jan 2026 16:19:20 +0100
Message-ID: <20260127151926.2805123-8-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978d78b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=buFWL2FryyfO44b410EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gOItHQAEK5JdQYqBc_Pcq3_YFFraa12s
X-Proofpoint-ORIG-GUID: IaA5Ab-IWkgSsCsR44k1qWZ9LHka8NSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX6f9V5uayh0cJ
 K14q/8u7jPMmPmsJLD4HLLJzXHF+kcVFQjy45fq1CCVM+f4H0UHqlM+jFeb4U4Pyx7S7jVjqbwn
 xx+js9ezjDsYPj2qLXUt6FWusaMG0PMBbA19AqRZ5+0vYthRmTCDPlMqTODxfnhlL3JExjjnilK
 9H4H3Hf3bPzbYa2dBBb2W3rbQc+M8moSMS3W//Bde2Kb31KVRe1RB+eo9NQUHn61awXPnrhZKVQ
 XkxtN2/wVcQlkbMhP3t1XMhGcz6yOgaAByoUVxj3237FBaONYwXC4U1BuZu99jvcPoLTEV+zuKf
 /8JlKJZrOmSMseT1sbTmCv4VumN93EvDra9IR9U42FEu6HkV/Q84bkjbZvw217EtxT/aqxTW2sd
 CsUKgbG0ewSNIrg1+XIC7ARw41YJ9n8PbOSet3LA5m0FVDNhC9bw4v+m8/y57UZaP/oCCTHHfci
 k9hS16xzHWHUbV0ZrKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

Convert the function macros user_mode(), instruction_pointer(), and
user_stack_pointer() to inline functions, to align their definition
with x86 and arm64.

Use const qualifier on struct pt_regs pointer parameters to prevent
compiler warnings:

arch/s390/kernel/stacktrace.c: In function ‘arch_stack_walk_user_common’:
arch/s390/kernel/stacktrace.c:114:34: warning: passing argument 1 of
‘instruction_pointer’ discards ‘const’ qualifier from pointer target
type [-Wdiscarded-qualifiers]
...
arch/s390/kernel/stacktrace.c:117:48: warning: passing argument 1 of
‘user_stack_pointer’ discards ‘const’ qualifier from pointer target
type [-Wdiscarded-qualifiers]
...

While at it add const qualifier to all struct pt_regs pointer parameters
that are accessed read-only and use __always_inline instead of inline to
harmonize the helper functions.

[hca@linux.ibm.com: Use psw_bits() helper]

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - New patch.  Split out "while at it" changes from patch "s390/ptrace:
      Provide frame_pointer()" to go upstream separately. (Heiko)

 arch/s390/include/asm/ptrace.h | 37 ++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 962cf042c66d..e6ec0ccf3d73 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -214,16 +214,23 @@ void update_cr_regs(struct task_struct *task);
 #define arch_has_single_step()	(1)
 #define arch_has_block_step()	(1)
 
-#define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
-#define instruction_pointer(regs) ((regs)->psw.addr)
-#define user_stack_pointer(regs)((regs)->gprs[15])
 #define profile_pc(regs) instruction_pointer(regs)
 
-static inline long regs_return_value(struct pt_regs *regs)
+static __always_inline bool user_mode(const struct pt_regs *regs)
+{
+	return psw_bits(regs->psw).pstate;
+}
+
+static inline long regs_return_value(const struct pt_regs *regs)
 {
 	return regs->gprs[2];
 }
 
+static __always_inline unsigned long instruction_pointer(const struct pt_regs *regs)
+{
+	return regs->psw.addr;
+}
+
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
 {
@@ -233,19 +240,26 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 int regs_query_register_offset(const char *name);
 const char *regs_query_register_name(unsigned int offset);
 
-static __always_inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+static __always_inline unsigned long kernel_stack_pointer(const struct pt_regs *regs)
+{
+	return regs->gprs[15];
+}
+
+static __always_inline unsigned long user_stack_pointer(const struct pt_regs *regs)
 {
 	return regs->gprs[15];
 }
 
-static __always_inline unsigned long regs_get_register(struct pt_regs *regs, unsigned int offset)
+static __always_inline unsigned long regs_get_register(const struct pt_regs *regs,
+						       unsigned int offset)
 {
 	if (offset >= NUM_GPRS)
 		return 0;
 	return regs->gprs[offset];
 }
 
-static __always_inline int regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+static __always_inline int regs_within_kernel_stack(const struct pt_regs *regs,
+						    unsigned long addr)
 {
 	unsigned long ksp = kernel_stack_pointer(regs);
 
@@ -261,7 +275,8 @@ static __always_inline int regs_within_kernel_stack(struct pt_regs *regs, unsign
  * is specifined by @regs. If the @n th entry is NOT in the kernel stack,
  * this returns 0.
  */
-static __always_inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+static __always_inline unsigned long regs_get_kernel_stack_nth(const struct pt_regs *regs,
+							       unsigned int n)
 {
 	unsigned long addr;
 
@@ -278,8 +293,8 @@ static __always_inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *r
  *
  * regs_get_kernel_argument() returns @n th argument of the function call.
  */
-static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
-						     unsigned int n)
+static __always_inline unsigned long regs_get_kernel_argument(const struct pt_regs *regs,
+							      unsigned int n)
 {
 	unsigned int argoffset = STACK_FRAME_OVERHEAD / sizeof(long);
 
@@ -290,7 +305,7 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 	return regs_get_kernel_stack_nth(regs, argoffset + n);
 }
 
-static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+static __always_inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 {
 	regs->gprs[2] = rc;
 }
-- 
2.51.0

