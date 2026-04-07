Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E063AB283;
	Tue,  7 Apr 2026 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558899; cv=none; b=W/1j4zJzlkvT4/whvl3bwvMB7O/dslhCtWhzrzgchjPnRGjlV7+CbwF66yPJaGYWLmZ7uaoMdcNKm5ayNZtqUugakJHMM8M5HUTATPZlYyaHnO/wr2MuQ93d9u9zYAf52CpsY/zQ3GB1PnTkuafNMW/nB72n85/MG/v5Ycr7YQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558899; c=relaxed/simple;
	bh=OmYlzEE+8OIRxtdH4TpR6pENdo8TjWdkgGWJVg82Wh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8tNQCk74+NiC4f5jJ/qmHM3QpVltFWnHcZbG3kj5qhRtXuL/kyMC6xXuTOHyyKCNdB4DbWguJ9m69Dy3xzK+L+yR0o0/YOc0IBBMqmo13WERyZnbQwYqGvUimhsvjF3CIx+RndDRqcXIE46Gins1Rj/yfNm4Rr31MqQJAOfcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KLPOkIBZ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KLPOkIBZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775558888; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jfHY2L/BBeDphqighEF+vXkegaIZ6ojc1FaKwta2Yhg=;
	b=KLPOkIBZ9X4iysMHq9Ee1c4LBI0EzUOtvu5d9Fb3wSXzNvzjCQE7K7unkfJUGUeG1v5yJQv1dx+Mr40nZHhrnDQ2UNL+M/y9uJccaKj8Kzui4bSGtJP2bb4GceBKB1OEiojLrMrs9kimDsrySwggFBDhU2bgC+zHZCIOKxiUHpI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0X0bYxbG_1775558884;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X0bYxbG_1775558884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 18:48:06 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: tglx@kernel.org,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	jstultz@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	daniel.lezcano@kernel.org,
	sboyd@kernel.org,
	dwmw2@infradead.org
Cc: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com,
	svens@linux.ibm.com,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-fpga@vger.kernel.org,
	imx@lists.linux.dev,
	linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: [PATCH v2 1/2] ptp: move emulated/virtual clock drivers into a dedicated subdirectory
Date: Tue,  7 Apr 2026 18:48:01 +0800
Message-Id: <20260407104802.34429-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260407104802.34429-1-guwen@linux.alibaba.com>
References: <20260407104802.34429-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PTP subsystem has grown beyond the original IEEE 1588/NIC use case
and today contains both network-oriented PHC drivers and various
emulated/virtual clock implementations.

Prepare for clearer ownership and future maintenance by moving the
emulated/virtual/non-NIC PTP clock drivers into a dedicated subdirectory,
with its own Kconfig and Makefile.

The network/IEEE 1588 oriented drivers remain in drivers/ptp/ alongside
the PTP core infrastructure:

  - drivers/ptp/          : PTP core infrastructure and IEEE 1588 /
                            network-oriented clock drivers.

  - drivers/ptp/emulated/ : emulated/virtual/non-NIC implementations
                            that expose high-precision time sources via
                            the PTP interface but are not tied to the
                            NIC/packet-timestamping pipeline.

No functional changes are intended; this is a refactor only.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 drivers/ptp/Kconfig                         | 68 ++++-----------------
 drivers/ptp/Makefile                        | 11 ++--
 drivers/ptp/emulated/Kconfig                | 61 ++++++++++++++++++
 drivers/ptp/emulated/Makefile               | 11 ++++
 drivers/ptp/{ => emulated}/ptp_kvm_arm.c    |  0
 drivers/ptp/{ => emulated}/ptp_kvm_common.c |  0
 drivers/ptp/{ => emulated}/ptp_kvm_x86.c    |  0
 drivers/ptp/{ => emulated}/ptp_s390.c       |  0
 drivers/ptp/{ => emulated}/ptp_vmclock.c    |  0
 drivers/ptp/{ => emulated}/ptp_vmw.c        |  0
 10 files changed, 87 insertions(+), 64 deletions(-)
 create mode 100644 drivers/ptp/emulated/Kconfig
 create mode 100644 drivers/ptp/emulated/Makefile
 rename drivers/ptp/{ => emulated}/ptp_kvm_arm.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_common.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_x86.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_s390.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmclock.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmw.c (100%)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b7..4cb199332546 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -20,11 +20,16 @@ config PTP_1588_CLOCK
 	  time stamping units, it can be possible to achieve
 	  synchronization to within a few hundred nanoseconds.
 
