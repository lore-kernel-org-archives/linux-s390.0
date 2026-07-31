Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F6403AFA;
	Fri, 31 Jul 2026 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503378; cv=none; b=Tb6uqT7piBJ1ixqWw7Whp1vyGEunCP6QevHM6gdu4N0pJ6c9RXrVpmuFJqGkjLv2+iujIJtBfWQg4yMmSFiE2/jAIDGixIUIEBjQThC/YbCei7BtsKcQuegSXabe/D33j06e24GpoKxx2el8K0+LQ7CPpcLE2P1URdA/kHzIc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503378; c=relaxed/simple;
	bh=TbJkPNq6nSUjmk/9eF0wRX32lUads1IXfsDTs4oMCFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHx+OfX1ciZ2NNY6qQgJeMzA78ipH5HpW0jojyFu7qV69mXioP6+O1VLEKqS8B4KkVW+EJc4f381AKfgntFSWfof60pQtpUR2Y7/fnqN27gm5mjp737ls2LkhP/fNhxiDXyumuCVW3IxKUwTIhY0HHtFAyKshfgOtp4sTUGmTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KG03/Ptm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KG03/Ptm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlo7D1765817;
	Fri, 31 Jul 2026 13:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WE1juuDRkDodrIk7Y
	44eGv6k6mTFRgrA6xPVXKZnMYQ=; b=KG03/PtmcZ43ULcYkKz1owBTDd+uZy7ne
	wFUo9Qt0m6FclAunIUGb+Q2r6wPw4UVEGhNOP4mOI9262X3qhAeeQptrKNGZ0mpY
	mUQ6GN+FoGByXo3L1ULdh++vMVC4bmPbMauydLwlJ68JAKbYrcnu2DHLzEGOPtai
	+2o1CxFnVI/4/3dUyE6f0SwX87g72gluISDZM6tQO49Qbi+aXVwD1Uh83m22VJsT
	qG0y/lmyYFGHY+RRIBRNLP7n0Plx5ac7Kru/oz0ilEeHk7Z4V88VBEnXu6zdnJer
	L//1kWqAtuXlYLTQ9VeWQNDUMa85tTf6OJrgzIi7mvaadtY1+A9Gw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y565f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCQFoT026851;
	Fri, 31 Jul 2026 13:09:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqtbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD990A45547846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68BB520040;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 008CA2004B;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:08 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
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
Subject: [PATCH v5 14/31] KVM: s390: Move s390 kvm code into a subdirectory
Date: Fri, 31 Jul 2026 15:08:42 +0200
Message-ID: <20260731130902.654679-15-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OXx-ERYv_mekzpbcxk_sG9OJzMeuOsOy
X-Proofpoint-ORIG-GUID: tvHpK62mCDGhVprRE-Opo9ziqTSElVIH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfXwTpT8ffdJ5SU
 DZDtDfXH1jnN6fOnDVGWFTyyiw0shqfTM3xih1fqHT5KogCcH1yWJn5PDWFrWHWpza+IHi9W3b3
 s0pCzYeEXAb+0R47p10Fbw+LP8P1eHs=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6c9e7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=_XZOIuALDOYOogwKVDcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX7CI6EXPQstl0
 6L2U6aS6FYMg5I0rprUGeGR4qGo4/Cznl8rLM9ZCc+kFYAh9OBwbbfG/uMPwyzuNX6NaMQSPtRY
 Qgzo+YoAwledBoNfgbG5n93JUb5Dh2kuMQW6qD8a17zwfTNWmg1OQ6ou5groc9UQcDTE4KF+vmE
 +MWKmTOiQSIB8tdWRaBVthuv3jwui70AM9m5BjUK4P6xMzRNZ1m59EEWZcuBLIWEWklKKUUskev
 dvRAdSXzo7Vfo147ZGRipWmyCSL9O2EeV3YwC1NuHAhQDFdcM11wfkCJz5f7j2mgKmci7MkdMDy
 I7OQMS0UxS51944NbRqEw32GOHWtGkVMv9OhPiSfYKsL/cfNV0zf1KHsK2dGCnLRv91ioUkBfF9
 XrV4ZaouCHlLWECxfDJpUIoVx0jXEy6vVnbXs89C6b7Ay6YmCJy83aVQbtrrgrRcsbdYvKQQkcF
 vl1w1iWJPyGns/JAJcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Move all the code required to run s390 KVM guests on s390 to a s390
