Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4732AAD1;
	Fri, 27 Feb 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180385; cv=none; b=snNN76xI7ctzWPZG2xvUPqi6ETSJSIIKg/z8ZD7RNbYejQWT3PqLdiRpLUXBbrWvFrYLCtRr4lsPPuj+h44madG6P8noRl8gqlFpP5USef3AO7sM4kgWP0oZHRP9FRP7HYSglFlkf6r7eV+y1oq1o7DFPGzR/0v8r3xV+DEkvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180385; c=relaxed/simple;
	bh=cyTAOiYQzgYa7b0sz1MLBTaYz4MZMt2MbrEL4F0zPuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ph3VKUloMOZzwT7CqxgY9r5WGKjQtpxCOmAQGL12+Wz12H6F36TcLE6pCewF2/tD/MwTkdMnmXN/3r8MppVZcOBxP4YLYp/kFz7aKOSq4Th4fa2KP7O3oKxQkyN4ORYXGnHsuTJGp1qs9LjeUDlSzxhZ/RRu8ds5ZwYan3E/NyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BBb3Qya1; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BBb3Qya1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772180379; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KYyVjLefmVhInHKv1d1oMGdC/8b/EL4khfStPVVEIto=;
	b=BBb3Qya1Ba4UbTXIWWIURdRFsUkvpPalBt0TIl7zoxH3UwJtInT4dv6qo5SlafDcmUXRUQyMOjbv68ZCMyVk3KVlL4kpnGaelueTRGwhwimsCQOCPMYU9ebRk2KJldxNDBz4JbvJuktJlaAl4vKdQSDvMqMRG4Amz9SMHiYVYz0=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WztmZI5_1772180376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 16:19:38 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: tglx@kernel.org,
	tglx@linutronix.de,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com
Cc: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com,
	svens@linux.ibm.com,
	dwmw2@infradead.org,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-fpga@vger.kernel.org,
	imx@lists.linux.dev,
	linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	taniya.das@oss.qualcomm.com
Subject: [RFC v2 1/2] ptp: split clock drivers into two subdirectories
Date: Fri, 27 Feb 2026 16:19:33 +0800
Message-Id: <20260227081934.96865-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260227081934.96865-1-guwen@linux.alibaba.com>
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
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

Prepare for clearer ownership and future maintenance by refactoring
drivers/ptp/ to make the split explicit. Keep the PTP core
infrastructure in drivers/ptp/ and move the drivers into two new
subdirectories:

  - drivers/ptp/ieee1588/  : network/IEEE 1588 oriented drivers
  - drivers/ptp/emulated/  : emulated/virtual/non-NIC implementations

Move the corresponding Kconfig entries into the new directories and
include them from drivers/ptp/Kconfig. Update the top-level
drivers/ptp/Makefile to build the core as before and recurse into the
two subdirectories.

