Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BD411A03;
	Fri, 21 Aug 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342043; cv=none; b=bahWKRCYLLrKx6SZzTg4DzxnqAGpNtGRriBy7t5ZPjugjnyvELXTAFB1rsn+16r4UBKbZ+zxs7hyTg0kO4e5PG+DqNOUQyJbrwUA+B0NiGfkQ3SGHpL+KOAViEb5AvOaz+N2qN6kVgbfgNjjamQRWbScbDgfuJV3wvRrxVs/wUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342043; c=relaxed/simple;
	bh=CijnpLgnFKB8WMdF68gN5v75gDWZ0eEtgeICc4kMbVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWJdHJ16E+AxzzPmLAHCG5FbcIep3TuEnj0tc0VEod+f67BB+6WOf8G0kdCgIUZd1HcWhxmaPNjjHfPAzoi9RYMCePdqw+XlwmkhcNGucQvF1TkuY4rPNgD/npMTbBQ6rmku53p/aXm7kbImDR4eT/JOVe86nQWPt+1IWJbrv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N39L+4wt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N39L+4wt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVRZA2314623;
	Fri, 21 Aug 2026 19:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kCOKOkueq+VfUETIJ
	ByLo8qoaTH3QETrvkMVm1Hwq4Q=; b=N39L+4wtOjIKhItS/LDFE9HK4zRRWTi/3
	nTj+MJn1+RiPjzaT5jCX4zazCIsbfdmlHNzEEzvhFvVCC2PqmBX0EBD3jLC+oQyv
	oGvSWSvXQkd3/zH5pKEegwG0w3nSJ5YH2Fz712EXEA6GRLBncD88aQB7cz2RVs4l
	WdVZeeTBabURhJOe+JangBsaVxWLM+p1UrrWrF7+e6NuAqk1IALz+cOzRR60uWsp
	4xld5yTJ71/A3KRzMYfNGJ6I0kNBsHpl1NO47TK35AFqSLoKJ1axKaBQsJSY8sFo
	j61io9W3dVDBc9kYJXUjFg7WkDqY1BhIQf3hMW9/An7/ArZfnx05w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1uteq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfHgn008693;
	Fri, 21 Aug 2026 19:53:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yxdwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr9VQ45679056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA43A20040;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D50420043;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 16/24] unwind_user/eh_frame: Ignore DW_CFA_GNU_args_size
Date: Fri, 21 Aug 2026 21:52:51 +0200
Message-ID: <20260821195259.2688377-17-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a88acab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=bNYdn40op4m7Rmrl5ooA:9
X-Proofpoint-GUID: uBmxp-udTVl5WcoYm2i4owqnk8DaaQ15
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX/mRM2xk9j8h1
 wPaUa+sIMGX/Kv+9jpvwKJ3yCpcD33FxyuNBrS/5LFdLXaxL7rLXsqR14AT+U/YwNrslSMVbnvm
 q6n9h16viKrhbqgewIe/sW64sbwI+9g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXxLaSlVJu5mIK
 wEIrMKq9CZ1sWsiNYIymaZyS9WGDjHvRzbZMBcDMYDdPI5VTVkKA07UJY0SmT4oR7iNu7CpoIMg
 jYzQXQbsccQeRN1id1XIjugGUfu5s8vVFpzXN2BDPvSMdufUofs2rEHjbA0u6KIvnSJkLLMdu1h
 GT7dEe0E32yx9O6i3dvTAAu1AViOYNmPmOWY1ULCEXP5AI7z0fFx6Hc28cc6Xt4fvb9R/323iIY
 CcATHQvBLzUxjye/1TW/wCbOM5Uqnj9opGOMnfo4qa36Nn3ZKMP36TJOBtwN1ehqv0rqDjCUkAY
 g8WgnixvL3fEF9liMGRrGsGIEHb+V/sKuH3riRE2/qBSBQV2sKwE1XdWAfcA2ba1/o8zs9b7QVT
 GDGeadig5x+EFFsgO2J1fncCKFp2wgWb800EFjtcgF3C0t/wBeb1bSrSo48L7LAoNJJFIOw7ue4
 kLbeG9Eh5dcF3bcArtA==
X-Proofpoint-ORIG-GUID: xKmdZyASn5M0pRptJC8JiHcExZafOzkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

The DW_CFA_GNU_args_size DWARF CFI instruction is used by GCC to track
the size of arguments pushed on the stack for exception handling
purposes.  It is not needed for stack tracing.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This patch could be squashed into "unwind_user/eh_frame: Add support for
    reading .eh_frame section".  Leaving separate for review.

 kernel/unwind/eh_frame.c | 11 +++++++++++
 kernel/unwind/eh_frame.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 1ac7308814a1..d185187b0c34 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -980,6 +980,17 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
 			break;
 		}
 
+		case DW_CFA_GNU_args_size: {
+			unsigned long args_size;
+
+			ret = read_uleb128(&cur, end, &args_size);
+			if (ret)
+				return ret;
+
+			/* Ignore DW_CFA_GNU_args_size */
+			break;
+		}
+
 		case DW_CFA_remember_state:
 			if (ctx->stack_depth >= EH_FRAME_MAX_STATE_STACK)
 				return -EINVAL;
diff --git a/kernel/unwind/eh_frame.h b/kernel/unwind/eh_frame.h
index 9a0c71102742..a43560486283 100644
--- a/kernel/unwind/eh_frame.h
+++ b/kernel/unwind/eh_frame.h
@@ -29,6 +29,7 @@
 #define DW_CFA_val_offset		0x14
 #define DW_CFA_val_offset_sf		0x15
 #define DW_CFA_val_expression		0x16
+#define DW_CFA_GNU_args_size		0x2e
 
 /* Helpers for CFI opcodes */
 #define DW_CFA_opcode(insn)		((insn) & 0xc0)
-- 
2.53.0

