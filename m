Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6884908B1;
	Fri, 24 Jul 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902422; cv=none; b=D56NUXgHmQUq9AGW8zqgZaHYif1PAtY6bpHeq84/0UGlX3X9z1RYuKysNkVLtFWLJDei5zpr5LM0SWCzrHcuZvwx+uBNslkzRmNXpv/JY6zKibw7HC+9Lq7eUYic0kzSlnEC9TJD4X8VKyQxiWs8LRTCFNuoXW6ECxegYRUHi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902422; c=relaxed/simple;
	bh=eD6KthX/agMahtfSxUkG9k9qP+fh0XjghUVPLnq/bM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEavj2GrtHDKI/TGcuMOMnUDFDnakjtdPK/I6T7CgKDsYQjLrVzF1UnR00wq1HOj/oPTor8Sd+95aFD7dS/ytwodBxV1yDdKXnrYITVJNWpdYqwnezT7tp5ZWoGnNdpJXzcmsKfBuLqvlf+hBIxNozVDqJZprTUJmzGxt+SGAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QNzIs/b1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QNzIs/b1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfnDU1869270;
	Fri, 24 Jul 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WLZu7e8IxS3aea7Sv
	V49Et/DZXMcYkot0Hljc8ji2Co=; b=QNzIs/b1BWpnnJcXLX4zUUZ18vkDLzc7O
	I1IP19bYG7axeox8rNKWxuwlG5FARixHB/jq7K9rAhZwHKBmT1NmRAkT/9o/9Z30
	kL1b/kRBz3248oMdi8QwBEE4sLo5uqUnwlOeOkPN669mGnxljh/Qb31yXmDyOZvZ
	0FTJCyxi2xmAytTlFNTgUEQ2P18ISXZbL0s1oXWLXBJ/NN8u3pR1gbpdGlgPx3o6
	4fcO7NH2ATjp6kmLR91/gwxPi9YfLXi38QadUWwl9FHUPRJLsRdMa4mGq99tflss
	R4ViKvSITYA7SGwx82db3Z5/QQwBU37qalP1WoEzF7jGbdO7MuSfg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gmcdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4eEI013218;
	Fri, 24 Jul 2026 14:13:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whamy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDNCg48038202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07FD220116;
	Fri, 24 Jul 2026 14:13:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70D820129;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: llvm@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI
Date: Fri, 24 Jul 2026 16:13:17 +0200
Message-ID: <20260724141318.1037434-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724141318.1037434-1-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXzwDy6ZnJDl4n
 J/Pi7uIfkfsU8jl1LOQFDoaD7gox7+ZAHJJP9lOuRYNWKfOojmZsf+FqsEjHk95WQDlG8XlyNZM
 S1e1p2GCTXCCu2RV/fAdFAzg/ZBYd7X6scbEazhbEyhG4TiYPw5tLPM2T3dm6qHGZgfim9O3nTv
 dq59g8W15Ri6y8YdZ8fdwFkXkn87fgC91XfPNpmYjNIamL14DAv0hX3y+J8/4JWG3NaKyGgkE0S
 /wZjdMLPGujQzinMXaGgYF45r5+vT0a4NWK07ukg7q74t+hFmI25KX5iKxHIM8CcSOSujDZpX4J
 5PiGK3i/IsG/yyw1a7ZOziwoSXgkO+rCLkFvWPxqVhnVUTBOynz/2ydZ9UjtXSPpXHRi8a2V1L6
 vaecV1Jk1UJbBMDjyqfBmwt3sBKGWYHY2m1wCzZrkVn0fVRZUxYaVxEC1PNX7QvxDJ8dKpD8Rn8
 K0QLin+lhtBKdmY3iFQ==
X-Proofpoint-GUID: xAyLlGmyh314oUpH8SwYTsP2WKzHI-B0
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a637308 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rWXMRKN3t-ortPuYfZYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX5OOLAGuBEw7V
 1XDpGtwih4lEuoiUluDK8akrq/krCvIVUGH6NRrY2BEU2MZQ9eO607E6jKzlugMYfz7G/2p/HhA
 vNT21bd2EyBMRIUafd/hXzo1IVCDI6E=
X-Proofpoint-ORIG-GUID: uHsx4DBFjSr0Mj2beW0O1Rw1QuoqejyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

With all prerequisites in place select ARCH_SUPPORTS_CFI.

Note that this support is supposed to work with the generic kcfi support
which is provided by clang. This comes with a couple of limitations:

The generic kcfi implementation does not generate a .kcfi_traps section,
nor is a special instruction used in case a checksum mismatch is detected.

This means in case of checksum mismatch the kernel just crashes. It should
be quite easy to tell by the surrounding code that a crash happened because
of a checksum mismatch.

If clang and/or gcc provide a .kcfi_traps section it will be possible to
print proper CFI messages instead of just crashing the kernel (enable
ARCH_USES_CFI_TRAPS).

In addition this also means that CFI_PERMISSIVE does not work. Even if the
option is selected the kernel will crash in case of checksum mismatch.

However it seems to be acceptable to enable kcfi support to the kernel now
even if it is not perfect. Later clang and gcc extensions are required to
improve this.

As of now a crash caused by a CFI failure looks like this:

illegal operation: 0001 ilc:1 [#1]SMP
Modules linked in: bpf_testmod(OE)
CPU: 0 UID: 0 PID: 92 Comm: test_progs Tainted: G           OE       7.2.0-rc4-00021-gc35ed7a1ca22-dirty #3 PREEMPTLAZY
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: IBM 3931 A01 703 (KVM/Linux)
Krnl PSW : 0704e00180000000 00000166d4853a0a (bpf_task_work_callback+0x176/0x290)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0400000069b02e96 000001665471856c 0000000084dc1000 000000008084da58
           000000008084da60 000000005ff492bf 0000000000000000 00000000809de300
           fffffffffff7ffff 00000000000a0337 00000000809e4d00 000000008437b100
           00000000801bc288 00000000801bc280 00000166d48538fc 000000e6d502ba90
Krnl Code: 00000166d48539fa: e320c0400004       lg      %r2,64(%r12)
           00000166d4853a00: e340c0480004       lg      %r4,72(%r12)
          *00000166d4853a06: a7640001           brc     6,00000166d4853a08
          >00000166d4853a0a: 0de1               basr    %r14,%r1
           00000166d4853a0c: e300b6580095       llh     %r0,1624(%r11)
           00000166d4853a12: ec040009027e       cij     %r0,2,4,00000166d4853a24
           00000166d4853a18: a70affff           ahi     %r0,-1
           00000166d4853a1c: 4000b658           sth     %r0,1624(%r11)
Call Trace:
 [<00000166d4853a0a>] bpf_task_work_callback+0x176/0x290
...

The disassembly contains the brc instruction (branch into the instruction
itself with two byte offset to execute an illegal instruction, and the
following basr instruction used for an indirect branch.

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..d57a6c02f51d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -144,6 +144,7 @@ config S390
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
-- 
2.53.0

