Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49C4657FE;
	Mon,  6 Jul 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328012; cv=none; b=XFOWvUpCgsWt2NYWQWOcZ7HIOv8KYi4+4nHGgwkAVCw58v+na8KFvSbCTeuvwyV7GQbhExGS2POyj2+JJL56Og1kGLqjOt8jXG8K3mU903Vj5vSHecVfdlp0DwzwIbQAstjpIxQwF6PWf66xUgrzaifsrfZkoDKoSfbt8h/ebDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328012; c=relaxed/simple;
	bh=npS0L8Fo+fxP2hrL38XEyKlAyMTpA2F2TKR67ry3kv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWOtEyUirJQm2o3G4isM8DGCcCvW/D0bgzJ/OBWFQWg8ZN6KlwXcFQiNfch9eQtXTFgowygpH6wj/wdDgGszHt+YfjB6h92T5UYt5xca7iibf2vatSeS0hpUx4OxvE2tvfwEU9ETIh6KgBHabzRDYkVNzbVuUOIL67Va4ZWmsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l9DyDfI/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l9DyDfI/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIXW22304625;
	Mon, 6 Jul 2026 08:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CHpu9JFTRpFCbIumH
	nfQyYI50JKhIursL4W9IqP9v8k=; b=l9DyDfI/6YAJvZKMoG5OM8XvtYVzvvjra
	6Q+bVXYfJRzW/wNMoFr8KQdlt0+quKp4Q5of1E0zVORGpNVgmOF5LYaoOLbYe/qO
	FeO03hLzhOWz3g4be/p6S9RUnTH+5+LtiCmwFBtORPwBEBzPMxJavVHdco6c6B1o
	ukWhcPjfYmHnuXKqg7SAwK4hUKbRHcQO5sr6+qWAOsrC9FL58Q8RKoGBC7PqRBo+
	5w1RO/s4g6c8YqX1BYdCEwEX1u9xwODjbczlAFHNpAGJcvZhNOBJD3qcjdL14PkJ
	3x7HDU6Wdci61muR4SocnbhYgNxU7wIp4QqX4vaMpYTuafV5S4JnQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gk7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668nuDo022945;
	Mon, 6 Jul 2026 08:52:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4qdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 08:52:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6668qZXE50594160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 08:52:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C766C20040;
	Mon,  6 Jul 2026 08:52:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654DD2004D;
	Mon,  6 Jul 2026 08:52:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 08:52:35 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v4 14/27] KVM: s390: Move s390 kvm code into a subdirectory
Date: Mon,  6 Jul 2026 10:52:14 +0200
Message-ID: <20260706085229.979525-15-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706085229.979525-1-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6cdc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=kTvsoZ858Vc8iPobKz8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfXxSKdDZJLGlcp
 cddVDdGQnWdLYohlWjyp5ZKKFgjBwAkGMbAi0RRp16aP0QnAus7UBD5PK1CjNnOcXKYolFvFYkz
 XjWmTDonaFXO4K765UHpKoyBYZeAevM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX4stLhjsacSPh
 CdGivn2NFXYQPbQgyTrpzzevVDyk3cLXJGL1h59xm0nSiSuFuqkGkWxYuVQ2ddhAJQeLAILdSvX
 Y9xkYGjcueLnTJQAVWG29SBa568stsqIdRxzwR/CJIhSJdZ5UqK18LoJTzkRGjt06K3ES3Ad8M0
 3/bQFf8wwbjzDSQ1galNo9eXSb4HYpQJTADDYLkMNvtK9Hma3VYNLy2EZGpD7D/t0hgE0dknXSo
 DT4Ub9Q/QrZm7pM450BtPNq15gvJK1XPoh1iJeNYjJ6OJs+8tr65kWb3yJpUhBYh9H6Dx5u5an6
 Z3uH5K2VBNGQJyED0OuqDl4aYUIHT/J1ceEv3L8S5sGda+6NZBcvw1LRc8XE/d0XvczREuGvRzh
 zuedgL5X7qZMxZAUhsPkFp6eSJ9rkfdWIZ9iG9BkNQz/fdvn4rUGEeNGTF6+nd0g5X6z4q6EQac
 zz2nGYFmJsXrT+Bo/dw==
