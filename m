Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DA322B88;
	Tue,  9 Dec 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282646; cv=none; b=K23R04TLZ+XXl+LdcQAmhUBsrwCnZsd1bp7EWGxzZcoOtysVMUkMH9rjrld2ImS2oQaANJoMJwci3LH5i6M/Ubdw9jAEIz6jeLDqbjDBX5ezM8D/6wIpp9D33/Md7Q7BfAuJEVQgmyXN4WW9K648owQewxrZHRVxQnskvEYLfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282646; c=relaxed/simple;
	bh=tlPlwCGYgMBUjzd0QJiiPXC9FJ9nYBH5Zkn1ttWYIJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHpM6j0ZKLIkHEfrHLmC0ulvUGiqCmUJgLsoD7f2wrnvMr36NNIf2Tdg+rJKQ+TMhJ+tbDcpK9xyRP7OY/9vdmOeEs6vo7kMegTPe4COPWiJ6+jx+rYYYkqmY3Qu4YXof55ourEFEm8PnRg7nO6/NIWj47srZlUejVvIxsleryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FK0ZXTRs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FK0ZXTRs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B99Vx7X002462;
	Tue, 9 Dec 2025 12:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mco84vDQwVMoTlRTI
	mYE3TmP3tQMcXaXnoH93sMmm1c=; b=FK0ZXTRsYObHMmHIEh8WK7W0bKdf5UKz6
	Lzw0m0bGBzsjjlCkCYsCeBzofvkM+ceL7A1p90hu5BHyLjeNwnMlmZ/Fm+olO+tw
	8ty/TBCaGtlHHoeHCBtSW4j3iYp7m991U1qc6MAsHDnxsF8zsDwbd4Zy+hwCg6b8
	XBqtiM02FWaveJuXL3B8Hz2hFg/gJV37BxIFnM5jallOur2twN+XR8mFgj80sS1S
	UCAUpzctFLX8CcpH+ze7y2eaCQHiG41/S3MRA0AQ+7anxu5Kp7KPAlbftQGPlZWX
	hin6NzYG6NE1VoZ4Z7PZ0rpXdotHdfCY0hv0Q4lS9zRcbDCLdR38Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61crds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B98lQXm026789;
	Tue, 9 Dec 2025 12:17:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h12fuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH2Rl13173016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BBC920040;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CF5C20043;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/9] s390/bug: Introduce and use monitor code macro
Date: Tue,  9 Dec 2025 13:16:56 +0100
Message-ID: <20251209121701.1856271-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX0L38cm8u+2WR
 qnvaXxynDAi1WnrmketIoyPRBptD0rQ8EiZhk5Wc5OOSShckCOtg+AOuIpT+NjU1HLmazerLlw5
 ILiCS2FEkX6dcgGpQHIdTQaO68kp3a01g4v6Bqhe2bq13SpQ2wE6rbtztU9jN+W841kiT4TB0oW
 9UKQL5HfDzmLALWm1KUBSkRxiE3Vkk5Mc2qTaIxbgVITxzTrs9WqSjauzPEG3LISjy+eKocV1iv
 k2zGa65FgiiqOIBAI5Os+eBfXMBqHMeRNk1boGQefmkZxGR+43PE8KvAw90x2dfvrPksscyReNh
 iqz8C0BowvI4BhPSezXAa2mXQPgCyX/Ebl11aUTn+ILjzQa0p1FUi2yg6rIN6xugHSBGcjxuEVV
 MrHk7lv2L0iAOryAgx0fzxmmENHKXw==
X-Proofpoint-GUID: rJ08T93RRR-qTLKu7iX7yQ8kQxmnhB2f
X-Proofpoint-ORIG-GUID: rJ08T93RRR-qTLKu7iX7yQ8kQxmnhB2f
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69381346 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=1CQZ4ekRhcDcd_lEXJAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

The first operand address of the monitor call (mc) instruction is the
monitor code. Currently the monitor code is ignored, but this will
change. Therefore add and use MONCODE_BUG instead of a hardcoded zero.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 10 ++++++++--
 arch/s390/kernel/traps.c    |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 5a635158cbad..1e1dece0eee4 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -3,7 +3,11 @@
 #define _ASM_S390_BUG_H
 
 #include <linux/compiler.h>
+#include <linux/const.h>
 
+#define	MONCODE_BUG	_AC(0, U)
+
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_BUG
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
@@ -24,7 +28,7 @@
 #define __BUG_ASM(cond_str, flags)					\
 do {									\
 	asm_inline volatile("\n"					\
-		"0:	mc	0,0\n"					\
+		"0:	mc	%[monc](%%r0),0\n"			\
 		"	.section __bug_table,\"aw\"\n"			\
 		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
 		__BUG_ENTRY_VERBOSE("%[frmt]", "%[file]", "%[line]")	\
@@ -32,7 +36,8 @@ do {									\
 		"	.org	1b+%[size]\n"				\
 		"	.previous"					\
 		:							\
-		: [frmt] "i" (WARN_CONDITION_STR(cond_str)),		\
+		: [monc] "i" (MONCODE_BUG),				\
+		  [frmt] "i" (WARN_CONDITION_STR(cond_str)),		\
 		  [file] "i" (__FILE__),				\
 		  [line] "i" (__LINE__),				\
 		  [flgs] "i" (flags),					\
@@ -54,6 +59,7 @@ do {									\
 #define HAVE_ARCH_BUG_FORMAT
 
 #endif /* CONFIG_BUG */
+#endif /* __ASSEMBLER__ */
 
 #include <asm-generic/bug.h>
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 19687dab32f7..de63e98e724b 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -258,11 +258,12 @@ static void __init test_monitor_call(void)
 	if (!IS_ENABLED(CONFIG_BUG))
 		return;
 	asm_inline volatile(
-		"	mc	0,0\n"
+		"	mc	%[monc](%%r0),0\n"
 		"0:	lhi	%[val],0\n"
 		"1:\n"
 		EX_TABLE(0b, 1b)
-		: [val] "+d" (val));
+		: [val] "+d" (val)
+		: [monc] "i" (MONCODE_BUG));
 	if (!val)
 		panic("Monitor call doesn't work!\n");
 }
-- 
2.51.0

