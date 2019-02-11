Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 11 Feb 2019 08:04:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.0 #3
MIME-Version: 1.0
Message-Id: <20190211080436.13c3504f@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull s390 fixes for 5.0-rc7

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-3

for you to fetch changes up to 614db26954ff08fa8e92b04100e31ebc04b817cf:

  Revert "s390/pci: remove bit_lock usage in interrupt handler" (2019-02-07 11:56:29 +0100)

----------------------------------------------------------------
s390 update with bug fixes for 5.0-rc6

 - Fix specification exception on z196 during ap probe

 - A fix for suspend-to-disk, the VMAP stack patch broke the
   swsusp_arch_suspend function

 - The EMC CKD ioctl of the dasd driver needs an additional size
   check for user space data

 - Revert an incorrect patch for the PCI base code that removed
   a bit lock that turned out to be required after all

----------------------------------------------------------------
Harald Freudenberger (1):
      s390/zcrypt: fix specification exception on z196 during ap probe

Martin Schwidefsky (1):
      s390/suspend: fix stack setup in swsusp_arch_suspend

Sebastian Ott (1):
      Revert "s390/pci: remove bit_lock usage in interrupt handler"

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

 arch/s390/kernel/swsusp.S      | 4 ++--
 arch/s390/pci/pci.c            | 4 +++-
 drivers/s390/block/dasd_eckd.c | 8 ++++++++
 drivers/s390/crypto/ap_bus.c   | 3 ++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index 537f97f..b6796e6 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -30,10 +30,10 @@
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	lg	%r1,__LC_NODAT_STACK
-	aghi	%r1,-STACK_FRAME_OVERHEAD
 	stmg	%r6,%r15,__SF_GPRS(%r1)
+	aghi	%r1,-STACK_FRAME_OVERHEAD
 	stg	%r15,__SF_BACKCHAIN(%r1)
-	lgr	%r1,%r15
+	lgr	%r15,%r1
 
 	/* Store FPU registers */
 	brasl	%r14,save_fpu_regs
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index a966d7b..4266a4d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -382,7 +382,9 @@ static void zpci_irq_handler(struct airq_struct *airq)
 			if (ai == -1UL)
 				break;
 			inc_irq_stat(IRQIO_MSI);
+			airq_iv_lock(aibv, ai);
 			generic_handle_irq(airq_iv_get_data(aibv, ai));
+			airq_iv_unlock(aibv, ai);
 		}
 	}
 }
@@ -408,7 +410,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	zdev->aisb = aisb;
 
 	/* Create adapter interrupt vector */
-	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA);
+	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA | AIRQ_IV_BITLOCK);
 	if (!zdev->aibv)
 		return -ENOMEM;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 4e7b55a..6e294b4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4469,6 +4469,14 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 		usrparm.psf_data &= 0x7fffffffULL;
 		usrparm.rssd_result &= 0x7fffffffULL;
 	}
+	/* at least 2 bytes are accessed and should be allocated */
+	if (usrparm.psf_data_len < 2) {
+		DBF_DEV_EVENT(DBF_WARNING, device,
+			      "Symmetrix ioctl invalid data length %d",
+			      usrparm.psf_data_len);
+		rc = -EINVAL;
+		goto out;
+	}
 	/* alloc I/O data area */
 	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
 	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 48ea000..5a69974 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -248,7 +248,8 @@ static inline int ap_test_config(unsigned int *field, unsigned int nr)
 static inline int ap_test_config_card_id(unsigned int id)
 {
 	if (!ap_configuration)	/* QCI not supported */
-		return 1;
+		/* only ids 0...3F may be probed */
+		return id < 0x40 ? 1 : 0;
 	return ap_test_config(ap_configuration->apm, id);
 }
 
