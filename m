Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0269C07E95
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D261613C1
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 13:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGDNxc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 4 Jul 2021 09:53:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGDNxc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 4 Jul 2021 09:53:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164DYcnJ050299;
        Sun, 4 Jul 2021 09:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=Xnj5iqfUbw7+HJPYIVkXolCO2YBjUK6/MbV95gFKPpE=;
 b=jRj5Vos+1+IN3wp0XeQTC0lxpE0O3x9d6mKTHgUfOR3J84VV3n7TYrLUZ0hA7QdmAqC7
 7ntDNEl+NMvt+OCEpTt6j1GRpgXbYf5UXz/sfL0+V47ozuHxjtoo/9eAU/Xtm+3PyuFA
 jEXcVAwNuBpr84AM/n3ZwGybuADa57YMjgKGIveEYIEib+F6V8ibZRDOEcHRo7+6m7uB
 PPUq01ARp5JA1T5LOwRc0zKlLv2/stsuLgiYBqOUUp25WFy1FI3b+i17MhvSrrWJ5bx6
 SCSW8Ca3O5HzCFxpH6NaOYSHKJqW/9kMWWGYNAY3zDR2EJoO/gD0oHTbFNYZBouHEbC4 kg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39kctwha14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Jul 2021 09:50:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 164DgTOR002591;
        Sun, 4 Jul 2021 13:50:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8rd43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Jul 2021 13:50:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 164Doo0h32899522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Jul 2021 13:50:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 179C05204F;
        Sun,  4 Jul 2021 13:50:50 +0000 (GMT)
Received: from localhost (unknown [9.171.50.66])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AD5AC52052;
        Sun,  4 Jul 2021 13:50:49 +0000 (GMT)
Date:   Sun, 4 Jul 2021 15:50:48 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.14 merge window
Message-ID: <your-ad-here.call-01625406648-ext-2488@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SwE0EclELPrfCTZYWybHjxfyZ7bwnaaq
X-Proofpoint-GUID: SwE0EclELPrfCTZYWybHjxfyZ7bwnaaq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-04_10:2021-07-02,2021-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040083
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.14.

Thank you,
Vasily

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-1

for you to fetch changes up to d4a01902eb59e478ab7c7d36d7bb90d94a315f89:

  s390/dasd: use register pair instead of register asm (2021-06-28 11:18:29 +0200)

----------------------------------------------------------------
s390 updates for the 5.14 merge window

- Rework inline asm to get rid of error prone "register asm" constructs,
  which are problematic especially when code instrumentation is enabled. In
  particular introduce and use register pair union to allocate even/odd
  register pairs. Unfortunately this breaks compatibility with older
  clang compilers and minimum clang version for s390 has been raised to 13.
  https://lore.kernel.org/linux-next/CAK7LNARuSmPCEy-ak0erPrPTgZdGVypBROFhtw+=3spoGoYsyw@mail.gmail.com/

- Fix gcc 11 warnings, which triggered various minor reworks all over
  the code.

- Add zstd kernel image compression support.

- Rework boot CPU lowcore handling.

- De-duplicate and move kernel memory layout setup logic earlier.

- Few fixes in preparation for FORTIFY_SOURCE performing compile-time
  and run-time field bounds checking for mem functions.

- Remove broken and unused power management support leftovers in s390
  drivers.

- Disable stack-protector for decompressor and purgatory to fix buildroot
  build.

- Fix vt220 sclp console name to match the char device name.

- Enable HAVE_IOREMAP_PROT and add zpci_set_irq()/zpci_clear_irq() in
  zPCI code.

- Remove some implausible WARN_ON_ONCEs and remove arch specific counter
  transaction call backs in favour of default transaction handling in
  perf code.

- Extend/add new uevents for online/config/mode state changes of
  AP card / queue device in zcrypt.

- Minor entry and ccwgroup code improvements.

- Other small various fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Gordeev (8):
      s390/mcck: fix calculation of SIE critical section size
      s390/mcck: fix invalid KVM guest condition check
      s390/mm: ensure switch_mm() is executed with interrupts disabled
      s390/smp: reallocate IPL CPU lowcore
      s390/smp: do not preserve boot CPU lowcore on hotplug
      s390/smp: remove redundant pcpu::lowcore member
      s390/mcck: cleanup use of cleanup_sie_mcck
      s390/entry.S: factor out OUTSIDE macro

