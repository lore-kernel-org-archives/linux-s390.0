Return-Path: <linux-kernel-owner+w=401wt.eu-S1765932AbYCEL5c@vger.kernel.org>
Message-Id: <20080305115713.171047955@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:33 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/10] Update default configuration.
Content-Disposition: inline; filename=001-defconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig
+++ quilt-2.6/arch/s390/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.24
-# Sat Feb  9 12:13:01 2008
+# Linux kernel version: 2.6.25-rc4
+# Wed Mar  5 11:22:59 2008
 #
 CONFIG_MMU=y
 CONFIG_ZONE_DMA=y
@@ -43,12 +43,15 @@ CONFIG_CGROUPS=y
 # CONFIG_CGROUP_DEBUG is not set
 CONFIG_CGROUP_NS=y
 # CONFIG_CPUSETS is not set
+CONFIG_GROUP_SCHED=y
 CONFIG_FAIR_GROUP_SCHED=y
-CONFIG_FAIR_USER_SCHED=y
-# CONFIG_FAIR_CGROUP_SCHED is not set
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUP_CPUACCT is not set
 # CONFIG_RESOURCE_COUNTERS is not set
 CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
 CONFIG_NAMESPACES=y
 CONFIG_UTS_NS=y
@@ -85,7 +88,9 @@ CONFIG_SLAB=y
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 CONFIG_KPROBES=y
+CONFIG_KRETPROBES=y
 CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -185,6 +190,7 @@ CONFIG_IPL=y
 CONFIG_IPL_VM=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
+CONFIG_FORCE_MAX_ZONEORDER=9
 # CONFIG_PROCESS_DEBUG is not set
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
@@ -435,6 +441,7 @@ CONFIG_DASD_EER=y
 CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HAVE_IDE is not set
 
 #
 # SCSI device support
@@ -593,6 +600,7 @@ CONFIG_S390_VMUR=m
 #
 # Sonics Silicon Backplane
 #
+# CONFIG_MEMSTICK is not set
 
 #
 # File systems
@@ -750,7 +758,6 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_FRAME_POINTER is not set
-CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_KPROBES_SANITY_TEST is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
@@ -759,6 +766,7 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_LATENCYTOP is not set
 CONFIG_SAMPLES=y
 # CONFIG_SAMPLE_KOBJECT is not set
+# CONFIG_SAMPLE_KPROBES is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
 
 #

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
