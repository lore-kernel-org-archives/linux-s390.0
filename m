Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FC25782A;
	Tue, 30 Jun 2026 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789336; cv=none; b=s8okfADo+aQddb0SPJ149wVluGSy6KlocA7GGcJjxbrag35LkIuxZlZQkXsSRovueqZHSZPswTYHMAjSCM5RuPa0UWZmdzKrnP5h6+67yz0LeapVa6vwKUHmXEkJv5QKcyXMdMsUpe9lOq2F//JZNcJLv61hB72rjgg5HGkLIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789336; c=relaxed/simple;
	bh=NIXE57ffnuMMcLG97CIYTh+9V84PZUJ7bSblNEk/BzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAF1fGSGqx14RAY71HBdqXUEJVzXjltYslIm6cBizk87Q6EWUO2iPIXLAt1XNNp5NzsbiPGTR/yGrcBtYwpD6ykTtdSuhhd2/CQecN0PTpwA9lleGRbMdOqfgL18795Uuvg2tfscOZQedePO9PmcMnf8Dh+NCDjhwE6rFl6Wcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jl66eXqw; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jl66eXqw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782789332; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=h4cvvdYNdUTFVSwKliLOrRpdL1HZQLjA5KzRaVdKv6Q=;
	b=jl66eXqwevxsJ6a2mmogzOc1K26DmZLYs4swe53PJ3+coTtaJKUTMoExDHP9fgz+6ztlPU9mC8kH5UJ1gukNBbDoTWRdmX4jSyBtOdA9J911dJjz1REsrtoz07jFQgvDD5Ggm43e2wlHPFsOCG4LQVSNmznSmnHy/PCwE2o1DWM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X5zUONW_1782789329;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X5zUONW_1782789329 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 11:15:31 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: richardcochran@gmail.com,
	dwmw2@infradead.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: svens@linux.ibm.com,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-s390@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com
Subject: [PATCH v3 1/2] ptp: move non-host-disciplined clock drivers into a dedicated subdirectory
Date: Tue, 30 Jun 2026 11:15:18 +0800
Message-Id: <20260630031519.23072-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260630031519.23072-1-guwen@linux.alibaba.com>
References: <20260630031519.23072-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PTP subsystem today contains both host-disciplined PHC drivers and
various clock implementations that expose external precision time
sources via the PTP interface but are not disciplined by the host.

Move the latter into a dedicated subdirectory to prepare for clearer
ownership and maintenance boundaries:

  - drivers/ptp/          : PTP core infrastructure and host-disciplined
                            PHC drivers.

  - drivers/ptp/emulated/ : PHC drivers that expose precision time from
                            hypervisors, platforms, or firmware. These
                            clocks are read-only and not host-disciplined.

No functional changes are intended; this is a directory reorganization
only.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 drivers/ptp/Kconfig                         | 55 +------------------
 drivers/ptp/Makefile                        | 11 ++--
 drivers/ptp/emulated/Kconfig                | 61 +++++++++++++++++++++
 drivers/ptp/emulated/Makefile               | 11 ++++
 drivers/ptp/{ => emulated}/ptp_kvm_arm.c    |  0
 drivers/ptp/{ => emulated}/ptp_kvm_common.c |  0
 drivers/ptp/{ => emulated}/ptp_kvm_x86.c    |  0
 drivers/ptp/{ => emulated}/ptp_s390.c       |  0
 drivers/ptp/{ => emulated}/ptp_vmclock.c    |  0
 drivers/ptp/{ => emulated}/ptp_vmw.c        |  0
 10 files changed, 78 insertions(+), 60 deletions(-)
 create mode 100644 drivers/ptp/emulated/Kconfig
 create mode 100644 drivers/ptp/emulated/Makefile
 rename drivers/ptp/{ => emulated}/ptp_kvm_arm.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_common.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_x86.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_s390.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmclock.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmw.c (100%)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b7..19ec509cb365 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -119,35 +119,6 @@ config PTP_1588_CLOCK_PCH
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
@@ -195,18 +166,6 @@ config PTP_1588_CLOCK_MOCK
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
@@ -241,18 +200,6 @@ config PTP_DFL_TOD
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
@@ -263,4 +210,6 @@ config PTP_NETC_V4_TIMER
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

