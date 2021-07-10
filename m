Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DFDC07E95
	for <linux-s390@archiver.kernel.org>; Sat, 10 Jul 2021 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7386361363
	for <linux-s390@archiver.kernel.org>; Sat, 10 Jul 2021 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhGJNzu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:55:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhGJNzu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 10 Jul 2021 09:55:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16ACrPth012324;
        Sat, 10 Jul 2021 09:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=p26rw0hSYyySHclACB5byNgqqHmqXRk4rhAV78Cbbvw=;
 b=bd1BX9+G5u393I2YfroGJ79mDmbpT6Q6Uc10ZPkg7hOnYjEOyCZ52ippdEuO9BLWzTvi
 ieOeXs3VrIn8vLja6RFGL15JuP9ecd2RCb+tw00eYnA9gGjsZcQx5SFSs7+V6BiIzmUH
 d73MiAvGjZnJ4YWpIe78SJonPGWgjZxXUVPFdY3HQVDLdsYMKDMdHojWKC7G3VICSoN3
 mB57w8IN1MpMwwahoB+lrzs5USVk6c+KKy+pa/uE5FaJYgBT+wK0R90p63wK4J4yGeet
 IEaUr+bX4oK7JDTe6D55IG4yqv1MtaQCHACroC8bEsDSqGAcbw2qdIu66L5omu8jmjRo 4A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39q7pxn6x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jul 2021 09:53:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16ADqYK5020283;
        Sat, 10 Jul 2021 13:53:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39q368849a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jul 2021 13:53:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16ADouiZ36634894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Jul 2021 13:50:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32FCC11C04A;
        Sat, 10 Jul 2021 13:52:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB86711C050;
        Sat, 10 Jul 2021 13:52:57 +0000 (GMT)
Received: from localhost (unknown [9.171.5.66])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Jul 2021 13:52:57 +0000 (GMT)
Date:   Sat, 10 Jul 2021 15:52:56 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.14 merge window #2
Message-ID: <your-ad-here.call-01625925176-ext-2826@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0MFhw6Sim_1MzT-TM7RYd4WPF7xzndX5
X-Proofpoint-ORIG-GUID: 0MFhw6Sim_1MzT-TM7RYd4WPF7xzndX5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-10_02:2021-07-09,2021-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107100024
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull the second round of s390 fixes and features for 5.14.

Thank you,
Vasily

The following changes since commit 2bb919b62f6e5959552a90a399d09d683afa3d1d:

  Merge tag 's390-5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2021-07-04 12:17:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-2

for you to fetch changes up to 6a942f5780545ebd11aca8b3ac4b163397962322:

  s390: preempt: Fix preempt_count initialization (2021-07-08 22:12:18 +0200)

----------------------------------------------------------------
s390 updates for the 5.14 merge window #2

- Fix preempt_count initialization.

- Rework call_on_stack() macro to add proper type handling and avoid
  possible register corruption.

- More error prone "register asm" removal and fixes.

- Fix syscall restarting when multiple signals are coming in. This adds
  minimalistic trampolines to vdso so we can return from signal without
  using the stack which requires pgm check handler hacks when NX is
  enabled.

- Remove HAVE_IRQ_EXIT_ON_IRQ_STACK since this is no longer true after
  switch to generic entry.

- Fix protected virtualization secure storage access exception handling.

- Make machine check C handler always enter with DAT enabled and move
  register validation to C code.

- Fix tinyconfig boot problem by avoiding MONITOR CALL without CONFIG_BUG.

- Increase asm symbols alignment to 16 to make it consistent with
  compilers.

- Enable concurrent access to the CPU Measurement Counter Facility.

- Add support for dynamic AP bus size limit and rework ap_dqap to deal
  with messages greater than recv buffer.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/boot: replace magic string check with a bootdata flag