-	  This driver adds support for PTP clocks as character
-	  devices. If you want to use a PTP clock, then you should
-	  also enable at least one clock driver as well.
+	  This infrastructure adds support for PTP clocks as character
+	  devices. It has since evolved into a general-purpose PTP
+	  clock framework also used by high-precision clocks exposed
+	  by platforms, hypervisors or special hardware, beyond the
+	  traditional NIC/IEEE 1588 use case.
 
-	  To compile this driver as a module, choose M here: the module
+	  If you want to use any PTP clock device, enable this option
+	  and at least one clock driver.
+
+	  To compile the core as a module, choose M here: the module
 	  will be called ptp.
 
 config PTP_1588_CLOCK_OPTIONAL
@@ -119,35 +124,6 @@ config PTP_1588_CLOCK_PCH
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_pch.
 
-config PTP_1588_CLOCK_KVM
-	tristate "KVM virtual PTP clock"
-	depends on PTP_1588_CLOCK
-	depends on (KVM_GUEST && X86) || (HAVE_ARM_SMCCC_DISCOVERY && ARM_ARCH_TIMER)
-	default y
-	help
-	  This driver adds support for using kvm infrastructure as a PTP
-	  clock. This clock is only useful if you are using KVM guests.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_kvm.
-
-config PTP_1588_CLOCK_VMCLOCK
-	tristate "Virtual machine PTP clock"
-	depends on X86_TSC || ARM_ARCH_TIMER
-	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128
-	default PTP_1588_CLOCK_KVM
-	help
-	  This driver adds support for using a virtual precision clock
-	  advertised by the hypervisor. This clock is only useful in virtual
-	  machines where such a device is present.
-
-	  Unlike the KVM virtual PTP clock, the VMCLOCK device offers support
-	  for reliable timekeeping even across live migration. So this driver
-	  is enabled by default whenever the KVM PTP clock is.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_vmclock.
-
 config PTP_1588_CLOCK_IDT82P33
 	tristate "IDT 82P33xxx PTP clock"
 	depends on PTP_1588_CLOCK && I2C
@@ -195,18 +171,6 @@ config PTP_1588_CLOCK_MOCK
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_mock.
 
-config PTP_1588_CLOCK_VMW
-	tristate "VMware virtual PTP clock"
-	depends on ACPI && HYPERVISOR_GUEST && X86
-	depends on PTP_1588_CLOCK
-	help
-	  This driver adds support for using VMware virtual precision
-	  clock device as a PTP clock. This is only useful in virtual
-	  machines running on VMware virtual infrastructure.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_vmw.
-
 config PTP_1588_CLOCK_OCP
 	tristate "OpenCompute TimeCard as PTP clock"
 	depends on PTP_1588_CLOCK
@@ -241,18 +205,6 @@ config PTP_DFL_TOD
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_dfl_tod.
 
-config PTP_S390
-	tristate "S390 PTP driver"
-	depends on PTP_1588_CLOCK
-	depends on S390
-	help
-	  This driver adds support for S390 time steering via the PtP
-	  interface. This works by adding a in-kernel clock delta value,
-	  which is always added to time values used in the kernel. The PtP
-	  driver provides the raw clock value without the delta to
-	  userspace. That way userspace programs like chrony could steer
-	  the kernel clock.
-
 config PTP_NETC_V4_TIMER
 	tristate "NXP NETC V4 Timer PTP Driver"
 	depends on PTP_1588_CLOCK
@@ -263,4 +215,6 @@ config PTP_NETC_V4_TIMER
 	  synchronization. It also supports periodic output signal (e.g. PPS)
 	  and external trigger timestamping.
 
+source "drivers/ptp/emulated/Kconfig"
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index bdc47e284f14..bcea2d3d4efd 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -1,24 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for PTP 1588 clock support.
+# Makefile for PTP clock support.
 #
 
+subdir-ccflags-y += -I$(srctree)/drivers/ptp
+
 ptp-y					:= ptp_clock.o ptp_chardev.o ptp_sysfs.o ptp_vclock.o
-ptp_kvm-$(CONFIG_X86)			:= ptp_kvm_x86.o ptp_kvm_common.o
-ptp_kvm-$(CONFIG_HAVE_ARM_SMCCC)	:= ptp_kvm_arm.o ptp_kvm_common.o
 obj-$(CONFIG_PTP_1588_CLOCK)		+= ptp.o
 obj-$(CONFIG_PTP_1588_CLOCK_DTE)	+= ptp_dte.o
 obj-$(CONFIG_PTP_1588_CLOCK_INES)	+= ptp_ines.o
 obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
-obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
-obj-$(CONFIG_PTP_1588_CLOCK_VMCLOCK)	+= ptp_vmclock.o
 obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
 obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
 obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
-obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
-obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
 obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
+obj-$(CONFIG_PTP_1588_CLOCK)		+= emulated/
diff --git a/drivers/ptp/emulated/Kconfig b/drivers/ptp/emulated/Kconfig
new file mode 100644
index 000000000000..3e11f78dfbd8
--- /dev/null
+++ b/drivers/ptp/emulated/Kconfig
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Emulated PTP clock drivers configuration
+#
+
+menu "Emulated PTP clock drivers"
+
+config PTP_1588_CLOCK_KVM
+	tristate "KVM virtual PTP clock"
+	depends on PTP_1588_CLOCK
+	depends on (KVM_GUEST && X86) || (HAVE_ARM_SMCCC_DISCOVERY && ARM_ARCH_TIMER)
+	default y
+	help
+	  This driver adds support for using kvm infrastructure as a PTP
+	  clock. This clock is only useful if you are using KVM guests.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_kvm.
+
+config PTP_1588_CLOCK_VMCLOCK
+	tristate "Virtual machine PTP clock"
+	depends on X86_TSC || ARM_ARCH_TIMER
+	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128
+	default PTP_1588_CLOCK_KVM
+	help
+	  This driver adds support for using a virtual precision clock
+	  advertised by the hypervisor. This clock is only useful in virtual
+	  machines where such a device is present.
+
+	  Unlike the KVM virtual PTP clock, the VMCLOCK device offers support
+	  for reliable timekeeping even across live migration. So this driver
+	  is enabled by default whenever the KVM PTP clock is.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_vmclock.
+
+config PTP_1588_CLOCK_VMW
+	tristate "VMware virtual PTP clock"
+	depends on ACPI && HYPERVISOR_GUEST && X86
+	depends on PTP_1588_CLOCK
+	help
+	  This driver adds support for using VMware virtual precision
+	  clock device as a PTP clock. This is only useful in virtual
+	  machines running on VMware virtual infrastructure.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_vmw.
+
+config PTP_S390
+	tristate "S390 PTP driver"
+	depends on PTP_1588_CLOCK
+	depends on S390
+	help
+	  This driver adds support for S390 time steering via the PtP
+	  interface. This works by adding a in-kernel clock delta value,
+	  which is always added to time values used in the kernel. The PtP
+	  driver provides the raw clock value without the delta to
+	  userspace. That way userspace programs like chrony could steer
+	  the kernel clock.
+
+endmenu
diff --git a/drivers/ptp/emulated/Makefile b/drivers/ptp/emulated/Makefile
new file mode 100644
index 000000000000..577917df3dc9
--- /dev/null
+++ b/drivers/ptp/emulated/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for emulated PTP clocks.
+#
+
+ptp_kvm-$(CONFIG_X86)			:= ptp_kvm_x86.o ptp_kvm_common.o
+ptp_kvm-$(CONFIG_HAVE_ARM_SMCCC)	:= ptp_kvm_arm.o ptp_kvm_common.o
+obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
+obj-$(CONFIG_PTP_1588_CLOCK_VMCLOCK)	+= ptp_vmclock.o
+obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
+obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
diff --git a/drivers/ptp/ptp_kvm_arm.c b/drivers/ptp/emulated/ptp_kvm_arm.c
similarity index 100%
rename from drivers/ptp/ptp_kvm_arm.c
rename to drivers/ptp/emulated/ptp_kvm_arm.c
diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/emulated/ptp_kvm_common.c
similarity index 100%
rename from drivers/ptp/ptp_kvm_common.c
rename to drivers/ptp/emulated/ptp_kvm_common.c
diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/emulated/ptp_kvm_x86.c
similarity index 100%
rename from drivers/ptp/ptp_kvm_x86.c
rename to drivers/ptp/emulated/ptp_kvm_x86.c
diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/emulated/ptp_s390.c
similarity index 100%
rename from drivers/ptp/ptp_s390.c
rename to drivers/ptp/emulated/ptp_s390.c
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/emulated/ptp_vmclock.c
similarity index 100%
rename from drivers/ptp/ptp_vmclock.c
rename to drivers/ptp/emulated/ptp_vmclock.c
diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/emulated/ptp_vmw.c
similarity index 100%
rename from drivers/ptp/ptp_vmw.c
rename to drivers/ptp/emulated/ptp_vmw.c
-- 
2.43.5

