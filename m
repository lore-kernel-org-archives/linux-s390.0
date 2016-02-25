Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 09:30:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.5-rc6
Message-ID: <20160225093014.03aacf3d@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Two critical bug fixes for the signal handling.

Martin Schwidefsky (2):
      s390/compat: correct restore of high gprs on signal return
      s390/fpu: signals vs. floating point control register

 arch/s390/include/asm/fpu/internal.h | 2 ++
 arch/s390/kernel/compat_signal.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/fpu/internal.h b/arch/s390/include/asm/fpu/internal.h
index ea91ddf..629c908 100644
--- a/arch/s390/include/asm/fpu/internal.h
+++ b/arch/s390/include/asm/fpu/internal.h
@@ -40,6 +40,7 @@ static inline void convert_fp_to_vx(__vector128 *vxrs, freg_t *fprs)
 static inline void fpregs_store(_s390_fp_regs *fpregs, struct fpu *fpu)
 {
 	fpregs->pad = 0;
+	fpregs->fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_vx_to_fp((freg_t *)&fpregs->fprs, fpu->vxrs);
 	else
@@ -49,6 +50,7 @@ static inline void fpregs_store(_s390_fp_regs *fpregs, struct fpu *fpu)
 
 static inline void fpregs_load(_s390_fp_regs *fpregs, struct fpu *fpu)
 {
+	fpu->fpc = fpregs->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx(fpu->vxrs, (freg_t *)&fpregs->fprs);
 	else
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index 66c9441..4af6037 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -271,7 +271,7 @@ static int restore_sigregs_ext32(struct pt_regs *regs,
 
 	/* Restore high gprs from signal stack */
 	if (__copy_from_user(&gprs_high, &sregs_ext->gprs_high,
-			     sizeof(&sregs_ext->gprs_high)))
+			     sizeof(sregs_ext->gprs_high)))
 		return -EFAULT;
 	for (i = 0; i < NUM_GPRS; i++)
 		*(__u32 *)&regs->gprs[i] = gprs_high[i];
