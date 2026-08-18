Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0A33AD53F;
	Tue, 18 Aug 2026 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064641; cv=none; b=EUhJVt+0mpaR8JJJyARhY46Hqa2Y4vVuGmBlmVP4dp9d1xH//0VbkfskZ8cuY6JjSTetrWMvKKW1IzUOZLpxhDaehbSpHJ67LiqhzpPS9219251Rpj/oncaC1SK9K1OOUShVwYMm0BVcW/8cTJ209xQOT+FIyXgaO7i9+ub7zd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064641; c=relaxed/simple;
	bh=URzcqcKildsNvgSpR2lLGV/p+z/i7pvGxHXc8UvWV84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuBCUSIuSeY/9Cof+5Jwif4jgRTuPmEDc4wmIRAQXstpGwB+yjy2tgZm3DQc0ZX77lsGBAhhRO7bqtw+Os8yZuPrVowdSvAupMCcUg6sVzohbUDkP29LV2C3UZMVeiuUF0STxtzwvGqj+u+6iTrUjITzkG6Hri9YLak5wfHb1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VSqo18AB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VSqo18AB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3rD03582829;
	Tue, 18 Aug 2026 14:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gD+wy2WOXKDmawHxG
	A2GRaC0ZcIOI/WUyr9zsMyBQes=; b=VSqo18ABFmlZVT78D5lhAcdqMy2jAVJdC
	MWZXHL9OB8cXo3NQ5SJ0h7mqQsL/dsMpKe26jLE8b+XQq9pTfb09owkmzSJz4L+d
	gnb5uzCT1p0Oa7qBd53GheI6ie9m62vwgsgccStNpnJpAayU3w4O/BDmyt/+hmhz
	Fc0C9/fAaTknubK7dA9+/lsCvlYT7XOym0snyOvLorIqC7Xl0cYIVB7rATvntM3L
	OHXqx2BLS6CqIjaalK1m5q3KxEvX/PtcA/FsaUofbPbOERchbgyJIu9s3Z0YL/zX
	JUWw6ZdO67nEPQIakG7v8MDggDWs0x2WXf5jq9x3qZbw1bohWiKgQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe8h08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfMvI032436;
	Tue, 18 Aug 2026 14:50:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybgbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnwQs43450644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB28A20043;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0C442004D;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 03/25] unwind_user: Enable archs that pass RA in a register
Date: Tue, 18 Aug 2026 16:49:32 +0200
Message-ID: <20260818144954.2320378-4-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX9D7QzlJzNNWQ
 Q7jTN6AM5BGt/Oj8UPtmrGIAuNszgRp+bf53wC6DTWHvSralC6Cc9vKgC6uNcJ/l54c21LoBDlt
 pZ9++Ry+Tfv8kUzxM3Z+kGmQW3muXQ7D0/SeSqwnr2cpux2khkRaG6QbuEwr2X8wN5DpAwv6BWL
 vwWoL8gXCu84aui+VwEeG3ErkOyFDCXKM/FsfI7sYvqmD7kSyS3d8tAIu2OuV1KhGX4yOU+b8TZ
 ltTiwyUz2E03luVidwA41veYud27I64kL3bSAOkqCnYVOgBXX/MXU809U4HOl+kqX4pyuy7KvTO
 RBVDlpqAJhRdLJqOLcK+02mkXRqZBciI0MjgZ5ar5ORHwB8xeFoQUPRH99XDXZgpvo+FoVDq+DC
 kV++7wSgmH+urvts4cQDJvuL6xFFDXQZ9ipXO8gb80xyzUe5txf4p6aGcLh8D3vx963NZoMMnF2
 yZtiqErDTzapMm+2WQA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a84711b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=lmaF1edk6S-LLGGX4wsA:9
X-Proofpoint-ORIG-GUID: Fudr4d5TOv1TC2mZhNZSW_il2A9ovbc6
X-Proofpoint-GUID: p3H-jH2f_7fiOQMXqfiP0tlFV2B7VZR_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX/IE7IFnUMmb3
 MGRJ+xcs+TdUd+glWqKuWQrX5JmMD8VWLpIa2hInh9esNLIMAfe//YomuZ08e63H9u71D9R6W2c
 2EThFgDnrud2/nU4T2LP4Ix7H5mQcy0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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