X-Proofpoint-ORIG-GUID: 7b8gAO3x4iDedriyFOrgwDYsyuITBAnc
X-Proofpoint-GUID: 7b8gAO3x4iDedriyFOrgwDYsyuITBAnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088

Move all the code required to run s390 KVM guests on s390 to a s390
subdirectory. Move gmap related code into a gmap directory to later
share gmap code between KVM implementations.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/Kconfig                 | 38 +--------------------------
 arch/s390/kvm/Makefile                | 11 +-------
 arch/s390/kvm/gmap/Makefile           |  5 ++++
 arch/s390/kvm/{ => gmap}/dat.c        |  0
 arch/s390/kvm/{ => gmap}/dat.h        |  0
 arch/s390/kvm/{ => gmap}/faultin.c    |  0
 arch/s390/kvm/{ => gmap}/faultin.h    |  0
 arch/s390/kvm/{ => gmap}/gmap.c       |  0
 arch/s390/kvm/{ => gmap}/gmap.h       |  0
 arch/s390/kvm/{ => gmap}/trace-gmap.h |  1 +
 arch/s390/kvm/{ => s390}/Kconfig      | 21 +--------------
 arch/s390/kvm/{ => s390}/Makefile     |  8 +++---
 arch/s390/kvm/{ => s390}/diag.c       |  0
 arch/s390/kvm/{ => s390}/gaccess.c    |  0
 arch/s390/kvm/{ => s390}/gaccess.h    |  0
 arch/s390/kvm/{ => s390}/guestdbg.c   |  0
 arch/s390/kvm/{ => s390}/intercept.c  |  0
 arch/s390/kvm/{ => s390}/interrupt.c  |  0
 arch/s390/kvm/{ => s390}/pci.c        |  0
 arch/s390/kvm/{ => s390}/pci.h        |  0
 arch/s390/kvm/{ => s390}/priv.c       |  0
 arch/s390/kvm/{ => s390}/pv.c         |  0
 arch/s390/kvm/{ => s390}/s390.c       |  0
 arch/s390/kvm/{ => s390}/s390.h       |  0
 arch/s390/kvm/{ => s390}/sigp.c       |  0
 arch/s390/kvm/{ => s390}/trace-s390.h |  0
 arch/s390/kvm/{ => s390}/trace.h      |  0
 arch/s390/kvm/{ => s390}/vsie.c       |  0
 28 files changed, 14 insertions(+), 70 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (100%)
 rename arch/s390/kvm/{ => gmap}/dat.h (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (100%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (100%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (100%)
 rename arch/s390/kvm/{ => gmap}/trace-gmap.h (96%)
 copy arch/s390/kvm/{ => s390}/Kconfig (71%)
 copy arch/s390/kvm/{ => s390}/Makefile (64%)
 rename arch/s390/kvm/{ => s390}/diag.c (100%)
 rename arch/s390/kvm/{ => s390}/gaccess.c (100%)
 rename arch/s390/kvm/{ => s390}/gaccess.h (100%)
 rename arch/s390/kvm/{ => s390}/guestdbg.c (100%)
 rename arch/s390/kvm/{ => s390}/intercept.c (100%)
 rename arch/s390/kvm/{ => s390}/interrupt.c (100%)
 rename arch/s390/kvm/{ => s390}/pci.c (100%)
 rename arch/s390/kvm/{ => s390}/pci.h (100%)
 rename arch/s390/kvm/{ => s390}/priv.c (100%)
 rename arch/s390/kvm/{ => s390}/pv.c (100%)
 rename arch/s390/kvm/{ => s390}/s390.c (100%)
 rename arch/s390/kvm/{ => s390}/s390.h (100%)
 rename arch/s390/kvm/{ => s390}/sigp.c (100%)
 rename arch/s390/kvm/{ => s390}/trace-s390.h (100%)
 rename arch/s390/kvm/{ => s390}/trace.h (100%)
 rename arch/s390/kvm/{ => s390}/vsie.c (100%)

diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index fbf4162d6f2d..f8d4a9a38dae 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -19,42 +19,6 @@ if VIRTUALIZATION
 config KVM
 	tristate
 
-config KVM_S390
-	def_tristate y
-	prompt "Kernel-based Virtual Machine (KVM) support (s390)"
-	select KVM
-	select HAVE_KVM_CPU_RELAX_INTERCEPT
-	select KVM_ASYNC_PF
-	select KVM_ASYNC_PF_SYNC
-	select KVM_COMMON
-	select HAVE_KVM_IRQCHIP
-	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_INVALID_WAKEUPS
-	select HAVE_KVM_NO_POLL
-	select KVM_VFIO
-	select VIRT_XFER_TO_GUEST_WORK
-	select KVM_MMU_LOCKLESS_AGING
-	select KVM_GENERIC_PRE_FAULT_MEMORY
-	help
-	  Support hosting paravirtualized s390 guest machines using the SIE
-	  virtualization capability on the mainframe. This should work
-	  on any 64bit machine.
-
-	  This module provides access to the hardware capabilities through
-	  a character device node named /dev/kvm.
-
-	  To compile this as a module, choose M here: the module
-	  will be called kvm.
-
-	  If unsure, say N.
-
-config KVM_S390_UCONTROL
-	bool "Userspace controlled virtual machines"
-	depends on KVM_S390
-	help
-	  Allow CAP_SYS_ADMIN users to create KVM virtual machines that are
-	  controlled by userspace.
-
-	  If unsure, say N.
+source "arch/s390/kvm/s390/Kconfig"
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index df10063ae042..c43d7dffca13 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -3,13 +3,4 @@
 #
 # Copyright IBM Corp. 2008
 
-include $(srctree)/virt/kvm/Makefile.kvm
-
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
-
-kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-kvm-y += dat.o gmap.o faultin.o
-
-kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM_S390) += s390/
diff --git a/arch/s390/kvm/gmap/Makefile b/arch/s390/kvm/gmap/Makefile
new file mode 100644
index 000000000000..21967ed88877
--- /dev/null
+++ b/arch/s390/kvm/gmap/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GMAP ?= ../gmap
+
+kvm-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o
diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/gmap/dat.c
similarity index 100%
rename from arch/s390/kvm/dat.c
rename to arch/s390/kvm/gmap/dat.c
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/gmap/dat.h
similarity index 100%
rename from arch/s390/kvm/dat.h
rename to arch/s390/kvm/gmap/dat.h
diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/gmap/faultin.c
similarity index 100%
rename from arch/s390/kvm/faultin.c
rename to arch/s390/kvm/gmap/faultin.c
diff --git a/arch/s390/kvm/faultin.h b/arch/s390/kvm/gmap/faultin.h
similarity index 100%
rename from arch/s390/kvm/faultin.h
rename to arch/s390/kvm/gmap/faultin.h
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap/gmap.c
similarity index 100%
rename from arch/s390/kvm/gmap.c
rename to arch/s390/kvm/gmap/gmap.c
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap/gmap.h
similarity index 100%
rename from arch/s390/kvm/gmap.h
rename to arch/s390/kvm/gmap/gmap.h
diff --git a/arch/s390/kvm/trace-gmap.h b/arch/s390/kvm/gmap/trace-gmap.h
similarity index 96%
rename from arch/s390/kvm/trace-gmap.h
rename to arch/s390/kvm/gmap/trace-gmap.h
index b4abe4e385f8..78559298932c 100644
--- a/arch/s390/kvm/trace-gmap.h
+++ b/arch/s390/kvm/gmap/trace-gmap.h
@@ -6,6 +6,7 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
+#define TRACE_INCLUDE_PATH ../gmap
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace-gmap
 
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/s390/Kconfig
similarity index 71%
copy from arch/s390/kvm/Kconfig
copy to arch/s390/kvm/s390/Kconfig
index fbf4162d6f2d..4b7a7c2945e5 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/s390/Kconfig
@@ -1,23 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# KVM configuration
-#
-source "virt/kvm/Kconfig"
-
-menuconfig VIRTUALIZATION
-	def_bool y
-	prompt "KVM"
-	help
-	  Say Y here to get to see options for using your Linux host to run other
-	  operating systems inside virtual machines (guests).
-	  This option alone does not add any kernel code.
-
-	  If you say N, all options in this submenu will be skipped and disabled.
-
-if VIRTUALIZATION
-
-config KVM
-	tristate
+# KVM_S390 configuration
 
 config KVM_S390
 	def_tristate y
@@ -56,5 +39,3 @@ config KVM_S390_UCONTROL
 	  controlled by userspace.
 
 	  If unsure, say N.
-
-endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/s390/Makefile
similarity index 64%
copy from arch/s390/kvm/Makefile
copy to arch/s390/kvm/s390/Makefile
index df10063ae042..51aee874b36f 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -3,13 +3,15 @@
 #
 # Copyright IBM Corp. 2008
 
+KVM := ../../../../virt/kvm
 include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/arch/s390/kvm/gmap/Makefile
 
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
+ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
 
 kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-kvm-y += dat.o gmap.o faultin.o
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
-obj-$(CONFIG_KVM) += kvm.o
+
+obj-$(CONFIG_KVM_S390) += kvm.o
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/s390/diag.c
similarity index 100%
rename from arch/s390/kvm/diag.c
rename to arch/s390/kvm/s390/diag.c
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/s390/gaccess.c
similarity index 100%
rename from arch/s390/kvm/gaccess.c
rename to arch/s390/kvm/s390/gaccess.c
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/s390/gaccess.h
similarity index 100%
rename from arch/s390/kvm/gaccess.h
rename to arch/s390/kvm/s390/gaccess.h
diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/s390/guestdbg.c
similarity index 100%
rename from arch/s390/kvm/guestdbg.c
rename to arch/s390/kvm/s390/guestdbg.c
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/s390/intercept.c
similarity index 100%
rename from arch/s390/kvm/intercept.c
rename to arch/s390/kvm/s390/intercept.c
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/s390/interrupt.c
similarity index 100%
rename from arch/s390/kvm/interrupt.c
rename to arch/s390/kvm/s390/interrupt.c
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/s390/pci.c
similarity index 100%
rename from arch/s390/kvm/pci.c
rename to arch/s390/kvm/s390/pci.c
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/s390/pci.h
similarity index 100%
rename from arch/s390/kvm/pci.h
rename to arch/s390/kvm/s390/pci.h
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/s390/priv.c
similarity index 100%
rename from arch/s390/kvm/priv.c
rename to arch/s390/kvm/s390/priv.c
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/s390/pv.c
similarity index 100%
rename from arch/s390/kvm/pv.c
rename to arch/s390/kvm/s390/pv.c
diff --git a/arch/s390/kvm/s390.c b/arch/s390/kvm/s390/s390.c
similarity index 100%
rename from arch/s390/kvm/s390.c
rename to arch/s390/kvm/s390/s390.c
diff --git a/arch/s390/kvm/s390.h b/arch/s390/kvm/s390/s390.h
similarity index 100%
rename from arch/s390/kvm/s390.h
rename to arch/s390/kvm/s390/s390.h
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/s390/sigp.c
similarity index 100%
rename from arch/s390/kvm/sigp.c
rename to arch/s390/kvm/s390/sigp.c
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/s390/trace-s390.h
similarity index 100%
rename from arch/s390/kvm/trace-s390.h
rename to arch/s390/kvm/s390/trace-s390.h
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/s390/trace.h
similarity index 100%
rename from arch/s390/kvm/trace.h
rename to arch/s390/kvm/s390/trace.h
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/s390/vsie.c
similarity index 100%
rename from arch/s390/kvm/vsie.c
rename to arch/s390/kvm/s390/vsie.c
-- 
2.53.0

