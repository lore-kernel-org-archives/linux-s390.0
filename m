Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE542931E5;
	Mon, 27 Jul 2026 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161143; cv=none; b=p7+RGeDmQnKDOwRrQxGhk+pOCO/rsVtlkJmi0l9lDdvhOd5bMI56Z89C7sQcWRQ+bUTd2rO4DLO6IVEiHRrPkBwFAtO4MuThMMTLEGr2PO+xWtGiy13Uz7+U8VuIXvoylMgJX+vnJ4YcL5peSJ4I2ZDMnBBx7U6J7MuAXJpCoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161143; c=relaxed/simple;
	bh=KUmr6Y7PRUUAWvposqz7awH3xRFniiU/GRcJXW+7Xt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdeEN8J+w0FS1WN8EjYZQfY/I2UD1HuT/eZo5Hxxxa7PAAtHAYWV4AQynqim2uijprQJuqCh/4ynb3RqKQ5lUmLvjG6oYFnbwfgiirfP6YKA50bKaUbUeM3/9abKuszZyEIrCICwBDwTSZgHPVR5FYHPw5+qk+J8ysl3/unhcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SoLD00Sf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SoLD00Sf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmlrO2406461;
	Mon, 27 Jul 2026 14:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Br4hxfDzBzmtooVPf+i8Z7IgbNE/mEzGmZeyZTa4x
	fs=; b=SoLD00SfXWy75fAaRt8BaZbQbfG+DdQFYgji/ZIq5zMHALyuLwHEJUxPh
	aigjvjY0/ylYIM4Edo3mtE9c0k2KqqrI73vfX91YlFGjEKdRDIwykSjMeIlrUoEO
	8XWM6k5orDTjkAeO1bskZmLhkM8AnIEPAzeSDuLiQi26GFgJwLSjvf5KDTnQ+FF7
	nT56AfjJmHLkvQBOG7uWVJe3cMQBqPJbZMuNVFvkKtVYxF2JTk3KsPkgX8rE9llw
	fVgma/jR1cBN5cZJnh3+/kC7QRZaOYLqceAFNpQhYUwgi07Q3bS8AYKmCNQxxCxH
	wkjCK9NWa8nd9SNO3rlKLPgLN5vrw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgcpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RDuZHU002383;
	Mon, 27 Jul 2026 14:05:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwcnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RE5IsC50463180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:05:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D6072007C;
	Mon, 27 Jul 2026 14:05:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 313D72006E;
	Mon, 27 Jul 2026 14:05:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:05:14 +0000 (GMT)
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
Subject: [PATCH v2 0/6] s390: Add kCFI support
Date: Mon, 27 Jul 2026 16:05:07 +0200
Message-ID: <20260727140514.116501-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: X0ziWFo-1mW-WAdyXrJ3Bu7FRYQf49r9
X-Proofpoint-ORIG-GUID: YQK93AjpwH9QuivFdPJ8hnNuiriGr0ag
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX7xDE+Z8FhSRQ
 W50GzH8nuJH7dnvwfdEeYsgPzYksQ89Ohd57SzaMfE90BuZQSKzW8ac7h+0/amtq/KuF6Sx0fGJ
 gTBZ0+zVtiA41sTPJwOrp7AskoiTqlw=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6765a3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VabnemYjAAAA:8
 a=mZeUlHFlDe_EzX9cADQA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX1F64TwyVEFDb
 YruNBwNsbwFmiToaFIcxS5CGHBaRCTb470ykOHxBonba0rtEiKc555mGFzeSridkNJPGqxob/TC
 Rx/gifazRo7AEUGtYn5isKopQTvA05kJ+hdOfPqJREw46iFAAp249c0jupVbUy4gXFS6GAcps68
 sU4fbREoBy5MgF1asY65wOgqNPH2ucCKbi127RhlCIDiDcBBIDrn8VIkW3lXbDl/Q2ojgfcd2YT
 x+I09kQaDzvTVIST/inGHCUX7cDA0wljzAkxLkdCcWCxKQC2q7L0aC3B66J7+K1h/uMOOqdczCC
 jF2BsM5fvkyG9mcrj5UKueF8bGI0A/VxADqV1XdaF56aesYIQSfJvXNw86skmn0/bV6+Qh3y5yR
 VktSiucY/nJWjzo1cy/7tt+GWBGD4JmlIuxpoWSos2Rc/9Yun6VD5MjJDkcYOXFN7TFMeJ1p1sr
 TJYK4VVnXbO41hctNJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270132

v2:
- Select ARCH_USES_CFI_GENERIC_LLVM_PASS [Nathan Chancellor]
- Add CONFIG_FUNCTION_GRAPH_TRACER guard to ftrace stub [bot+bpf-ci]
- Add additional CFI offset adjustments to bpf code [sashiko-bot]
- Move bpf patch before ARCH_SUPPORTS_CFI is selected, since there are
  functions with missing __bpfcall atttribute [sashiko-bot]

v1:
Add s390 kCFI support using the generic support provided by clang.
This comes with a couple of limitations:

The generic kCFI implementation does not generate a .kcfi_traps section,
nor is a special instruction used in case a checksum mismatch is detected.

This means in case of a checksum mismatch the kernel just crashes.
It should be quite easy to tell by the surrounding code that a crash
happened because of a checksum mismatch.

If clang and/or gcc provide a .kcfi_traps section it will be possible to
print proper CFI messages instead of just crashing the kernel (enable
ARCH_USES_CFI_TRAPS).

In addition this also means that CFI_PERMISSIVE does not work. Even if the
option is selected the kernel will crash in case of a checksum mismatch.

However it seems to be acceptable to enable kCFI support to the kernel now
even if it is not perfect. Later s390 specific clang and gcc extensions are
required to improve this.

This passes all ftrace selftests. It also passes the kernel bpf selftests
(vmtest.sh), except those using the task work scheduling kfuncs. However
that appears to be a real bug and has been reported [1].
(Update: fix for [1] is available [2]).

[1] https://lore.kernel.org/all/20260724112221.212464A3f-hca@linux.ibm.com/
[2] https://lore.kernel.org/all/20260724-task_work_cfi-v1-1-2616691781ed@meta.com/

Thanks,
Heiko

Heiko Carstens (6):
  s390/tools: Pass symbol name to do_relocs()
  s390/tools/relocs: Ignore __kcfi_typeid_ relocations
  s390: Add ftrace_stub_graph
  s390/diag: Generate CFI type information for assembly functions
  s390/bpf: Add kCFI support
  s390/Kconfig: Select ARCH_SUPPORTS_CFI

 arch/s390/Kconfig               |   2 +
 arch/s390/include/asm/cfi.h     |   7 ++
 arch/s390/kernel/mcount.S       |   9 +-
 arch/s390/kernel/text_amode31.S |  13 +--
 arch/s390/net/bpf_jit_comp.c    |  28 +++++-
 arch/s390/tools/relocs.c        | 158 +++++++++++++++++++++++++++++++-
 6 files changed, 203 insertions(+), 14 deletions(-)
 create mode 100644 arch/s390/include/asm/cfi.h

-- 
2.53.0

