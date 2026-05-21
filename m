Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C33C8C74;
	Thu, 21 May 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383012; cv=none; b=ClDtSU1TFm87qbmW/Br84BOSIxB9C8roSEm4wmXIR4H7ZFEXs9rBdXrBaCLesgovFzVViTn4QMU623vXI7PHI043Pv3ya5fTk46W108Dvbpp2aSd8LzQ28/pYwlBGEOwjabJbHYW6BWNfvUjekRGzZyocwUHB/oXIpPZzgUNnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383012; c=relaxed/simple;
	bh=l1cUyA5FplPN/2uL8yAw+l5bre+hzljT7SVrnK/XrEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3+mFa8KpKM5bc2KxbGJ/Rxn2owmGCemKEqs0G8xRkaTcIOmVRaQ8iJd5/VbTeX+sY5pSi10ZB/qpXJMDW51UK9ihaL77D3QDt6od9EZsG1Hcteor3MtwuDpCdKv6cynY1++X+sx5M2y4CU4VXGZtICQsyJyXV2HLV1ESnn71cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TrHIrFWr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TrHIrFWr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LE8JAq2887670;
	Thu, 21 May 2026 17:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2nwvA2SPNwIg7l9kJ
	UtDl6L8v0ZoLWWwy2tUYAn++Ys=; b=TrHIrFWrH6mohcFj20G/RmvaZk6GdJb3t
	GbDuTpjxThDkT46dLtiTblffVqghnz9K9daSh2TFUHkTTPhj7B83i8JIofqACSNX
	HD/eW0U++xh/mbxIR6RhhVZ5X5MMdM+eAfAnyvIxH8Rt7Xk/94NfweDT9TeyAHGQ
	5fwvuOzb3/SdSoS0vK7p9MSo/Pv/wKUVX0ZDNF/ahMbcsGtNH6adM6LZGeMPf/ci
	ddRPbe+1eR8TTUUb6tCRXK27BfazV93CsKmmsCKQntyXHvc8J7b28joXQfe34OHl
	VudNDtGXv2oL0970YIcKD4Htxy0gNeTZ0/YDyBLwzLpeVa/MZKyIA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawf0p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LGs9Ji014936;
	Thu, 21 May 2026 17:03:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqdh03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LH36eK31588708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 17:03:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19A9320040;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D62AA2005A;
	Thu, 21 May 2026 17:03:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 17:03:05 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
Date: Thu, 21 May 2026 18:56:19 +0200
Message-ID: <20260521165622.279953-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521165622.279953-1-japo@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2NyBTYWx0ZWRfX8afzmhpmHBgv
 Pp3klJW9VrZeWd8F8lQJVDhzsfkGcEAAGe9BDMTk61WLmDYUZkBB8wRkDJG7W5ERRMLSmA4p9c/
 JZNjIvGf0rZXOnqibsbHvco/bBR7Y8piplgFhlXfCeeZs53r/cxuSjTz10JjO2Rri1UKFF+SUen
 NoJwpPU+zs09CsuoRUpclJdKjKaolWGLFkWXv7xnFB+dgM2rt7U+eklsZTCbkUBHkvYfH1VJKT+
 P/tLr49PiH4G9FI8vONGG895ZxctxhiMGwX/ZVjv1MlRw4X52jucqRQciSBzybVaItfYY/acNl4
 7MLcirZIQu0PkDdQWSVrEvP29JpmF+PhdyiVAmEhXl1dqx56fsrqi23Jsr0/C474zdRO/sGGM6F
 EObHQszvQV86O+M3X6/2U2/cKPY1IqAH0jEb9YnU60BRSAR+AfFbVvri4xR1pd8XU3T6EgzQkm3
 +/SIqBA4+A8SIH/8WNw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f3acf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=F81QZrn2fL8uw8yBg3oA:9
X-Proofpoint-ORIG-GUID: kSdSLFQiwppZM3PZhH1D-LPB3y54YZGZ
X-Proofpoint-GUID: 1Tv2pCgM_v5CEnUV5jt9p-QkigHowDrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210167

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

