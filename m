Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207DBC433ED
	for <linux-s390@archiver.kernel.org>; Tue, 27 Apr 2021 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57816101C
	for <linux-s390@archiver.kernel.org>; Tue, 27 Apr 2021 13:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhD0Nqc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Apr 2021 09:46:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236156AbhD0Nqa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 27 Apr 2021 09:46:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RDXi57165462;
        Tue, 27 Apr 2021 09:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=ELL/iD39Ysryj0yTqm9NOxVSyN2mOz2rdYdKwkDH6AE=;
 b=Pa8V7C/bleZIqfVcVKUne1oKTwtGaWMGrPWwXmUGjVosZC27+KKY7hFM8zlWjjYWeWQk
 HFZNPuTcY21Bljd65nMzfryhPpoIGpReL8uZgWxRkdTIrUi8C43CukDmH6qdVp3gOX8r
 /DjexcUkW42Jj42j8ZKDhMPqZQYp23n/Cz04DaP4nqpzF+bSCd5Ka5AAcvPV25Q4Xr0M
 9hsMA0tpvEIX5ofTblFA5DJaBdaV6VP8TKhAtSu8PduUMI5C54RT+FStZKXLi26FFIV4
 XdezJcqt9Ssl0F7wAZcLEUGyWtuBLjjPmNppHn0gesCVG4BuKphrDv78LEMGonUZWOul 8g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386jn4jthj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 09:45:39 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RDSmwn026238;
        Tue, 27 Apr 2021 13:45:37 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 384ay80s6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 13:45:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RDj9a036766016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 13:45:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CA8642045;
        Tue, 27 Apr 2021 13:45:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DB134203F;
        Tue, 27 Apr 2021 13:45:33 +0000 (GMT)
Received: from osiris.fritz.box (unknown [9.171.95.61])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Apr 2021 13:45:33 +0000 (GMT)
Date:   Tue, 27 Apr 2021 15:45:31 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.13 merge window
Message-ID: <YIgVewka8KeZn5F9@osiris.fritz.box>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SKIcaxzak50upG2h_wKgcTS8eRAnAePL
X-Proofpoint-ORIG-GUID: SKIcaxzak50upG2h_wKgcTS8eRAnAePL
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_06:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270094
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull s390 update for 5.13 merge window.

Note that I once merged our fixes branch. Therefore this pull request
contains commits which are already in 5.12. The resulting diffstat
when merging this will look like

 58 files changed, 1458 insertions(+), 964 deletions(-)

unlike the one generated by 'git request-pull' below.

Thanks,
Heiko

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-1

for you to fetch changes up to 6f3353c2d2b3eb4de52e9704cb962712033db181:

  s390/disassembler: increase ebpf disasm buffer size (2021-04-21 12:32:12 +0200)

----------------------------------------------------------------
s390 updates for 5.13 merge window

- fix buffer size for in-kernel disassembler for ebpf programs.

- fix two memory leaks in zcrypt driver.

- expose PCI device UID as index, including an indicator if the uid is
  unique.

- remove some oprofile leftovers.

- improve stack unwinder tests.

- don't use gcc atomic builtins anymore, just like all other
  architectures. Even though I'm sure the current code is ok, I
  totally dislike that s390 is the only architecture being special
  here; especially considering that there was a lengthly discussion
  about this topic and the outcome was not to use the builtins.
  Therefore open-code atomic ops again with inline assembly and switch
  to gcc builtins as soon as other architectures are doing.

- couple of other changes to atomic and cmpxchg, and use
  atomic-instrumented.h for KASAN.

- separate zbus creation, registration, and scanning in our PCI code
  which allows for cleaner and easier handling.

- a rather large change to the vfio-ap code to fix circular locking
  dependencies when updating crypto masks.

- move QAOB handling from qdio layer down to drivers.

- add CRW inject facility to common I/O layer. This adds debugs files
  which allow to generate artificial events from user space for
  testing purposes.

- increase SCLP console line length from 80 to 320 characters to avoid
  odd wrapped lines.

- add protected virtualization guest and host indication files, which
  indicate either that a guest is running in pv mode or if the
  hypervisor is capable of starting pv guests.

- various other small fixes and improvements all over the place.

----------------------------------------------------------------
Alexander Gordeev (3):
      s390/cpcmd: fix inline assembly register clobbering
      s390/mm: fix phys vs virt confusion in mark_kernel_pXd() functions family
      s390/smp: fix do_restart() prototype