No functional changes are intended; this is a refactor only.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 drivers/ptp/Kconfig                          | 255 ++-----------------
 drivers/ptp/Makefile                         |  27 +-
 drivers/ptp/emulated/Kconfig                 |  81 ++++++
 drivers/ptp/emulated/Makefile                |  12 +
 drivers/ptp/{ => emulated}/ptp_kvm_arm.c     |   0
 drivers/ptp/{ => emulated}/ptp_kvm_common.c  |   0
 drivers/ptp/{ => emulated}/ptp_kvm_x86.c     |   0
 drivers/ptp/{ => emulated}/ptp_ocp.c         |   0
 drivers/ptp/{ => emulated}/ptp_s390.c        |   0
 drivers/ptp/{ => emulated}/ptp_vmclock.c     |   0
 drivers/ptp/{ => emulated}/ptp_vmw.c         |   0
 drivers/ptp/ieee1588/Kconfig                 | 159 ++++++++++++
 drivers/ptp/ieee1588/Makefile                |  15 ++
 drivers/ptp/{ => ieee1588}/ptp_clockmatrix.c |   0
 drivers/ptp/{ => ieee1588}/ptp_clockmatrix.h |   0
 drivers/ptp/{ => ieee1588}/ptp_dfl_tod.c     |   0
 drivers/ptp/{ => ieee1588}/ptp_dte.c         |   0
 drivers/ptp/{ => ieee1588}/ptp_fc3.c         |   0
 drivers/ptp/{ => ieee1588}/ptp_fc3.h         |   0
 drivers/ptp/{ => ieee1588}/ptp_idt82p33.c    |   0
 drivers/ptp/{ => ieee1588}/ptp_idt82p33.h    |   0
 drivers/ptp/{ => ieee1588}/ptp_ines.c        |   0
 drivers/ptp/{ => ieee1588}/ptp_mock.c        |   0
 drivers/ptp/{ => ieee1588}/ptp_netc.c        |   0
 drivers/ptp/{ => ieee1588}/ptp_pch.c         |   0
 drivers/ptp/{ => ieee1588}/ptp_qoriq.c       |   0
 26 files changed, 296 insertions(+), 253 deletions(-)
 create mode 100644 drivers/ptp/emulated/Kconfig
 create mode 100644 drivers/ptp/emulated/Makefile
 rename drivers/ptp/{ => emulated}/ptp_kvm_arm.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_common.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_kvm_x86.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_ocp.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_s390.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmclock.c (100%)
 rename drivers/ptp/{ => emulated}/ptp_vmw.c (100%)
 create mode 100644 drivers/ptp/ieee1588/Kconfig
 create mode 100644 drivers/ptp/ieee1588/Makefile
 rename drivers/ptp/{ => ieee1588}/ptp_clockmatrix.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_clockmatrix.h (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_dfl_tod.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_dte.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_fc3.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_fc3.h (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_idt82p33.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_idt82p33.h (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_ines.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_mock.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_netc.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_pch.c (100%)
 rename drivers/ptp/{ => ieee1588}/ptp_qoriq.c (100%)

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b7..abcb6ca7dfb8 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -12,17 +12,27 @@ config PTP_1588_CLOCK
 	select PPS
 	select NET_PTP_CLASSIFY
 	help
-	  The IEEE 1588 standard defines a method to precisely
-	  synchronize distributed clocks over Ethernet networks. The
-	  standard defines a Precision Time Protocol (PTP), which can
-	  be used to achieve synchronization within a few dozen
-	  microseconds. In addition, with the help of special hardware
-	  time stamping units, it can be possible to achieve
-	  synchronization to within a few hundred nanoseconds.
+	  Enable the core infrastructure for PTP (Precision Time Protocol)
+	  clock devices
 
-	  This driver adds support for PTP clocks as character
-	  devices. If you want to use a PTP clock, then you should
-	  also enable at least one clock driver as well.
+	  The core provides the common user space interfaces for PTP
+	  clocks, including the character device (/dev/ptpX), sysfs
+	  attributes and ioctl operations.
+
+	  This infrastructure was originally introduced for hardware
+	  clocks on network devices implementing IEEE 1588 to
+	  synchronize distributed clocks over Ethernet networks. With
+	  special hardware time stamping units, synchronization within
+	  a few dozen microseconds, and in some cases a few hundred
+	  nanoseconds, can be achieved.
+
+	  Over time it has evolved into a generic clock device framework
+	  and is also used by other high precision clocks exposed by
+	  platforms, hypervisors or special hardware, even when those
+	  clocks are not synchronized via IEEE 1588 over a network.
+
+	  If you want to use any PTP clock device, enable this option and
+	  at least one clock driver.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp.
@@ -39,228 +49,7 @@ config PTP_1588_CLOCK_OPTIONAL
 	  If PTP support is disabled, this dependency will still be
 	  met, and drivers refer to dummy helpers.
 
-config PTP_1588_CLOCK_DTE
-	tristate "Broadcom DTE as PTP clock"
-	depends on PTP_1588_CLOCK
-	depends on NET && HAS_IOMEM
-	depends on ARCH_BCM_MOBILE || (ARCH_BCM_IPROC && !(ARCH_BCM_NSP || ARCH_BCM_5301X)) || COMPILE_TEST
-	default y if ARCH_BCM_MOBILE || ARCH_BCM_IPROC
-	help
-	  This driver adds support for using the Digital timing engine
-	  (DTE) in the Broadcom SoC's as a PTP clock.
-
-	  The clock can be used in both wired and wireless networks
-	  for PTP purposes.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_dte.
-
-config PTP_1588_CLOCK_QORIQ
-	tristate "Freescale QorIQ 1588 timer as PTP clock"
-	depends on GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF || COMPILE_TEST
-	depends on PTP_1588_CLOCK
-	default y if GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF
-	help
-	  This driver adds support for using the Freescale QorIQ 1588
-	  timer as a PTP clock. This clock is only useful if your PTP
-	  programs are getting hardware time stamps on the PTP Ethernet
-	  packets using the SO_TIMESTAMPING API.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_qoriq.
-
-comment "Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks."
-	depends on PHYLIB=n || NETWORK_PHY_TIMESTAMPING=n
-
-config DP83640_PHY
-	tristate "Driver for the National Semiconductor DP83640 PHYTER"
-	depends on NETWORK_PHY_TIMESTAMPING
-	depends on PHYLIB
-	depends on PTP_1588_CLOCK
-	select CRC32
-	help
-	  Supports the DP83640 PHYTER with IEEE 1588 features.
-
-	  This driver adds support for using the DP83640 as a PTP
-	  clock. This clock is only useful if your PTP programs are
-	  getting hardware time stamps on the PTP Ethernet packets
-	  using the SO_TIMESTAMPING API.
-
-	  In order for this to work, your MAC driver must also
-	  implement the skb_tx_timestamp() function.
-
-config PTP_1588_CLOCK_INES
-	tristate "ZHAW InES PTP time stamping IP core"
-	depends on NETWORK_PHY_TIMESTAMPING
-	depends on HAS_IOMEM
-	depends on PHYLIB
-	depends on PTP_1588_CLOCK
-	help
-	  This driver adds support for using the ZHAW InES 1588 IP
-	  core.  This clock is only useful if the MII bus of your MAC
-	  is wired up to the core.
-
-config PTP_1588_CLOCK_PCH
-	tristate "Intel PCH EG20T as PTP clock"
-	depends on MIPS_GENERIC || X86_32 || COMPILE_TEST
-	depends on HAS_IOMEM && PCI
-	depends on NET
-	depends on PTP_1588_CLOCK
-	help
-	  This driver adds support for using the PCH EG20T as a PTP
-	  clock. The hardware supports time stamping of PTP packets
-	  when using the end-to-end delay (E2E) mechanism. The peer
-	  delay mechanism (P2P) is not supported.
-
-	  This clock is only useful if your PTP programs are getting
-	  hardware time stamps on the PTP Ethernet packets using the
-	  SO_TIMESTAMPING API.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_pch.
-
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
-config PTP_1588_CLOCK_IDT82P33
-	tristate "IDT 82P33xxx PTP clock"
-	depends on PTP_1588_CLOCK && I2C
-	default n
-	help
-	  This driver adds support for using the IDT 82P33xxx as a PTP
-	  clock. This clock is only useful if your time stamping MAC
-	  is connected to the IDT chip.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_idt82p33.
-
-config PTP_1588_CLOCK_IDTCM
-	tristate "IDT CLOCKMATRIX as PTP clock"
-	depends on PTP_1588_CLOCK && I2C
-	default n
-	help
-	  This driver adds support for using IDT CLOCKMATRIX(TM) as a PTP
-	  clock. This clock is only useful if your time stamping MAC
-	  is connected to the IDT chip.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_clockmatrix.
-
-config PTP_1588_CLOCK_FC3W
-	tristate "RENESAS FemtoClock3 Wireless as PTP clock"
-	depends on PTP_1588_CLOCK && I2C
-	default n
-	help
-	  This driver adds support for using Renesas FemtoClock3 Wireless
-	  as a PTP clock. This clock is only useful if your time stamping
-	  MAC is connected to the RENESAS chip.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_fc3.
-
-config PTP_1588_CLOCK_MOCK
-	tristate "Mock-up PTP clock"
-	depends on PTP_1588_CLOCK
-	help
-	  This driver offers a set of PTP clock manipulation operations over
-	  the system monotonic time. It can be used by virtual network device
-	  drivers to emulate PTP capabilities.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_mock.
-
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
-config PTP_1588_CLOCK_OCP
-	tristate "OpenCompute TimeCard as PTP clock"
-	depends on PTP_1588_CLOCK
-	depends on HAS_IOMEM && PCI
-	depends on I2C && MTD
-	depends on SERIAL_8250
-	depends on !S390
-	depends on COMMON_CLK
-	select NET_DEVLINK
-	select CRC16
-	select DPLL
-	help
-	  This driver adds support for an OpenCompute time card.
-
-	  The OpenCompute time card is an atomic clock along with
-	  a GPS receiver that provides a Grandmaster clock source
-	  for a PTP enabled network.
-
-	  More information is available at http://www.timingcard.com/
-
-config PTP_DFL_TOD
-	tristate "FPGA DFL ToD Driver"
-	depends on FPGA_DFL
-	depends on PTP_1588_CLOCK
-	help
-	  The DFL (Device Feature List) device driver for the Intel ToD
-	  (Time-of-Day) device in FPGA card. The ToD IP within the FPGA
-	  is exposed as PTP Hardware Clock (PHC) device to the Linux PTP
-	  stack to synchronize the system clock to its ToD information
-	  using phc2sys utility of the Linux PTP stack.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called ptp_dfl_tod.
-
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
-config PTP_NETC_V4_TIMER
-	tristate "NXP NETC V4 Timer PTP Driver"
-	depends on PTP_1588_CLOCK
-	depends on PCI_MSI
-	help
-	  This driver adds support for using the NXP NETC V4 Timer as a PTP
-	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
-	  synchronization. It also supports periodic output signal (e.g. PPS)
-	  and external trigger timestamping.
+source "drivers/ptp/ieee1588/Kconfig"
+source "drivers/ptp/emulated/Kconfig"
 
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index bdc47e284f14..740443a8d419 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -1,24 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for PTP 1588 clock support.
+# Makefile for PTP clock support.
 #
 
-ptp-y					:= ptp_clock.o ptp_chardev.o ptp_sysfs.o ptp_vclock.o
-ptp_kvm-$(CONFIG_X86)			:= ptp_kvm_x86.o ptp_kvm_common.o
-ptp_kvm-$(CONFIG_HAVE_ARM_SMCCC)	:= ptp_kvm_arm.o ptp_kvm_common.o
-obj-$(CONFIG_PTP_1588_CLOCK)		+= ptp.o
-obj-$(CONFIG_PTP_1588_CLOCK_DTE)	+= ptp_dte.o
-obj-$(CONFIG_PTP_1588_CLOCK_INES)	+= ptp_ines.o
-obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
-obj-$(CONFIG_PTP_1588_CLOCK_KVM)	+= ptp_kvm.o
-obj-$(CONFIG_PTP_1588_CLOCK_VMCLOCK)	+= ptp_vmclock.o
-obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
-obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
-obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
-obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
-obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
-obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
-obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
-obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
-obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
-obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
+subdir-ccflags-y += -I$(srctree)/drivers/ptp
+
+ptp-y				:= ptp_clock.o ptp_chardev.o ptp_sysfs.o ptp_vclock.o
+obj-$(CONFIG_PTP_1588_CLOCK)	+= ptp.o
+obj-$(CONFIG_PTP_1588_CLOCK)	+= emulated/
+obj-$(CONFIG_PTP_1588_CLOCK)	+= ieee1588/
diff --git a/drivers/ptp/emulated/Kconfig b/drivers/ptp/emulated/Kconfig
new file mode 100644
index 000000000000..7fc5c5172e6b
--- /dev/null
+++ b/drivers/ptp/emulated/Kconfig
@@ -0,0 +1,81 @@
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
+config PTP_1588_CLOCK_OCP
+	tristate "OpenCompute TimeCard as PTP clock"
+	depends on PTP_1588_CLOCK
+	depends on HAS_IOMEM && PCI
+	depends on I2C && MTD
+	depends on SERIAL_8250
+	depends on !S390
+	depends on COMMON_CLK
+	select NET_DEVLINK
+	select CRC16
+	select DPLL
+	help
+	  This driver adds support for an OpenCompute time card.
+
+	  The OpenCompute time card is an atomic clock along with
+	  a GPS receiver that provides a Grandmaster clock source
+	  for a PTP enabled network.
+
+	  More information is available at http://www.timingcard.com/
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
index 000000000000..33c64cb1ab83
--- /dev/null
+++ b/drivers/ptp/emulated/Makefile
@@ -0,0 +1,12 @@
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
+obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
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
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/emulated/ptp_ocp.c
similarity index 100%
rename from drivers/ptp/ptp_ocp.c
rename to drivers/ptp/emulated/ptp_ocp.c
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
diff --git a/drivers/ptp/ieee1588/Kconfig b/drivers/ptp/ieee1588/Kconfig
new file mode 100644
index 000000000000..71d8e1596104
--- /dev/null
+++ b/drivers/ptp/ieee1588/Kconfig
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# IEEE 1588 PTP clock drivers configuration
+#
+
+menu "IEEE 1588 network-oriented PTP clock drivers"
+
+config PTP_1588_CLOCK_DTE
+	tristate "Broadcom DTE as PTP clock"
+	depends on PTP_1588_CLOCK
+	depends on NET && HAS_IOMEM
+	depends on ARCH_BCM_MOBILE || (ARCH_BCM_IPROC && !(ARCH_BCM_NSP || ARCH_BCM_5301X)) || COMPILE_TEST
+	default y if ARCH_BCM_MOBILE || ARCH_BCM_IPROC
+	help
+	  This driver adds support for using the Digital timing engine
+	  (DTE) in the Broadcom SoC's as a PTP clock.
+
+	  The clock can be used in both wired and wireless networks
+	  for PTP purposes.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_dte.
+
+config PTP_1588_CLOCK_QORIQ
+	tristate "Freescale QorIQ 1588 timer as PTP clock"
+	depends on GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF || COMPILE_TEST
+	depends on PTP_1588_CLOCK
+	default y if GIANFAR || FSL_DPAA_ETH || FSL_DPAA2_ETH || FSL_ENETC || FSL_ENETC_VF
+	help
+	  This driver adds support for using the Freescale QorIQ 1588
+	  timer as a PTP clock. This clock is only useful if your PTP
+	  programs are getting hardware time stamps on the PTP Ethernet
+	  packets using the SO_TIMESTAMPING API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_qoriq.
+
+comment "Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks."
+	depends on PHYLIB=n || NETWORK_PHY_TIMESTAMPING=n
+
+config DP83640_PHY
+	tristate "Driver for the National Semiconductor DP83640 PHYTER"
+	depends on NETWORK_PHY_TIMESTAMPING
+	depends on PHYLIB
+	depends on PTP_1588_CLOCK
+	select CRC32
+	help
+	  Supports the DP83640 PHYTER with IEEE 1588 features.
+
+	  This driver adds support for using the DP83640 as a PTP
+	  clock. This clock is only useful if your PTP programs are
+	  getting hardware time stamps on the PTP Ethernet packets
+	  using the SO_TIMESTAMPING API.
+
+	  In order for this to work, your MAC driver must also
+	  implement the skb_tx_timestamp() function.
+
+config PTP_1588_CLOCK_INES
+	tristate "ZHAW InES PTP time stamping IP core"
+	depends on NETWORK_PHY_TIMESTAMPING
+	depends on HAS_IOMEM
+	depends on PHYLIB
+	depends on PTP_1588_CLOCK
+	help
+	  This driver adds support for using the ZHAW InES 1588 IP
+	  core.  This clock is only useful if the MII bus of your MAC
+	  is wired up to the core.
+
+config PTP_1588_CLOCK_PCH
+	tristate "Intel PCH EG20T as PTP clock"
+	depends on MIPS_GENERIC || X86_32 || COMPILE_TEST
+	depends on HAS_IOMEM && PCI
+	depends on NET
+	depends on PTP_1588_CLOCK
+	help
+	  This driver adds support for using the PCH EG20T as a PTP
+	  clock. The hardware supports time stamping of PTP packets
+	  when using the end-to-end delay (E2E) mechanism. The peer
+	  delay mechanism (P2P) is not supported.
+
+	  This clock is only useful if your PTP programs are getting
+	  hardware time stamps on the PTP Ethernet packets using the
+	  SO_TIMESTAMPING API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_pch.
+
+config PTP_1588_CLOCK_IDT82P33
+	tristate "IDT 82P33xxx PTP clock"
+	depends on PTP_1588_CLOCK && I2C
+	default n
+	help
+	  This driver adds support for using the IDT 82P33xxx as a PTP
+	  clock. This clock is only useful if your time stamping MAC
+	  is connected to the IDT chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_idt82p33.
+
+config PTP_1588_CLOCK_IDTCM
+	tristate "IDT CLOCKMATRIX as PTP clock"
+	depends on PTP_1588_CLOCK && I2C
+	default n
+	help
+	  This driver adds support for using IDT CLOCKMATRIX(TM) as a PTP
+	  clock. This clock is only useful if your time stamping MAC
+	  is connected to the IDT chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_clockmatrix.
+
+config PTP_1588_CLOCK_FC3W
+	tristate "RENESAS FemtoClock3 Wireless as PTP clock"
+	depends on PTP_1588_CLOCK && I2C
+	default n
+	help
+	  This driver adds support for using Renesas FemtoClock3 Wireless
+	  as a PTP clock. This clock is only useful if your time stamping
+	  MAC is connected to the RENESAS chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_fc3.
+
+config PTP_1588_CLOCK_MOCK
+	tristate "Mock-up PTP clock"
+	depends on PTP_1588_CLOCK
+	help
+	  This driver offers a set of PTP clock manipulation operations over
+	  the system monotonic time. It can be used by virtual network device
+	  drivers to emulate PTP capabilities.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_mock.
+
+config PTP_DFL_TOD
+	tristate "FPGA DFL ToD Driver"
+	depends on FPGA_DFL
+	depends on PTP_1588_CLOCK
+	help
+	  The DFL (Device Feature List) device driver for the Intel ToD
+	  (Time-of-Day) device in FPGA card. The ToD IP within the FPGA
+	  is exposed as PTP Hardware Clock (PHC) device to the Linux PTP
+	  stack to synchronize the system clock to its ToD information
+	  using phc2sys utility of the Linux PTP stack.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_dfl_tod.
+
+config PTP_NETC_V4_TIMER
+	tristate "NXP NETC V4 Timer PTP Driver"
+	depends on PTP_1588_CLOCK
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC V4 Timer as a PTP
+	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
+	  synchronization. It also supports periodic output signal (e.g. PPS)
+	  and external trigger timestamping.
+
+endmenu
diff --git a/drivers/ptp/ieee1588/Makefile b/drivers/ptp/ieee1588/Makefile
new file mode 100644
index 000000000000..995ae90aa43c
--- /dev/null
+++ b/drivers/ptp/ieee1588/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for IEEE 1588 network-oriented PTP clocks.
+#
+
+obj-$(CONFIG_PTP_1588_CLOCK_DTE)	+= ptp_dte.o
+obj-$(CONFIG_PTP_1588_CLOCK_INES)	+= ptp_ines.o
+obj-$(CONFIG_PTP_1588_CLOCK_PCH)	+= ptp_pch.o
+obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+= ptp_qoriq.o
+obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
+obj-$(CONFIG_PTP_1588_CLOCK_FC3W)	+= ptp_fc3.o
+obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
+obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
+obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
+obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ieee1588/ptp_clockmatrix.c
similarity index 100%
rename from drivers/ptp/ptp_clockmatrix.c
rename to drivers/ptp/ieee1588/ptp_clockmatrix.c
diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ieee1588/ptp_clockmatrix.h
similarity index 100%
rename from drivers/ptp/ptp_clockmatrix.h
rename to drivers/ptp/ieee1588/ptp_clockmatrix.h
diff --git a/drivers/ptp/ptp_dfl_tod.c b/drivers/ptp/ieee1588/ptp_dfl_tod.c
similarity index 100%
rename from drivers/ptp/ptp_dfl_tod.c
rename to drivers/ptp/ieee1588/ptp_dfl_tod.c
diff --git a/drivers/ptp/ptp_dte.c b/drivers/ptp/ieee1588/ptp_dte.c
similarity index 100%
rename from drivers/ptp/ptp_dte.c
rename to drivers/ptp/ieee1588/ptp_dte.c
diff --git a/drivers/ptp/ptp_fc3.c b/drivers/ptp/ieee1588/ptp_fc3.c
similarity index 100%
rename from drivers/ptp/ptp_fc3.c
rename to drivers/ptp/ieee1588/ptp_fc3.c
diff --git a/drivers/ptp/ptp_fc3.h b/drivers/ptp/ieee1588/ptp_fc3.h
similarity index 100%
rename from drivers/ptp/ptp_fc3.h
rename to drivers/ptp/ieee1588/ptp_fc3.h
diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ieee1588/ptp_idt82p33.c
similarity index 100%
rename from drivers/ptp/ptp_idt82p33.c
rename to drivers/ptp/ieee1588/ptp_idt82p33.c
diff --git a/drivers/ptp/ptp_idt82p33.h b/drivers/ptp/ieee1588/ptp_idt82p33.h
similarity index 100%
rename from drivers/ptp/ptp_idt82p33.h
rename to drivers/ptp/ieee1588/ptp_idt82p33.h
diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ieee1588/ptp_ines.c
similarity index 100%
rename from drivers/ptp/ptp_ines.c
rename to drivers/ptp/ieee1588/ptp_ines.c
diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ieee1588/ptp_mock.c
similarity index 100%
rename from drivers/ptp/ptp_mock.c
rename to drivers/ptp/ieee1588/ptp_mock.c
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ieee1588/ptp_netc.c
similarity index 100%
rename from drivers/ptp/ptp_netc.c
rename to drivers/ptp/ieee1588/ptp_netc.c
diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ieee1588/ptp_pch.c
similarity index 100%
rename from drivers/ptp/ptp_pch.c
rename to drivers/ptp/ieee1588/ptp_pch.c
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ieee1588/ptp_qoriq.c
similarity index 100%
rename from drivers/ptp/ptp_qoriq.c
rename to drivers/ptp/ieee1588/ptp_qoriq.c
-- 
2.43.5

