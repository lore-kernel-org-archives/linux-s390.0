Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90006C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA2161131
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 18:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKEShf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:37:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232412AbhKEShf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Nov 2021 14:37:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5IXtgs024564;
        Fri, 5 Nov 2021 18:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=C2y5HtmorkOyBUCmKiDlpOuF8853EjDf33StaCTtLvs=;
 b=ppW/IzS1XXJ9jjMb82KvOvYXJILep2dJ2eppwtiibPK2H1xx6CpiIuy5pwV1X4X29cTX
 vUrSafqoD5JINe/Dj4pznCqvt7XllV1ahtJyrzrx/5DdBjIoL3hTKUmNLNm8xuIJmLKb
 M3Z5phP67yaUHHE8jHKi+0uIZ/gUMWJB5AtZnNTBplxuQltgNfpp8ne/VGMCeGqv5ud7
 VtMj31ozvglClDAJsIEw6stAF6lEZU1STytYxItPoL/rJ07zM6+T6sd93PUfjxczD2sh
 jYQ0HYnr+GEA5bFX5MxyaQagq3W5WfBC9sXUfhkT4tsYQ2ogZ4QTWMJasLIJLg6OWZvG OA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c56rnmjus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 18:34:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A5INJDB015965;
        Fri, 5 Nov 2021 18:34:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3c4t4dfahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 18:34:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A5IS3hx56361372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Nov 2021 18:28:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB44852057;
        Fri,  5 Nov 2021 18:34:31 +0000 (GMT)
