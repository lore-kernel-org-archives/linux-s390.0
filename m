Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgFTPWF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 20 Jun 2020 11:22:05 -0400
Date: Sat, 20 Jun 2020 17:21:56 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.8-rc2
Message-ID: <your-ad-here.call-01592666516-ext-8102@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.8-rc2.

Thank you,
Vasily

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-2

for you to fetch changes up to b3583fca5fb654af2cfc1c08259abb9728272538:

  s390: fix syscall_get_error for compat processes (2020-06-17 23:05:05 +0200)

----------------------------------------------------------------
s390 fixes for 5.8-rc2

- Few ptrace fixes mostly for strace and seccomp_bpf kernel tests
  findings.

- Cleanup unused pm callbacks in virtio ccw.

- Replace kmalloc + memset with kzalloc in crypto.

- Use $(LD) for vDSO linkage to make clang happy.

- Fix vDSO clock_getres() to preserve the same behaviour as
  posix_get_hrtimer_res().

- Fix workqueue cpumask warning when NUMA=n and nr_node_ids=2.

- Reduce SLSB writes during input processing, improve warnings and
  cleanup qdio_data usage in qdio.

- Few fixes to use scnprintf() instead of snprintf().

----------------------------------------------------------------
Chen Zhou (3):
      s390/crypto: use scnprintf() instead of snprintf()
      s390: use scnprintf() in sys_##_prefix##_##_name##_show
      s390/protvirt: use scnprintf() instead of snprintf()

Cornelia Huck (1):
      s390/virtio: remove unused pm callbacks

Dmitry V. Levin (1):
      s390: fix syscall_get_error for compat processes

Heiko Carstens (1):
      s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES

Julian Wiedmann (4):
      s390/qdio: fine-tune SLSB update
      s390/qdio: reduce SLSB writes during Input Queue processing
      s390/qdio: clean up usage of qdio_data
      s390/qdio: warn about unexpected SLSB states

Nathan Chancellor (1):
      s390/vdso: Use $(LD) instead of $(CC) to link vDSO

Sven Schnelle (5):
      s390/seccomp: pass syscall arguments via seccomp_data
      s390/ptrace: return -ENOSYS when invalid syscall is supplied
      s390/ptrace: pass invalid syscall numbers to tracing
      s390/ptrace: fix setting syscall number
      selftests/seccomp: s390 shares the syscall and return value register

Vincenzo Frascino (1):
      s390/vdso: fix vDSO clock_getres()

Zou Wei (1):
      s390/zcrypt: use kzalloc

 arch/s390/Kconfig                             |   1 +
 arch/s390/crypto/prng.c                       |  14 ++--
 arch/s390/include/asm/syscall.h               |  12 ++-
 arch/s390/include/asm/vdso.h                  |   1 +
 arch/s390/kernel/asm-offsets.c                |   2 +-
 arch/s390/kernel/entry.S                      |   2 +-
 arch/s390/kernel/ipl.c                        |   2 +-
 arch/s390/kernel/ptrace.c                     |  83 +++++++++++++++++----
 arch/s390/kernel/time.c                       |   1 +
 arch/s390/kernel/uv.c                         |   8 +-
 arch/s390/kernel/vdso64/Makefile              |  10 +--
 arch/s390/kernel/vdso64/clock_getres.S        |  10 +--
 drivers/s390/cio/qdio.h                       |   7 +-
 drivers/s390/cio/qdio_debug.c                 |   4 +-
 drivers/s390/cio/qdio_main.c                  | 101 +++++++++++---------------
 drivers/s390/crypto/zcrypt_ep11misc.c         |   3 +-
 drivers/s390/virtio/virtio_ccw.c              |  26 -------
 tools/testing/selftests/seccomp/seccomp_bpf.c |   1 +
 18 files changed, 154 insertions(+), 134 deletions(-)
