Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB12F8EA5;
	Mon, 27 Jul 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161163; cv=none; b=L7+M0lHyRsLK+Cx5Xeo1kvqA0/DzG9Y8sgCiDiuEjn3rrZJcYI3dQw9HCLyiURiqnchbtw1puv/SNTCUuhBaNQsD7ppFiWlW7Yaa+j/K/Tc4qiT2RwyFNV25Efy/VD4nToXgGshppTBpr5XQpOPRGIa1cb80P/gLoO7w0T6b5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161163; c=relaxed/simple;
	bh=nPUesl3mFSTrx3xAZmt/puQaip42ElJrPvMDkkij+aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzn0ymwADGyLAb/PPgVcE8oPjAJnCvcquwNDjksi7eDeCrFZ3k7LIo33u4UJx8FlXufMo24F68PyQ1g4yBpTO3yYXuvkaI63x7lCt8jj+sRR0Xq2twe58MBWhfCFT3DCbSv643IzSxRozUT5BtSCwNqGFXEbmvm4x7wCXhzswP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mHUGLzI8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mHUGLzI8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnevM2412527;
	Mon, 27 Jul 2026 14:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nc+wucjUOwacrswBE
	ezmtQySPAR9e78ErAQlW+vqnBM=; b=mHUGLzI84V8P7QUPXcWUkKHPvQNN4de7k
	xzUiUGa/1tyHVdDHpfSQgJvHceXv+yqw5dm53rrzLiOBgZpv8FU89pxWTK7Exa/Q
	WMKG7jpT3Q5lQ76nQIZ6YtW7l7Rz0Jmy9EINpVkCfjU01bIBoRflh0JJ2hlQ9dFs
	qWENs/Olc+aOeLu4RpJmoclxCbQhRPeIo91tO/hrNMG14SvfwBXfGEvyYNPSquNJ
	nbzSMvc6yr46aAT0GZ6JplHhAyCHMpt5GhxnNtaC83JZ5GJ45D9UJyT0W58DwaPb
	vzUyEjPBMFBrXXDLLjxAJXVexQ1p38D1dmh9rUfPaVSBa76SzKTMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcqygr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RDubk5011123;
	Mon, 27 Jul 2026 14:05:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5f27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RE5bmk52625740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:05:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8BB620084;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7644720083;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
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
Subject: [PATCH v2 6/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI
Date: Mon, 27 Jul 2026 16:05:13 +0200
Message-ID: <20260727140514.116501-7-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: g5w9kKXPPL_mJe3ikFxCv1T0ZdfSx7Uy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX+RotPxjuDric
 +2qLLpRMhmzijdK/2NnJiz8NSA09+lv40oZ01fohSLg3W0uQdCLkxcD3kMxtx8GHT/7mmKA6zTq
 Y5Viof0y+ceDjgUUof9dmeopmx7qLQ0=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6765b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qhuSvAhk5ZVRJEhCuTsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX82l8NH4Rzv+4
 Tig4QUpeXZgusmt2k0BlxlT4jvINtts+q+RVlkndKYysbQMKV8IX004tOYoUTIaBeWPk0o9aISB
 LPQjFxI5Q5LU80NXfFvLjtuHl7KLOrMDgFNQwA5bFhrektx+zhg2oZirXYqcdqO2/X/vKGBTUr9
 9uoFbm9UA5a92H8P/Sl1FiyUx7H8OIYTSXYtQHaDbCYM4fqIkIZtHvdSFXXzwzEyIG36eWXZKf5
 1EsXQmIfhQ2H5jjjvmk0W6UPikCxQ4VQ3bOqyr7joFH6KcCZTUDMxE5nsPGJbCU6hUc4g3vkT2k
 KFv4gd9aotXv8RixOPYAPrXeVTJlkjwP2Xi+g/i8C+px3vQi9eH569k4UipxGy7ZyiueSPzPx1o
 /4chAYK2VxMsa0wWJNUE2uqdcyN2P1QZaaMcMJ0rJ3PMPgQrk4sM8nG1AS7A5b2F+MxSlyHk095
 qpdBM9MM6cbi8kQo79Q==
X-Proofpoint-GUID: D1blFMAAOvY_Z4U4DEWagJ7CsHeiG_yE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270132

With all prerequisites in place select ARCH_SUPPORTS_CFI.

Note that this support is supposed to work with the generic kCFI support
which is provided by clang. This comes with a couple of limitations:

The generic kCFI implementation does not generate a .kcfi_traps section,
nor is a special instruction used in case a checksum mismatch is detected.

This means in case of checksum mismatch the kernel just crashes. It should
be quite easy to tell by the surrounding code that a crash happened because
of a checksum mismatch.

If clang and/or gcc provide a .kcfi_traps section it will be possible to
print proper CFI messages instead of just crashing the kernel (enable
ARCH_USES_CFI_TRAPS).

In addition this also means that CFI_PERMISSIVE does not work. Even if the
option is selected the kernel will crash in case of checksum mismatch.

However it seems to be acceptable to enable kCFI support to the kernel now
even if it is not perfect. Later clang and gcc extensions are required to
improve this.

As of now a crash caused by a CFI failure looks like this:

illegal operation: 0001 ilc:1 [#1]SMP
Modules linked in: bpf_testmod(OE)
CPU: 0 UID: 0 PID: 92 Comm: test_progs Tainted: G           OE       7.2.0-rc4-00021-gc35ed7a1ca22-dirty #3 PREEMPTLAZY
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: IBM 3931 A01 703 (KVM/Linux)
Krnl PSW : 0704e00180000000 00000166d4853a0a (bpf_task_work_callback+0x176/0x290)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0400000069b02e96 000001665471856c 0000000084dc1000 000000008084da58
           000000008084da60 000000005ff492bf 0000000000000000 00000000809de300
           fffffffffff7ffff 00000000000a0337 00000000809e4d00 000000008437b100
           00000000801bc288 00000000801bc280 00000166d48538fc 000000e6d502ba90
Krnl Code: 00000166d48539fa: e320c0400004       lg      %r2,64(%r12)
           00000166d4853a00: e340c0480004       lg      %r4,72(%r12)
          *00000166d4853a06: a7640001           brc     6,00000166d4853a08
          >00000166d4853a0a: 0de1               basr    %r14,%r1
           00000166d4853a0c: e300b6580095       llh     %r0,1624(%r11)
           00000166d4853a12: ec040009027e       cij     %r0,2,4,00000166d4853a24
           00000166d4853a18: a70affff           ahi     %r0,-1
           00000166d4853a1c: 4000b658           sth     %r0,1624(%r11)
Call Trace:
 [<00000166d4853a0a>] bpf_task_work_callback+0x176/0x290
...

The disassembly contains the brc instruction (branch into the instruction
itself with two byte offset to execute an illegal instruction, and the
following basr instruction used for an indirect branch.

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..ec96595cae39 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -144,6 +144,7 @@ config S390
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
@@ -151,6 +152,7 @@ config S390
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
+	select ARCH_USES_CFI_GENERIC_LLVM_PASS if CC_IS_CLANG
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_SYM_ANNOTATIONS
-- 
2.53.0

