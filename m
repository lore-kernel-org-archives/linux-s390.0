Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969437E2E9;
	Tue, 18 Aug 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064631; cv=none; b=JRiUcRe5Oey3ovar8t5StVwJ44hWJDhsW9afRccpjRscTKA5EKnbiGQHtNOHyj/yEm1vmQA9WwVkd8KHS0Xn8+Ok3JUM1mutGRPC9C3LXm39upN2Q4wyFKpjhZsz1kiw5lI6y0eRUyysbPfJnnDliXpWK0wUYfjUS+HZbMbn4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064631; c=relaxed/simple;
	bh=O0SPzgf2EQOjoZmBiRzcLTE+OD7iWiK8l5BG6BpKfwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCNW27KIWTXLWTzMt57owHWFAWXwI0twLWpb21ZSpAtp7aw3WPjklZf/wHEUGeSYthFWQfsboVr5OXKphNJYgt3WYErSN5txHi7TtElyxF9ZWNZd9gKuv7kkT8pR2dRzmS0S2wmZJZco77WD9h7wxItGY+dGWYxDUxAFnaH76c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bYSfc0vk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bYSfc0vk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3c0H542431;
	Tue, 18 Aug 2026 14:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uy5/N5srkznANn5S/
	Kowiheg8PnzcVvDEkJYvUPZGHQ=; b=bYSfc0vkPvZ2L/cfRxPp2IVPtQ4uofmNG
	S5u+d2+OXjE1HWbusrZDiIzh4WBBl0SCU1LTk2hlwy5aXXMkC7fIdx5s5CJrtnu4
	SaZBH9BewkZQwMIr/TcIxwEcZxYxVnBcxrGsN+ddQzM2N2n5sYYEI3bYwZbQEocT
	wKea2pf9c3JF6Xk5VsXEalUx5RKn5WvnmeLxKJPLukge6Iv6xX0k82jwnQYGKvuu
	FVkXsH9ieN9CEVvE2+MktHs9egN6LCoxrzZyOiUuNfp1XLbiLBnVXGf71icKLPp8
	xrut6DtUS4T4SD4UU1Cv1VoDlV8oXHg6a65OTBpIlAMAYWtBLtDTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8btb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfVQE000623;
	Tue, 18 Aug 2026 14:50:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybgcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo3Am39584240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67BF220043;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD7E20040;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
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
        Sam James <sam@gentoo.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [RFC PATCH v1 19/25] x86/uaccess: Add unsafe_copy_from_user() implementation
Date: Tue, 18 Aug 2026 16:49:48 +0200
Message-ID: <20260818144954.2320378-20-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a847120 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8
 a=pGLkceISAAAA:8 a=gpC398cPzQKiNBT45cIA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXwmU4yKF0+OXq
 +A02kxUYSb4lnoEDiQ/pvHHDdGdHG66SaD+SMoXkdMxAhyYZs5ytG5FL9WFIPKMiwtp/4sA+MPJ
 K7xwMOph/kRAaJaAmoJjNpkK4pye57I=
X-Proofpoint-GUID: zdvb4IvzeITmmDxRy40CtXkrrQhGM4CG
X-Proofpoint-ORIG-GUID: QCBfe5MbYwNLOeXWuc-HVAIQVt0I2CQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX7sXD/w4YTy5X
 s7uQdKx8k7xfGYXGyrYaX9gfOT+hj6cyIsJ22ioZlu6Vlia9LLyz15ubW85KovnrjO3mbN68hfD
 i933NOgrS6wtR6AeZO4v+ZN4w+cbLSIZ0b5ZXPq01XTG0WuPgLsbELGFg6v8KRTqLVzNFiYsruV
 nUV8WiKpx01RViFbSQqEIDHB/WzRZsdEwuWJFpuFoOnAQE1jtyPVEK5oiNQ4cMpjWdyu+m/zC8Z
 S/Yy9lc71wNbKUtLL1jH21hNff0oZW77BaBrMF/jNFCB8BiUmTKHuUkNFYcwqqoY7bSXEbbDLkD
 PJ9DGiJB+wJP3CDPS+g1qQNiaRRi94rkCVNVWfoTWaOVgVWTtZ0TQJQo/f+ZIR+CgEk1XUVOsuN
 NdNc9tDV/d3au0Ra81lwkRCkpFoJozhs6aFBkEuH0OTeiArEr1mQkpZQ+/T+J5aTQKftw64mt61
 X0KYbuph/XYbYftJ68g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add an x86 implementation of unsafe_copy_from_user() similar to the
existing unsafe_copy_to_user().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-5-jremus@linux.ibm.com/

 arch/x86/include/asm/uaccess.h | 39 +++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..235886106f31 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -598,7 +598,7 @@ _label:									\
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_copy_loop(dst, src, len, type, label)				\
+#define unsafe_copy_to_user_loop(dst, src, len, type, label)			\
 	while (len >= sizeof(type)) {						\
 		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
 		dst += sizeof(type);						\
@@ -606,15 +606,34 @@ _label:									\
 		len -= sizeof(type);						\
 	}
 
-#define unsafe_copy_to_user(_dst,_src,_len,label)			\
-do {									\
-	char __user *__ucu_dst = (_dst);				\
-	const char *__ucu_src = (_src);					\
-	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+#define unsafe_copy_to_user(_dst, _src, _len, label)				\
+do {										\
+	void __user *__dst = (_dst);						\
+	const void *__src = (_src);						\
+	size_t __len = (_len);							\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
+} while (0)
+
+#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
+	while (len >= sizeof(type)) {						\
+		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_from_user(_dst, _src, _len, label)				\
+do {										\
+	void *__dst = (_dst);							\
+	const void __user *__src = (_src);					\
+	size_t __len = (_len);							\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.53.0

