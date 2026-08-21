Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC780411693;
	Fri, 21 Aug 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342091; cv=none; b=ieE7uaQXm/aojR3n4EEQ5/qnXxSrZCQMrYANJ7tvKpzpmNMrcB3DqkOjOTFxQo4vYyd28S8O2x4nY9hhTP5jHY02YzkjsLtzNjWCH5wqWH3hHBIWu1SaFq6g4awf0RosBl/cgvmnFCC0pv+sRC4wHlaaxScxOE5PtOUFoxwj0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342091; c=relaxed/simple;
	bh=AMhQNb4JAsa+jlBSzff6AGFydffy3B//nxd42wH5HfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX8mDoDgqRFANX5jP2hKbipfyn4dr18eNzeL9U3YtwwFLl94yjdT+YN9VLZz/0DBm9OvIr/hSF/MMdm103HOL0Jmen1Gb/hPUR+ZtdyrF/Ft/qVRdxX1ISTdWNzEyVX5tGPKbVAm0w5ctvfA3Hr5B+WLIwCQG+aBhjYuK3Xc8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LV8PegSH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LV8PegSH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVwqW492146;
	Fri, 21 Aug 2026 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9uRn1piC2zfGR8Dyy
	ycUNE9uLIucBpzYcAaaqwnf1uo=; b=LV8PegSHn1j+L2Q/kfqkxJaxaBse0lpi3
	qkEd9Q8A46zCKnXObhRZ0YnGKN+/ktddhbaGtZctiD0w0H+oyveqaLoBWA6dofLc
	XtWb/D2YC5WKqYsPJ0aw36zJCDYzXEvtrmheBmVLFeRsNuKoiw0y4lQH9jDCU1Wd
	Taw5uzX64v84sLNLvAsSVd3sw9ZNVWuG+6EoPDRQmnbpf0yHNjCktyFul8BJunDX
	19tQ+FAnSvZRmQ59QTzQCylon6t5SZJEQKTap5caW2AcYqUpTnxxaGVABuqYz/9C
	lwFo+jozT+R7+obP5uao2bDuLInnT2P8PC3XR4RxiGuh2yXbjzTUA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kvd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHak020582;
	Fri, 21 Aug 2026 19:53:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpupq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr8Qh42861026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 526972004B;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15AD520043;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:08 +0000 (GMT)
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
Subject: [RFC PATCH v2 11/24] unwind_user/eh_frame: Wire up unwind_user to eh_frame
Date: Fri, 21 Aug 2026 21:52:46 +0200
Message-ID: <20260821195259.2688377-12-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lIugM_vnGLWqnLWURCpxLBatY63qBa1o
X-Proofpoint-GUID: BIm13viEOWutGzu1kaI7vNWFv2ZYIJsu
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a88acab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Z71hq_FPCwn_qcrh8uAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXy0GgUFSo/469
 qYEnqW47Cdxd4zX2QKvPhtBndZEeKqe3A9r2NTy72RxodgUSbmFdFXRrBToLSglvG07cm7+oHQ0
 SICO3S7DNhYY1mbjE8OujdKuBStL334=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXw7DidMuGOLaQ
 BHHSa2w55R6wCeocy9ZPPokYcjIq8DS1Xv3lNHPrr/84/dpJbE0M59/7zTVxRY+uXZ9e+YuY0ny
 jfrzlKFQrUphFJTMPF9s6dWV8IPq+VqEFNeZ7rFt9yjroYkRlLUArKGJQ1pVg9rJBXv1IJIczo9
 urywnSzrG5L4uLjRuNS1GGEUlzaurWKuzW9LUZ2kxo1/7kX12+dhvlIAZrY6f96yUMVGi8N9vJb
 7jqnv3rub8MtL1K0GpCZuYy0mvEO6EjwCzCOxtlaQUSYNOhSkNmjbJYrDOGFdXOKZgbdw0ZcnXJ
 3dT65G2nmH0va6qtwrVMO/HX4odJWsKVxNr3EPyYfdS0Ng81mjbKMR5pngRJJI3UdiGoPdP3G55
 HHS4pJtcqXZF45CARca4L2yutp/wuvTVkhhXd1PUG6FP9xcLFaJwSaTsdAS6Y20tg2e53tCBRmP
 QxF5MyIeIgzvTw3iYlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

Now that the eh_frame infrastructure is fully in place, make it work by
hooking it up to the unwind_user interface.

Based on Josh Poimboeuf's, Steven Rostedt's, and my unwind user sframe
implementation.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/Kconfig                      |  1 +
 include/linux/unwind_user_types.h |  4 +++-
 kernel/unwind/user.c              | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 60542d5e5731..ea969811f798 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -488,6 +488,7 @@ config UNWIND_USER
 
 config HAVE_UNWIND_USER_EH_FRAME
 	bool
+	select UNWIND_USER
 
 config HAVE_UNWIND_USER_FP
 	bool
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 4da058096259..88fc2fee8534 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -9,7 +9,8 @@
  * available.
  */
 enum unwind_user_type_bits {
-	UNWIND_USER_TYPE_FP_BIT =		0,
+	UNWIND_USER_TYPE_EH_FRAME_BIT =		0,
+	UNWIND_USER_TYPE_FP_BIT =		1,
 
 	NR_UNWIND_USER_TYPE_BITS,
 };
@@ -17,6 +18,7 @@ enum unwind_user_type_bits {
 enum unwind_user_type {
 	/* Type "none" for the start of stack walk iteration. */
 	UNWIND_USER_TYPE_NONE =			0,
+	UNWIND_USER_TYPE_EH_FRAME =		BIT(UNWIND_USER_TYPE_EH_FRAME_BIT),
 	UNWIND_USER_TYPE_FP =			BIT(UNWIND_USER_TYPE_FP_BIT),
 };
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 830c620fe453..85fc82252af1 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -10,6 +10,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
+#include <linux/eh_frame.h>
 
 #ifdef CONFIG_DYNAMIC_DEBUG
 
@@ -173,6 +174,16 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 	return unwind_user_next_common(state, &fp_frame);
 }
 
+static int unwind_user_next_eh_frame(struct unwind_user_state *state)
+{
+	struct unwind_user_frame frame;
+
+	/* eh_frame expects the frame to be local storage */
+	if (eh_frame_find(state->ip, &frame))
+		return -ENOENT;
+	return unwind_user_next_common(state, &frame);
+}
+
 static int unwind_user_next(struct unwind_user_state *state)
 {
 	unsigned long iter_mask = state->available_types;
@@ -186,6 +197,16 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 		state->current_type = type;
 		switch (type) {
+		case UNWIND_USER_TYPE_EH_FRAME:
+			switch (unwind_user_next_eh_frame(state)) {
+			case 0:
+				return 0;
+			case -ENOENT:
+				continue;	/* Try next method. */
+			default:
+				state->done = true;
+			}
+			break;
 		case UNWIND_USER_TYPE_FP:
 			if (!unwind_user_next_fp(state))
 				return 0;
@@ -214,6 +235,8 @@ static int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
+	if (current_has_eh_frame())
+		state->available_types |= UNWIND_USER_TYPE_EH_FRAME;
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->available_types |= UNWIND_USER_TYPE_FP;
 
-- 
2.53.0

