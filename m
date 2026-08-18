Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DF4746B9;
	Tue, 18 Aug 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064644; cv=none; b=sdgycnki3Tkuj4+D/w/AGzBbSiIJDAcFHDMSVIofKTOb5S/1uVczBe7KBJwuAqs8mdzOEZBLO4HqZSZc+qvAdY2V1uIUGcc4uCfR/QOZFYSQHURhtQ++R6JYNxINirk2z1b0UDBBtkmopLJBOv7JNT6H7AYaSbpoDjq+rfPCE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064644; c=relaxed/simple;
	bh=AMhQNb4JAsa+jlBSzff6AGFydffy3B//nxd42wH5HfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNka5LmBmRYjmqpTQXXM0rYDHCE6mMHtGtaP/AX1I6H4GUAHWBkoVUQX4MkkfJ5lHHonBZdK2WYJraCEHTI/lvJBvASZX7ZKA7uTE/3TyD8AqVvlmXTGQCBk2pdSY/y1IV9BBp/Y12cHU8wYnLe+GklhJG7s7pR6y1tp7g2iMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJ4qHphw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJ4qHphw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3ipr2831339;
	Tue, 18 Aug 2026 14:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9uRn1piC2zfGR8Dyy
	ycUNE9uLIucBpzYcAaaqwnf1uo=; b=kJ4qHphw4pL5LFI31hyN/yg5DmdQ9mEXi
	v0pIhMGdQOFzAuzxco4biEkD9W7OdtwseeDjUWsf6UchwxVkZ5Pw2Id0TP0vAlUl
	LrM4IocGSbiVYVDTyYrmIs3jh6npwAYzyJ0ZKuTxUrGBi4ySWZUBdOdcI1SFCiPM
	MuFiMoJK+fEVVtAMuKrxkagKpo8MkImWEEbFVwNoIdB8o+xWyoXp2dZDyVtYWeJI
	o9p5d3zmOA9B3qz6irvDKXw/ifii3JwnTlH/9bzr4wctFjg7PU092Sy3cFL0W/v8
	hUX6cbv/IdSuJhsVyilD0zB/DC+F0CNHDbjCdELE6G1GLxXmSCFtQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqrvr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfMYm025405;
	Tue, 18 Aug 2026 14:50:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh3q5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo0No29819544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA8C320040;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7378F20043;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:00 +0000 (GMT)
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
Subject: [RFC PATCH v1 11/25] unwind_user/eh_frame: Wire up unwind_user to eh_frame
Date: Tue, 18 Aug 2026 16:49:40 +0200
Message-ID: <20260818144954.2320378-12-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX3/UlmZ9W/JP2
 WGOeycrYno+H6Fn9R8o1qkq0fuLakg8wCKQ0qU+pX/5F3QEtejPjHMEbrsk1YbTEVUgZMj8yBiV
 Eu6PHhDjBh9fZoGn5dn5rv4m9//smvHe2UMqG1lqoCXbZvpz6zAg75As29FEtqYvonccxoLK0WP
 R6ZENaYDivZ1Dm5HAMltsRhiJjfh2j5dGFXx8m6R8Ae4c7QOeEBEiai2OJ1VWCSdNnxr0c9ehtk
 ILOucnXmFy/blQWVu8AIFeRQh4DDRqDNmSOtKnbm7iy7W1cjxClaPvsYXC2j6BVTv6eXqVlR0pM
 d2lhnLuPYrWOfSvJGu40U/cbgFDqF+hh+M1FAinCZ8ZPu/nwk2aESkFmkv5e8V8t7mQDCtSHi6l
 DUgqTAbdhVpqTRo7xk6SkZ0+2J6uA2KdrsXC6sPWmBMHY17h0bsJ5E5G3YSIeI29cWZvU4GVN5o
 R/p71GY5G4oWlm9kD9g==
X-Proofpoint-ORIG-GUID: Fch2np3my5BmMhd0tXmvBuHiLI03faCE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX6qE0HRT1DzMA
 L3Qd4uFlIPQcgNd5r4FBR0uakga+/GhAPL4Tt1vOW4XJ9wN4l2aba9sgMbQxp1lxcxaegCCNeDb
 YVXwXA0/UYyZu3wOVKufXvwQEBylrcA=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84711e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Z71hq_FPCwn_qcrh8uAA:9
X-Proofpoint-GUID: at7WDyMuZ4lCw5N8_ZjgdbBJHfwDgA8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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

