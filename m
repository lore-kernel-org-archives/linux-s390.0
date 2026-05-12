Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E638E8A9;
	Tue, 12 May 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583619; cv=none; b=hIcPBUBDLSXxt8+81L5thkRywjcOsqon6IxpySVgJ/hk4pDbVSUJCC9sEWyF1oZunweoVTLwQyr8lY06mUTf5MoZUuFugIXG87Sb7vF+3tjerq+Cc+qsV4QVOEqWz3/SZ244huherNNyiHkmCsjm6fwpJV9jjA5maSsZmEXd4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583619; c=relaxed/simple;
	bh=U6/LcTiqruqor+FDjFsQzDGbTMZxpL+RX21QAg/TWWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/F3Hx6RBfeLPqbp6d0XxaOlgb5e6Hw8hxmgIFpP1FeIkQHcOaA4CxGh9C6FuPFaaUdUnF7nPP7fOyrHMnpZXmG2UKNHjQClS3EZZem50pAB4e+ZYU9PzHDXxLXQ6rDZv/J2dYc4PovCZr135N7w+OVTTR1TUWbOas7IobTzCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mM43fB8r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mM43fB8r"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C1doub3868883;
	Tue, 12 May 2026 10:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9QN4xzwD0rdAXfP9K
	EGOymcaOuZFhUrdoTCs7CLW064=; b=mM43fB8rFi/+qe37nI0fHe7k96hKzqByz
	/vqbWTkbRnHGO2N9nTHqEQ943FKo1o7HUNEPhdRPBAJtLqtRq0ewNZ8GW6XjEwN9
	ApVjIbiCWk8Lj64phC7eapeBs5j+hbR9sjFc3DEFd3L1CXOrFifYYAnTJZCSl5eq
	ViQPzvXWVic9C5bxs2rkvrrCnGhi/OwkQFXWnXc7mscbX72lo4jsLA7nrqh/QfV0
	mhS++ney571wMhsJarYPDmH9XUXSSIenmTHWdY24/NVfeEVlOCVuba4LTmpw+HtY
	xh+SNWgL/hLVqbMu41OVCFfj/KdMffhIqCAa9kYdcKc6hntg/ayIw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5ap4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CAdZnq021833;
	Tue, 12 May 2026 10:59:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgassk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CAxWZi40829286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 10:59:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C197920043;
	Tue, 12 May 2026 10:59:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FD4D2004B;
	Tue, 12 May 2026 10:59:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 10:59:32 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
Date: Tue, 12 May 2026 12:59:17 +0200
Message-ID: <20260512105920.2426293-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512105920.2426293-1-japo@linux.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a030819 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=F81QZrn2fL8uw8yBg3oA:9
X-Proofpoint-ORIG-GUID: ClCL0DXOOzJuKIGWUxhG3T9zNgCWcUBS
X-Proofpoint-GUID: OzDshFBJiaKr-kYi7QD8co5-LoJH9Bq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwOSBTYWx0ZWRfX3SCVmdsc82Ow
 3/ZZf+0YfxNzuMRNus8iGEQ/IvTlI905XYaJAJGhWWInI6KjXi4t4PYAus5NoFA0UoG4nJIM3Zb
 VuiTomc7FeL2sgxavbB/BjQpJt2i45lk0cYWyI0EgqzRsjhLTSVqCXrdemoBGcp8tPDHjXWMU+H
 a+WMBrDXdXHSXqUOmhKzWeBALycJLlVCS/m5q4cLw3Jkt6UwS03ml0G1tY7xSFxu6qZpv7/dv6Q
 +IJNf6b+ptS1ph9yFE4xPvbTAJNpOMmr1PAcRCkILtrWb7cL7kZXaXU2T7tq61Jr/2nZ2SCpnZt
 isTxPT+AojWnNj6DNfetXyFWQaLZT1d14yQpmh46JA4iHjFXkgoX53IjqfKI+UWhLq9jmS6zJnT
 ismhL1F6PE07XAe+BkudRNFcbaN5hdktpC/Gdsgihz0CSw5gUT+atpTM44jUAeJXuqPJC3eulgD
 hpeyzxtM6gKJCH2erJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120109

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
index 59017fd3d935..baaf5d571785 100644
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
+	__stringify(mc MONCODE_BUG(%r0),0) "\n"				\
+	__BUG_ENTRY("9b", file, line, flags, size)
+
+#define ARCH_WARN_REACHABLE
+
 #endif /* CONFIG_BUG && CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS */
 #endif /* __ASSEMBLER__ */
 
-- 
2.51.0

