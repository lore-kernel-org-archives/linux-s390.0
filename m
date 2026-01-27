Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA735CB9F;
	Tue, 27 Jan 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527202; cv=none; b=MyLa1l/dTkeD7BNteriLMTqzE2MtTM87znYLW6PKGylAJXULkW4irdAnoqgG8DD48fjppGLqzmZwuPkI+TerXaRRk/po6HnYGiCWa7MQWOQDg/bwj80jI7HW7pgMrYTAWUZnj2GY1ZYHkIOrtE5Ynx4rC3f/DosHi96HGTMhAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527202; c=relaxed/simple;
	bh=/GDZHvKL20WkVc+xQURi+GL8V7aNFAeFcy2+sWH8F2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVCvRc8qGc+3ldkNfSz4cddYLtozgnJYnJlvCgH0KqSri6hpsj7LsX7wSV0KpNoEAJLbSmsVW1vg9Ec/k05UlWmmUpIpLEXZiL77Atr71o/veejFm8hoG/eYEc5I8FS7SQHKEAdnJXNEiFgOcGs1UQlY785NK16fp/DR5C59A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z9KHoC2d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z9KHoC2d"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7WMTd008927;
	Tue, 27 Jan 2026 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LHC+JvN+TpuEh9Kkw
	evIeUH2B3MQb7aBBWgCtLuQE6c=; b=Z9KHoC2dTDahr98rSJevpGPuc5EfzuICu
	MpavmjziX/f+4M2/wlFRRGOXTtv9K76sPR5Is9uy4JNtVpFpDNCg+v93ZWtST1gb
	xWji6JZsXUd9mtjdQTmovFo6CWRm09pGeJ40B6CX6BJNcFMbtymZfqQoUP/03jQD
	28F6t7KtMXFheYaAf5dRc83mQTSQIbW8t5zm10UBB1LPQK0+9IRLh2AWH6LrG1Td
	HD19xr18KsINAbrBMqWI5gYbTrS+/0fpJzBIwn6EkqzVQDz2aEyR1e/ddsaweRog
	QbGV2EnOot9E6P3DQYbru3r3XJwrWbYOsRQM0VW2cJso6XQxcn5jA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr648ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFJdjZ030640;
	Tue, 27 Jan 2026 15:19:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr648ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDaidJ026334;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk930y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJZb233423682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D858620040;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 948D420043;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
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
Subject: [PATCH v4 11/12] unwind_user/fp: Use arch-specific helper to initialize FP frame
Date: Tue, 27 Jan 2026 16:19:24 +0100
Message-ID: <20260127151926.2805123-12-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX7hBeit9GXDVo
 mxdAE/qwW8N/bbTp6ed+YllfTLEcy43dddeY6htWgcSLrEHaAxAgSW94oVO9jHXHbzVFJ5nrvu4
 jpCmUXYlcqg/oeZKuK9Xv3VByUIp1VFjDnQwvXIxa6q/PRIIFpYzx6dbcP66C9ESXnWeYS2F1qN
 u0rzzKor5BwLeJqWsTIHygrBH5PJ1mqsSuj2vMtUcpziFZkrIJhgzUDDmBw3Vp5DsxNq2hn1XxS
 P83+M9+c7xuYVoo5iycVye7dTNG+DZSzXcpx3UHfx1eXRCJfTKj4i5EhrPzMmNqnYhHVNxfOdDc
 coNpoKU35vascLriTYN83/9iySqfw3UJT/DaEqz0MBaRTsVOFzz4mpLrehw4Qo90UXENjAHSs4D
 oO9GfryFJq4kwKxAsZi8OlMPEsxz56s6bplWY+eCXWaUNNotxz3q3p6bq1ld8qLnj91vedoldgI
 1Oj8b3FClj46L/RKSJw==
X-Proofpoint-GUID: 29P8UNrgDPJ85o-mcNqcsHDh82lbKJJh
X-Proofpoint-ORIG-GUID: ZrvKTO_7gMK6ZC4ehVSazwqHNKCzgvyX
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6978d78c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Rlq6_WvGfIKZnD4uTv0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

This enables more sophisticated initialization of the FP frame, for
instance to implement support for unwinding of user space using back
chain on s390 with a subsequent commit.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - Remove superfluous unwind_user_fp_get_frame defines.
    
    Changes in RFC v3:
    - New patch.  Prerequirement to implement unwind user fp using back
      chain on s390.

 arch/x86/include/asm/unwind_user.h | 19 ++++++++++++++++---
 include/linux/unwind_user.h        | 19 ++++++-------------
 kernel/unwind/user.c               | 16 ++++------------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 0650bcfae461..f5e9fbcdae28 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -84,11 +84,24 @@ static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
 	.sp_off		= 0,				\
 	.outermost	= false,
 
-static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
+					   struct unwind_user_frame *frame)
 {
-	return is_uprobe_at_func_entry(regs);
+	struct pt_regs *regs = task_pt_regs(current);
+
+	if (state->topmost && is_uprobe_at_func_entry(regs)) {
+		const struct unwind_user_frame fp_entry_frame = {
+			ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
+		};
+		*frame = fp_entry_frame;
+	} else {
+		const struct unwind_user_frame fp_frame = {
+			ARCH_INIT_USER_FP_FRAME(state->ws)
+		};
+		*frame = fp_frame;
+	}
+	return 0;
 }
-#define unwind_user_at_function_start unwind_user_at_function_start
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 92cdf38c8ade..f65b0573b3a5 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -7,21 +7,14 @@
 
 #ifndef CONFIG_HAVE_UNWIND_USER_FP
 
-#define ARCH_INIT_USER_FP_FRAME(ws)
-
-#endif
-
-#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
-#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
-#endif
-
-#ifndef unwind_user_at_function_start
-static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
+					   struct unwind_user_frame *frame)
 {
-	return false;
+	WARN_ON_ONCE(1);
+	return -EINVAL;
 }
-#define unwind_user_at_function_start unwind_user_at_function_start
-#endif
+
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
 #ifndef unwind_user_get_ra_reg
 static inline int unwind_user_get_ra_reg(unsigned long *val)
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 036328cb9ee8..a64ceb4a2bf6 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -135,19 +135,11 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-	struct pt_regs *regs = task_pt_regs(current);
-
-	if (state->topmost && unwind_user_at_function_start(regs)) {
-		const struct unwind_user_frame fp_entry_frame = {
-			ARCH_INIT_USER_FP_ENTRY_FRAME(state->ws)
-		};
-		return unwind_user_next_common(state, &fp_entry_frame);
-	}
+	struct unwind_user_frame frame;
 
-	const struct unwind_user_frame fp_frame = {
-		ARCH_INIT_USER_FP_FRAME(state->ws)
-	};
-	return unwind_user_next_common(state, &fp_frame);
+	if (unwind_user_fp_get_frame(state, &frame))
+		return -ENOENT;
+	return unwind_user_next_common(state, &frame);
 }
 
 static int unwind_user_next_sframe(struct unwind_user_state *state)
-- 
2.51.0

