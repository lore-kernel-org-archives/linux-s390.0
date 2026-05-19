Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B93546C1;
	Tue, 19 May 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203571; cv=none; b=dSJ282JGrN0nhW2Lh+El1tIOzP83sAWsUbmciqy3xZtmja8YxhJY1C7zIvUUSCHptyDtqxqLnubrgt37uIAEpJblPUOyo9Du5Ev+Tm1JPLr3GptzE01KuMrCBfGNXnoYm+oMHg9qhovbDPJace/FbToLcj+HOF6CTHt21s2xfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203571; c=relaxed/simple;
	bh=l1cUyA5FplPN/2uL8yAw+l5bre+hzljT7SVrnK/XrEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBfuRlEyWO7qsa/zJ9NmoRCLtUTvcuokvHHrqVZbkIe4i+p9AxQjd/5uCCz8yK+jD/h3nOHWbsJPoFotX0e4WjHDLVZfcoqKoWmBQnnA074siXsUEhV0W0LUcady7BOeEUKXJq+YsHqNf2u+GdBGDYs0DW4eGikSn1HLpcjEtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJttePeL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJttePeL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J85YCQ2561525;
	Tue, 19 May 2026 15:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2nwvA2SPNwIg7l9kJ
	UtDl6L8v0ZoLWWwy2tUYAn++Ys=; b=qJttePeLe0OQcytegH0d8x4CLlVX5TSEW
	NQ2U2qiZWkgSXWWAKfw/WGJhJhPwr6nMvZSP91t263rm6baVTIBssktZEzJ1PYhC
	jospcvjRFMntcS+apVBjJr3y0+YqsRd/tL4tE+ybJ1XtrBJY25rGh2mb9Ig2MLzT
	Y7kvmUF7LglNSnbrgKksFK58jIyWOd01jwxlfrPpX/jVvoivlaeTcvqBrmslCoxB
	D0g9C65J7zQTJ2PM3IHz6OE8O96z4kNttFaSgPgICw5JI2Q8MJR0CPNfVYKOvcf6
	VrABlKRtAGt5fSaxfzRcmHVlkfnCTyma7dKxZEabtqC+QHVCshkPg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mnp3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JF95iY012254;
	Tue, 19 May 2026 15:12:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq3dn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JFCTdH46465432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:12:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71CF020043;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29AE42004D;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
Date: Tue, 19 May 2026 17:12:11 +0200
Message-ID: <20260519151215.1611802-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519151215.1611802-1-japo@linux.ibm.com>
References: <20260519151215.1611802-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: lOc65Af8eZvr7u8j5JgHHJNMIDq_UGXb
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0c7de2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=F81QZrn2fL8uw8yBg3oA:9
X-Proofpoint-ORIG-GUID: bEP3qfW4w1E3TQpEzAARnhuaJz99h10I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MCBTYWx0ZWRfXzzhpwFRskTHR
 Ir6KcBMyEiwPeEJsSJqstRjhO2JIHPTx/2fKInD56arXZurp/+e9xgejutSvz+1R9r1m/Jhbku/
 9pOlHmRGz73NphKQzX7/PPDDG/zhu/1yb1y+y3xOe1ETBDGTHlEDxDue8RZWkn7COS7BQdya3jw
 7589y/Bd/QGHl5oZoBT9ltYCWs6hLcdyyv33UEHhEgbSuPgCPYzb/VgeHTStKew26A3/kTvWO4j
 yjQVfEseU1ozebsP2ny7CkzY2SDQjHJfLaB7XFoY47o+4XpUwF8j8EiZTdjB9+LNISJkPbtB4DU
 4ANNTf5ryf2Buig+b58r4zYi5+N3fCA9VRGNPIUMP6dVMi2meG7B4ShbKAtIV+aB8kjgjJ/GqUO
 e5wxwTXLdzSvgR5fiTunBsNnqurkeWh3DJcEgtVW61EHavs8gajJyrycLdNtx4V7ckm91nl2TRm
 2R4d7DYHXJmK7H8qmuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190150

Rust WARN and BUG support relies on ARCH_WARN_ASM to emit __bug_table
entries. On s390 the macro is missing, so Rust code cannot generate
proper WARN/BUG metadata for the kernel's bug reporting infrastructure.

Define ARCH_WARN_ASM to produce the same assembly sequence and
__bug_table entry format as the existing s390 BUG handling, including
the monitor call. Define ARCH_WARN_REACHABLE as empty since s390 does
not provide reachability analysis for warning paths.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 59017fd3d935..a72439370f62 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/const.h>
+#include <linux/stringify.h>
 
 #define	MONCODE_BUG	_AC(0, U)
 #define	MONCODE_BUG_ARG _AC(1, U)
@@ -121,6 +122,17 @@ do {									\
 #define HAVE_ARCH_BUG_FORMAT
 #define HAVE_ARCH_BUG_FORMAT_ARGS
 
+#define ARCH_WARN_ASM(file, line, flags, size)				\
+	".section .rodata.str,\"aMS\",@progbits,1\n"			\
+	"9:\n"								\
+	".asciz \"\"\n"		/* Empty string for compatibility */	\
+	".previous\n"							\
+	"0:\n"								\
+	__stringify(mc 0(%r0),0) "\n"				\
+	__BUG_ENTRY("9b", file, line, flags, size)
+
+#define ARCH_WARN_REACHABLE
+
 #endif /* CONFIG_BUG && CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS */
 #endif /* __ASSEMBLER__ */
 
-- 
2.51.0

