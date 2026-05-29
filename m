Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6F3F9F30;
	Fri, 29 May 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066705; cv=none; b=Vfhj5ZcXE7jVFkqy7dHttC9pJ+7Nxxy8yXeJ3yadpqGwfcwvgpIBvZtcs5MTR9xbBTbp+/a3BlH9NDNU3J4AkQ0QgbtljWLCQ0Sz6wpva11+xUusEjv+TbDHfcNBAvmd9ffa2ItO5X/sTYsl+1oNzSsuKbx9yUoNelNXlz55has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066705; c=relaxed/simple;
	bh=t9prYQ5R/QNczm6DLTqQUsztYBFPrZkZLT1+x0wTetQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3KA9hrf6xuR0lKCYLYawJFe5kSxmMuYY5Z/L14qrfyAoeKssUPcWFIiDQKEsvE8k/6VnMmRlin9H40D0vYB8ptYNIt0OVuzsWa6cMWQ9qe4xCm+oq1BrPqy+SSbDQEgoV2ykG4/9vM0+TDZ7lFgK28IjqGd4YotiiBpTO+WTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FvtNDIMm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FvtNDIMm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TAjhfP2133306;
	Fri, 29 May 2026 14:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g1D4FOhP0sX94oDuy
	01ICrI8pDgK0OI7tEiSOa5IySA=; b=FvtNDIMmj6jgaFShSH75DC7tFBG7fiRqZ
	RvbNiqzyjb1VwpYLOrHGFaYFSf75UHhyUkRiEqtMAq/gCLuQvDZQkYQO4SdG5XOt
	6Cf5o7su8J/krK6eMakEZY0uK8YppJP9qTB690MvFQrxQhNU7vSOMC61prE3VHz+
	AlvEpE4qa/vtIp8ThDfe2/c0tLAljyxXTQt8939oJJ8Hr6hTM1x1uTQ876DIZhLP
	lgYyokmnLOmL0z6mJqp1InVCnRIdmcDFogNWHZJVOtXqScJai7/6/4u73Ke1RK76
	qBGa8gXhHy6EqRdVYZrkfPqkulfEuB0jctv2FMSZt2EQbU3Pb2URg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887t6be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs7Z2005221;
	Fri, 29 May 2026 14:57:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc74ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEvsZf46268674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:57:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C56C20043;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E562004D;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
Date: Fri, 29 May 2026 16:57:47 +0200
Message-ID: <20260529145752.1209016-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529145752.1209016-1-japo@linux.ibm.com>
References: <20260529145752.1209016-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a19a977 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=_2yia0w1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gpATZORf9AIJ6E5TQREA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-GUID: pPPECtYoTcHRoGbgVZrcEv7yCdgXg6UH
X-Proofpoint-ORIG-GUID: s9PzUE96grJ90uhgjJTkpN5Jp7MtODNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfX4uzePk7v7zxd
 4SFiRb38HPA6JiooiqXFpDW2R3DMcOMal9YbYnmiN5dUEKJc1R/mMc9Wy7+Q3hD5NZfI4DJ4scb
 L/QqOsMFFDuG+Aix9PN2Jo2e9p8ZK3OMnT79haaVBwYclNPXVi8+Mj1kp6Doy0jaWNtpj36fgp9
 +HkSgIffDR2PUHynb7ryVg0xz5rtD3ZUN0QmNYFAW0gXwoESdHuY0PrcyxnLtUUt4UB/66c/TZz
 W2zapZ8/X0M+ohtwSvF/SkRBT2e9DS0qyhoS3TduLVIThIctjofu/ZPEOIA3pO6C5iBs1SuXKVy
 CI88UieugkCHsmbBs2xFoRJGBnusHgWSY2Vc7WLaWp0L20bU/FtiMQ8i1Y/L98WdjcoN+7+vMeH
 nskewOWszAljmIkNmtDxZ1o7PbC1Zs4O27oDL9w+HU/Jj5dFxifxyFrkZ7GGWvIIXNixQ03+hlx
 QREqEDRLmP0gKttx82g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290146

Rust WARN and BUG support relies on ARCH_WARN_ASM to emit __bug_table
entries. On s390 the macro is missing, so Rust code cannot generate
proper WARN/BUG metadata for the kernel's bug reporting infrastructure.

Define ARCH_WARN_ASM to produce the same assembly sequence and
__bug_table entry format as the existing s390 BUG handling, including
the monitor call. Define ARCH_WARN_REACHABLE as empty since s390 does
not provide reachability analysis for warning paths.

Acked-by: Gary Guo <gary@garyguo.net>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
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
2.53.0