Received: from localhost (unknown [9.171.82.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7A91F52051;
        Fri,  5 Nov 2021 18:34:31 +0000 (GMT)
Date:   Fri, 5 Nov 2021 19:34:30 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.16 merge window
Message-ID: <your-ad-here.call-01636137270-ext-1192@work.hours>
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9OwLbVSsoBuCyN_PK-BNuph5IbaNrpz7
X-Proofpoint-ORIG-GUID: 9OwLbVSsoBuCyN_PK-BNuph5IbaNrpz7
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 

Hello Linus,

please pull s390 changes for 5.16. There are 2 merge conflicts, please
see below.

An introduction of s390 ftrace with direct call and ftrace direct
call samples touches ftrace samples and arch/x86/Kconfig to pick new
HAVE_SAMPLE_FTRACE_DIRECT. There is also a conflict with ftrace tree (which
you've pulled already). To avoid a compile error for s390 could you please
apply this during the merge (it has been in linux-next as well
https://lore.kernel.org/all/YXAqZ%2FEszRisunQw@osiris/). Also attached as a
separate patch.
---
 arch/x86/Kconfig        | 1 +
 samples/Kconfig         | 3 +++
 samples/Makefile        | 1 +
 samples/ftrace/Makefile | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cdeb7df21480..4bcebf18d546 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -193,6 +193,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
+	select HAVE_SAMPLE_FTRACE_MULTI_DIRECT	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/samples/Kconfig b/samples/Kconfig
index 501f66309118..5518a3e62292 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -227,3 +227,6 @@ endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
 	bool
+
+config HAVE_SAMPLE_FTRACE_MULTI_DIRECT
+	bool
diff --git a/samples/Makefile b/samples/Makefile
index 087e0988ccc5..f06e59950193 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -21,6 +21,7 @@ subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
+obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace/
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
 subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index ab1d1c05c288..e8a3f8520a44 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
-obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
--

Another potential conflict according to linux-next is with Andrew's akpm
tree, which contains memblock changes:
"memblock: rename memblock_free to memblock_phys_free"
"memblock: use memblock_free for freeing virtual pointers"
The following resolution should be fine: 

diff --cc arch/s390/kernel/setup.c
index 27454962c119,e738a45057ac..40405f2304f1
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@@ -880,14 -878,12 +879,12 @@@ static void __init setup_randomness(voi
  {
  	struct sysinfo_3_2_2 *vmms;
  
- 	vmms = (struct sysinfo_3_2_2 *) memblock_phys_alloc(PAGE_SIZE,
- 							    PAGE_SIZE);
+ 	vmms = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
  	if (!vmms)
  		panic("Failed to allocate memory for sysinfo structure\n");
- 
  	if (stsi(vmms, 3, 2, 2) == 0 && vmms->count)
  		add_device_randomness(&vmms->vm, sizeof(vmms->vm[0]) * vmms->count);
- 	memblock_phys_free((unsigned long)vmms, PAGE_SIZE);
 -	memblock_free_ptr(vmms, PAGE_SIZE);
++	memblock_free(vmms, PAGE_SIZE);
  }
  
  /*
--

I also had to pull our fixes in, to resolve dependencies and avoid merge
conflict, hence there are couple of MAINTAINERS changes in the log,
you've already pulled with our last fixes.

Thank you,
Vasily

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-1

for you to fetch changes up to 622021cd6c560ce7aaaf7294a732177a30c9d65f:

  s390: make command line configurable (2021-10-26 15:21:31 +0200)

----------------------------------------------------------------
s390 updates for the 5.16 merge window

- Add support for ftrace with direct call and ftrace direct call samples.

- Add support for kernel command lines longer than current 896 bytes and
  make its length configurable.

- Add support for BEAR enhancement facility to improve last breaking
  event instruction tracking.

- Add kprobes sanity checks and testcases to prevent kprobe in the mid
  of an instruction.

- Allow concurrent access to /dev/hwc for the CPUMF users.

- Various ftrace / jump label improvements.

- Convert unwinder tests to KUnit.

- Add s390_iommu_aperture kernel parameter to tweak the limits on
  concurrently usable DMA mappings.

- Add ap.useirq AP module option which can be used to disable interrupt
  use.

- Add add_disk() error handling support to block device drivers.

- Drop arch specific and use generic implementation of strlcpy and strrchr.

- Several __pa/__va usages fixes.

- Various cio, crypto, pci, kernel doc and other small fixes and
  improvements all over the code.

----------------------------------------------------------------
Alexander Gordeev (8):
      s390/boot: initialize control registers in decompressor
      s390/boot: allocate amode31 section in decompressor
      s390/pgtable: use physical address for Page-Table Origin
      s390/cpcmd: use physical address for command and response
      s390/setup: use virtual address for STSI instruction
      s390/setup: use physical pointers for memblock_reserve()
      s390/setup: convert start and end initrd pointers to virtual
      s390/sclp: sort out physical vs virtual pointers usage

Andy Shevchenko (1):
      s390/cmm: use string_upper() instead of open coded variant

Cornelia Huck (2):
      KVM: s390: remove myself as reviewer
      vfio-ccw: step down as maintainer

Gerald Schaefer (1):
      s390/block/dcssblk: add error handling support for add_disk()

Halil Pasic (1):
      s390/cio: make ccw_device_dma_* more robust

Harald Freudenberger (4):
      s390/ap: Fix hanging ioctl caused by orphaned replies
      s390/zcrypt: rework of debug feature messages
      s390/ap: new module option ap.useirq
      s390/ap: function rework based on compiler warning

Heiko Carstens (25):
      s390/ftrace: remove dead code
      s390/barrier: factor out bcr_serialize()
      s390: introduce text_poke_sync()
      s390/jump_label: use text_poke_sync()
      s390/ftrace: use text_poke_sync_lock()
      s390/ftrace: add missing serialization for graph caller patching
      s390/jump_label: make use of HAVE_JUMP_LABEL_BATCH
      s390/jump_label: rename __jump_label_transform()
      s390/jump_label: add __init_or_module annotation
      s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_ARGS support
      s390/ftrace: add ftrace_instruction_pointer_set() helper function
      s390/ftrace: provide separate ftrace_caller/ftrace_regs_caller implementations
      s390/ptrace: fix coding style
      selftests/ftrace: add s390 support for kprobe args tests
      s390/ptrace: add function argument access API
      s390: add Alexander Gordeev as reviewer
      s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALL support
      s390: make STACK_FRAME_OVERHEAD available via asm-offsets.h
      samples: add HAVE_SAMPLE_FTRACE_DIRECT config option
      samples: add s390 support for ftrace direct call samples
      s390: update defconfigs
      s390/hmcdrv: fix kernel doc comments
      s390/string: use generic strrchr
      s390/string: use generic strlcpy
      s390/spinlock: remove incorrect kernel doc indicator

Huilong Deng (1):
      s390/bitops: return true/false (not 1/0) from bool functions

Luis Chamberlain (2):
      s390/block/dasd_genhd: add error handling support for add_disk()
      s390/block/scm_blk: add error handling support for add_disk()

Mete Durlu (1):
      s390/test_unwind: convert to KUnit

Niklas Schnelle (4):
      s390/pci: fix zpci_zdev_put() on reserve
      s390/pci: tolerate inconsistent handle in recover
      s390/pci: add simpler s390dbf traces for events
      s390/pci: add s390_iommu_aperture kernel parameter

Peter Oberparleiter (1):
      s390/sclp_sd: fix warnings about missing parameter description

Randy Dunlap (2):
      s390/sclp_vt220: fix unused function warning
      s390/debug: fix kernel-doc warnings

Roberto Sassu (1):
      s390: fix strrchr() implementation

Sven Schnelle (10):
      s390/kprobes: add sanity check
      s390/ftrace: add FTRACE_GEN_NOP_ASM macro
      kprobes: add testcases for s390
      s390/ptrace: add last_break member to pt_regs
      s390: rename last_break to pgm_last_break
      s390: introduce nospec_uses_trampoline()
      s390: add support for BEAR enhancement facility
      s390/kexec_file: move kernel image size check
      s390: support command lines longer than 896 bytes
      s390: make command line configurable

Thomas Richter (1):
      s390/cpumf: Allow multiple processes to access /dev/hwc

Tiezhu Yang (1):
      bpf, s390: Fix potential memory leak about jit_data

Tony Krowiak (1):
      s390/vfio-ap: s390/crypto: fix all kernel-doc warnings

Vasily Gorbik (1):
      Merge branch 'fixes' into features

Vineeth Vijayan (2):
      s390/cio: unregister the subchannel while purging
      s390/cio: derive cdev information only for IO-subchannels

 Documentation/admin-guide/kernel-parameters.txt    |  12 ++
 MAINTAINERS                                        |   3 +-
 arch/s390/Kconfig                                  |  26 +++
 arch/s390/boot/compressed/decompressor.h           |   1 +
 arch/s390/boot/head.S                              |  54 ++---
 arch/s390/boot/ipl_parm.c                          |   4 +-
 arch/s390/boot/pgm_check_info.c                    |   4 +-
 arch/s390/boot/startup.c                           |   8 +
 arch/s390/configs/debug_defconfig                  |   9 +-
 arch/s390/configs/defconfig                        |   6 +
 arch/s390/include/asm/barrier.h                    |  24 ++-
 arch/s390/include/asm/bitops.h                     |   2 +-
 arch/s390/include/asm/cpu.h                        |   3 +
 arch/s390/include/asm/debug.h                      |   2 +-
 arch/s390/include/asm/ftrace.h                     |  58 +++++-
 arch/s390/include/asm/jump_label.h                 |   2 +
 arch/s390/include/asm/livepatch.h                  |   4 +-
 arch/s390/include/asm/lowcore.h                    |   9 +-
 arch/s390/include/asm/nospec-branch.h              |   5 +
 arch/s390/include/asm/pci.h                        |   2 +
 arch/s390/include/asm/pgtable.h                    |  12 +-
 arch/s390/include/asm/ptrace.h                     |  23 ++-
 arch/s390/include/asm/sclp.h                       |   1 +
 arch/s390/include/asm/setup.h                      |   9 +-
 arch/s390/include/asm/string.h                     |   4 -
 arch/s390/include/asm/text-patching.h              |  16 ++
 arch/s390/include/uapi/asm/setup.h                 |  13 --
 arch/s390/kernel/alternative.c                     |  20 ++
 arch/s390/kernel/asm-offsets.c                     |   7 +-
 arch/s390/kernel/cpcmd.c                           |   6 +-
 arch/s390/kernel/dumpstack.c                       |   2 +-
 arch/s390/kernel/early.c                           |   3 +-
 arch/s390/kernel/entry.S                           |  45 +++-
 arch/s390/kernel/entry.h                           |   1 +
 arch/s390/kernel/ftrace.c                          |  96 ++-------
 arch/s390/kernel/head64.S                          |  18 --
 arch/s390/kernel/irq.c                             |  10 +-
 arch/s390/kernel/jump_label.c                      |  34 +--
 arch/s390/kernel/kprobes.c                         |  48 ++++-
 arch/s390/kernel/machine_kexec_file.c              |  35 ++--
 arch/s390/kernel/mcount.S                          |  64 ++++--
 arch/s390/kernel/nospec-branch.c                   |   2 +-
 arch/s390/kernel/nospec-sysfs.c                    |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                    | 228 ++++++++++++++-------
 arch/s390/kernel/process.c                         |   2 +-
 arch/s390/kernel/setup.c                           |  42 ++--
 arch/s390/kernel/syscall.c                         |   2 +
 arch/s390/kernel/traps.c                           |  10 +-
 arch/s390/kernel/vmlinux.lds.S                     |   1 +
 arch/s390/kvm/interrupt.c                          |   2 +-
 arch/s390/lib/Makefile                             |   2 +
 arch/s390/lib/spinlock.c                           |   2 +-
 arch/s390/lib/string.c                             |  46 -----
 arch/s390/lib/test_kprobes.c                       |  75 +++++++
 arch/s390/lib/test_kprobes.h                       |  10 +
 arch/s390/lib/test_kprobes_asm.S                   |  45 ++++
 arch/s390/lib/test_unwind.c                        | 169 ++++++++-------
 arch/s390/mm/cmm.c                                 |  11 +-
 arch/s390/mm/dump_pagetables.c                     |  14 +-
 arch/s390/mm/pageattr.c                            |   4 +-
 arch/s390/mm/vmem.c                                |  10 +-
 arch/s390/net/bpf_jit_comp.c                       |   8 +-
 arch/s390/pci/pci.c                                |  45 +++-
 arch/s390/pci/pci_dma.c                            |  25 ++-
 arch/s390/pci/pci_event.c                          |   8 +-
 arch/s390/pci/pci_sysfs.c                          |   8 +
 arch/x86/Kconfig                                   |   1 +
 drivers/pci/hotplug/s390_pci_hpc.c                 |   9 +-
 drivers/s390/block/dasd_genhd.c                    |  10 +-
 drivers/s390/block/dcssblk.c                       |   8 +-
 drivers/s390/block/scm_blk.c                       |   7 +-
 drivers/s390/char/sclp.c                           |  14 +-
 drivers/s390/char/sclp.h                           |   2 +-
 drivers/s390/char/sclp_early.c                     |   5 +
 drivers/s390/char/sclp_ftp.c                       |   3 +
 drivers/s390/char/sclp_sd.c                        |  11 +-
 drivers/s390/char/sclp_vt220.c                     |   4 +-
 drivers/s390/cio/css.c                             |   9 +-
 drivers/s390/cio/device.c                          |   2 +
 drivers/s390/cio/device_ops.c                      |  12 +-
 drivers/s390/crypto/ap_bus.c                       |  81 ++++----
 drivers/s390/crypto/ap_debug.h                     |   2 +-
 drivers/s390/crypto/ap_queue.c                     |   9 +-
 drivers/s390/crypto/vfio_ap_drv.c                  |  16 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |   5 +-
 drivers/s390/crypto/vfio_ap_private.h              |  43 ++--
 drivers/s390/crypto/zcrypt_api.c                   |  45 ++--
 drivers/s390/crypto/zcrypt_card.c                  |   8 +-
 drivers/s390/crypto/zcrypt_debug.h                 |   2 +-
 drivers/s390/crypto/zcrypt_error.h                 |  22 +-
 drivers/s390/crypto/zcrypt_msgtype50.c             |  18 +-
 drivers/s390/crypto/zcrypt_msgtype6.c              |  40 ++--
 drivers/s390/crypto/zcrypt_queue.c                 |  17 +-
 samples/Kconfig                                    |   5 +-
 samples/ftrace/ftrace-direct-modify.c              |  44 ++++
 samples/ftrace/ftrace-direct-too.c                 |  28 +++
 samples/ftrace/ftrace-direct.c                     |  28 +++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   3 +
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   4 +
 99 files changed, 1324 insertions(+), 671 deletions(-)
 create mode 100644 arch/s390/include/asm/text-patching.h
 create mode 100644 arch/s390/lib/test_kprobes.c
 create mode 100644 arch/s390/lib/test_kprobes.h
 create mode 100644 arch/s390/lib/test_kprobes_asm.S

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-samples-add-HAVE_SAMPLE_FTRACE_MULTI_DIRECT-config-o.patch"

From 3f7bbd84ff68df1af21c566bd8e18644fcc6a7c6 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 20 Oct 2021 16:40:39 +0200
Subject: [PATCH] samples: add HAVE_SAMPLE_FTRACE_MULTI_DIRECT config option

Add HAVE_SAMPLE_FTRACE_MULTI_DIRECT config option which can be selected
by architectures which have support for ftrace multi direct call samples.

Link: https://lore.kernel.org/all/YXAqZ%2FEszRisunQw@osiris/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/x86/Kconfig        | 1 +
 samples/Kconfig         | 3 +++
 samples/Makefile        | 1 +
 samples/ftrace/Makefile | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cdeb7df21480..4bcebf18d546 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -193,6 +193,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
+	select HAVE_SAMPLE_FTRACE_MULTI_DIRECT	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
diff --git a/samples/Kconfig b/samples/Kconfig
index 501f66309118..5518a3e62292 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -227,3 +227,6 @@ endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
 	bool
+
+config HAVE_SAMPLE_FTRACE_MULTI_DIRECT
+	bool
diff --git a/samples/Makefile b/samples/Makefile
index 087e0988ccc5..f06e59950193 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -21,6 +21,7 @@ subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
+obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace/
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
 subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index ab1d1c05c288..e8a3f8520a44 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -3,7 +3,7 @@
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
-obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-multi.o
+obj-$(CONFIG_SAMPLE_FTRACE_MULTI_DIRECT) += ftrace-direct-multi.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
-- 
2.25.4


--r5Pyd7+fXNt84Ff3--

