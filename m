Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Oct 2017 08:30:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.14-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171018083028.74f405c8@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Two bug fixes:

 * A fix for cputime accounting vs CPU hotplug

 * Add two options to zfcpdump_defconfig to make SCSI dump work again

Christian Borntraeger (1):
      s390/cputime: fix guest/irq/softirq times after CPU hotplug

Dimitri John Ledkov (1):
      s390: fix zfcpdump-config

 arch/s390/configs/zfcpdump_defconfig | 2 ++
 arch/s390/kernel/smp.c               | 3 +++
 2 files changed, 5 insertions(+)

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
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 1cee675..495ff69 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -293,7 +293,10 @@ static void pcpu_attach_task(struct pcpu *pcpu, struct task_struct *tsk)
 	lc->lpp = LPP_MAGIC;
 	lc->current_pid = tsk->pid;
 	lc->user_timer = tsk->thread.user_timer;
+	lc->guest_timer = tsk->thread.guest_timer;
 	lc->system_timer = tsk->thread.system_timer;
+	lc->hardirq_timer = tsk->thread.hardirq_timer;
+	lc->softirq_timer = tsk->thread.softirq_timer;
 	lc->steal_timer = 0;
 }
 