Dimitri John Ledkov (1):
      s390/boot: add zstd support

Fabrice Fontaine (1):
      s390: disable SSP when needed

Harald Freudenberger (2):
      s390/ap: extend AP change bindings-complete uevent with counter
      s390/ap/zcrypt: notify userspace with online, config and mode info

Heiko Carstens (39):
      s390/ipl: make parameter area accessible via struct parmarea
      s390/boot: access kernel command line via parmarea
      s390/lowcore: remove superfluous __packed annotations
      s390/processor: always inline stap() and __load_psw_mask()
      s390/irqflags: always inline arch irqflags functions
      s390: introduce register pair union
      s390/bitops: use register pair instead of register asm
      s390/smp: use register pair instead of register asm
      s390/page: use register pair instead of register asm
      s390/diag: use register pair instead of register asm
      s390/checksum: use register pair instead of register asm
      s390/maccess: use register pair instead of register asm
      s390/sthyi: use register pair instead of register asm
      s390/sigp: use register pair instead of register asm
      s390/cpcmd: use register pair instead of register asm
      s390/ipl_parm: fix program check new psw handling
      s390/ipl_parm: use register pair instead of register asm
      s390/pgtable: use register pair instead of register asm
      s390/sysinfo: get rid of register asm
      s390/uaccess: get rid of register asm
      s390/facility: get rid of register asm
      s390/mem_detect: fix diag260() program check new psw handling
      s390/mem_detect: use register pair instead of register asm
      s390/mem_detect: fix tprot() program check new psw handling
      s390/ipl: use register pair instead of register asm
      virtio/s390: get rid of open-coded kvm hypercall
      s390/hypfs: use register pair instead of register asm
      s390/timex: get rid of register asm
      s390/lib,xor: get rid of register asm
      s390/mm,pages-states: get rid of register asm
      s390/cmpxchg: use register pair instead of register asm
      s390/string: get rid of register asm
      s390/lib,uaccess: get rid of register asm
      s390/lib,string: get rid of register asm
      s390/cmf: get rid of register asm
      s390/ioasm: get rid of register asm
      s390/ioasm: use symbolic names for asm operands
      s390/qdio: get rid of register asm
      s390/dasd: use register pair instead of register asm

Julian Wiedmann (7):
      s390/zcrypt: remove zcrypt_device_count
      s390/ap: wire up bus->probe and bus->remove
      s390/ccwgroup: release the cdevs from within dev->release()
      s390/vfio-ap: clean up vfio_ap_drv's definition
      s390/ccwgroup: simplify ungrouping when driver deregisters
      s390/ccwgroup: use BUS_NOTIFY_UNBOUND_DRIVER to trigger ungrouping
      s390/hvc_iucv: Remove power management support

Kees Cook (2):
      s390/speculation: Use statically initialized const for instructions
      s390/zcrypt: Switch to flexible array member

Nathan Chancellor (1):
      scripts/min-tool-version.sh: Raise minimum clang version to 13.0.0 for s390

Niklas Schnelle (3):
      s390: enable HAVE_IOREMAP_PROT
      s390/pci: use register pair instead of register asm
      s390/pci: add zpci_set_irq()/zpci_clear_irq()

Peter Oberparleiter (11):
      s390/debug: Remove pointer obfuscation
      s390/dcssblk: Remove power management support
      s390/xpram: Remove power management support
      s390/monreader: Remove power management support
      s390/monwriter: Remove power management support
      s390/sclp: Remove console power management support
      s390/sclp: Remove vt220 power management support
      s390/sclp: Remove memory hotplug power management support
      s390/sclp: Remove quiesce power management support
      s390/sclp: Remove sclp base power management support
      s390/vmlogrdr: Remove power management support

Randy Dunlap (1):
      s390: appldata depends on PROC_SYSCTL

Rob Landley (1):
      s390/decompressor: replace use of perl with simple sed/tr

Sven Schnelle (8):
      s390/entry: use assignment to read intcode / asm to copy gprs
      s390/facilities: move stfl information from lowcore to global data
      s390/irq: add union/struct to access external interrupt parameters
      s390/traps: add struct to access transactional diagnostic block
      s390/crypto: fix function/prototype mismatches
      s390/cio: add tpi.h header file
      s390: add struct tpi_info to struct pt_regs
      s390: use struct tpi_info in lowcore.h

