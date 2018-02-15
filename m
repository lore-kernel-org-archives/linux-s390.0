From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Hpage capability rework
Date: Thu, 15 Feb 2018 16:43:19 +0100
Message-ID: <1518709402-91101-1-git-send-email-frankja@linux.vnet.ibm.com>
References: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <28551222-18a6-4566-0b7a-acc366c860c3@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I'm not yet done cleaning up, so I rather have an update here than
sending a new version. The first to patches also clean up cmma, pfmfi
and skf fixing the use_cmma naming annoyance.

Janosch Frank (3):
  KVM: s390: Refactor host cmma and pfmfi interpretation controls
  KVM: s390: Add storage key facility interpretation control
  s390/mm: Enable gmap huge pmd support

 Documentation/virtual/kvm/api.txt   | 12 +++++++++++
 arch/s390/include/asm/kvm_host.h    |  4 +++-
 arch/s390/include/asm/mmu.h         |  2 ++
 arch/s390/include/asm/mmu_context.h |  1 +
 arch/s390/kvm/kvm-s390.c            | 41 ++++++++++++++++++++++++++-----------
 arch/s390/kvm/priv.c                | 24 +++++++++++++---------
 arch/s390/mm/gmap.c                 |  8 +++++---
 include/uapi/linux/kvm.h            |  1 +
 8 files changed, 67 insertions(+), 26 deletions(-)

-- 
2.7.4
