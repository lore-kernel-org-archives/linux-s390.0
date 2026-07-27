Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B312387341;
	Mon, 27 Jul 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162724; cv=none; b=lODmIydZvF3ulrusAbC8CW4N74xvSPqNd/aGXK9E28NIP3X7gjiiDgz/FjSuhxRq3RNsZBagC5LB+qhLMXePsHFc1qI6GtxzZo6zZXrEsz6N3jNtMd36FEYBY/EsTgU5LKaFGNNnPyfrBJcLnj2BPuOn7HkXpPHu15E6Hm08EvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162724; c=relaxed/simple;
	bh=PC03vSEvQCTrr/hd/WBL4apcZdWW5yTfE9mGchulFU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK3GJdaJZ7ELM/bOit9v25j47LUGYbb8z1o4cZyUj7Uea1uW9VkK4bV+VWqir1/use+0MSI8NL1iM1DPtI17ocA2DvorslJV4/IY83BXrjawTTBTRgdbDGihd5bq5njxFN6QP2hbP9BtWqOICaldL1nbtsx5H/XUpyOPYDQStc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a0jh3DCS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a0jh3DCS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmdtU2373014;
	Mon, 27 Jul 2026 14:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rGhjnL4PI81TK3QrI
	ZxIwkT6bcOXxX6BlHcY64m3kuM=; b=a0jh3DCSkRL0N0TMBoeg9HKrP2fBSCvzq
	R8cQ+Fd7G31t4vzjvKkHi4EuewUxmBCgCm8VJLMAlAeUpxyMyoKZGZV+JIFuSKIO
	zSu1nJFF6oKaNFZ6oLzlLOo0D9QgHKGBqev/7mjHOVR/mQlSAsXU+IUJFBh/8nRf
	BnzudJPSkGuXtVeLShQVG2SMscKIwBp5Lt8O2S8a1+zmdYp2h5J09nKDJfiBE5qG
	Oqo8qTsn5WlP1/M/R05iFQ4RJQeOti1TNcHo7qMrfCJteOEquUf5il1peOJh3HHy
	VrfGDh1raDJkXWqm70sUg8pDdmn9gEeLRGpxmW0TfMlripCaIZOWg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw78gqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:31:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REQVwh008422;
	Mon, 27 Jul 2026 14:31:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq5w8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:31:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66REVdTj12059090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:31:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF9E520078;
	Mon, 27 Jul 2026 14:05:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51E962006A;
	Mon, 27 Jul 2026 14:05:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:05:15 +0000 (GMT)
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
Subject: [PATCH v2 3/6] s390: Add ftrace_stub_graph
Date: Mon, 27 Jul 2026 16:05:10 +0200
Message-ID: <20260727140514.116501-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: b2X7SkazEYeAxxbrdMi91umbLVlzJXQw
X-Proofpoint-ORIG-GUID: g5XL5PGU7qDS381EEaX3bOkc7eA12Npx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX0emBqaYliJ9o
 xbA1GN8CKJY8Y6Msp3t+zolodC0nAyYHjc8RRYui5W7CYq1U2bxeWlWaz4792rltWLZ3d8K08GD
 PovwxPFdCSiymdGnrBPFYhKOyvHhVWD94TROiaqcwI1D2eCWf83Xr0laOZWPWvruRepHqvFlWeW
 2gDdddBIkuEJHqHjI6VRdhSU+13W141P8djWA87I45ZuMqcdO6rhTuFd3K4LERok+azyO+KwNZF
 TOHtsjDv8YtS+WJvARs7Pmq4iUch6u2ZMGEvTgvmzAvTSGj8kVFlkhd9gico061Oxywxq2Y5sw3
 GcywWSpkDcNK64WfWNIeRV5blyFOJsS9KYJqd7odbLpFi2OW74KB60uqAJIiE+YN3cE5hMq0+qf
 GSCaIcKFsWmmx+QpsQ1ANkIzmwSm2eA9DvafbKz86a0FXicgw71smoa5TBIdcEnAbTEW7aSxsc1
 YVjzXRU5BfZjxaNMkWQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a676bd0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-AIEXUT1W0u7Szh5zmwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX9/hGv4Igv+1P
 /0zMFdgCjCmuVgQWz9sZhGdQm92ljFOI25LlrloAth69QuMNlHLB5KjXCUTcYLclUnRf23kdLLA
 /TdneCxmRLy+0YfBJh94zzOBlCRiP0M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270136

This is the s390 variant of commit f3a0c23f2539 ("riscv: Add
ftrace_stub_graph"):

"Commit 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and
ftrace_stub_graph()") added a separate ftrace_stub_graph function for
CFI_CLANG. Add the stub to fix FUNCTION_GRAPH_TRACER compatibility
with CFI."

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/mcount.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 1fec370fecf4..6bc44c767642 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -4,6 +4,7 @@
  *
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
@@ -34,10 +35,16 @@
 
 	.section .kprobes.text, "ax"
 
-SYM_FUNC_START(ftrace_stub)
+SYM_TYPED_FUNC_START(ftrace_stub)
 	BR_EX	%r14
 SYM_FUNC_END(ftrace_stub)
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+SYM_TYPED_FUNC_START(ftrace_stub_graph)
+	BR_EX	%r14
+SYM_FUNC_END(ftrace_stub_graph)
+#endif
+
 SYM_CODE_START(ftrace_stub_direct_tramp)
 	lgr	%r1, %r0
 	BR_EX	%r1
-- 
2.53.0

