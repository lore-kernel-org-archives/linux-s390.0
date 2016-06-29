Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Jun 2016 09:28:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.7-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160629092821.3ae6dd7b@mschwide>
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

Another two bug fixes for 4.7:

 - The revert of patch which removed boot information for systems using an
   intermediate boot kernel, e.g. the SLES12 grub setup.

 - A fix for an incorrect inline assembly constraint that causes broken
   code to be generated with gcc 4.8.5.

Martin Schwidefsky (1):
      s390: fix test_fp_ctl inline assembly contraints

Michael Holzheu (1):
      Revert "s390/kdump: Clear subchannel ID to signal non-CCW/SCSI IPL"

 arch/s390/include/asm/fpu/api.h | 2 +-
 arch/s390/kernel/ipl.c          | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/fpu/api.h b/arch/s390/include/asm/fpu/api.h
index 5e04f3c..8ae236b0 100644
--- a/arch/s390/include/asm/fpu/api.h
+++ b/arch/s390/include/asm/fpu/api.h
@@ -22,7 +22,7 @@ static inline int test_fp_ctl(u32 fpc)
 		"	la	%0,0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "=d" (rc), "=d" (orig_fpc)
+		: "=d" (rc), "=&d" (orig_fpc)
 		: "d" (fpc), "0" (-EINVAL));
 	return rc;
 }
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index f20abdb..d14069d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2064,12 +2064,5 @@ void s390_reset_system(void)
 	S390_lowcore.program_new_psw.addr =
 		(unsigned long) s390_base_pgm_handler;
 
-	/*
-	 * Clear subchannel ID and number to signal new kernel that no CCW or
-	 * SCSI IPL has been done (for kexec and kdump)
-	 */
-	S390_lowcore.subchannel_id = 0;
-	S390_lowcore.subchannel_nr = 0;
-
 	do_reset_calls();
 }
