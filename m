From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC][PATCH 0/5] s390: improve speculative execution handling v2
Date: Tue, 23 Jan 2018 14:07:00 +0100
Message-ID: <1516712825-2917-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Version 2 of the speculative execution mitigation for s390. Changes to v1:

* The KVM patch to add the guest bpb feature already went upstream.
* Dropped the patch to introduce the gmb barrier to defend against spectre
  variant 1 until the bikeshedding in regard to the naming is done.
* Switched from a system call to the PR_ISOLATE_BP process control to run
  user space tasks with branch prediction isolation.

My main question is if the prctl(PR_ISOLATE_BP) makes sense.

Martin Schwidefsky (5):
  prctl: add PR_ISOLATE_BP process control
  s390/alternative: use a copy of the facility bit mask
  s390: add options to change branch prediction behaviour for the kernel
  s390: define ISOLATE_BP to run tasks with modified branch prediction
  s390: scrub registers on kernel entry and KVM exit

 arch/s390/Kconfig                   |  17 +++++
 arch/s390/include/asm/facility.h    |  18 +++++
 arch/s390/include/asm/lowcore.h     |   3 +-
 arch/s390/include/asm/processor.h   |   4 ++
 arch/s390/include/asm/thread_info.h |   4 ++
 arch/s390/kernel/alternative.c      |  26 ++++++-
 arch/s390/kernel/early.c            |   5 ++
 arch/s390/kernel/entry.S            | 134 +++++++++++++++++++++++++++++++++++-
 arch/s390/kernel/ipl.c              |   1 +
 arch/s390/kernel/processor.c        |   8 +++
 arch/s390/kernel/setup.c            |   4 +-
 arch/s390/kernel/smp.c              |   6 +-
 include/uapi/linux/prctl.h          |   8 +++
 kernel/sys.c                        |   6 ++
 14 files changed, 238 insertions(+), 6 deletions(-)

-- 
2.7.4
