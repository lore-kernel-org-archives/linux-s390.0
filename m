Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489133290B8;
	Mon,  1 Jun 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336032; cv=none; b=siAgVSYk4ZwaF0u0XzmoNFE4t578p0TmEGMTkxFqPy6klk+AbI/RAIQ4uQbQJ69Fim2D3BZJMrwEdzsejogXNC1h/CEGFlTg3NsRVGDCOrV97RmBoqcE18/AG50aVMcQCtFVjCAYvoiW2LH0rAQQneg0fUWAFGs+DaCryVBc4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336032; c=relaxed/simple;
	bh=6Beh0BXLshpfL2Hb+MbUXy5c5KIRMxIbuJ8AL0kTKes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1nSIe58dxmieBvRSOm8TEkmS/DJcarubeGJC1kBWHlgEsXgLmWOdbQWyrTV2H/+OPEE7mmlm+vjqCCTsCGASbZFcea1aR2YVuPNdI9aNULZNMgYvhCfcdfjHdygIvXmRGD6bVjZmn67xsuJBet301Wa426qElWkyIT+a12lffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AVixrssm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AVixrssm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FtHA92915119;
	Mon, 1 Jun 2026 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kiTQIqXzFRNR10s1i
	TIOjFdWLOqwspy0rkyPaFJ0kjE=; b=AVixrssmtr7lmKpa+fwDPRqv0lV3uU1/r
	p4jSN9MQxQEDBbu6NhtFft8xpi8otyb0Uvu7bh2X/9RWMWkukeS9PawulAcUwoDm
	1wZblhSgr+yhN8X6NgWsmpTKbLES7LZ1OzfM1jPrWbvUDIosK4whcRFTWahv1aC7
	r9rE5c3XNNqemlkKxDONnhx44lbydzcqeP/T+dRVSox8MjohC71dhp7MTz1PbJn2
	VJoFXQF4D17IEGNqLacUx21zW+Lc4wtMlvdzmXIQUIjWKuNEmhQQR5zRMeuYehP3
	HRaOmIQ0SUS62QuUrNixFTkD/b25TF6+x2hBUEp5vtbvc01VOs3aw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd427sd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Hd61j025111;
	Mon, 1 Jun 2026 17:46:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvqh3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651HklgZ45220098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E5020040;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA3F2004B;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v5 1/6] s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
Date: Mon,  1 Jun 2026 19:46:20 +0200
Message-ID: <20260601174625.2910233-2-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601174625.2910233-1-japo@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfXyA99xsXcX0Dd
 P/F0Cy5uqQa4xCANClZfmg3bCWoGeCd0jZRoUVZ0Jmb8kB6nkbouNALBd12gMNeaqCX4sVL3f7/
 ydzFO3vU7/pTDV5dLsNdtokCukO61ZKhuF2d8Qyy88iSyB5HOlIr74ROy9nlhBBP6babLDa7M4G
 nBL5QKccpa4PWWYMAJaAQwiiSf0z+kOKmC1JfUlasnljbkp/T9lt31Nd1AO8xyLGQBEedEgNklC
 iPyO28rk4Tm5+efWtGKfbDgSMUb1VXfWguPofZdKAyKhTGtL+vkEZ54G8i+joN08QBFXXRv3D7D
 iK9HZCc0Fvs18QGjVy/HkeLFH1AZ8lZ/0T4eAkQNn1EVKwCG9FTVeAuhVlPazP10m2VFvf4+0QW
 ZgqWqTycn3CFlo7R0TB0gvjjNbVhickAMv0Hbxu9QdEec9S+WFR986OwD4ziwdY9YT1C9enkEpf
 Ezst32rHKIiriTtTNzA==
X-Proofpoint-GUID: 0tT5OgJF6yi6c20TP8yP5dQBmTEOTWty
X-Proofpoint-ORIG-GUID: qsAZwh1riQIXGKVXJ-J9v05iSYEMM-1O
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1dc58c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=_2yia0w1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gpATZORf9AIJ6E5TQREA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

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
index 59017fd3d935..d8e65885e935 100644
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
+	__stringify(mc 0(%r0),0) "\n"					\
+	__BUG_ENTRY("9b", file, line, flags, size)
+
+#define ARCH_WARN_REACHABLE
+
 #endif /* CONFIG_BUG && CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS */
 #endif /* __ASSEMBLER__ */
 
-- 
2.53.0

