Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F6421226;
	Mon,  3 Aug 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777713; cv=none; b=ojV32l7Ow2Hx0ct+fJe2CFusbDIi6Abn55qK9SwAtXEA69gUZIzBirVsDQhbBNDcPO1jWBcttdaVr6VNLol3ene8uF8YQkFqBAClUDFk+1G02kT50UowuIJmR9MzqF5BLWncDmab5j6OJxQYJNirf4lG04i+j5Q6LdL7NcaaEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777713; c=relaxed/simple;
	bh=JNEqBRuXVsoVnYcv8wlx7H/C8k/YQJKFhPvcSMB0MlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYKZAxrtKHFX/PHMYdIByQ7ErYLdohtkDFnPM4lozNXGhRpsHhbo65+0c449ScOupzzi02PjpYWSAoF7uxK0mZ5Cned4JNLi2R0LJjOPr7sZKWTex1C4B2UYKgsilTIFL4Xg18tkKF7tc5YVqoLMSU4jJ1co18p5/yeUC6R7ttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GewqhBSS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GewqhBSS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HI8ls2604514;
	Mon, 3 Aug 2026 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=On1d1TcDUcNK34OSW
	fsGitnOJIewTkbkeiUtMiaoNyM=; b=GewqhBSS2C7bVeky7w21bHBVuW4XFHjar
	0acQd+UdJh267Q1hKh76rEx/9SlqKNnsfKDQHBeCilaBZn6U/plxBQ3Qc61m/UtD
	+Gsvp6R6XC3Osc8KlS96k1M44+bTbh2wmqF8Ri2Ykg1w2CcUFYk44cnVnjUY5aEB
	QJDiNtrm7o0e/GOsJkchFBxMAKk1jDdl1V/kc+m+A3vNxlG3dO4iQ778lAFxKIKx
	VcB8YJNLDvr578glgfWDauQl5eW0NXlm4O1MJq64i+mTI9W+dvGpD2UspcmvAuOD
	j7Hl4hMBM0jYL8fwPKrdSz+By6W6LgcK5p5d79JF1eMcZs6nGR9gA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhygq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673HBbl3023859;
	Mon, 3 Aug 2026 17:21:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtye7p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673HLju649807788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 17:21:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 558E72004D;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38E652005A;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] s390: Enable CONTEXT_ANALYSIS for various directories
Date: Mon,  3 Aug 2026 19:21:44 +0200
Message-ID: <20260803172144.827049-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803172144.827049-1-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfXxLH6wlNRDI7A
 YryzpW/FBK6CZsxQICEaXQ/kAYGqTn2sFSiABRUFKjWf3QRXQkZMdmBDfEUZRcGUsRxHi4RKRHN
 rmYvuB2LDOooFgiFlkvp2XZdVLEa8e0=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70ce2e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=zIwKMP4gc6Z8FwJYrOAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX/XzmwXXwJ5it
 eEWVIXtLlmZN1/TLqcuDOBcAswuJ7AR7QXMjUQD+Z2q9BMwyGVN0LXFUDDjxA75JHbrR5Y3qJvf
 Td+PJcOv2sB9gqec2j8maEF37hAAnD33lg/rFLhDBzjEACwTAYXzpxCy4AbPoQGR7H5/aI02ZxV
 ygfbCU0cIkuulEJT2fShkataFqLJRReA9XQ0sznZIGSmC1YkrWiXklob3JA7a6prLJwiGx81h01
 jHVG7Cj481k+TFzMz4YankE1z+ePDjEGYcCvNIMDRT2rOeFS43YUsPs/MwDmi9EXHngUSgpjGll
 bLi0/WO8+FUfkWtBqCsq34MNpQ65iVKNKToy5wCKIYFBhrBAQNQp+PrZwxMS0+dituGDRREhGYk
 lJzCj0GsBPDXjMhiaD7S4jvpVq/fDWM98IJOR6XDzYaUygPu3okw+/SQRs62uKxBrHiCAPk/t3P
 Vn/BQznGJJ8RbMxfH/w==
X-Proofpoint-ORIG-GUID: 4Wkeb8RGLO3LsiqxFn6t7Y-heJahXwJo
X-Proofpoint-GUID: 4Wkeb8RGLO3LsiqxFn6t7Y-heJahXwJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030154

Enable CONTEXT_ANALYSIS for various directories which do not generate
any warnings (anymore).

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/appldata/Makefile  | 2 ++
 arch/s390/hypfs/Makefile     | 2 ++
 arch/s390/kernel/Makefile    | 2 ++
 arch/s390/lib/Makefile       | 2 ++
 arch/s390/mm/Makefile        | 2 ++
 arch/s390/net/Makefile       | 3 +++
 arch/s390/purgatory/Makefile | 2 ++
 7 files changed, 15 insertions(+)

diff --git a/arch/s390/appldata/Makefile b/arch/s390/appldata/Makefile
index b06def4a4f2f..132381f16fb1 100644
--- a/arch/s390/appldata/Makefile
+++ b/arch/s390/appldata/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the Linux - z/VM Monitor Stream.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_APPLDATA_BASE) += appldata_base.o
 obj-$(CONFIG_APPLDATA_MEM) += appldata_mem.o
 obj-$(CONFIG_APPLDATA_OS) += appldata_os.o
diff --git a/arch/s390/hypfs/Makefile b/arch/s390/hypfs/Makefile
index c34854d298f8..5a3daeafe926 100644
--- a/arch/s390/hypfs/Makefile
+++ b/arch/s390/hypfs/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the linux hypfs filesystem routines.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_S390_HYPFS)	+= hypfs_dbfs.o
 obj-$(CONFIG_S390_HYPFS)	+= hypfs_diag.o
 obj-$(CONFIG_S390_HYPFS)	+= hypfs_diag0c.o
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 6c88476d79a3..71330352bf3f 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the linux kernel.
 #
 
+CONTEXT_ANALYSIS := y
+
 ifdef CONFIG_FUNCTION_TRACER
 
 # Do not trace tracer code
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index aa6cc6a1fe88..bb707700d7af 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -3,6 +3,8 @@
 # Makefile for s390-specific library files..
 #
 
+CONTEXT_ANALYSIS := y
+
 # string.o implements standard library functions like memset/memcpy etc.
 # Use -ffreestanding to ensure that the compiler does not try to "optimize"
 # them into calls to themselves.
diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
index 193899c39ca7..7dea37a5ad3b 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
+CONTEXT_ANALYSIS := y
+
 obj-y		:= init.o fault.o extmem.o mmap.o vmem.o maccess.o
 obj-y		+= page-states.o pageattr.o pgtable.o pgalloc.o extable.o
 
diff --git a/arch/s390/net/Makefile b/arch/s390/net/Makefile
index 9275cf63192a..0a7323c9b372 100644
--- a/arch/s390/net/Makefile
+++ b/arch/s390/net/Makefile
@@ -2,5 +2,8 @@
 #
 # Arch-specific network modules
 #
+
+CONTEXT_ANALYSIS := y
+
 obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
 obj-$(CONFIG_HAVE_PNETID) += pnet.o
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index e74410bb1b88..b2f17e0d7fd6 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS := y
+
 purgatory-y := head.o purgatory.o string.o sha256.o
 
 targets += $(purgatory-y) purgatory.lds purgatory purgatory.chk purgatory.ro
-- 
2.53.0

