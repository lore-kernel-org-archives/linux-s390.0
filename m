Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726120AbfJZKPI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Oct 2019 06:15:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9QAC0eS082681
        for <linux-s390@vger.kernel.org>; Sat, 26 Oct 2019 06:15:07 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vvhetbyd3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 26 Oct 2019 06:15:06 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 26 Oct 2019 11:15:04 +0100
Date: Sat, 26 Oct 2019 12:14:58 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.4-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Message-Id: <your-ad-here.call-01572084898-ext-1277@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.4-rc5.

Thank you,
Vasily

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-5

for you to fetch changes up to ac49303d9ef0ad98b79867a380ef23480e48870b:

  s390/kaslr: add support for R_390_GLOB_DAT relocation type (2019-10-22 17:55:51 +0200)

----------------------------------------------------------------
s390 updates for 5.4-rc5

- Add R_390_GLOB_DAT relocation type support. This fixes boot problem
  on linux-next.

- Fix memory leak in zcrypt.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/kaslr: add support for R_390_GLOB_DAT relocation type

Johan Hovold (1):
      s390/zcrypt: fix memleak at release

 arch/s390/boot/startup.c               | 14 +++++++++++---
 arch/s390/kernel/machine_kexec_reloc.c |  1 +
 drivers/s390/crypto/zcrypt_api.c       |  3 +--
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 596ca7cc4d7b..5367950510f6 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -101,10 +101,18 @@ static void handle_relocs(unsigned long offset)
 	dynsym = (Elf64_Sym *) vmlinux.dynsym_start;
 	for (rela = rela_start; rela < rela_end; rela++) {
 		loc = rela->r_offset + offset;
-		val = rela->r_addend + offset;
+		val = rela->r_addend;
 		r_sym = ELF64_R_SYM(rela->r_info);
-		if (r_sym)
-			val += dynsym[r_sym].st_value;
+		if (r_sym) {
+			if (dynsym[r_sym].st_shndx != SHN_UNDEF)
+				val += dynsym[r_sym].st_value + offset;
+		} else {
+			/*
+			 * 0 == undefined symbol table index (STN_UNDEF),
+			 * used for R_390_RELATIVE, only add KASLR offset
+			 */
+			val += offset;
+		}
 		r_type = ELF64_R_TYPE(rela->r_info);
 		rc = arch_kexec_do_relocs(r_type, (void *) loc, val, 0);
 		if (rc)
diff --git a/arch/s390/kernel/machine_kexec_reloc.c b/arch/s390/kernel/machine_kexec_reloc.c
index 3b664cb3ec4d..d5035de9020e 100644
--- a/arch/s390/kernel/machine_kexec_reloc.c
+++ b/arch/s390/kernel/machine_kexec_reloc.c
@@ -27,6 +27,7 @@ int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 		*(u32 *)loc = val;
 		break;
 	case R_390_64:		/* Direct 64 bit.  */
+	case R_390_GLOB_DAT:
 		*(u64 *)loc = val;
 		break;
 	case R_390_PC16:	/* PC relative 16 bit.	*/
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 45bdb47f84c1..9157e728a362 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -522,8 +522,7 @@ static int zcrypt_release(struct inode *inode, struct file *filp)
 	if (filp->f_inode->i_cdev == &zcrypt_cdev) {
 		struct zcdn_device *zcdndev;
 
-		if (mutex_lock_interruptible(&ap_perms_mutex))
-			return -ERESTARTSYS;
+		mutex_lock(&ap_perms_mutex);
 		zcdndev = find_zcdndev_by_devt(filp->f_inode->i_rdev);
 		mutex_unlock(&ap_perms_mutex);
 		if (zcdndev) {
