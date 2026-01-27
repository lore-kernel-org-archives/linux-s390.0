Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9A2DFA46;
	Tue, 27 Jan 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528040; cv=none; b=DC7fBe6+j5j4AU7rxIJA4V2dezsE6wgHlIv/O+xlxSz9a5u94ePEifNiZTIbu1IGXzteJM2zOYU/4lk/H6FeGKB+kIDQbOqjtCpHmr5y83fAW7uPCkwELoBnpoRaCdgzm2F/2kyeX43PABRVuVcjQz/gwA243f8MjoPcxzJIqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528040; c=relaxed/simple;
	bh=8EpHxZmbo5MA89kwaBMFvsr5o9QT3VveoDjwUfOUgBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTPLr5TGkwXj/AytfDjCl0gtUh/uYbyrmlsLc+KAlQ4nwREvUWyzib6xbIWegUUGVoqhya0YWFkFTvlnZGvpa/vtSB6nPeHgnZq5ygB9hI/QTUtE5fUJROKCIRS4Rd1zZU/+UjsUoLKESJA2m6hKGdg+wyAIqcgFu5ns9ykZVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wh4gcOtU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wh4gcOtU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7xVZj021517;
	Tue, 27 Jan 2026 15:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A6LNSorwzVv4H5Mhx
	oq3cEEmuKyMfMFGQ0xYyBTQIzg=; b=Wh4gcOtUlcxviEzQI7qHSGK6ylDMHEGaX
	UHrFXrMQIaH6eb4iNOOo9Qx/BjmRUWg7Gf3R8fFzf/a4xNDFtKmGCO/Ab1A6LVE6
	fE9g5tpVs5U3e7h34jUQlEmcCDIZh/3m85fdMBdcj0jmdVeqRJc7qMk1plw8+/Qj
	OYcueNumLGcnZgNDzzsZvR4zkbChNvgtWXH4OXKEJMYS10mlW+cflpHjwXSRa9jc
	DcTSLMS/ghMXqHK8S79p9NVy3fMa6h+Yzj4Z2gWPX2/kewHV+Ezil/lIZUH0nvsx
	Owouv8nzKelRR6pqbYVFdRi2jOr+VwIrM2MDYXLJL8F86OHhUsToA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmnnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFJc72000308;
	Tue, 27 Jan 2026 15:33:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmnmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDXlxe026805;
	Tue, 27 Jan 2026 15:33:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk94jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFXYR217826170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:33:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1187E20040;
	Tue, 27 Jan 2026 15:33:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C4020043;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v1 2/5] unwind_user/sframe: Add support for signal frame indication
Date: Tue, 27 Jan 2026 16:33:28 +0100
Message-ID: <20260127153331.2902504-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127153331.2902504-1-jremus@linux.ibm.com>
References: <20260127153331.2902504-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978dad3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=2aD4vtywDDCJo0oALMAA:9
X-Proofpoint-GUID: 7V0RLH_uAxNet9SNUFsSWHiZ3uiWnj5f
X-Proofpoint-ORIG-GUID: zWvwnW9BxTrisa8ZJ1QcNz7HD8q0pL7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX4gj2vaKP5sGl
 j10QJ+t5anyfJa8nl2vSyXDe3LnULkBHEuvNVuz52n6zKXVIIFihkcEdOXrV6ANdnOHxLxuYtPc
 4XLo0W5gprSAT/M9xbT3wO/fZ1HU5OyJG2e9jfQ2+QC2qgNZRuhxXYoc04pgVH9HqeGr1vMsbpE
 YwcvuJkl3fHQJcS1BVklp7gmSjWyck+l8mHbgEaor+eoA9jgK5Yuoj2RdahoVY5anfdKch3yCr2
 8khSpefxYHhBce99Uw6yvuEX0rLrKYgwmA3rpaZiYtiR/f/TZAEkq8AcWiCNPQWiSH+913BPU1t
 f9DgCFOfnb2KAgxr0Gf9pSToymbo9L1/S0WJKPQJE1GW+VWs6XRFb//8VFH4Vs4M9AUZoI1Z1Fi
 OLOQFwkI1o3d/h1JIzzNVAVW/qvejxiII44c37yl+GrAxSIxcJw9Zc+shplUDqaZ7IozpGs3mcR
 zyBT2xomHdHC9uMRAGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125

SFrame V3 represents the assembler directive .cfi_signal_frame using
a SFrame FDE flag.  Note that a SFrame FDE with this particular flag set
may have no SFrame FREs.

Introduce a SFRAME_V3_FDE_SIGNAL_P() helper macro.  Use it in
__find_fre() to populate the signal flag in struct unwind_user_frame,
even if there are no FREs.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/sframe.c | 8 +++++++-
 kernel/unwind/sframe.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 21283e3bda42..9fd2fc1572cc 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -446,6 +446,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 				      struct unwind_user_frame *frame)
 {
 	unsigned char fde_pctype = SFRAME_V3_FDE_PCTYPE(fde->info);
+	bool signal = SFRAME_V3_FDE_SIGNAL_P(fde->info);
 	struct sframe_fre_internal *fre, *prev_fre = NULL;
 	struct sframe_fre_internal fres[2];
 	unsigned long fre_addr;
@@ -486,8 +487,11 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		prev_fre = fre;
 	}
 
-	if (!prev_fre)
+	if (!prev_fre) {
+		if (signal)
+			goto signal;
 		return -EINVAL;
+	}
 	fre = prev_fre;
 
 	ret = __read_fre_datawords(sec, fde, fre);
@@ -500,6 +504,8 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	sframe_init_rule_data(&frame->fp, fre->fp_ctl, fre->fp_off);
 	frame->sp_off  = SFRAME_SP_OFFSET;
 	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
+signal:
+	frame->signal = signal;
 
 	return 0;
 }
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index 8a5322e95403..78432857f84c 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -65,6 +65,7 @@ struct sframe_fda_v3 {
 #define SFRAME_V3_FDE_FRE_TYPE(info)		((info) & 0xf)
 #define SFRAME_V3_FDE_PCTYPE(info)		(((info) >> 4) & 0x1)
 #define SFRAME_V3_AARCH64_FDE_PAUTH_KEY(info)	(((info) >> 5) & 0x1)
+#define SFRAME_V3_FDE_SIGNAL_P(info)		(((info) >> 7) & 0x1)
 
 #define SFRAME_FDE_TYPE_REGULAR			0
 #define SFRAME_FDE_TYPE_FLEXIBLE		1
-- 
2.51.0

