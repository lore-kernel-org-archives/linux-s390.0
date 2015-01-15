From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 00/21] KVM: s390: fixes and features for kvm/next (3.20)
Date: Thu, 15 Jan 2015 14:43:13 +0100
Message-ID: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

I will send a pull request for the below patches next week. Since some of
these patches add new interfaces, I want to give people some days to
complain if anything doesn't look right.

There is one interesting problem that popped up when we acidentially
enabled ntp. All KVM architectures use hrtimers for wakeups. These
timers follow adjclock of the host, causing several interesting issues.

Providing a RAW variant of these timers might be the right thing to do.
David will look into this. For now we will just make sure that things
don't break on s390. (x86 seems to have no hangs, but wakeups might
be too early or too late there as well).

Christian

The following changes since commit bab5bb398273bb37547a185f7b344b37c700d0b9:

  kvm: x86: Remove kvm_make_request from lapic.c (2015-01-08 22:48:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150115

for you to fetch changes up to 68f78d77fb1a2bae65d6d567b18f59c2515971d0:

  KVM: s390/cpacf: Enable/disable protected key functions for kvm guest (2015-01-15 12:48:58 +0100)

----------------------------------------------------------------
KVM: s390: fixes and features for kvm/next (3.20)

1. Generic
- sparse warning (make function static)
- optimize locking
- bugfixes for interrupt injection
- fix MVPG addressing modes

2. hrtimer/wakeup fun
A recent change can cause KVM hangs if adjtime is used in the host.
The hrtimer might wake up too early or too late. Too early is fatal
as vcpu_block will see that the wakeup condition is not met and
sleep again. This CPU might never wake up again.
This series addresses this problem. adjclock slowing down the host
clock will result in too late wakeups. This will require more work.
In addition to that we also change the hrtimer from REALTIME to
MONOTONIC to avoid similar problems with timedatectl set-time.

3. sigp rework
We will move all "slow" sigps to QEMU (protected with a capability that
can be enabled) to avoid several races between concurrent SIGP orders.

4. Optimize the shadow page table
Provide an interface to announce the maximum guest size. The kernel
will use that to make the pagetable 2,3,4 (or theoretically) 5 levels.

5. Provide an interface to set the guest TOD
We now use two vm attributes instead of two oneregs, as oneregs are
vcpu ioctl and we don't want to call them from other threads.

6. Protected key functions
The real HMC allows to enable/disable protected key CPACF functions.
Lets provide an implementation + an interface for QEMU to activate
this.

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: make local function static
      KVM: s390: no need to hold the kvm->mutex for floating interrupts

David Hildenbrand (11):
      KVM: s390: prevent sleep duration underflows in handle_wait()
      KVM: s390: base hrtimer on a monotonic clock
      KVM: s390: forward hrtimer if guest ckc not pending yet
      KVM: s390: new parameter for SIGP STOP irqs
      KVM: s390: handle stop irqs without action_bits
      KVM: s390: a VCPU may only stop when no interrupts are left pending
      KVM: s390: SIGP SET PREFIX cleanup
      s390/sclp: introduce check for the SIGP Interpretation Facility
      KVM: s390: only one external call may be pending at a time
      KVM: s390: clear the pfault queue if user space sets the invalid token
      KVM: s390: forward most SIGP orders to user space

Dominik Dingel (3):
      KVM: remove unneeded return value of vcpu_postcreate
      KVM: s390: move vcpu specific initalization to a later point
      KVM: s390: Allow userspace to limit guest memory size

Jason J. Herne (1):
      KVM: s390: Provide guest TOD Clock Get/Set Controls

Jens Freimann (2):
      KVM: s390: fix bug in sigp emergency signal injection
      KVM: s390: trace correct values for set prefix and machine checks

Thomas Huth (1):
      KVM: s390: Take addressing mode into account for MVPG interception

Tony Krowiak (1):
      KVM: s390/cpacf: Enable/disable protected key functions for kvm guest

 Documentation/virtual/kvm/api.txt        |  22 ++-
 Documentation/virtual/kvm/devices/vm.txt |  14 ++
 arch/arm/kvm/arm.c                       |   3 +-
 arch/mips/kvm/mips.c                     |   3 +-
 arch/powerpc/kvm/powerpc.c               |   3 +-
 arch/s390/include/asm/kvm_host.h         |  28 +--
 arch/s390/include/asm/sclp.h             |   4 +-
 arch/s390/include/uapi/asm/kvm.h         |  16 ++
 arch/s390/kvm/intercept.c                |  41 ++--
 arch/s390/kvm/interrupt.c                | 178 ++++++++++++-----
 arch/s390/kvm/kvm-s390.c                 | 324 ++++++++++++++++++++++++++++---
 arch/s390/kvm/kvm-s390.h                 |   6 +-
 arch/s390/kvm/sigp.c                     | 160 ++++++++-------
 arch/s390/kvm/trace-s390.h               |  14 +-
 arch/x86/kvm/x86.c                       |  10 +-
 drivers/s390/char/sclp_early.c           |   8 +
 include/linux/kvm_host.h                 |   2 +-
 include/uapi/linux/kvm.h                 |   7 +
 18 files changed, 649 insertions(+), 194 deletions(-)
