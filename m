Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2451DF6C;
	Thu, 19 Sep 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772631; cv=none; b=VpTfMb/J7+KMISILFWjHlDEVMnmrAzYqLVJLWOuM2h25nyYyS9EZelaWmix2z9MdFUCS6TPiETZoATKxQpT90Sg+0toflXJmBneVpqtm641S8sQB4/Vml5HefI1+5aH6Ja7785zCGJLK1J+KYXUXzyW9VoDh9frd8THm7015Bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772631; c=relaxed/simple;
	bh=bM/svC/iQ9FSUuZsSXmjATJF5zh/+PN2M11vlVf8R/M=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=DIgpTqZpCtCtxIy6hIdVzkSGFkjThQR7XV0uQ0o5Ta0qrqofDVt/nBPWcMipBhLbYIAUHgtnpBXd1fdBrEPzWRx9RPdNfQjKGcWeYZTMFzpbe3H/lr5//WLBmFjLpyVdnxVzRD9ghz/7ohR+6YN3bovBYUZl8aa/h6P/txNrvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dOiZnXCD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dOiZnXCD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JIxb9k018250;
	Thu, 19 Sep 2024 19:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=g5tt/D/6bcy2LR5fr8tc/g7HLwDfD5wyl/gZ/Ru3PbY=; b=dOiZnXCDwdWC
	MQtOI2yvW/3XNlWUdOnTvu34JvCFe6HbWitoJzGKiUzjG7Mnktqakre5n17gvn9+
	LyiaG4ZgKE1c5ltVfTl3UTIhc+el/bccxWoq4Du+XVaV423sJKceVSx1Ecrth6AW
	9G3/9TGKdU9AEqxh+d4M806cXdQkZq1cCSNPxDg65g6URm+ohambFBGHPqYiYC28
	xj+4qvrjjIWldhsrBCGTrcHIRnWuVswvJ/evzwzpiUsxe1ejEyRrTvPJ53OxZIMJ
	uHTuuX2zM2qUyoHUsfqwHS4VwJdSXgR8AiJoSmL1/ph/EyYpE4IC9KzPiwnA51De
	dA5eHX1CcQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vp6syd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 19:03:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48JIvanw000641;
	Thu, 19 Sep 2024 19:03:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn71k98g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 19:03:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48JJ3eAM57606456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 19:03:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 913BA20043;
	Thu, 19 Sep 2024 19:03:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 170AE20040;
	Thu, 19 Sep 2024 19:03:40 +0000 (GMT)
Received: from localhost (unknown [9.171.81.188])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Sep 2024 19:03:40 +0000 (GMT)
Date: Thu, 19 Sep 2024 21:03:36 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 6.12 merge window
Message-ID: <Zux1iMM-bKAyyCUi@localhost>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nEY1-FtEcfBhDKtY_cGmyt9mFn9jAR_4
X-Proofpoint-GUID: nEY1-FtEcfBhDKtY_cGmyt9mFn9jAR_4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_18,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409190127

Hello Linus,

