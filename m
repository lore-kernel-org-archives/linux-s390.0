Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781C3FFFAB;
	Fri, 21 Aug 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342019; cv=none; b=a9dmgf1x/ZEaAfrutTqzREskP4KRNRId0qXoHcwmwRRgKDObQnOt+nYgllsyJGHEFcXTz/D/MKm0LIY0yEv0CfM4pXHH4AU0cF/9fZb9tgIbpodj3GuNdgWrgJCfJYkS0NHp+ZR6+xyDvYAcUrKkJZw8j4wWG1DCl+IwxSfLdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342019; c=relaxed/simple;
	bh=URzcqcKildsNvgSpR2lLGV/p+z/i7pvGxHXc8UvWV84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akMTv/yU0bZO7K8G0DZ8B+i8pSNRKx5UaMp9jy4NLzXPbkfr5oVkA1j0Zgw9y719mtUpi47BIcUfQEs4KaanFPu7Hf5YPnQmSicV9L6irAmHsp0umYZs9M3KbI8fEclfbqBzQj7iETbVfDmRji9YFXjtLR6HDHL+kohfGESriw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UdFWgLSt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UdFWgLSt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVhMQ491833;
	Fri, 21 Aug 2026 19:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gD+wy2WOXKDmawHxG
	A2GRaC0ZcIOI/WUyr9zsMyBQes=; b=UdFWgLStueFS5PXYCMV9eD6Iad2hYvcnI
	wgesUwNYBqb3CSG0Tlb0K7WP831mG7bcWufuKPhvpLXZjsjw9PUpfELQzfaUWND+
	AtrvTOsKdaljuck2eqqEcdBzEdBfOXO201newke6XqDWKp5vjV8+mgii0d3dN26y
	DRCO4KP6dDN6GUml68XbJ/DOg0430QNOfUcymPskpXfMbFw0JNXrqMnqoF700+5T
	H97vBklZ7AVhBPXyWKuftUBKsMzTw1QTJW15MR12LWQut62I8R6jXQ3ftf6kTiGC
	iUgB1aFrv+sjhKuWpBb6YoI2kAiL0uQDwhEuR/iv9539Wb7W+QlrQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kvcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfMOT021134;
	Fri, 21 Aug 2026 19:53:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpnxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr6Pi49086762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA44620040;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B9E2004B;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 03/24] unwind_user: Enable archs that pass RA in a register
Date: Fri, 21 Aug 2026 21:52:38 +0200
Message-ID: <20260821195259.2688377-4-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: CsQ34D-wem0TFAaS_C18ZH87z5nSDW8m
X-Proofpoint-GUID: U1jlYB3oJKNvknEFnfPVXj96BpSbcWEZ
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88aca7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=lmaF1edk6S-LLGGX4wsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXxWWo8rletH68
 AXc47pnN5fvhjc/oYbDdU3JICndl8rvxRHeJiqRAudV/mcJ5/dtWr/K0pvZ9JmriIPWRAWXvUiI
 nc4DdE8QW80OZp9JuMhIXWN4ZMRlKTA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1oj2n87d0V1A
 +jZVS4c278t5RkTtkKDj9QZE+YF6HcPvsee3umuIOiuNnTjB2LOf6PTCtOx4dKejbF/3iJUG4Xz
 TYKALpZThMwZSs93GMJXPTG1kWbkSHBPOLjl6aKrMXJW5Et/U2AIrphQbDZFexq1cDQ46MFUudD
 fsCwiTvIrNGnc1FRiRQW2POqp3K8Mdrx/1m7HKvxmXhGzsz6a27g1ShzMM31ctwhIDqB0zBpVYS
 KW9qRg8nvceZgNfiIxOw6VOwmAn1k3RUrMB1BCaA/ERxIEF4eUhPXWxHT27S4s4HSb4vviW/BjE
 huoYsajcwysNx3a6UdXzwOSWFB2QJCBHNeLVnCUY4JDIkWLtHf0IG1M/Qww579Zon/TFZGyOc1t
 cU+db5nWsFdci11S566pKZ5BbypAKjM1hpext2u7GibG6sXnjEuykk9q35IxFVn7wnn+YkHqmxU
 hzU0uiSxVjfVa0RX84A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

Not all architectures/ABIs pass the return address (RA) on the stack on
function entry, like x86-64 does due to its CALL instruction pushing
the RA onto the stack.  Architectures/ABIs, such as s390, also do not
require the RA to be saved on the stack in the function prologue.  In
particular, the RA may never be saved to the stack at all, such as in
leaf functions.  Unwinding must therefore not assume the presence of a
RA saved on stack for the topmost frame.

Treat a RA offset from CFA of zero as indication that the RA is not
saved (on the stack).  For the topmost frame treat it as indication that
the RA is in the link/RA register, such as on arm64 and s390, and obtain
it from there.  For non-topmost frames treat it as error, as the RA must
be saved.

Additionally allow the SP to be unchanged in the topmost frame, for
architectures where SP at function entry == SP at call site, such as
arm64 and s390.

Note that treating a RA offset from CFA of zero as indication that
the RA is not saved on the stack additionally allows for architectures,
such as s390, where the frame pointer (FP) may be saved without the RA
being saved as well.  Provided that such architectures represent this
in SFrame by encoding the "missing" RA offset using a padding RA offset
with a value of zero.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-14-jremus@linux.ibm.com/

 include/linux/unwind_user.h | 10 ++++++++++
 kernel/unwind/user.c        | 20 ++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 64618618febd..941cef652435 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -23,6 +23,16 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 #define unwind_user_at_function_start unwind_user_at_function_start
 #endif
 
+#ifndef unwind_user_get_ra_reg
+static inline int unwind_user_get_ra_reg(unsigned long *val)
+{
+	pr_debug("%s (%d): %s() not implemented\n",
+		 current->comm, current->pid, __func__);
+	return -EINVAL;
+}
+#define unwind_user_get_ra_reg unwind_user_get_ra_reg
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 28091ece830c..f8a97d4167f0 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -2,6 +2,9 @@
 /*
 * Generic interfaces for unwinding user space
 */
+
+#define pr_fmt(fmt)	"unwind_user: " fmt
+
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -47,8 +50,12 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	}
 	cfa += frame->cfa_off;
 
-	/* Make sure that stack is not going in wrong direction */
-	if (cfa <= state->sp)
+	/*
+	 * Make sure that stack is not going in wrong direction.  Allow SP
+	 * to be unchanged for the topmost frame, by subtracting topmost,
+	 * which is either 0 or 1.
+	 */
+	if (cfa <= state->sp - state->topmost)
 		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
@@ -56,8 +63,13 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
-	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
-		return -EINVAL;
+	if (frame->ra_off) {
+		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
+			return -EINVAL;
+	} else {
+		if (!state->topmost || unwind_user_get_ra_reg(&ra))
+			return -EINVAL;
+	}
 
 	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
-- 
2.53.0