Alexander Gordeev (6):
      s390/entry.S: factor out SIEEXIT macro
      s390/mcck: optimize user mode check in case of !CONFIG_KVM
      s390/mcck: always enter C handler with DAT enabled
      s390/mcck: move storage error checks to assembler
      s390/mcck: keep machine check interruption codes sorted
      s390/mcck: move register validation to C code

Harald Freudenberger (3):
      s390/AP: support new dynamic AP bus size limit
      s390/ap: Rework ap_dqap to deal with messages greater than recv buffer
      s390/ap: get rid of register asm in ap_dqap()

Heiko Carstens (16):
      s390/lib,uaccess: fix copy_in_user_mvcos() inline asm clobber list
      s390/lib,string: fix strcat() inline asm constraint modifier
      s390/ap: get rid of register asm
      s390/irq: simplify do_softirq_own_stack()
      s390/irq: inline do_softirq_own_stack()
      s390/irq: simplify on_async_stack()
      s390: introduce proper type handling call_on_stack() macro
      s390/mm: use call_on_stack() macro
      s390/irq: use call_on_stack() macro
      s390/kexec: use call_on_stack() macro
      s390/smp: use call_on_stack() macro
      s390/lib: use call_on_stack() macro
      s390/softirq: use call_on_stack() macro
      s390: remove old CALL_ON_STACK() macro
      s390: add type checking to CALL_ON_STACK_NORETURN() macro
      s390: rename CALL_ON_STACK_NORETURN() to call_on_stack_noreturn()

Ilya Leoshkevich (1):
      s390/traps: do not test MONITOR CALL without CONFIG_BUG

Janosch Frank (1):
      s390: mm: Fix secure storage access exception handling

Kefeng Wang (1):
      s390/kprobes: use is_kernel() helper

Sven Schnelle (9):
      s390/irq: remove HAVE_IRQ_EXIT_ON_IRQ_STACK
      s390/vdso: always enable vdso
      s390/vdso64: add sigreturn,rt_sigreturn and restart_syscall
      s390/vdso: rename VDSO64_LBASE to VDSO_LBASE
      s390/vdso: add minimal compat vdso
      s390/signal: switch to using vdso for sigreturn and syscall restart
      s390/signal: remove sigreturn on stack
      s390: move restart of execve() syscall
      s390: rename PIF_SYSCALL_RESTART to PIF_EXECVE_PGSTE_RESTART

Thomas Richter (1):
      s390/cpumf: Allow concurrent access for CPU Measurement Counter Facility

Valentin Schneider (1):
      s390: preempt: Fix preempt_count initialization

