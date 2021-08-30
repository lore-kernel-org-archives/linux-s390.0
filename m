Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C95C432BE
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 13:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45CF6023E
	for <linux-s390@archiver.kernel.org>; Mon, 30 Aug 2021 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhH3NMx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:12:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230119AbhH3NMx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Aug 2021 09:12:53 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17UD4laR026892;
        Mon, 30 Aug 2021 09:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=j7HKoz3fJyfb5LydSmYsiGMJ2oMkTJ8CjtoKAUkD7ro=;
 b=TE+FbRjDIzksaRp7Hb23k/5D3z4pHogoNBmO95hGlsTZBJVWnIxft+cAlwSRA3h6n9Uz
 BZ3GMCLVyKkiPBFFAzgNBkwoLI6Rrtzbp5QM51q4OEtzGUiE+ARK+juvnf+weV2EEKO/
 pdOQ4jEHusbt4zBLnDBBda4oZ3FSN31z8PefmW0NGHzKP/SwgnftbfDnoVA/XabWGpgO
 47nPUCJeuGyXm7jvQ8iepEOQjuuQj12ggQlYA27WDkCMIpVdMyDhT97rLfMcPH5xOhL2
 gaJPxGtJv1OhHcPkF57Qmw7AgN8930y8s/m8xXJ3BnTHimh/H9OTp4Ra6EKKOEdLgcW/ bA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ary141q7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 09:11:58 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17UDBaPT004506;
        Mon, 30 Aug 2021 13:11:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3aqcs8u1mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 13:11:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17UDBqhk53608786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 13:11:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9D8411C05B;
        Mon, 30 Aug 2021 13:11:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CE1C11C077;
        Mon, 30 Aug 2021 13:11:52 +0000 (GMT)
