From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 00/15] Move vcpu_load and vcpu_put calls to arch code
Date: Sat, 25 Nov 2017 21:57:03 +0100
Message-ID: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Some architectures may decide to do different things during
kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
arm64 is about to do significant work in vcpu load/put when running a
vcpu, but it's problematic to do this for any other vcpu ioctl than
KVM_RUN.

Further, while it may be possible to call kvm_arch_vcpu_load() for a
number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
to reason about, especially after my optimization series, because a lot
of things can now happen, where we have to consider if we're really in
the process of running a vcpu or not.

This series will first move the vcpu_load() and vcpu_put() calls in the
arch generic dispatch function into each case of the switch statement
and then, one-by-one, pushed the calls down into the architecture
specific code making the changes for each ioctl as required.

Thanks,
-Christoffer

Christoffer Dall (15):
  KVM: Prepare for moving vcpu_load/vcpu_put into arch specific code
  KVM: Factor out vcpu->pid adjustment for KVM_RUN
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_run
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_regs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_sregs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_sregs
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_mpstate
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_mpstate
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
  KVM: Move vcpu_load to arch-specific
    kvm_arch_vcpu_ioctl_set_guest_debug
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_set_fpu
  KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl
  KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls than KVM_RUN

 arch/arm64/kvm/guest.c     |  17 +++++--
 arch/mips/kvm/mips.c       |  72 +++++++++++++++++++--------
 arch/powerpc/kvm/book3s.c  |  38 +++++++++++++-
 arch/powerpc/kvm/booke.c   |  65 +++++++++++++++++++-----
 arch/powerpc/kvm/powerpc.c |  24 ++++++---
 arch/s390/kvm/kvm-s390.c   | 119 +++++++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c         | 121 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/kvm_host.h   |   2 +
 virt/kvm/arm/arm.c         |  91 +++++++++++++++++++++++++---------
 virt/kvm/kvm_main.c        |  43 +++++++---------
 10 files changed, 463 insertions(+), 129 deletions(-)

-- 
2.14.2
