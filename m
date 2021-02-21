Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D07C433E0
	for <linux-s390@archiver.kernel.org>; Sun, 21 Feb 2021 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32E564EBE
	for <linux-s390@archiver.kernel.org>; Sun, 21 Feb 2021 21:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBUVdj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Feb 2021 16:33:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230312AbhBUVdj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 21 Feb 2021 16:33:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11LLRsuC191696;
        Sun, 21 Feb 2021 16:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=H0XABPmW/VOtpSWnodbsfwDPg5POPFIc7StKT6cYDLY=;
 b=B7toPufUu27vng671Id+LGqSSVtFSHDVx9v07oMN7Vwbpfzc1sZoKuXOYLSHu8Kp/e3m
 ZRbjcjGfgfU6QQfDpQeJupMot5UJ9j335MSMCk8h8yJb1y1a5ztBYBe52QZP3E17kBbB
 mc/OoU6QvQifi1h3erT2vEn970SWNXV6mNPNPr3lqpayjptAtRtHBaMJZq4uvbhDvsK+
 D4RWV9l9Cuk2A1+YWB9p8mqXHPC+nWBpJXcdL2+rrN9S2bp/wh3auMbyVdKoRxlJSrZZ
 IT7JR+n5QQguoTYjwK59JN0I9SgqddAbdilVb6yvl1esfccKKt0XzWB1aX+Wc4a264jC RQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36uyf5g2xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 16:32:54 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11LLWrFd031415;
        Sun, 21 Feb 2021 21:32:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 36tt288j8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 21:32:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11LLWoPR39846230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Feb 2021 21:32:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D41A4040;
        Sun, 21 Feb 2021 21:32:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 369E1A4055;
        Sun, 21 Feb 2021 21:32:48 +0000 (GMT)
Received: from localhost (unknown [9.171.74.91])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 21 Feb 2021 21:32:47 +0000 (GMT)
Date:   Sun, 21 Feb 2021 22:32:41 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.12 merge window
Message-ID: <your-ad-here.call-01613943161-ext-2093@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_10:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102210216
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.12. There are small common code and
alpha/Kconfig changes caused by
96c0a6a72d18 ("s390,alpha: switch to 64-bit ino_t"). Which has been
discussed here: lkml.kernel.org/r/YCV7QiyoweJwvN+m@osiris

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-1

for you to fetch changes up to 2223318c2862edc7f5b282939b850b19fc934ec4:

  s390/qdio: remove 'merge_pending' mechanism (2021-02-13 17:17:55 +0100)

Thank you,
Vasily
----------------------------------------------------------------
s390 updates for the 5.12 merge window

- Convert to using the generic entry infrastructure.

- Add vdso time namespace support.

- Switch s390 and alpha to 64-bit ino_t. As discussed here
  lkml.kernel.org/r/YCV7QiyoweJwvN+m@osiris

- Get rid of expensive stck (store clock) usages where possible. Utilize
  cpu alternatives to patch stckf when supported.

- Make tod_clock usage less error prone by converting it to a union and
  rework code which is using it.

- Machine check handler fixes and cleanups.

- Drop couple of minor inline asm optimizations to fix clang build.

- Default configs changes notably to make libvirt happy.

- Various changes to rework and improve qdio code.

- Other small various fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Egorenkov (2):
      s390: update defconfigs
      s390/thread_info.h: fix task_struct declaration warning

Alexander Gordeev (1):
      s390/tlb: make cleared_pXs flags consistent with generic code

Chengyang Fan (1):
      s390/ap: remove unneeded semicolon

Colin Ian King (1):
      s390/tape: Fix spelling mistake in function name tape_3590_erp_succeded

Halil Pasic (1):
      s390/defconfig: add some NFT modules

Harald Freudenberger (2):
      s390/crypto: improve retry logic in case of master key change
      s390/zcrypt: return EIO when msg retry limit reached