Thomas Richter (2):
      s390/cpumf: remove counter transaction call backs
      s390/cpumf: remove WARN_ON_ONCE in counter start handler

Valentin Vidic (1):
      s390/sclp_vt220: fix console name to match device

Vasily Gorbik (4):
      Merge branch 's390/fixes' into features
      s390: setup kernel memory layout early
      s390/setup: cleanup reserve/remove_oldmem
      s390/decompressor: correct BOOT_HEAP_SIZE condition

Vineeth Vijayan (1):
      s390/cio: dont call css_wait_for_slow_path() inside a lock

Zou Wei (1):
      s390/sclp: convert list_for_each to entry variant

 arch/s390/Kconfig                        |   4 +-
 arch/s390/Makefile                       |   1 +
 arch/s390/boot/als.c                     |   6 +-
 arch/s390/boot/boot.h                    |   1 +
 arch/s390/boot/compressed/Makefile       |   6 +-
 arch/s390/boot/compressed/decompressor.c |   8 +-
 arch/s390/boot/head.S                    |   3 +
 arch/s390/boot/ipl_parm.c                |  59 ++++++-----
 arch/s390/boot/mem_detect.c              |  73 +++++++------
 arch/s390/boot/startup.c                 |  91 ++++++++++++++++
 arch/s390/boot/uv.c                      |  25 +++++
 arch/s390/hypfs/hypfs_sprp.c             |  13 ++-
 arch/s390/include/asm/bitops.h           |  10 +-
 arch/s390/include/asm/ccwgroup.h         |   3 +-
 arch/s390/include/asm/checksum.h         |  10 +-
 arch/s390/include/asm/cio.h              |   1 +
 arch/s390/include/asm/cmpxchg.h          |  44 ++++----
 arch/s390/include/asm/cpu_mcf.h          |   3 +-
 arch/s390/include/asm/facility.h         |  25 +++--
 arch/s390/include/asm/irqflags.h         |  16 +--
 arch/s390/include/asm/kasan.h            |   1 -
 arch/s390/include/asm/lowcore.h          |  38 ++++---
 arch/s390/include/asm/mmu_context.h      |  15 ++-
 arch/s390/include/asm/page.h             |  15 +--
 arch/s390/include/asm/pci.h              |   7 +-
 arch/s390/include/asm/percpu.h           |  27 ++---
 arch/s390/include/asm/pgtable.h          |  62 +++++++----
 arch/s390/include/asm/processor.h        |   6 +-
 arch/s390/include/asm/ptrace.h           |  12 ++-
 arch/s390/include/asm/setup.h            |   3 +-
 arch/s390/include/asm/sigp.h             |  14 +--
 arch/s390/include/asm/string.h           |  59 ++++++-----
 arch/s390/include/asm/timex.h            |  26 +++--
 arch/s390/include/asm/tpi.h              |  24 +++++
 arch/s390/include/asm/types.h            |  19 ++++
 arch/s390/include/asm/uaccess.h          |  36 +++----
 arch/s390/include/uapi/asm/schid.h       |   3 +
 arch/s390/kernel/alternative.c           |   3 +-
 arch/s390/kernel/asm-offsets.c           |   7 +-
 arch/s390/kernel/cpcmd.c                 |  42 ++++----
 arch/s390/kernel/debug.c                 |   2 +-
 arch/s390/kernel/diag.c                  |  11 +-
 arch/s390/kernel/early.c                 |   6 +-
 arch/s390/kernel/entry.S                 |  61 +++++------
 arch/s390/kernel/ipl.c                   |  14 +--
 arch/s390/kernel/irq.c                   |   6 +-
 arch/s390/kernel/nospec-branch.c         |  17 +--
 arch/s390/kernel/nospec-sysfs.c          |   2 +-
 arch/s390/kernel/perf_cpum_cf.c          |  92 +---------------
 arch/s390/kernel/perf_cpum_cf_common.c   |   1 -
 arch/s390/kernel/processor.c             |   4 +-
 arch/s390/kernel/ptrace.c                |   4 +-
 arch/s390/kernel/setup.c                 | 107 ++-----------------
 arch/s390/kernel/smp.c                   | 131 +++++++++++++++--------
 arch/s390/kernel/sthyi.c                 |  13 ++-
 arch/s390/kernel/syscall.c               |   5 +-
 arch/s390/kernel/sysinfo.c               |  19 ++--
 arch/s390/kernel/traps.c                 |   4 +-
 arch/s390/kernel/uv.c                    |   8 +-
 arch/s390/kvm/kvm-s390.c                 |  12 +--
 arch/s390/lib/string.c                   | 131 +++++++++++++----------
 arch/s390/lib/uaccess.c                  |  25 +++--
 arch/s390/lib/xor.c                      |   5 +-
 arch/s390/mm/kasan_init.c                |  35 ++-----
 arch/s390/mm/maccess.c                   |  19 ++--
 arch/s390/mm/page-states.c               |  12 +--
 arch/s390/pci/pci_insn.c                 |  55 +++++-----
 arch/s390/pci/pci_irq.c                  |  46 ++++++--
 arch/s390/pci/pci_mmio.c                 |  24 ++---
 arch/s390/purgatory/Makefile             |   1 +
 drivers/s390/block/dasd_diag.c           |  21 ++--
 drivers/s390/block/dcssblk.c             | 106 +------------------
 drivers/s390/block/xpram.c               |  63 +----------
 drivers/s390/char/monreader.c            | 125 +---------------------
 drivers/s390/char/monwriter.c            |  90 +---------------
 drivers/s390/char/sclp.c                 | 174 +------------------------------
 drivers/s390/char/sclp.h                 |  13 ---
 drivers/s390/char/sclp_cmd.c             |  34 ------
 drivers/s390/char/sclp_con.c             |  53 +---------
 drivers/s390/char/sclp_ftp.c             |   1 -
 drivers/s390/char/sclp_quiesce.c         |  37 +------
 drivers/s390/char/sclp_rw.c              |   7 --
 drivers/s390/char/sclp_rw.h              |   6 --
 drivers/s390/char/sclp_tty.c             |   4 +-
 drivers/s390/char/sclp_vt220.c           |  56 +---------
 drivers/s390/char/vmlogrdr.c             |  24 -----
 drivers/s390/cio/airq.c                  |   2 +-
 drivers/s390/cio/ccwgroup.c              |  60 ++++-------
 drivers/s390/cio/chp.c                   |   3 +
 drivers/s390/cio/chsc.c                  |   2 -
 drivers/s390/cio/cio.c                   |   2 +-
 drivers/s390/cio/cio.h                   |  13 +--
 drivers/s390/cio/cmf.c                   |  13 +--
 drivers/s390/cio/ioasm.c                 | 143 +++++++++++++------------
 drivers/s390/cio/qdio.h                  |  25 ++---
 drivers/s390/cio/qdio_main.c             |  62 +++++------
 drivers/s390/cio/trace.h                 |   6 +-
 drivers/s390/crypto/ap_bus.c             |  84 ++++++++++++---
 drivers/s390/crypto/ap_bus.h             |   3 +
 drivers/s390/crypto/ap_card.c            |   2 +
 drivers/s390/crypto/vfio_ap_drv.c        |  13 ++-
 drivers/s390/crypto/zcrypt_api.c         |   1 -
 drivers/s390/crypto/zcrypt_api.h         |   3 +-
 drivers/s390/crypto/zcrypt_card.c        |  30 +++++-
 drivers/s390/crypto/zcrypt_ccamisc.c     |  14 +--
 drivers/s390/crypto/zcrypt_ccamisc.h     |   4 +-
 drivers/s390/crypto/zcrypt_msgtype50.c   |   2 +
 drivers/s390/crypto/zcrypt_msgtype6.c    |   5 +
 drivers/s390/crypto/zcrypt_queue.c       |  16 +--
 drivers/s390/virtio/virtio_ccw.c         |  30 +-----
 drivers/tty/hvc/hvc_iucv.c               |  51 ---------
 scripts/min-tool-version.sh              |   7 +-
 112 files changed, 1250 insertions(+), 1853 deletions(-)
 create mode 100644 arch/s390/include/asm/tpi.h
 create mode 100644 arch/s390/include/asm/types.h
