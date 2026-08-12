Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FB47989B;
	Wed, 12 Aug 2026 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549068; cv=none; b=XrzSYxzR3ujAVBdQsp24HPrqpP65zirnjhotkmc0H5i0cN76w+s4PpZlAf74UHy/shyvHARHrVBiQslvSezJHNA3Edb9mlrCTjMU2B0Bo3Ewx43wZVrn2GSrMpGqWqIcAYkEbvbJ4+fSP8VOo6o0YEbN1VysSUgExalJJCL8wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549068; c=relaxed/simple;
	bh=Ef5gnhF7x3talP8mcnjrnwLk41c0TxwtAp6o6ci0dcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsT+GIbDEJL+bjLfyXJtnl98zq04v0+0SAgTeOA0VeLJrE7aXNMGIAloXJQXPDTroIoJkhA6LNX7FGFXsLFv30yr/JvopqyYkuERO/g+Jk4/jRHdncbF2xo4RwUbMg1/xUyNt8SxXTogHgs9aRS6rFgioKMkBwSWRYMO/jXuq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IwN7xo26; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IwN7xo26"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1S3x3686405;
	Wed, 12 Aug 2026 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eEIg1Xw4LzW5cs8dP
	xyjzAXZwHhpDE2Y+1SyF1VqDm0=; b=IwN7xo260tXIwAnCqP5iqEH6pBM0X50u4
	bBe1YvnlpHjTz/xLlY6taA+XVQzqgfLM2xcRPAJ3rf46ipvGTlYWLZ4Pxh133eli
	InEua6EO4COwbd7q6lzMDtZOjBW3xcbbIa8t85cSTMk3ksM7bIeXjtFdk4gJBBxR
	602poLr3xFNExIDNNe0danjlaTwI5oznBfhChxxHjAo4puSlwE118faWahgNtYFB
	EZmRzUqr4pxiC5LtvSL5UEl+73IWUiSPfnlOM3Waa+G1/Zl6NyaBfvmDhL9jhkxL
	Oka/QwD+iXXrd+lb2iJpKONmQv01ST5t724AXRKHtLmDrMeKbEmtg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9u9u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQTf6024859;
	Wed, 12 Aug 2026 15:36:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxpjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFacer26607904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6B420040;
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1599120067;
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:38 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 16/33] KVM: s390: Move s390 kvm code into a subdirectory
Date: Wed, 12 Aug 2026 17:36:12 +0200
Message-ID: <20260812153631.3376090-17-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX8KvD/J/dZhsQ
 YS7wq0vmF10P0ro7yCi1FFfcy2Kpe/upnIu/jVBfScm8JVu0VQTAgS0rU/O/Z0XlWc/M10qGHDo
 yCkbdwcJIurX5A+XTyhfjn3L4bgvKwnShrCVNmNq4dvlaCXC5x5F2RhawcmSPMfgTHG8IUfQgzH
 rkJf52mdNYxsfW+Yz09FgkfZKjMyfqIH5MhdrrSsNzY9aa6utZ+KhcH+mWUnBd7KbZXmgGH7pdF
 0KMTBPDRmkib+oiZTiiscnGH6Zjc+hORbO5AYnsfX8unvzM0roa0NuAUI2MbTfoCX5GBm0dKSHc
 zlhUJ2pSn5BsPVLjhWGSNFEe3aPjQzcCCqyDCPV0g7m8tzhM2/BnR1TaZFG9ADjtbdOtA1fiFDO
 t5aOAKqQDPDTzrsLBtP8G8nlZS4JekmoYgsMga71hqSqdfCNHLJzEJE7/LxlUByMBy8+wc8UDBl
 7fo3meLF2vsVfcDUMYw==
X-Proofpoint-ORIG-GUID: Vgn75nfZb8w5zP45uaoqsu3-ApumsbzN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXxGSscRy5sw92
 MkKlE0u86yrVoyr96v2J+dg8IvBumW1fDNrr+7MtJgsFRAriMGZds/iHJpTLQuUmqSE7HMhVzuA
 kw1SoXeKfI3+QujSwkBB7lFct8f4XMc=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c930c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l8Pa1nNPRxDDRIpcrlkA:9
X-Proofpoint-GUID: q5_k0aIdYqMZ-vw1puVkrjVtk6VgDvKy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

Move all the code required to run s390 KVM guests on s390 to a s390
subdirectory. Move gmap related code into a gmap directory to later
share gmap code between KVM implementations.

Update S390 VFIO-PCI MAINTAINERS filepath.

No functional change.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                           |  2 +-
 arch/s390/kvm/Makefile                | 11 +----------
 arch/s390/kvm/gmap/Makefile           |  5 +++++
 arch/s390/kvm/{ => gmap}/dat.c        |  0
 arch/s390/kvm/{ => gmap}/dat.h        |  0
 arch/s390/kvm/{ => gmap}/faultin.c    |  0
 arch/s390/kvm/{ => gmap}/faultin.h    |  0
 arch/s390/kvm/{ => gmap}/gmap.c       |  0
 arch/s390/kvm/{ => gmap}/gmap.h       |  0
 arch/s390/kvm/{ => gmap}/trace_gmap.h |  2 +-
 arch/s390/kvm/{ => s390}/Makefile     |  9 ++++-----
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
 27 files changed, 12 insertions(+), 17 deletions(-)
 create mode 100644 arch/s390/kvm/gmap/Makefile
 rename arch/s390/kvm/{ => gmap}/dat.c (100%)
 rename arch/s390/kvm/{ => gmap}/dat.h (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.c (100%)
 rename arch/s390/kvm/{ => gmap}/faultin.h (100%)
 rename arch/s390/kvm/{ => gmap}/gmap.c (100%)
 rename arch/s390/kvm/{ => gmap}/gmap.h (100%)
 rename arch/s390/kvm/{ => gmap}/trace_gmap.h (96%)
 copy arch/s390/kvm/{ => s390}/Makefile (62%)
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
index 15c7dc516f7c..29802f061063 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24150,7 +24150,7 @@ L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
-F:	arch/s390/kvm/pci*
+F:	arch/s390/kvm/s390/pci*
 F:	drivers/vfio/pci/vfio_pci_zdev.c
 F:	include/uapi/linux/vfio_zdev.h
 
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
index 000000000000..3a4f8df11622
--- /dev/null
+++ b/arch/s390/kvm/gmap/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GMAP ?= ../gmap
+
+gmap-y += $(GMAP)/dat.o $(GMAP)/gmap.o $(GMAP)/faultin.o
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
diff --git a/arch/s390/kvm/trace_gmap.h b/arch/s390/kvm/gmap/trace_gmap.h
similarity index 96%
rename from arch/s390/kvm/trace_gmap.h
rename to arch/s390/kvm/gmap/trace_gmap.h
index a3cad705021b..15ec88bdce55 100644
--- a/arch/s390/kvm/trace_gmap.h
+++ b/arch/s390/kvm/gmap/trace_gmap.h
@@ -7,7 +7,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../gmap
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace_gmap
 
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/s390/Makefile
similarity index 62%
copy from arch/s390/kvm/Makefile
copy to arch/s390/kvm/s390/Makefile
index 961de97b8e80..762a63826423 100644
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
+kvm-y += $(gmap-y)
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
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