Heiko Carstens (34):
      s390/atomic: remove small optimization to fix clang build
      s390/bitops: remove small optimization to fix clang build
      s390: update defconfigs
      s390/vdso: remove VDSO32_LBASE compat leftover
      s390/vdso: fix vdso data page definition
      s390/vdso: convert vdso_init() to arch_initcall
      s390/vdso: simplify vdso size calculation
      s390/vdso: remove BUG_ON()
      s390/vdso: remove superfluous check
      s390/vdso: remove superfluous variables
      s390/vdso: misc simple code changes
      s390/vdso: get rid of vdso_fault
      s390/vdso: put vdso datapage in a separate vma
      s390/vdso: move data page before code pages
      s390/vdso: simplify __arch_get_hw_counter()
      s390/vdso: implement generic vdso time namespace support
      s390/vdso: on timens page fault prefault also VVAR page
      s390/vtime: fix inline assembly clobber list
      s390/cpum_cf_diag: use get_tod_clock_fast()
      s390/time: use stcke instead of stck
      s390/entry: use cpu alternative for stck/stckf
      s390/alternatives: add alternative_input() / alternative_io()
      s390/vtime: use cpu alternative for stck/stckf
      s390,alpha: switch to 64-bit ino_t
      s390/time: introduce union tod_clock
      s390/time: rename store_tod_clock_ext() and use union tod_clock
      s390/time: introduce new store_tod_clock_ext()
      s390/time: convert tod_clock_base to union
      s390/vdso: use union tod_clock
      s390/kvm: use union tod_clock
      s390/debug: use union tod_clock
      s390/hypfs: use store_tod_clock_ext()
      s390/crypto: use store_tod_clock_ext()
      s390/time: remove get_tod_clock_ext()

Jan Höppner (1):
      Documentations: scsi, kvm: Update s390-tools GitHub URL

Jiapeng Zhong (1):
      s390: Simplify the calculation of variables

Julian Wiedmann (11):
      s390/cio: remove ccw_device_add() wrapper
      s390/cio: use dma helpers for setting masks
      s390/qdio: remove Input tasklet code
      s390/qdio: remove qdio_inbound_q_moved() wrapper
      s390/qdio: adopt new tasklet API
      s390/qdio: make thinint registration symmetric
      s390/qdio: track time of last data IRQ for each device
      s390/qdio: inline qdio_kick_handler()
      s390/qdio: rework q->qdio_error indication
      s390/qdio: improve handling of PENDING buffers for QEBSM devices
      s390/qdio: remove 'merge_pending' mechanism

Marc Hartmayer (1):
      s390/debug_config: enable kmemleak detector

Niklas Schnelle (2):
      s390/pci: remove superfluous zdev->zbus check
      s390/pci: refactor zpci_create_device()

