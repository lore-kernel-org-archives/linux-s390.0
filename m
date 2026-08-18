Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C73B776D;
	Tue, 18 Aug 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064641; cv=none; b=VcB0L8qpA8nxbPD229/nopTj+9tBf6yagYRpJry6h2XaxNUPGYgWgZ2qpQmc9XqueGzZzGMle59KED0gBlJa3CphsoZ16SLm0nXs/SQ+ibDr9/Ca+RNImOHTCX68j30BPqCyDz2PNpzhn9Tdz/2WCrBsw+qXMFlFtzzoiOnNDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064641; c=relaxed/simple;
	bh=Mujhq9PPwuWeYrcXDjr+wrAhWIDWgt09QIXgWZWX9Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk5oiQbDGjAnmuELU0R+E8Wxdod1d5kcxHpbx0bTKHQ+FJ6bNfJkEnopln+TYkspnaa6jhVhw75JFFLIvNqsE8dddciT3njVLQuyG4iFvS2Z96qkhuPgURUddGp4SvrIPOFLda9ECv1e2NyKLvqkxDlcqLpWFfStj1ADBEozM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GoNa/QWy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GoNa/QWy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3Y8U505138;
	Tue, 18 Aug 2026 14:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D0vcBEOOyUGoBu+pm
	ZMPQX5WLSQAyvRwHJCCq37w9/8=; b=GoNa/QWynkpgP+WOzTG0NuQcD0WKAfVXK
	J70CuH/e3zfjqBoVsPa/cbjgf8m82jPzUVt0SF9gKuYQK81LxYBaC7dAZlN5rY3S
	idz2nJUQuZv5u19jSv9gp3TmG9v/KSjGWv6dwY7cS+3kypzPfBh3MeQOlliYHvjg
	PPpimEs5kjBXR2EAKjexwDV28SHlj0OXBfBV1A7nSAMweP+P9E7fytpJ2G0vtB+J
	yJN4cq3pKRO5W+H/y5IhldWvBTjQQGPeuPBSOBvvV2F/hk7u9ysztIRdTLpejjuE
	aaou60f8FuIUk8FtP2XcuI9MNicmjPvBTeow+y1YC4++wqWmUwRCw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4rx2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfSiI014812;
	Tue, 18 Aug 2026 14:50:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3r7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo2wh51577228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B633820040;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EA6520043;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
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
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 17/25] unwind_user/eh_frame: Ignore DW_CFA_GNU_args_size
Date: Tue, 18 Aug 2026 16:49:46 +0200
Message-ID: <20260818144954.2320378-18-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SwQbcLL-8v0RRqYKpDrR0IBRTLIR2XoW
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a847120 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=bNYdn40op4m7Rmrl5ooA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX6ydL08lUhfqB
 EjVeLJLfCuseowCf9EFYGdH7HJz+Z5F7MCEH9BY/f4K5WNYjhk1/EPOuX2zr8N7v/nTOE0IimhD
 mMQK/bLUmGOwDVbwv6sZQhUvXr1Viu0=
X-Proofpoint-ORIG-GUID: q-1xRGIh6qlvCecDcc-qrIok36DR8wqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX5xem2d3GoSHv
 8vdSItxff8/kodM96i5JuOkTQYlz8M+0sv31UNAcU4016abpqzO4GXR6Gj+JOqdUdW3Vleyk/it
 3Bo3AWMm70lN7HqL7A9vjo+ZXGa+38762lMBThD3dE09z0YeQ2H8QpT/wtfwtAdT3ONMk/ra0TK
 YDCb6oTcD0wIU0KBe2rLe3MMfiCXz8n9nnoP833stCN84QALFMZ8NQIDswk2tkMqZYbFqsarwor
 uzZRIIKhSJyX1HnCXnRelib5gn3MagwdIwjtpa3DdcnrTW/jaRxb7ttmdXkmBJCToqja7tBKnOo
 2ujdg4/UhbJs5JqfA3Cm8ojYxftRt+4oSu+X2WdhfCDljaolThV0Bc/VKryViDlA7f77K72yaGw
 a6O7HAvQjwkGdzKstFLh48rRjhIURhxMnnzuCFTeJmKsm/SEBaqtmedmHJj6XYRx+MTyqddCub8
 W483aLrJs3hOTuhll+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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
index ac288cec8021..64176242b7d8 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1012,6 +1012,17 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
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

