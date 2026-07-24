Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC9423EAD;
	Fri, 24 Jul 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902422; cv=none; b=Ahw/7bk24KFC9l7OfOkB9SIRHWdJP7MnjdJkCVBZDd1VvBzPt3OyUsDLtyA1yxQgsGKW/Q5q1apZb+94MOIYYXRhjkk7RmGtDU70925UGnZzYk/PIEsd5XW0b70s8II9DahG/NSW5op91wuXG7tIIj9nR1oqBkTUcZV0iBSxovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902422; c=relaxed/simple;
	bh=kZDkuebWmGXmLSMYX+w65HN68TgG1HeSfwm7+6uNqiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU5T0HRlsqw46Gh75ItaUcyMd1hIg1PUjsC8oeUtrNEMGNwtXI6PYGV+Q8Wjrq1i8l0VzbA/+3SrADM0eEoBOy7lY1XN1YTIGRw2oaGFchmiDfN7jWj4OVy/+KmI+sTYTq6q38OKZ6Exnpfpe+dXtOueg4/Rqzlkce68uzJpZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OFgr4rOI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OFgr4rOI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODflaR1974199;
	Fri, 24 Jul 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LcWYdIw5DKr0gJasi
	dPh0A6eet/ZPBaSpJYwfM4G3DQ=; b=OFgr4rOI2tfPmCYLuq5WYTpcDQKcEBh9V
	CHL+bypohk+zW+AlXaX0b0zJ0ymufPVyWafmHRT3OjGAtnc9iN2jNWGeNA7JhKZI
	bfD7sL/uwHqlMxEdsIeVayJa7wh9spx2boZwS4o/5tQ8m+EWa84Xdi1gF0w505V9
	ZGnxFZ87vF0SyIzcjoCP+nK97jFfgE24lSBWIJrg6013C2sHv/HYqV+S8FaCNWv0
	DrfxSMuFFBJBxVAGSv9tjXMqWBfaCIFWRbRfWt0Dvg4U7E7gW8W0bcb+d9eJydSg
	b3UWWOdkMeqvUd4e4ZjwvSSQqgrRzpDmRIXbPczxFkw6WdgMP63Kw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h50ap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4g6u013230;
	Fri, 24 Jul 2026 14:13:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whamx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDMsh17039686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66A1620116;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 152922012B;
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
Subject: [PATCH 3/6] s390: Add ftrace_stub_graph
Date: Fri, 24 Jul 2026 16:13:15 +0200
Message-ID: <20260724141318.1037434-4-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX7Lzll5IZziPt
 8eKuKUSDcWS3q9tXU48kVL8103/C94ctOYCmi37lY7om7NioHR+7n7CLZklTJzw7vHG/aNpb/fm
 rR2hqHWxefhujfzn2wAEpErJohtukcQ=
X-Proofpoint-ORIG-GUID: pJ_05TysW6_E7gMKoaaQgx40WY4_nQgO
X-Proofpoint-GUID: vB5YhEF_2REwfzPmYvED_aBzAgfXeyiY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX+4mNoFfHJOig
 N8Lfg0KvJstP0NWozbjvs2oPjo+suwM/zB5zxdBfEoCAWnGHIllXHDDpxPRYgXU8rzI5WtOjuN3
 4B3RdeFwLNSorN28/+lBwjLf/NAXuuNRpovO5UsupDgxAdpIjmRDuYR74cQfZO0gDmIr/qVKYM4
 XDMW8ECzLQeg9fZrmhm2itMqNVXwrl4Iznhq1PYEtU5TzhTOAVN6KqlBDu/F07iGPvZjUofoNU3
 lZzaCiAh5fT6BXJ306sdJWR9oU8MXk20okcE9lTF/qzX3Fz9nzDDZMn/B8vSbN8lysu4o/MrCfq
 NgD8wKjHtgj5KkkAWq7ougZX+W78zXe7R+wxvHEnIBvEPB6S6DCaNFG0hRAc3YUpohrSvL00/bm
 M/nviexND4zyJAjNRRVGy/4ciiCfP2Iwxt7iFjpxoBSIPGhRzW84r/p+y2bnCWmboN1TsE7qhNe
 dkVwPnZFzMOkg3JH/aQ==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a637308 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-AIEXUT1W0u7Szh5zmwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240128

This is the s390 variant of commit f3a0c23f2539 ("riscv: Add
ftrace_stub_graph"):

"Commit 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and
ftrace_stub_graph()") added a separate ftrace_stub_graph function for
CFI_CLANG. Add the stub to fix FUNCTION_GRAPH_TRACER compatibility
with CFI."

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/mcount.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 1fec370fecf4..97e9d6bdc017 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -4,6 +4,7 @@
  *
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
@@ -34,10 +35,14 @@
 
 	.section .kprobes.text, "ax"
 
-SYM_FUNC_START(ftrace_stub)
+SYM_TYPED_FUNC_START(ftrace_stub)
 	BR_EX	%r14
 SYM_FUNC_END(ftrace_stub)
 
+SYM_TYPED_FUNC_START(ftrace_stub_graph)
+	BR_EX	%r14
+SYM_FUNC_END(ftrace_stub_graph)
+
 SYM_CODE_START(ftrace_stub_direct_tramp)
 	lgr	%r1, %r0
 	BR_EX	%r1
-- 
2.53.0