Received: from osiris (unknown [9.145.49.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Aug 2021 13:11:52 +0000 (GMT)
Date:   Mon, 30 Aug 2021 15:11:50 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.15 merge window
Message-ID: <YSzZFgBt6nMvpVgc@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2927kLiuflB4QyltkqxqkX2DB-oqajq1
X-Proofpoint-ORIG-GUID: 2927kLiuflB4QyltkqxqkX2DB-oqajq1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_05:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300090
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull s390 updates for the 5.15 merge window. There are some small
changes outside of s390, but everything has been agreed on (see provided
links below).

Thanks,
Heiko

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.15-1

for you to fetch changes up to 927932240aa1739ac8c92b142a5e2dcc490f36e0:

  s390: remove SCHED_CORE from defconfigs (2021-08-30 12:55:05 +0200)

----------------------------------------------------------------
s390 updates for 5.15 merge window

- Improve ftrace code patching so that stop_machine is not required anymore.
  This requires a small common code patch acked by Steven Rostedt:
  https://lore.kernel.org/linux-s390/20210730220741.4da6fdf6@oasis.local.home/

- Enable KCSAN for s390. This comes with a small common code change to fix a
  compile warning. Acked by Marco Elver:
  https://lore.kernel.org/r/20210729142811.1309391-1-hca@linux.ibm.com/

- Add KFENCE support for s390. This also comes with a minimal x86 patch from
  Marco Elver who said also this can be carried via the s390 tree:
  https://lore.kernel.org/linux-s390/YQJdarx6XSUQ1tFZ@elver.google.com/

- More changes to prepare the decompressor for relocation.

- Enable DAT also for CPU restart path.

- Final set of register asm removal patches; leaving only three locations where
  needed and sane.

- Add NNPA, Vector-Packed-Decimal-Enhancement Facility 2, PCI MIO support to
  hwcaps flags.

- Cleanup hwcaps implementation.

- Add new instructions to in-kernel disassembler.

- Various QDIO cleanups.

- Add SCLP debug feature.

- Various other cleanups and improvements all over the place.

----------------------------------------------------------------
Alexander Egorenkov (19):
      s390/boot: move all linker symbol declarations from c to h files
      s390/boot: make stacks part of the decompressor's image
      s390/cio: remove unused include linux/spinlock.h from cio.h
      s390/sclp: use only one sclp early buffer to send commands
      s390/boot: move uv function declarations to boot/uv.h
      s390/boot: disable Secure Execution in dump mode
      s390/uv: de-duplicate checks for Protected Host Virtualization
      s390/boot: get rid of magic numbers for startup offsets
      s390/boot: move sclp early buffer from fixed address in asm to C
      s390/boot: introduce boot data 'initrd_data'
      s390/dump: introduce boot data 'oldmem_data'
      s390/setup: remove unused symbolic constants for C code from setup.h
      s390/setup: drop _OFFSET macros
      s390/setup: generate asm offsets from struct parmarea
      s390/boot: move EP_OFFSET and EP_STRING to head.S
      s390/boot: make _diag308_reset_dma() position-independent
      s390/boot: move dma sections from decompressor to decompressed kernel
      s390/setup: don't reserve memory that occupied decompressor's head
      s390/sclp: reserve memory occupied by sclp early buffer

Alexander Gordeev (4):
      s390/kasan: fix large PMD pages address alignment check
      s390/boot: factor out offset_vmlinux_info() function
      s390/smp: enable DAT before CPU restart callback is called
      s390/smp: do not use nodat_stack for secondary CPU start

David Hildenbrand (1):
      s390/mm: remove unused cmma functions

Harald Freudenberger (2):
      s390/zcrypt: fix wrong offset index for APKA master key valid state
      s390/ap: fix state machine hang after failure to enable irq

Heiko Carstens (34):
      s390/mm: use pr_err() instead of printk() for pte_ERROR & friends
      s390/mm: don't print hashed values for pte_ERROR() & friends
      s390/jump_label: print real address in a case of a jump label bug
      s390/dasd: remove debug printk
      s390/debug: remove unused print defines
      s390/cpacf: get rid of register asm
      s390/syscall: provide generic system call functions
      s390/vdso: use system call functions
      s390/ctl_reg: add ctlreg5 and ctlreg15 unions
      s390: report more CPU capabilities
      s390/disassembler: add instructions
      s390/hwcaps: shorten HWCAP defines
      s390/hwcaps: introduce HWCAP bit numbers
      s390/hwcaps: use named initializers for hwcap string arrays
      s390/hwcaps: add sanity checks
      s390/hwcaps: move setup_hwcaps()
      s390/hwcaps: split setup_hwcaps()
      s390/hwcaps: open code initialization of first six hwcap bits
      s390/hwcaps: use consistent coding style / remove comments
      s390/hwcaps: remove z/Architecture mode active check
      s390/hwcaps: remove hwcap stfle check
      s390/hwcaps: make sie capability regular hwcap
      s390/boot: get rid of arithmetics on function pointers
      s390/delay: get rid of not needed header includes
      s390/mm: implement set_memory_4k()
      kcsan: use u64 instead of cycles_t
      s390/mm: use page_to_virt() in __kernel_map_pages()
      s390: rename dma section to amode31
      s390: fix typo in linker script
      s390/mm,pageattr: fix walk_pte_level() early exit
      s390/diag: make restart_part2 a local label
      KVM: s390: generate kvm hypercall functions
      s390: update defconfigs
      s390: remove SCHED_CORE from defconfigs

Ilya Leoshkevich (4):
      s390/headers: fix code style in module.h
      s390: enable KCSAN
      ftrace: Introduce ftrace_need_init_nop()
      s390/ftrace: implement hotpatching

Julian Wiedmann (18):
      s390/qdio: fix roll-back after timeout on ESTABLISH ccw
      s390/qdio: cancel the ESTABLISH ccw after timeout
      s390/qdio: improve roll-back after error on ESTABLISH ccw
      s390/qdio: propagate error when cancelling a ccw fails
      s390/qdio: remove remaining tasklet & timer code
      s390/qdio: remove unneeded siga-sync for Output Queue
      s390/qdio: clarify reporting of errors to the drivers
      s390/qdio: remove unused macros
      s390/qdio: use absolute data address in ESTABLISH ccw
      s390/qdio: remove unused sync-after-IRQ infrastructure
      s390/qdio: clean up SIGA capability tracking
      s390/qdio: fine-tune the queue sync
      s390/qdio: use dev_info() in qdio_print_subchannel_info()
      s390/qdio: consolidate QIB code
      s390/qdio: remove unused support for SLIB parameters
      s390/ap: use the common device_driver pointer
      s390/ap: use the common driver-data pointer
      s390/zcrypt: remove gratuitious NULL check in .remove() callbacks

Marco Elver (1):
      kfence, x86: only define helpers if !MODULE

Masahiro Yamada (1):
      s390: move the install rule to arch/s390/Makefile

Niklas Schnelle (8):
      s390: make PCI mio support a machine flag
      s390: add HWCAP_S390_PCI_MIO to ELF hwcaps
      s390/pci: cleanup resources only if necessary
      s390/pci: reset zdev->zbus on registration failure
      s390/pci: fix misleading rc in clp_set_pci_fn()
      s390/pci: handle FH state mismatch only on disable
      s390/pci: simplify CLP List PCI handling
      s390/pci: improve DMA translation init and exit

Peter Oberparleiter (4):
      s390/debug: keep debug data on resize
      s390/debug: fix debug area life cycle
      s390/debug: add early tracing support
      s390/sclp: add tracing of SCLP interactions

Randy Dunlap (1):
      s390/crypto: fix all kernel-doc warnings in vfio_ap_ops.c

Sebastian Andrzej Siewior (2):
      s390: replace deprecated CPU-hotplug functions
      s390/sclp: replace deprecated CPU-hotplug functions

Sven Schnelle (4):
      kfence: add function to mask address bits
      s390: add support for KFENCE
      s390: add kfence region to pagetable dumper
      s390: remove do_signal() prototype and do_notify_resume() function

Vineeth Vijayan (2):
      s390/cio: add rescan functionality on channel subsystem
      s390/cio: add dev_busid sysfs entry for each subchannel

 arch/s390/Kconfig                                  |   2 +
 arch/s390/Makefile                                 |   3 +-
 arch/s390/boot/Makefile                            |   7 +-
 arch/s390/boot/boot.h                              |  14 +-
 arch/s390/boot/compressed/Makefile                 |   1 +
 arch/s390/boot/compressed/decompressor.c           |   5 -
 arch/s390/boot/compressed/decompressor.h           |   5 +
 arch/s390/boot/compressed/vmlinux.lds.S            |  35 +--
 arch/s390/boot/head.S                              |  56 +---
 arch/s390/boot/ipl_report.c                        |   6 +-
 arch/s390/boot/kaslr.c                             |   6 +-
 arch/s390/boot/mem_detect.c                        |   8 +-
 arch/s390/boot/pgm_check_info.c                    |   5 +-
 arch/s390/boot/sclp_early_core.c                   |   9 +
 arch/s390/boot/startup.c                           |  78 ++---
 arch/s390/boot/uv.c                                |  40 ++-
 arch/s390/boot/uv.h                                |  19 ++
 arch/s390/configs/debug_defconfig                  |   3 +-
 arch/s390/configs/defconfig                        |   1 -
 arch/s390/hypfs/hypfs_diag0c.c                     |  12 +-
 arch/s390/include/asm/cio.h                        |   1 -
 arch/s390/include/asm/cpacf.h                      | 208 +++++++------
 arch/s390/include/asm/cpufeature.h                 |   2 +-
 arch/s390/include/asm/ctl_reg.h                    |  17 ++
 arch/s390/include/asm/debug.h                      | 122 ++++++--
 arch/s390/include/asm/diag.h                       |  15 +-
 arch/s390/include/asm/elf.h                        |  76 +++--
 arch/s390/include/asm/extable.h                    |   4 +-
 arch/s390/include/asm/ftrace.h                     |  46 +--
 arch/s390/include/asm/ftrace.lds.h                 |  21 ++
 arch/s390/include/asm/ipl.h                        |   1 +
 arch/s390/include/asm/kfence.h                     |  42 +++
 arch/s390/include/asm/kvm_para.h                   | 229 +++++---------
 arch/s390/include/asm/linkage.h                    |   4 +-
 arch/s390/include/asm/lowcore.h                    |   3 +-
 arch/s390/include/asm/module.h                     |  14 +-
 arch/s390/include/asm/page.h                       |   3 -
 arch/s390/include/asm/pci.h                        |   7 +-
 arch/s390/include/asm/pci_dma.h                    |   2 -
 arch/s390/include/asm/pgtable.h                    |  10 +-
 arch/s390/include/asm/processor.h                  |   2 +
 arch/s390/include/asm/qdio.h                       |  19 +-
 arch/s390/include/asm/sclp.h                       |  10 +-
 arch/s390/include/asm/sections.h                   |   4 +-
 arch/s390/include/asm/set_memory.h                 |   6 +
 arch/s390/include/asm/setup.h                      |  46 +--
 arch/s390/include/asm/syscall.h                    |  59 ++++
 arch/s390/include/asm/uv.h                         |   8 -
 arch/s390/include/asm/vdso/gettimeofday.h          |  22 +-
 arch/s390/kernel/Makefile                          |   2 +-
 arch/s390/kernel/asm-offsets.c                     |   8 +
 arch/s390/kernel/crash_dump.c                      |  46 +--
 arch/s390/kernel/debug.c                           | 247 ++++++++++-----
 arch/s390/kernel/diag.c                            |  27 +-
 arch/s390/kernel/dis.c                             |   2 +
 arch/s390/kernel/early.c                           |   4 +
 arch/s390/kernel/entry.S                           |  11 +-
 arch/s390/kernel/entry.h                           |  11 +-
 arch/s390/kernel/ftrace.c                          | 222 +++++++++++++-
 arch/s390/kernel/ftrace.h                          |  26 ++
 arch/s390/kernel/head64.S                          |  17 ++
 arch/s390/kernel/ipl.c                             |   5 +-
 arch/s390/kernel/ipl_vmparm.c                      |   2 +
 arch/s390/kernel/irq.c                             |   4 +-
 arch/s390/kernel/jump_label.c                      |   2 +-
 arch/s390/kernel/machine_kexec.c                   |   5 +-
 arch/s390/kernel/module.c                          |  45 +++
 arch/s390/kernel/os_info.c                         |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                    |   4 +-
 arch/s390/kernel/processor.c                       | 177 ++++++++++-
 arch/s390/kernel/setup.c                           | 286 ++++++++----------
 arch/s390/kernel/signal.c                          |   6 -
 arch/s390/kernel/smp.c                             |  64 ++--
 .../{boot/text_dma.S => kernel/text_amode31.S}     |  60 ++--
 arch/s390/kernel/topology.c                        |   4 +-
 arch/s390/kernel/traps.c                           |   2 +-
 arch/s390/kernel/uv.c                              |  15 -
 arch/s390/kernel/vdso32/Makefile                   |   1 +
 arch/s390/kernel/vdso64/Makefile                   |   1 +
 arch/s390/kernel/vmlinux.lds.S                     |  35 +++
 arch/s390/lib/delay.c                              |  11 +-
 arch/s390/mm/dump_pagetables.c                     |  16 +
 arch/s390/mm/fault.c                               |  13 +-
 arch/s390/mm/init.c                                |   3 +-
 arch/s390/mm/kasan_init.c                          |  43 ++-
 arch/s390/mm/maccess.c                             |   4 +-
 arch/s390/mm/page-states.c                         |  43 ---
 arch/s390/mm/pageattr.c                            |  19 +-
 arch/s390/mm/vmem.c                                |   2 +-
 arch/s390/pci/pci.c                                |  73 +++--
 arch/s390/pci/pci_bus.c                            |   8 +-
 arch/s390/pci/pci_clp.c                            | 186 ++++++------
 arch/s390/pci/pci_dma.c                            |  25 +-
 arch/s390/pci/pci_event.c                          |   5 +-
 arch/s390/pci/pci_sysfs.c                          |  19 +-
 arch/s390/purgatory/Makefile                       |   1 +
 arch/s390/tools/opcodes.txt                        |  18 ++
 arch/x86/include/asm/kfence.h                      |   4 +
 drivers/iommu/s390-iommu.c                         |  18 +-
 drivers/s390/block/dasd_ioctl.c                    |   4 +-
 drivers/s390/char/sclp.c                           | 230 +++++++++++++-
 drivers/s390/char/sclp.h                           |   2 -
 drivers/s390/char/sclp_cmd.c                       |   2 +-
 drivers/s390/char/sclp_config.c                    |   4 +-
 drivers/s390/char/sclp_early_core.c                |  19 +-
 drivers/s390/char/zcore.c                          |   2 +-
 drivers/s390/cio/css.c                             |  30 ++
 drivers/s390/cio/qdio.h                            |  40 +--
 drivers/s390/cio/qdio_debug.c                      |   3 -
 drivers/s390/cio/qdio_main.c                       | 331 +++++----------------
 drivers/s390/cio/qdio_setup.c                      | 114 ++-----
 drivers/s390/crypto/ap_bus.c                       |  32 +-
 drivers/s390/crypto/ap_bus.h                       |  13 +-
 drivers/s390/crypto/ap_queue.c                     |  20 +-
 drivers/s390/crypto/vfio_ap_ops.c                  | 116 ++++----
 drivers/s390/crypto/zcrypt_api.c                   |   4 +-
 drivers/s390/crypto/zcrypt_card.c                  |   8 +-
 drivers/s390/crypto/zcrypt_ccamisc.c               |   8 +-
 drivers/s390/crypto/zcrypt_cex2a.c                 |  17 +-
 drivers/s390/crypto/zcrypt_cex2c.c                 |  24 +-
 drivers/s390/crypto/zcrypt_cex4.c                  |  38 +--
 drivers/s390/crypto/zcrypt_queue.c                 |   8 +-
 drivers/s390/net/qeth_core_main.c                  |  10 +-
 drivers/s390/scsi/zfcp_qdio.c                      |   5 +-
 include/linux/ftrace.h                             |  16 +
 kernel/kcsan/debugfs.c                             |   2 +-
 kernel/trace/ftrace.c                              |   4 +-
 mm/kfence/kfence_test.c                            |  13 +-
 128 files changed, 2467 insertions(+), 1824 deletions(-)
 create mode 100644 arch/s390/boot/uv.h
 create mode 100644 arch/s390/include/asm/ftrace.lds.h
 create mode 100644 arch/s390/include/asm/kfence.h
 create mode 100644 arch/s390/kernel/ftrace.h
 rename arch/s390/{boot/text_dma.S => kernel/text_amode31.S} (69%)