Please pull s390 changes for 6.12. There are 2 conflicts:
1. Conflict in arch/s390/include/asm/facility.h:
   The random number generator tree (already pulled) contains the s390
   vDSO getrandom implementation, which is based on and includes the same
   commit, 26d4959681e3 ("s390/facility: Disable compile-time optimization
   for decompressor code"), as was previously included in the s390 tree,
   hence the conflict. For details, please see:
   https://lore.kernel.org/all/20240913130544.2398678-1-hca@linux.ibm.com/
   The s390 tree doesn't have any other changes to
   arch/s390/include/asm/facility.h, so please just stick to what's
   already in your branch.

2. The mm tree (not yet pulled as of now) contains commit 590b9d576cae
   ("mm: kvmalloc: align kvrealloc() with krealloc()"), which, when
   pulled, would result in s390 build failure. Please apply the
   following fix-up, if possible, to avoid build breakage.
   Reported by linux-next maintainer:
   https://lore.kernel.org/all/20240808135836.740effac@canb.auug.org.au/
---
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9e2dc42143b3..fa54f3bc0c8d 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -256,7 +256,7 @@ static int add_marker(unsigned long start, unsigned long end, const char *name)
        if (!oldsize)
                markers = kvmalloc(newsize, GFP_KERNEL);
        else
-               markers = kvrealloc(markers, oldsize, newsize, GFP_KERNEL);
+               markers = kvrealloc(markers, newsize, GFP_KERNEL);
        if (!markers)
                goto error;
        markers[markers_cnt].is_start = 1;
-- 

Thank you,
Vasily

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.12-1

for you to fetch changes up to 9fed8d7c46f37151037334ef5e8b30b945baaceb:

  s390/crypto: Display Query and Query Authentication Information in sysfs (2024-09-12 14:13:27 +0200)

----------------------------------------------------------------
s390 updates for 6.12 merge window

- Optimize ftrace and kprobes code patching and avoid stop machine for
  kprobes if sequential instruction fetching facility is available

- Add hiperdispatch feature to dynamically adjust CPU capacity in
  vertical polarization to improve scheduling efficiency and overall
  performance. Also add infrastructure for handling warning track
  interrupts (WTI), allowing for graceful CPU preemption

- Rework crypto code pkey module and split it into separate, independent
  modules for sysfs, PCKMO, CCA, and EP11, allowing modules to load only
  when the relevant hardware is available

- Add hardware acceleration for HMAC modes and the full AES-XTS cipher,
  utilizing message-security assist extensions (MSA) 10 and 11. It
  introduces new shash implementations for HMAC-SHA224/256/384/512 and
  registers the hardware-accelerated AES-XTS cipher as the preferred
  option. Also add clear key token support

- Add MSA 10 and 11 processor activity instrumentation counters to perf
  and update PAI Extension 1 NNPA counters

- Cleanup cpu sampling facility code and rework debug/WARN_ON_ONCE
  statements

- Add support for SHA3 performance enhancements introduced with MSA 12

- Add support for the query authentication information feature of
  MSA 13 and introduce the KDSA CPACF instruction. Provide query and query
  authentication information in sysfs, enabling tools like cpacfinfo to
  present this data in a human-readable form

- Update kernel disassembler instructions

- Always enable EXPOLINE_EXTERN if supported by the compiler to ensure
  kpatch compatibility

- Add missing warning handling and relocated lowcore support to the
  early program check handler

- Optimize ftrace_return_address() and avoid calling unwinder

- Make modules use kernel ftrace trampolines

- Strip relocs from the final vmlinux ELF file to make it roughly 2
  times smaller

- Dump register contents and call trace for early crashes to the console

- Generate ptdump address marker array dynamically

- Fix rcu_sched stalls that might occur when adding or removing large
  amounts of pages at once to or from the CMM balloon

- Fix deadlock caused by recursive lock of the AP bus scan mutex

- Unify sync and async register save areas in entry code

- Cleanup debug prints in crypto code

- Various cleanup and sanitizing patches for the decompressor

- Various small ftrace cleanups

----------------------------------------------------------------
Finn Callies (4):
      s390/crypto: Add KDSA CPACF Instruction
      s390/crypto: Rework RRE and RRF CPACF inline functions
      s390/crypto: Add Support for Query Authentication Information
      s390/crypto: Display Query and Query Authentication Information in sysfs

Gaosheng Cui (1):
      s390/hypfs: Remove obsoleted declaration for hypfs_dbfs_exit

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Harald Freudenberger (9):
      s390/pkey: Split pkey_unlocked_ioctl function
      s390/pkey: Rework and split PKEY kernel module code
      s390/pkey: Unify pkey cca, ep11 and pckmo functions signatures
      s390/pkey: Introduce pkey base with handler registry and handler modules
      s390/pkey: Add slowpath function to CCA and EP11 handler
      s390/pkey: Add function to enforce pkey handler modules load
      s390/ap: Fix deadlock caused by recursive lock of the AP bus scan mutex
      s390/cpacf: Add MSA 10 and 11 new PCKMO functions
      s390/pkey: Add AES xts and HMAC clear key token support

Heiko Carstens (16):
      s390/mm/ptdump: Generate address marker array dynamically
      s390/entry: Move early program check handler to entry.S
      s390/entry: Make early program check handler relocated lowcore aware
      s390/traps: Handle early warnings gracefully
      s390/entry: Move early_pgm_check_handler() to init text section
      s390/early: Add __init to __do_early_pgm_check()
      s390/early: Dump register contents and call trace for early crashes
      s390/als: Remove obsolete comment
      s390/boot: Increase minimum architecture to z10
      s390/facility: Disable compile time optimization for decompressor code
      s390: Provide MARCH_HAS_*_FEATURES defines
      s390: Use MARCH_HAS_*_FEATURES defines
      s390/boot: Compile all files with the same march flag
      s390/boot: Rename decompressor_printk() to boot_printk()
      s390/boot: Use boot_printk() instead of sclp_early_printk()
      s390/boot: Move boot_printk() code to own file

Holger Dengler (7):
      s390/ap_bus: Cleanup debug code
      s390/ap_queue: Cleanup debug code
      s390/zcrypt_api: Cleanup debug code
      s390/zcrypt_msgtype50: Cleanup debug code
      s390/zcrypt_msgtype6: Cleanup debug code
      s390/crypto: Add hardware acceleration for full AES-XTS mode
      s390/crypto: Add hardware acceleration for HMAC modes

Ingo Franzki (1):
      s390/sha3: Fix SHA3 selftests failures

Jens Remus (4):
      s390/build: Avoid relocation information in final vmlinux
      s390/disassembler: Use proper format specifiers for operand values
      s390/disassembler: Update instruction mnemonics to latest spec
      s390/disassembler: Remove duplicate instruction format RSY_RDRU

Joerg Schmidbauer (1):
      s390/sha3: Support sha3 performance enhancements

Mete Durlu (8):
      s390/hypfs_diag: Remove unused dentry variable
      s390/smp: Add cpu capacities
      s390/hiperdispatch: Introduce hiperdispatch
      s390/hiperdispatch: Add steal time averaging
      s390/hiperdispatch: Add trace events
      s390/hiperdispatch: Add hiperdispatch sysctl interface
      s390/hiperdispatch: Add hiperdispatch debug attributes
      s390/hiperdispatch: Add hiperdispatch debug counters

Sven Schnelle (1):
      s390/entry: Unify save_area_sync and save_area_async

Thomas Richter (15):
      s390/cpum_sf: Use refcount_t instead of atomic_t
      s390/cpum_sf: Remove unused define PERF_CPUM_SF_MODE_MASK
      s390/cpum_sf: Remove unused defines REG_NONE and REG_OVERFLOW
      s390/cpum_sf: Rename macro to consistent prefix
      s390/cpum_sf: Move defines from header file to source file
      s390/cpum_cf: Move defines from header file to source file
      s390/cpum_sf: Use hwc as variable consistently
      s390/cpum_sf: Define and initialize variable
      s390/cpum_sf: Use variable name cpuhw consistently
      s390/cpum_sf: Ignore lsctl() return code in sf_disable()
      s390/cpum_sf: Ignore qsi() return code
      s390/cpum_sf: Rework debug_sprintf_event() messages
      s390/cpum_sf: Remove WARN_ON_ONCE statements
      s390/pai_crypto: Add support for MSA 10 and 11 pai counters
      s390/pai_ext: Update PAI extension 1 counters

Tobias Huschle (6):
      s390/wti: Introduce infrastructure for warning track interrupt
      s390/wti: Prepare graceful CPU pre-emption on wti reception
      s390/wti: Add wti accounting for missed grace periods
      s390/wti: Add debugfs file to display missed grace periods per cpu
      s390/topology: Add sysctl handler for polarization
      s390/topology: Add config option to switch to vertical during boot

Vasily Gorbik (10):
      s390/ftrace: Remove unused ftrace_plt_template*
      s390/ftrace: Use kernel ftrace trampoline for modules
      s390/ftrace: Avoid calling unwinder in ftrace_return_address()
      s390: Always enable EXPOLINE_EXTERN if supported
      s390/disassembler: Add instructions
      s390/setup: Recognize sequential instruction fetching facility
      s390/kprobes: Avoid stop machine if possible
      s390/ftrace: Avoid trampolines if possible
      s390/ftrace: Use get/copy_from_kernel_nofault consistently
      s390/ftrace: Avoid extra serialization for graph caller patching

 arch/s390/Kconfig                           |   36 +-
 arch/s390/Makefile.postlink                 |   38 +
 arch/s390/boot/Makefile                     |   34 +-
 arch/s390/boot/als.c                        |   49 +-
 arch/s390/boot/boot.h                       |    2 +-
 arch/s390/boot/head.S                       |    4 +-
 arch/s390/boot/ipl_parm.c                   |    2 +-
 arch/s390/boot/kaslr.c                      |    2 +-
 arch/s390/boot/pgm_check_info.c             |  160 +-
 arch/s390/boot/physmem_info.c               |   26 +-
 arch/s390/boot/printk.c                     |  124 ++
 arch/s390/boot/startup.c                    |    7 +-
 arch/s390/configs/debug_defconfig           |    4 +
 arch/s390/configs/defconfig                 |    4 +
 arch/s390/crypto/Kconfig                    |   10 +
 arch/s390/crypto/Makefile                   |    1 +
 arch/s390/crypto/aes_s390.c                 |  120 +-
 arch/s390/crypto/hmac_s390.c                |  359 ++++
 arch/s390/crypto/paes_s390.c                |    4 +-
 arch/s390/crypto/sha.h                      |    1 +
 arch/s390/crypto/sha3_256_s390.c            |   11 +-
 arch/s390/crypto/sha3_512_s390.c            |   11 +-
 arch/s390/crypto/sha_common.c               |   20 +-
 arch/s390/hypfs/hypfs.h                     |    1 -
 arch/s390/hypfs/hypfs_diag.c                |    7 +-
 arch/s390/include/asm/arch_hweight.h        |   15 +-
 arch/s390/include/asm/atomic_ops.h          |    7 +-
 arch/s390/include/asm/barrier.h             |    4 +-
 arch/s390/include/asm/cpacf.h               |  281 ++-
 arch/s390/include/asm/ctlreg.h              |    5 +-
 arch/s390/include/asm/diag.h                |    9 +
 arch/s390/include/asm/facility.h            |    6 +-
 arch/s390/include/asm/ftrace.h              |   17 +-
 arch/s390/include/asm/hiperdispatch.h       |   14 +
 arch/s390/include/asm/irq.h                 |    2 +
 arch/s390/include/asm/lowcore.h             |    4 +-
 arch/s390/include/asm/march.h               |   38 +
 arch/s390/include/asm/percpu.h              |    7 +-
 arch/s390/include/asm/perf_event.h          |   24 -
 arch/s390/include/asm/pkey.h                |    4 +-
 arch/s390/include/asm/preempt.h             |    7 +-
 arch/s390/include/asm/processor.h           |    1 +
 arch/s390/include/asm/sclp.h                |    1 +
 arch/s390/include/asm/setup.h               |    4 +
 arch/s390/include/asm/smp.h                 |    4 +
 arch/s390/include/asm/topology.h            |    3 +
 arch/s390/include/asm/trace/hiperdispatch.h |   58 +
 arch/s390/include/uapi/asm/pkey.h           |    5 +
 arch/s390/kernel/Makefile                   |    7 +-
 arch/s390/kernel/asm-offsets.c              |    3 +-
 arch/s390/kernel/cpacf.c                    |  119 ++
 arch/s390/kernel/diag.c                     |   17 +
 arch/s390/kernel/dis.c                      |   20 +-
 arch/s390/kernel/early.c                    |   38 +-
 arch/s390/kernel/early_printk.c             |   16 +-
 arch/s390/kernel/earlypgm.S                 |   23 -
 arch/s390/kernel/entry.S                    |   36 +-
 arch/s390/kernel/ftrace.c                   |  106 +-
 arch/s390/kernel/ftrace.h                   |    2 -
 arch/s390/kernel/hiperdispatch.c            |  430 ++++
 arch/s390/kernel/irq.c                      |    1 +
 arch/s390/kernel/kprobes.c                  |   15 +-
 arch/s390/kernel/mcount.S                   |    5 +-
 arch/s390/kernel/perf_cpum_cf.c             |    4 +
 arch/s390/kernel/perf_cpum_sf.c             |  309 +--
 arch/s390/kernel/perf_pai_crypto.c          |   16 +
 arch/s390/kernel/perf_pai_ext.c             |    9 +
 arch/s390/kernel/smp.c                      |   21 +
 arch/s390/kernel/stacktrace.c               |   19 -
 arch/s390/kernel/topology.c                 |   76 +-
 arch/s390/kernel/wti.c                      |  215 ++
 arch/s390/mm/cmm.c                          |   18 +-
 arch/s390/mm/dump_pagetables.c              |  191 +-
 arch/s390/tools/opcodes.txt                 |   52 +-
 drivers/crypto/Kconfig                      |   77 +-
 drivers/s390/char/sclp_early.c              |    1 +
 drivers/s390/crypto/Makefile                |   16 +-
 drivers/s390/crypto/ap_bus.c                |   59 +-
 drivers/s390/crypto/ap_queue.c              |   20 +-
 drivers/s390/crypto/pkey_api.c              | 2907 +++++++--------------------
 drivers/s390/crypto/pkey_base.c             |  362 ++++
 drivers/s390/crypto/pkey_base.h             |  195 ++
 drivers/s390/crypto/pkey_cca.c              |  629 ++++++
 drivers/s390/crypto/pkey_ep11.c             |  578 ++++++
 drivers/s390/crypto/pkey_pckmo.c            |  557 +++++
 drivers/s390/crypto/pkey_sysfs.c            |  648 ++++++
 drivers/s390/crypto/zcrypt_api.c            |   29 +-
 drivers/s390/crypto/zcrypt_ccamisc.c        |    8 +-
 drivers/s390/crypto/zcrypt_ccamisc.h        |    6 +-
 drivers/s390/crypto/zcrypt_ep11misc.c       |   28 +-
 drivers/s390/crypto/zcrypt_ep11misc.h       |   14 +-
 drivers/s390/crypto/zcrypt_msgtype50.c      |   10 +-
 drivers/s390/crypto/zcrypt_msgtype6.c       |   37 +-
 93 files changed, 6273 insertions(+), 3233 deletions(-)
 create mode 100644 arch/s390/Makefile.postlink
 create mode 100644 arch/s390/boot/printk.c
 create mode 100644 arch/s390/crypto/hmac_s390.c
 create mode 100644 arch/s390/include/asm/hiperdispatch.h
 create mode 100644 arch/s390/include/asm/march.h
 create mode 100644 arch/s390/include/asm/trace/hiperdispatch.h
 create mode 100644 arch/s390/kernel/cpacf.c
 delete mode 100644 arch/s390/kernel/earlypgm.S
 create mode 100644 arch/s390/kernel/hiperdispatch.c
 create mode 100644 arch/s390/kernel/wti.c
 create mode 100644 drivers/s390/crypto/pkey_base.c
 create mode 100644 drivers/s390/crypto/pkey_base.h
 create mode 100644 drivers/s390/crypto/pkey_cca.c
 create mode 100644 drivers/s390/crypto/pkey_ep11.c
 create mode 100644 drivers/s390/crypto/pkey_pckmo.c
 create mode 100644 drivers/s390/crypto/pkey_sysfs.c
