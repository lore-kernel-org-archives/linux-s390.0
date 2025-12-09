Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3108322C60;
	Tue,  9 Dec 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282641; cv=none; b=PHkpN1ZPd5v07bHZFJ9FAfoTWfCfaNzNCvELyllUQBwOgSz1/Hp8lCWZ6jC09rPpiwPBpaVs+Lf3qSuWuKQxyssSkvyPhzlmAdrQDUGETU3urADEOtkbSc5M46DrEBvK2K49HkqfNooOmmbku6tJgfiVbrxdLnfXGXgDYApn4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282641; c=relaxed/simple;
	bh=UDGmtkfo5pC5WgRYjTtEptOjFClgTjlbQFPUYawf5bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVmmHS5WvPxgrpm8ICSivHdjbHyYMre+Ic5K4AQuaoslswacuslefjO6s98ZmZRLW+WAqPBMhaie+5io12vGNvMSiKqdJydbEzhv9GLRTjfbngtl8flDlviKe2McAXz0JA+CWwDnU1DK/E9zFepv9XSyb3OAiVy2ecFCQYRBlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QIPepZkF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QIPepZkF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9AGpcW027524;
	Tue, 9 Dec 2025 12:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dAO6jDF7wzF8fbAN7
	X1asNEDmuL53nUTsOjcZDVPK4U=; b=QIPepZkFBxHZzb1zCzwhui0ll0cuJQL2H
	Qkhws15WvQcJRR2bFM68anXYKEpY+QVGit+tKMMhf0aNAzoP19nbOFATG3tJN1ZO
	6aJ77MVOqZM2jopfxXodLM0qcGMIv26NigHqdVGIxZqd8vXHMo2EHzblDJVM90y8
	6J1ChnJMXnOeMZt0Kiokaj91psz39CTSGdFHd5cxEitsG9AG259OHpBsvboqk8fR
	sdfa9NW4TIo7XXAAoNZLpnCT1MkDhWFBdNizOvYe/le6RsirBJU/5pGBZm/azPU0
	fD/7cuHFINmruWfANUFL+I6uzxyicUK5I6Zndgg6e/rF6dayqn59g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc61crdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9C2o8L002103;
	Tue, 9 Dec 2025 12:17:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jak9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH2Be13173014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3838620040;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDCF2004F;
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
Subject: [PATCH 3/9] s390/bug: Use BUG_FORMAT for DEBUG_BUGVERBOSE_DETAILED
Date: Tue,  9 Dec 2025 13:16:55 +0100
Message-ID: <20251209121701.1856271-4-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX7jLre2gjXI/M
 TuVkB2cHCnL7wH5jACVuFX6v8OnbuDXQYypVJFEcviLMxE1b+SnCOpUOKhNAzKftRxDOX5bnZqg
 EnE6JIcqtjKhhozGEOAY5kyy/+QiFwVObTiEQnDy4FDyF2CBc0Om5HKdK7Dyr0OwelA+js0Zs0T
 /CXk3Y+1GkgRns02i2RdyZ61iJHYU53GBSjtuJkkZVH+IvqgKtYtfit8wonHje80c3jEluDIXx0
 A0GGPF2XRXZIie0KvyTenaN+IK/ufn2lUFxJM4NPY3LkcmWjRPvPt+uxfGamnYUfU9224p8CTOl
 2JQDhHVRcElq+AMO8cOPLybL7NYqiMHQu0xD4L9XOdiNALzdjPmlmSR1fedmzSu/0v0B+7qMZhP
 nP/PEaoUEe+FnS00JG0wI1Dln7Q8Kg==
X-Proofpoint-GUID: ajk-IGSTWA516j5O_a4zneAKgReJXc0h
X-Proofpoint-ORIG-GUID: ajk-IGSTWA516j5O_a4zneAKgReJXc0h
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=69381343 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=O2IXE32GeF35JuYD2fkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

This is just the s390 variant of commit 4f1b701f24be ("x86/bug: Use
BUG_FORMAT for DEBUG_BUGVERBOSE_DETAILED").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 61496143a382..5a635158cbad 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -7,11 +7,18 @@
 #ifdef CONFIG_BUG
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define __BUG_ENTRY_VERBOSE(file, line)					\
+#define __BUG_ENTRY_VERBOSE(format, file, line)				\
+	"	.long	" format " - .	# bug_entry::format\n"		\
 	"	.long	" file " - .	# bug_entry::file\n"		\
 	"	.short	" line "	# bug_entry::line\n"
 #else
-#define __BUG_ENTRY_VERBOSE(file, line)
+#define __BUG_ENTRY_VERBOSE(format, file, line)
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE_DETAILED
+#define WARN_CONDITION_STR(cond_str) cond_str
+#else
+#define WARN_CONDITION_STR(cond_str) ""
 #endif
 
 #define __BUG_ASM(cond_str, flags)					\
@@ -20,12 +27,13 @@ do {									\
 		"0:	mc	0,0\n"					\
 		"	.section __bug_table,\"aw\"\n"			\
 		"1:	.long	0b - .	# bug_entry::bug_addr\n"	\
-		__BUG_ENTRY_VERBOSE("%[file]", "%[line]")		\
+		__BUG_ENTRY_VERBOSE("%[frmt]", "%[file]", "%[line]")	\
 		"	.short	%[flgs]	# bug_entry::flags\n"		\
 		"	.org	1b+%[size]\n"				\
 		"	.previous"					\
 		:							\
-		: [file] "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
+		: [frmt] "i" (WARN_CONDITION_STR(cond_str)),		\
+		  [file] "i" (__FILE__),				\
 		  [line] "i" (__LINE__),				\
 		  [flgs] "i" (flags),					\
 		  [size] "i" (sizeof(struct bug_entry)));		\
@@ -43,6 +51,7 @@ do {									\
 } while (0)
 
 #define HAVE_ARCH_BUG
+#define HAVE_ARCH_BUG_FORMAT
 
 #endif /* CONFIG_BUG */
 
-- 
2.51.0