Bhaskar Chowdhury (2):
      s390/kernel: fix a typo
      s390/crc32-vx: couple of typo fixes

Harald Freudenberger (2):
      s390/zcrypt: fix zcard and zqueue hot-unplug memleak
      s390/archrandom: add parameter check for s390_arch_random_generate

Heiko Carstens (20):
      s390/vdso: copy tod_steering_delta value to vdso_data page
      s390/vdso: fix tod_steering_delta type
      s390/vdso: fix initializing and updating of vdso_data
      s390/spinlock: remove align attribute from arch_spinlock_t
      s390/irq: fix reading of ext_params2 field from lowcore
      s390/setup: use memblock_free_late() to free old stack
      Merge branch 'fixes' into features
      s390/traps: convert pgm_check.S to C
      s390/traps,mm: add conditional trap handlers
      s390/bitops: make bitops only work on longs
      s390/atomic: move remaining inline assemblies to atomic_ops.h
      s390/atomic: use proper constraints
      s390/atomic: get rid of gcc atomic builtins
      s390/cmpxchg: get rid of gcc atomic builtins
      s390/atomic,cmpxchg: switch to use atomic-instrumented.h
      s390/spinlock: use R constraint in inline assembly
      s390: update defconfigs
      s390/cmpxchg: use unsigned long values instead of void pointers
      s390/atomic,cmpxchg: make constraints work with old compilers
      s390/atomic,cmpxchg: always inline __xchg/__cmpxchg

Janosch Frank (2):
      s390/uv: add prot virt guest/host indication files
      s390/uv: fix prot virt host indication compilation

Julian Wiedmann (1):
      s390/qdio: let driver manage the QAOB

Marc Zyngier (1):
      s390: get rid of oprofile leftovers

Matthew Rosato (1):
      MAINTAINERS: add backups for s390 vfio drivers

Niklas Schnelle (14):
      s390/pci: refactor zpci function states
      s390/pci: deconfigure device on release
      s390/pci: add zpci_event_hard_deconfigured()
      s390/pci: unify de-/configure for slots and events
      s390/pci: move zpci_remove_device() to bus code
      s390/pci: fix DMA cleanup on hard deconfigure
      s390/pci: expose UID uniqueness guarantee
      s390/pci: introduce zpci_bus_scan_device()
      s390/pci: do more bus setup in zpci_bus_scan()
      s390/pci: separate zbus creation from scanning
      s390/pci: use mutex not spinlock for zbus list
      s390/pci: separate zbus registration from scanning
      s390/pci: narrow scope of zpci_configure_device()
      s390/pci: expose a PCI device's UID as its index

Peter Oberparleiter (1):
      s390/sclp: increase sclp console line length

Shixin Liu (2):
      s390/cio: use DEFINE_SPINLOCK() for spinlock
      s390/cio: use DECLARE_WAIT_QUEUE_HEAD() for wait_queue

Tony Krowiak (1):
      s390/vfio-ap: fix circular lockdep when setting/clearing crypto masks

Vasily Gorbik (7):
      s390/unwind: add machine check handler stack
      s390/entry: avoid setting up backchain in ext|io handlers
      s390/entry: save the caller of psw_idle
      s390/test_unwind: unify error handling paths
      s390/test_unwind: add WARN if tests failed
      s390/test_unwind: print test suite start/end info
      s390/disassembler: increase ebpf disasm buffer size

Vineeth Vijayan (5):
      s390/cio: introduce CIO debugfs directory
      s390/cio: add CRW inject functionality
      s390: use DEFINE_SPINLOCK for initialization
      s390/sclp: use LIST_HEAD for Initialization
      s390/cio: use DECLARE_WAIT_QUEUE_HEAD for static work_queue_head_t

Wan Jiabing (1):
      s390/cio: remove duplicate struct ccw1 declaration

