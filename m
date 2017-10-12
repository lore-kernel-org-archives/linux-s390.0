Return-Path: <stable-owner@vger.kernel.org>
From: Dimitri John Ledkov <xnox@ubuntu.com>
Subject: [PATCH] s390: fix zfcpdump_defconfig failing to perform zfcpdump
Date: Thu, 12 Oct 2017 11:37:26 +0100
Message-Id: <1507804646-6197-1-git-send-email-xnox@ubuntu.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Dimitri John Ledkov <xnox@ubuntu.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

zipl from s390-tools generates root=/dev/ram0 kernel cmdline for
zfcpdump, thus BLK_DEV_RAM is required.

zfcpdump initrd mounts DEBUG_FS, thus it is also required.

Without above two options kernel images built with zfcpdump_defconfig
fail to perform zfcpdump. Affects v4.10+.

Bug-Ubuntu: https://launchpad.net/bugs/1722735
Bug-Ubuntu: https://launchpad.net/bugs/1719290

Cc: stable@vger.kernel.org
Signed-off-by: Dimitri John Ledkov <xnox@ubuntu.com>
---
 arch/s390/configs/zfcpdump_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index afa46a7..04e042e 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -27,6 +27,7 @@ CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_BLK_DEV_RAM=y
 # CONFIG_BLK_DEV_XPRAM is not set
 # CONFIG_DCSSBLK is not set
 # CONFIG_DASD is not set
@@ -59,6 +60,7 @@ CONFIG_CONFIGFS_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
-- 
2.7.4
