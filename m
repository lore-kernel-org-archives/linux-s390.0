Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgHVMht (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 22 Aug 2020 08:37:49 -0400
Date: Sat, 22 Aug 2020 14:37:40 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9-rc2
Message-ID: <your-ad-here.call-01598099860-ext-4027@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc2.

Thank you,
Vasily

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-3

for you to fetch changes up to b97bf44f99155e57088e16974afb1f2d7b5287aa:

  s390/pci: fix PF/VF linking on hot plug (2020-08-17 13:17:34 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc2

- Couple of fixes for storage key handling relevant for debugging.

- Add cond_resched into potentially slow subchannels scanning loop.

- Fixes for PF/VF linking and to ignore stale PCI configuration request
  events.

----------------------------------------------------------------
Heiko Carstens (2):
      s390/runtime_instrumentation: fix storage key handling
      s390/ptrace: fix storage key handling

Niklas Schnelle (4):
      s390/pci: ignore stale configuration request event
      s390/pci: fix zpci_bus_link_virtfn()
      s390/pci: re-introduce zpci_remove_device()
      s390/pci: fix PF/VF linking on hot plug

Vineeth Vijayan (1):
      s390/cio: add cond_resched() in the slow_eval_known_fn() loop

 arch/s390/kernel/ptrace.c          |  7 +++--
 arch/s390/kernel/runtime_instr.c   |  2 +-
 arch/s390/pci/pci.c                | 22 +++++++++++-----
 arch/s390/pci/pci_bus.c            | 52 ++++++++++++++++++++++----------------
 arch/s390/pci/pci_bus.h            | 13 ++++++++++
 arch/s390/pci/pci_event.c          |  7 +++--
 drivers/pci/hotplug/s390_pci_hpc.c | 12 ++++-----
 drivers/s390/cio/css.c             |  5 ++++
 8 files changed, 79 insertions(+), 41 deletions(-)