Sven Schnelle (10):
      s390: convert to generic entry
      s390: remove asmlinkage
      s390: pass struct pt_regs instead of registers to syscalls
      s390: add missing include to arch/s390/kernel/signal.c
      s390: open code SWITCH_KERNEL macro
      s390: use WRITE_ONCE when re-allocating async stack
      s390: add stack for machine check handler
      s390: fix kernel asce loading when sie is interrupted
      s390: use r13 in cleanup_sie as temp register
      s390: split cleanup_sie

 Documentation/scsi/scsi-parameters.rst     |   2 +-
 Documentation/virt/kvm/s390-pv-boot.rst    |   2 +-
 arch/Kconfig                               |   4 +
 arch/alpha/Kconfig                         |   1 +
 arch/s390/Kconfig                          |   3 +
 arch/s390/Kconfig.debug                    |  10 +-
 arch/s390/configs/debug_defconfig          |  12 +-
 arch/s390/configs/defconfig                |   9 +-
 arch/s390/configs/zfcpdump_defconfig       |   2 +
 arch/s390/crypto/paes_s390.c               |  28 +-
 arch/s390/crypto/prng.c                    |   2 +-
 arch/s390/hypfs/hypfs_diag0c.c             |   2 +-
 arch/s390/hypfs/hypfs_vm.c                 |   4 +-
 arch/s390/include/asm/alternative.h        |  16 +
 arch/s390/include/asm/ap.h                 |   2 +-
 arch/s390/include/asm/atomic.h             |  20 -
 arch/s390/include/asm/bitops.h             |  36 --
 arch/s390/include/asm/cputime.h            |   2 +
 arch/s390/include/asm/elf.h                |   7 +-
 arch/s390/include/asm/entry-common.h       |  60 ++
 arch/s390/include/asm/fpu/api.h            |   2 +
 arch/s390/include/asm/idle.h               |   4 +-
 arch/s390/include/asm/lowcore.h            |  17 +-
 arch/s390/include/asm/nmi.h                |   1 +
 arch/s390/include/asm/pci.h                |   4 +-
 arch/s390/include/asm/preempt.h            |   4 +-
 arch/s390/include/asm/processor.h          |  50 +-
 arch/s390/include/asm/ptrace.h             |   9 +-
 arch/s390/include/asm/qdio.h               |   7 +-
 arch/s390/include/asm/scsw.h               |   3 +-
 arch/s390/include/asm/syscall.h            |  11 +-
 arch/s390/include/asm/syscall_wrapper.h    | 128 +++--
 arch/s390/include/asm/thread_info.h        |   5 +
 arch/s390/include/asm/timex.h              |  48 +-
 arch/s390/include/asm/tlb.h                |   5 +-
 arch/s390/include/asm/uaccess.h            |   2 +-
 arch/s390/include/asm/vdso.h               |   7 +-
 arch/s390/include/asm/vdso/gettimeofday.h  |  12 +-
 arch/s390/include/asm/vtime.h              |  14 +
 arch/s390/include/uapi/asm/ptrace.h        |   5 +-
 arch/s390/kernel/Makefile                  |   2 +-
 arch/s390/kernel/asm-offsets.c             |  20 +-
 arch/s390/kernel/compat_signal.c           |   1 +
 arch/s390/kernel/debug.c                   |   6 +-
 arch/s390/kernel/early.c                   |  12 +-
 arch/s390/kernel/entry.S                   | 872 +++++------------------------
 arch/s390/kernel/entry.h                   |  12 +-
 arch/s390/kernel/fpu.c                     |  88 +++
 arch/s390/kernel/idle.c                    |  24 +
 arch/s390/kernel/irq.c                     |  89 ++-
 arch/s390/kernel/nmi.c                     |  19 +-
 arch/s390/kernel/perf_cpum_cf_diag.c       |   4 +-
 arch/s390/kernel/perf_cpum_sf.c            |   2 +-
 arch/s390/kernel/process.c                 |  30 +-
 arch/s390/kernel/ptrace.c                  | 117 +---
 arch/s390/kernel/setup.c                   |  23 +-
 arch/s390/kernel/signal.c                  |  13 +-
 arch/s390/kernel/smp.c                     |  19 +-
 arch/s390/kernel/{sys_s390.c => syscall.c} |  66 +++
 arch/s390/kernel/time.c                    |  50 +-
 arch/s390/kernel/traps.c                   |  65 +++
 arch/s390/kernel/uprobes.c                 |   6 +-
 arch/s390/kernel/vdso.c                    | 290 +++++-----
 arch/s390/kernel/vdso64/getcpu.c           |   6 +-
 arch/s390/kernel/vdso64/vdso64.lds.S       |   7 +-
 arch/s390/kernel/vtime.c                   |  18 +-
 arch/s390/kvm/kvm-s390.c                   |  27 +-
 arch/s390/kvm/vsie.c                       |   3 +
 arch/s390/lib/uaccess.c                    |  12 +-
 arch/s390/mm/fault.c                       |   2 +-
 arch/s390/pci/pci.c                        |  57 +-
 arch/s390/pci/pci_clp.c                    |  40 +-
 arch/s390/pci/pci_event.c                  |   6 +-
 drivers/s390/char/tape_3590.c              |   4 +-
 drivers/s390/cio/css.c                     |  20 +-
 drivers/s390/cio/device.c                  |  39 +-
 drivers/s390/cio/qdio.h                    |  25 +-
 drivers/s390/cio/qdio_debug.c              |   9 +-
 drivers/s390/cio/qdio_main.c               | 209 ++-----
 drivers/s390/cio/qdio_setup.c              |  19 +-
 drivers/s390/cio/qdio_thinint.c            |  70 +--
 drivers/s390/crypto/zcrypt_api.c           |  14 +
 drivers/s390/crypto/zcrypt_ccamisc.c       |  15 +-
 drivers/s390/net/qeth_core_main.c          |   7 +-
 fs/statfs.c                                |   5 +-
 include/linux/types.h                      |   8 +-
 86 files changed, 1353 insertions(+), 1661 deletions(-)
 create mode 100644 arch/s390/include/asm/entry-common.h
 rename arch/s390/kernel/{sys_s390.c => syscall.c} (61%)
