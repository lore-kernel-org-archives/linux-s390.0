Return-Path: <linux-kernel-owner+w=401wt.eu-S1756185AbYH0Oaf@vger.kernel.org>
Date: Wed, 27 Aug 2008 16:28:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] 2.6.27-rc5 updates for s390
Message-ID: <20080827142809.GA10087@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

This contains just two s390 specific build fixes.

Heiko Carstens (2):
      [S390] Fix linker script.
      [S390] dcss: fix build bug.

 arch/s390/kernel/vmlinux.lds.S |    2 +-
 drivers/s390/block/dcssblk.c   |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 76c1e60..607bd67 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -55,7 +55,7 @@ SECTIONS
 		__start___ex_table = .;
 		*(__ex_table)
 		__stop___ex_table = .;
-	}
+	} :data
 
 	.data : {		/* Data */
 		DATA_DATA
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index db85f1f..711b300 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -384,9 +384,10 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	 * get minor, add to list
 	 */
 	down_write(&dcssblk_devices_sem);
-	if (dcssblk_get_segment_by_name(local_buf)) {
+	if (dcssblk_get_device_by_name(local_buf)) {
+		up_write(&dcssblk_devices_sem);
 		rc = -EEXIST;
-		goto release_gd;
+		goto unload_seg;
 	}
 	rc = dcssblk_assign_free_minor(dev_info);
 	if (rc) {