Vasily Gorbik (1):
      s390/linkage: increase asm symbols alignment to 16

 arch/s390/Kconfig                           |    2 +-
 arch/s390/Makefile                          |   13 +
 arch/s390/boot/startup.c                    |    1 +
 arch/s390/boot/uv.c                         |    1 +
 arch/s390/include/asm/ap.h                  |  220 +++--
 arch/s390/include/asm/cpu_mcf.h             |   36 +-
 arch/s390/include/asm/ctl_reg.h             |    2 -
 arch/s390/include/asm/elf.h                 |   15 +-
 arch/s390/include/asm/entry-common.h        |    1 -
 arch/s390/include/asm/linkage.h             |    2 +-
 arch/s390/include/asm/nmi.h                 |    6 +-
 arch/s390/include/asm/preempt.h             |   16 +-
 arch/s390/include/asm/ptrace.h              |   24 +-
 arch/s390/include/asm/setup.h               |    2 +
 arch/s390/include/asm/softirq_stack.h       |   13 +
 arch/s390/include/asm/stacktrace.h          |  116 ++-
 arch/s390/include/asm/uv.h                  |    8 +-
 arch/s390/include/asm/vdso.h                |   25 +-
 arch/s390/include/asm/vdso/gettimeofday.h   |    1 -
 arch/s390/kernel/Makefile                   |    2 +-
 arch/s390/kernel/asm-offsets.c              |    6 -
 arch/s390/kernel/compat_signal.c            |   13 +-
 arch/s390/kernel/early.c                    |    4 +-
 arch/s390/kernel/entry.S                    |  141 ++--
 arch/s390/kernel/irq.c                      |   28 +-
 arch/s390/kernel/kprobes.c                  |    9 +-
 arch/s390/kernel/machine_kexec.c            |    3 +-
 arch/s390/kernel/nmi.c                      |  129 +--
 arch/s390/kernel/perf_cpum_cf.c             | 1026 +++++++++++++++++++++++-
 arch/s390/kernel/perf_cpum_cf_common.c      |   27 +-
 arch/s390/kernel/perf_cpum_cf_diag.c        | 1148 ---------------------------
 arch/s390/kernel/process.c                  |    6 +
 arch/s390/kernel/setup.c                    |    3 +-
 arch/s390/kernel/signal.c                   |   39 +-
 arch/s390/kernel/smp.c                      |   15 +-
 arch/s390/kernel/syscall.c                  |   34 +-
 arch/s390/kernel/traps.c                    |   14 +-
 arch/s390/kernel/uv.c                       |   10 +
 arch/s390/kernel/vdso.c                     |   63 +-
 arch/s390/kernel/vdso32/.gitignore          |    2 +
 arch/s390/kernel/vdso32/Makefile            |   75 ++
 arch/s390/kernel/vdso32/gen_vdso_offsets.sh |   15 +
 arch/s390/kernel/vdso32/note.S              |   13 +
 arch/s390/kernel/vdso32/vdso32.lds.S        |  141 ++++
 arch/s390/kernel/vdso32/vdso32_wrapper.S    |   15 +
 arch/s390/kernel/vdso32/vdso_user_wrapper.S |   21 +
 arch/s390/kernel/vdso64/Makefile            |    8 +
 arch/s390/kernel/vdso64/gen_vdso_offsets.sh |   15 +
 arch/s390/kernel/vdso64/vdso64.lds.S        |    5 +-
 arch/s390/kernel/vdso64/vdso_user_wrapper.S |   17 +
 arch/s390/lib/string.c                      |    2 +-
 arch/s390/lib/test_unwind.c                 |    5 +-
 arch/s390/lib/uaccess.c                     |    2 +-
 arch/s390/mm/fault.c                        |   49 +-
 arch/s390/mm/maccess.c                      |   13 +-
 drivers/s390/crypto/ap_bus.c                |   50 +-
 drivers/s390/crypto/ap_bus.h                |   11 +-
 drivers/s390/crypto/ap_card.c               |   16 +-
 drivers/s390/crypto/ap_queue.c              |   28 +-
 drivers/s390/crypto/zcrypt_api.c            |    6 +
 drivers/s390/crypto/zcrypt_cex4.c           |    9 +-
 drivers/s390/crypto/zcrypt_msgtype50.c      |   26 +-
 drivers/s390/crypto/zcrypt_msgtype6.c       |   54 +-
 drivers/s390/crypto/zcrypt_msgtype6.h       |    2 -
 drivers/s390/crypto/zcrypt_queue.c          |    6 +-
 include/linux/cpuhotplug.h                  |    1 -
 66 files changed, 2110 insertions(+), 1721 deletions(-)
 create mode 100644 arch/s390/include/asm/softirq_stack.h
 delete mode 100644 arch/s390/kernel/perf_cpum_cf_diag.c
 create mode 100644 arch/s390/kernel/vdso32/.gitignore
 create mode 100644 arch/s390/kernel/vdso32/Makefile
 create mode 100755 arch/s390/kernel/vdso32/gen_vdso_offsets.sh
 create mode 100644 arch/s390/kernel/vdso32/note.S
 create mode 100644 arch/s390/kernel/vdso32/vdso32.lds.S
 create mode 100644 arch/s390/kernel/vdso32/vdso32_wrapper.S
 create mode 100644 arch/s390/kernel/vdso32/vdso_user_wrapper.S
 create mode 100755 arch/s390/kernel/vdso64/gen_vdso_offsets.sh