zhongbaisong (1):
      s390/protvirt: fix error return code in uv_info_init()

 Documentation/ABI/testing/sysfs-bus-pci |  11 +-
 Documentation/s390/pci.rst              |  14 +-
 MAINTAINERS                             |   4 +-
 arch/s390/Kconfig.debug                 |   8 +
 arch/s390/configs/debug_defconfig       |   2 +-
 arch/s390/configs/defconfig             |   1 -
 arch/s390/crypto/arch_random.c          |   4 +
 arch/s390/crypto/crc32be-vx.S           |   4 +-
 arch/s390/include/asm/atomic.h          |  98 ++++++----
 arch/s390/include/asm/atomic_ops.h      |  76 +++++++-
 arch/s390/include/asm/bitops.h          |  93 ++++-----
 arch/s390/include/asm/ccwdev.h          |   3 -
 arch/s390/include/asm/cmpxchg.h         | 168 ++++++++++++++--
 arch/s390/include/asm/entry-common.h    |   4 -
 arch/s390/include/asm/pci.h             |  10 +-
 arch/s390/include/asm/qdio.h            |  22 +--
 arch/s390/include/asm/spinlock.h        |   2 +-
 arch/s390/include/asm/spinlock_types.h  |   2 +-
 arch/s390/include/asm/stacktrace.h      |   1 +
 arch/s390/include/asm/vdso/data.h       |   2 +-
 arch/s390/kernel/Makefile               |   2 +-
 arch/s390/kernel/cpcmd.c                |   6 +-
 arch/s390/kernel/dis.c                  |   2 +-
 arch/s390/kernel/dumpstack.c            |  12 +-
 arch/s390/kernel/entry.S                |   7 +-
 arch/s390/kernel/entry.h                |  25 +--
 arch/s390/kernel/ipl.c                  |   4 +-
 arch/s390/kernel/irq.c                  |   2 +-
 arch/s390/kernel/os_info.c              |   2 +-
 arch/s390/kernel/perf_event.c           |  21 --
 arch/s390/kernel/pgm_check.S            | 147 --------------
 arch/s390/kernel/setup.c                |   2 +-
 arch/s390/kernel/time.c                 |  10 +-
 arch/s390/kernel/traps.c                |  76 +++++++-
 arch/s390/kernel/uv.c                   |  47 ++++-
 arch/s390/lib/test_unwind.c             |  19 +-
 arch/s390/mm/fault.c                    |  18 +-
 arch/s390/mm/page-states.c              |   8 +-
 arch/s390/pci/pci.c                     | 132 ++++++++-----
 arch/s390/pci/pci_bus.c                 | 331 +++++++++++++++++++++++---------
 arch/s390/pci/pci_bus.h                 |   6 +
 arch/s390/pci/pci_event.c               |  96 ++++-----
 arch/s390/pci/pci_sysfs.c               |  44 +++++
 drivers/pci/hotplug/s390_pci_hpc.c      |  59 +-----
 drivers/s390/char/con3215.c             |   3 +-
 drivers/s390/char/sclp.c                |   6 +-
 drivers/s390/char/sclp_con.c            |  28 +--
 drivers/s390/char/sclp_tty.c            |  18 +-
 drivers/s390/char/sclp_vt220.c          |   9 +-
 drivers/s390/cio/Makefile               |   4 +-
 drivers/s390/cio/chp.c                  |   3 +-
 drivers/s390/cio/cio_debug.h            |   3 +
 drivers/s390/cio/cio_debugfs.c          |  23 +++
 drivers/s390/cio/cio_inject.c           | 171 +++++++++++++++++
 drivers/s390/cio/cio_inject.h           |  18 ++
 drivers/s390/cio/css.c                  |   6 +-
 drivers/s390/cio/ioasm.c                |  23 ++-
 drivers/s390/cio/qdio.h                 |  10 -
 drivers/s390/cio/qdio_main.c            |  63 +-----
 drivers/s390/cio/qdio_setup.c           |  49 +----
 drivers/s390/crypto/vfio_ap_ops.c       | 308 ++++++++++++++++++++---------
 drivers/s390/crypto/vfio_ap_private.h   |   2 +
 drivers/s390/crypto/zcrypt_card.c       |   1 +
 drivers/s390/crypto/zcrypt_queue.c      |   1 +
 drivers/s390/net/qeth_core.h            |   3 +-
 drivers/s390/net/qeth_core_main.c       | 102 +++++-----
 drivers/s390/scsi/zfcp_qdio.c           |   7 +-
 67 files changed, 1491 insertions(+), 977 deletions(-)
 delete mode 100644 arch/s390/kernel/pgm_check.S
 create mode 100644 drivers/s390/cio/cio_debugfs.c
 create mode 100644 drivers/s390/cio/cio_inject.c
 create mode 100644 drivers/s390/cio/cio_inject.h