subdirectory. Move gmap related code into a gmap directory to later
share gmap code between KVM implementations.

Update S390 VFIO-PCI MAINTAINERS filepath.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                           |  2 +-
 arch/s390/kvm/Kconfig                 | 37 +--------------------------
 arch/s390/kvm/Makefile                | 11 +-------
 arch/s390/kvm/gmap/Makefile           |  5 ++++
 arch/s390/kvm/{ => gmap}/dat.c        |  0
 arch/s390/kvm/{ => gmap}/dat.h        |  0
 arch/s390/kvm/{ => gmap}/faultin.c    |  0
 arch/s390/kvm/{ => gmap}/faultin.h    |  0
 arch/s390/kvm/{ => gmap}/gmap.c       |  0
 arch/s390/kvm/{ => gmap}/gmap.h       |  0
 arch/s390/kvm/{ => gmap}/trace-gmap.h |  2 +-
 arch/s390/kvm/{ => s390}/Kconfig      | 18 -------------
 arch/s390/kvm/{ => s390}/Makefile     |  9 +++----
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
 29 files changed, 13 insertions(+), 71 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (100%)
 rename arch/s390/kvm/{ => gmap}/dat.h (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (100%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (100%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (100%)
 rename arch/s390/kvm/{ => gmap}/trace-gmap.h (96%)
 copy arch/s390/kvm/{ => s390}/Kconfig (71%)
 copy arch/s390/kvm/{ => s390}/Makefile (65%)
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

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d7987278c07..c7ef6c0163a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23918,7 +23918,7 @@ R:	Eric Farman <farman@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
-F:	arch/s390/kvm/pci*
+F:	arch/s390/kvm/s390/pci*
 F:	drivers/vfio/pci/vfio_pci_zdev.c
 F:	include/uapi/linux/vfio_zdev.h
 
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index e9d2ca797907..51646b067935 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -16,41 +16,6 @@ menuconfig VIRTUALIZATION
 
 if VIRTUALIZATION
 
-config KVM
-	def_tristate y
-	prompt "Kernel-based Virtual Machine (KVM) support (s390)"
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
-	depends on KVM
-	help
-	  Allow CAP_SYS_ADMIN users to create KVM virtual machines that are
-	  controlled by userspace.
-
-	  If unsure, say N.
+source "arch/s390/kvm/s390/Kconfig"
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 961de97b8e80..a4e3875b5bdd 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -3,13 +3,4 @@
 #
 # Copyright IBM Corp. 2008
 
-include $(srctree)/virt/kvm/Makefile.kvm
-
-ccflags-y := -I$(src)
-
-kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-kvm-y += dat.o gmap.o faultin.o
-
-kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM) += s390/
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
index c139b4ef75f6..78559298932c 100644
--- a/arch/s390/kvm/trace-gmap.h
+++ b/arch/s390/kvm/gmap/trace-gmap.h
@@ -6,7 +6,7 @@
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../gmap
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace-gmap
 
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/s390/Kconfig
similarity index 71%
copy from arch/s390/kvm/Kconfig
copy to arch/s390/kvm/s390/Kconfig
index e9d2ca797907..62d65de3878d 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/s390/Kconfig
@@ -1,20 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-#
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
 
 config KVM
 	def_tristate y
@@ -52,5 +36,3 @@ config KVM_S390_UCONTROL
 	  controlled by userspace.
 
 	  If unsure, say N.
-
-endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/s390/Makefile
similarity index 65%
copy from arch/s390/kvm/Makefile
copy to arch/s390/kvm/s390/Makefile
index 961de97b8e80..de7deb81e655 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -1,15 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
-# Makefile for kernel virtual machines on s390
-#
-# Copyright IBM Corp. 2008
 
+KVM := ../../../../virt/kvm
 include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/arch/s390/kvm/gmap/Makefile
 
-ccflags-y := -I$(src)
+ccflags-y := -I$(src) -I$(srctree)/arch/s390/kvm/gmap
 
 kvm-y += s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-kvm-y += dat.o gmap.o faultin.o
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
+
 obj-$(CONFIG_KVM) += kvm.o
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

