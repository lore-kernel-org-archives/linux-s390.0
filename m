Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111438;
	b=VXQNoq5yTYezs9GsrrZq8kFEEhN/g/x0DLbaVMy/eXVVYOkj3/Ph9ShjjPLLMPC7P0/3
	 Ew9gwR/Otz+VVfxTQdFKnmip1huE1TTyM6HvAExNUGX8uvM4Kz481M6uMaZucw0j70j0q
	 zMfshVoimdhdTlFEVkFqOEmrleEJrTimmGqltVVkPupBDYehjomfRcjAWms2PYcJ9Mwxv
	 netykK/xAuZDF78HwzCYTjkvzaFau3c80y9kDh/0wP6simWj9NT2EgCEJPiCXU8+ss3Gx
	 DHx/bV0EWhaTzQF7YyWdupSpWuNvamqzb83P3Jhb0M+FqSD2L+FNWcPt7XUYtG5x8/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=q6Q12ZaHLuLQEZexqqXZnduVUMcfxj6/QTslAdOFrT8=;
	b=D9cRTgNX2cA2YNP3lXnxs0lrXksWvV2uv410IikK/BQDaazr54Or/+ouOJgWq9jv9V/i
	 w6umL74ojRHPtJyLse/ys35uFaZqUV3p2i1l4/DUlDYl/I3n1fhhu9Ob4fQCI75ERhirr
	 CIemkXMMG+mO7LBUYuKUxPdIrzofgo13oBUAw7GiUKwyXmVekbyArQ8gzVoGMDqw/ijm8
	 KjKbaDUwfHDj+qZk5DE0qhgksQNWSPy45qxbudt3AAh2TFOLzc58v2PyP1YzAMQXcX9DR
	 Tdwa/JcFsSwMT/I9UlMw//LGGYtVt2uUh/qPkEOfscWUp5h1Rld+6S4tc0C+/yM4vYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AuzqmmcJ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CA606A322;
	Tue, 27 Oct 2026 14:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B19CA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AuzqmmcJ
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REE7FN2897508;
	Tue, 27 Oct 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q6Q12ZaHLuLQEZexq
	qXZnduVUMcfxj6/QTslAdOFrT8=; b=AuzqmmcJxw5Pwp7urb19p6QAhb0DHw95f
	bcgqrPoywczh+3j7JyZquox5zaUP08C/elX3NdLrR4UWYAKs+rRCUEoPj13Sp94L
	Bf4l+ijp79JuBD2/dPbLXBc5kjAXEf4sB+t3++ubXWZFBQ6OIdI+G6iadErCnUQB
	ATKSmPVwxfHT5zdvmBlPbvNggpTMwYqh2/6sD3ATDx2PGQFQPzO9+BlJOlo1xpN2
	rLBKbNh/GdXJY2j/c9I0vrR2ZSnBUQQPz7YggIYruwAwENU6yFkYworu0VQD4oat
	nDHLbgGIN3tJSGuv3fe8vSGKmOJ0k59cKV2vR+td26BtlIqwFJkKQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm64002w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoQ0u097222;
	Tue, 27 Oct 2026 14:30:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh33ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUVTF34537808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BC6D20040;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4984A20043;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:31 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 02/10] s390/ftrace: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:22 +0100
Message-ID: <20261027143030.3154657-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX8oCqLCfapnS2
 xBgJv87Xx2UoZ8CerVmcbR9EUcZ81Y2ZqKpQDV9lwJ78C5Zo3PVbFvylujiDY9QIzmhkTfUV/jX
 PQYfhNSEnMaSWNuWedxK5aT62RFO6tE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX1j48Bm5hZaQb
 3qYVmROQjapvjl/BM1JZNbeZEvcpGZ1sWfE+LKOgX8OEoebfRMsdNWl79MOquUOZ/u0vX+QKdlV
 CqNYWcQP8qbI6EZjYQ6YKCcfvOKLVJqN3dlNA6mpE9tx0ro2V3hTqiYMQv5vBsTAflutxXv9//f
 d5oekne1p6q4xm77/afiCWP+goWUkLl0RyAdeUFN40FT19nZLaFW2CcHwzVJmnqD9yA4Miml56+
 T/FHT2wlBJV1ppfCMddEzS3T61bSe3H68VdimiUoeHVTo+X9jcUM2+Y6ifxOxoYJFdCHhMG8n99
 ycbkFRltf3mbKcjRwSMH1mqMQIWgH53q3KTTTVIMdO1MFUTD1RJnFx9j5XrEpYYHjq2IZQEfP7B
 IhREz4nP/OTsgIBhzQsVqAOcDoXlRUwEQZ9dSNHAho7bCkV+9wUqx3YEuR/UVpUyjTOAt8cvWdo
 66Mff8BDD9M9XOVsvzA==
X-Proofpoint-ORIG-GUID: fpJExi3LiK7X5v1QVoSuUr3CUfRnGyOJ
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae0b58c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TQKjL49O_MRvjM01t5MA:9
X-Proofpoint-GUID: fpJExi3LiK7X5v1QVoSuUr3CUfRnGyOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

Add ftrace_arch_code_modify_prepare() and extend
ftrace_arch_code_modify_post_process() to acquire and release
text_mutex when ftrace code is modified.

Also add locking to ftrace_init_nop(). This way s390 uses text_mutex
like e.g. x86 and riscv.

This is part of larger series where at the end s390_kernel_write()
requires that callers hold text_mutex for serialization.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/ftrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index e94bb98f5231..2f0c4ef1b2d6 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/hardirq.h>
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
@@ -90,6 +91,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	BUILD_BUG_ON(sizeof(struct ftrace_hotpatch_trampoline) !=
 		     SIZEOF_FTRACE_HOTPATCH_TRAMPOLINE);
 
+	guard(mutex)(&text_mutex);
+
 	next_trampoline = &next_vmlinux_trampoline;
 	trampolines_end = __ftrace_hotpatch_trampolines_end;
 	shared = ftrace_shared_hotpatch_trampoline(NULL);
@@ -247,13 +250,21 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return 0;
 }
 
+void ftrace_arch_code_modify_prepare(void)
+	__acquires(&text_mutex)
+{
+	mutex_lock(&text_mutex);
+}
+
 void arch_ftrace_update_code(int command)
 {
 	ftrace_modify_all_code(command);
 }
 
 void ftrace_arch_code_modify_post_process(void)
+	__releases(&text_mutex)
 {
+	mutex_unlock(&text_mutex);
 	/*
 	 * Flush any pre-fetched instructions on all
 	 * CPUs to make the new code visible.
-- 
2.53.0

