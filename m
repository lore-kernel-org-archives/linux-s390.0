From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH RFC 0/2] KVM: use RCU to allow dynamic kvm->vcpus array
Date: Wed, 16 Aug 2017 21:40:35 +0200
Message-ID: <20170816194037.9460-1-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

The goal is to increase KVM_MAX_VCPUS without worrying about memory
impact of many small guests.

This is a second out of three major "dynamic" options:
 1) size vcpu array at VM creation time
 2) resize vcpu array when new VCPUs are created
 3) use a lockless list/tree for VCPUs

The disadvantage of (1) is its requirement on userspace changes and
limited flexibility because userspace must provide the maximal count on
start.  The main advantage is that kvm->vcpus will work like it does
now.  It has been posted as "[PATCH 0/4] KVM: add KVM_CREATE_VM2 to
allow dynamic kvm->vcpus array",
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1377285.html

The main problem of (2), this series, is that we cannot extend the array
in place and therefore require some kind of protection when moving it.
RCU seems best, but it makes the code slower and harder to deal with.
The main advantage is that we do not need userspace changes.

The third option wasn't explored yet.  It would solve the ugly
kvm_for_each_vcpu() of (2), but kvm_get_vcpu() would become linear.
(We could mitigate it by having list of vcpu arrays and A lockless
 sequentially growing "tree" would be logarithmic and not that much more
 complicated to implement.)

Which option do you think is the best?

Thanks.

Radim Krčmář (2):
  KVM: remove unused __KVM_HAVE_ARCH_VM_ALLOC
  KVM: RCU protected dynamic vcpus array

 arch/mips/kvm/mips.c       |  8 +++--
 arch/powerpc/kvm/powerpc.c |  6 ++--
 arch/s390/kvm/kvm-s390.c   | 27 ++++++++++++-----
 arch/x86/kvm/hyperv.c      |  3 +-
 arch/x86/kvm/vmx.c         |  3 +-
 arch/x86/kvm/x86.c         |  5 ++--
 include/linux/kvm_host.h   | 73 +++++++++++++++++++++++++++++-----------------
 virt/kvm/arm/arm.c         | 10 +++----
 virt/kvm/kvm_main.c        | 72 +++++++++++++++++++++++++++++++++++++--------
 9 files changed, 144 insertions(+), 63 deletions(-)

-- 
2.13.3
