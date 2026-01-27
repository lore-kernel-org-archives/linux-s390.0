Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3992361654;
	Tue, 27 Jan 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527206; cv=none; b=jWj0L8FsKujzoKIK1C317EcKBP0AZ44dSDjYOypr+88aiLsn4UWQMm6UyL5RNYjUVjDxDNsFROFhJAhLOu8WwxcjEmS7UsxJWyTytcZXboTdasE//yB/ioYzt300w8nBEYWwn5l9z0RKubrTTJwOOPJZyltG/zxpcVA/F/c7VL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527206; c=relaxed/simple;
	bh=kaPUe9HEKn8n1z5tXB04hI3rzMgQLA6Ru2FLKn1YNjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsDZt9F9zAXbPEHUGm3mLNJYB3KkYpPJnLdYRCYRijr/S+KR5oelnPDF+0cwlQI9NrI+Y0iLmaV0A28Uag7P5ba8c1BFz20B4lbFlvrP+1kGzbV/TCkyUn45S12D4Y6QSA6zPuIdcP7w3Dfi553oWWB7HCeteVwuaQ/5o+UUHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q6J8Inew; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q6J8Inew"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R87CcA017052;
	Tue, 27 Jan 2026 15:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0U9VOyhHCvaJ8UWLX
	8BbR5hsyCDcsncf5gTti8J2pdY=; b=q6J8Inewdoa8NYTWMimSrskbIOwa4Js+q
	NPQk/2mPuvSnc1YLiSh3TbMBdrFedOHPALff0EpEhNkyFRAQu6p4ir9c/boU5H79
	DFhBu+wFE/WyAtGRXPfDUx3obA3rz+VpprZwZ3HXJMSSfS6dXiGIGYUpYqp+S7AN
	jfxttyTBoZ/nhCRwpBQeIululgvxflg0GOnHJ6UmHX5iv04+mzW0UgEEh5HSpKWr
	XKtVz6leYC6THim18lPOFDzuQqTgKIGHGVe8ob2DGdY48opeGhC6sRPqriEiLHhv
	2KFL5Z+jzpYar8vy1JtUjQNId/PYjgfX1PDUBd+NB8q0+WMePQMow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvfft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFGGf8014106;
	Tue, 27 Jan 2026 15:19:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvffm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REgU8i023624;
	Tue, 27 Jan 2026 15:19:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjrxxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJVv747645146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC2A520040;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8401E2004B;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:31 +0000 (GMT)
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
Subject: [PATCH v4 01/12] s390: asm/dwarf.h should only be included in assembly files
Date: Tue, 27 Jan 2026 16:19:14 +0100
Message-ID: <20260127151926.2805123-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6978d789 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=62EC5onNXgn9lpaB:21 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AB0lExOjSfRHyy3z6bMA:9
X-Proofpoint-GUID: SagVeGzBAfCeEh-IB3v7NxBRHDwEqn7w
X-Proofpoint-ORIG-GUID: hAb7Qz9FU9hp-6BRrNTIApnjgNty2F9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfXyB1dPePuW95I
 NgK0Lfug4ZCx0qfMsg2bO7BVcxg6CuIv+JsMdAh/gRcNjvXJu3yJX/xNrNLra3vUcBmockFdlsD
 bHgOM2yvwL5fQ/mKxBDjRRf3BDNs08yBnLOOA1ir+YF0hX1nDKCl6Ihr+igP+eVYTyhaLYa6/vm
 4mNh9PnxtE0QHG+DxGIjJrDX39fOGimeLK6zQcH6EbEM0URrAhu9Re53MeXq970SZT+IB7XoWRk
 lqftOqIirYJXDTbzPmQXtL8TelbQ5X/n7EC4yl2wcIDqBGiwdISrcmubWUJlwbA3zSqNzhdTtZi
 RplG03rEj0KsArQ0m0rGKpHUUXZMVOQ3dFqUVqz45gvPMmua1PN/U+WHUFN+AukncGthKGtRxuN
 TTptntW9YrOmhYUAwsGP6+c+Jc/6WAp7DJY1ivqF6OJ0VlhMbeoNEJu/FvyHtgl2+RIgPBEmSTs
 VIDj6Hc2pUEvKxwSNnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270125

Align to x86 and add a compile-time check that asm/dwarf.h is only
included in pure assembly files.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Adjust to upstream change of __ASSEMBLY__ to __ASSEMBLER__.

 arch/s390/include/asm/dwarf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index e3ad6798d0cd..df9f467910f7 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -2,7 +2,9 @@
 #ifndef _ASM_S390_DWARF_H
 #define _ASM_S390_DWARF_H
 
-#ifdef __ASSEMBLER__
+#ifndef __ASSEMBLER__
+#warning "asm/dwarf.h should be only included in pure assembly files"
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
@@ -33,6 +35,4 @@
 	.cfi_sections .eh_frame, .debug_frame
 #endif
 
-#endif	/* __ASSEMBLER__ */
-
 #endif	/* _ASM_S390_DWARF_H */
-- 
2.51.0

