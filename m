Return-Path: <linux-kselftest-owner@vger.kernel.org>
References: <20190523164309.13345-1-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 May 2019 13:11:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190523164309.13345-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0ad63449-c329-f38d-b879-6e427e6a8656@de.ibm.com>
Subject: Re:  [PATCH v1 0/9] KVM selftests for s390x
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org

I do get

[10400.440298] kvm-s390: failed to commit memory region
[10400.508723] kvm-s390: failed to commit memory region

when running the tests. Will have a look.

On 23.05.19 18:43, Thomas Huth wrote:
> This patch series enables the KVM selftests for s390x. As a first
> test, the sync_regs from x86 has been adapted to s390x, and after
> a fix for KVM_CAP_MAX_VCPU_ID on s390x, the kvm_create_max_vcpus
> is now enabled here, too.
> 
> Please note that the ucall() interface is not used yet - since
> s390x neither has PIO nor MMIO, this needs some more work first
> before it becomes usable (we likely should use a DIAG hypercall
> here, which is what the sync_reg test is currently using, too...
> I started working on that topic, but did not finish that work
> yet, so I decided to not include it yet).
> 
> RFC -> v1:
>  - Rebase, needed to add the first patch for vcpu_nested_state_get/set
>  - Added patch to introduce VM_MODE_DEFAULT macro
>  - Improved/cleaned up the code in processor.c
>  - Added patch to fix KVM_CAP_MAX_VCPU_ID on s390x
>  - Added patch to enable the kvm_create_max_vcpus on s390x and aarch64
> 
> Andrew Jones (1):
>   kvm: selftests: aarch64: fix default vm mode
> 
> Thomas Huth (8):
>   KVM: selftests: Wrap vcpu_nested_state_get/set functions with x86
>     guard
>   KVM: selftests: Guard struct kvm_vcpu_events with
>     __KVM_HAVE_VCPU_EVENTS
>   KVM: selftests: Introduce a VM_MODE_DEFAULT macro for the default bits
>   KVM: selftests: Align memory region addresses to 1M on s390x
>   KVM: selftests: Add processor code for s390x
>   KVM: selftests: Add the sync_regs test for s390x
>   KVM: s390: Do not report unusabled IDs via KVM_CAP_MAX_VCPU_ID
>   KVM: selftests: Move kvm_create_max_vcpus test to generic code
> 
>  MAINTAINERS                                   |   2 +
>  arch/mips/kvm/mips.c                          |   3 +
>  arch/powerpc/kvm/powerpc.c                    |   3 +
>  arch/s390/kvm/kvm-s390.c                      |   1 +
>  arch/x86/kvm/x86.c                            |   3 +
>  tools/testing/selftests/kvm/Makefile          |   7 +-
>  .../testing/selftests/kvm/include/kvm_util.h  |  10 +
>  .../selftests/kvm/include/s390x/processor.h   |  22 ++
>  .../kvm/{x86_64 => }/kvm_create_max_vcpus.c   |   3 +-
>  .../selftests/kvm/lib/aarch64/processor.c     |   2 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  25 +-
>  .../selftests/kvm/lib/s390x/processor.c       | 286 ++++++++++++++++++
>  .../selftests/kvm/lib/x86_64/processor.c      |   2 +-
>  .../selftests/kvm/s390x/sync_regs_test.c      | 151 +++++++++
>  virt/kvm/arm/arm.c                            |   3 +
>  virt/kvm/kvm_main.c                           |   2 -
>  16 files changed, 514 insertions(+), 11 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/s390x/processor.h
>  rename tools/testing/selftests/kvm/{x86_64 => }/kvm_create_max_vcpus.c (93%)
>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/processor.c
>  create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c
> 
