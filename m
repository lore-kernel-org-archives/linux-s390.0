From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 0/1] s390 preparation for vcpu preempted check
Date: Thu, 29 Sep 2016 17:51:04 +0200
Message-ID: <1475164265-246160-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, xen-devel-request@lists.xenproject.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch should enable s390 support for the upcoming vcpu
preempt check support, but it should compile and work fine 
without that patch set as well.

Christian Borntraeger (1):
  s390/spinlock: Provide vcpu_is_preempted

 arch/s390/include/asm/spinlock.h |  3 +++
 arch/s390/kernel/smp.c           |  9 +++++++--
 arch/s390/lib/spinlock.c         | 25 ++++++++-----------------
 3 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.5.5
