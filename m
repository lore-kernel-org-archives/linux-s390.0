From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Feb 2019 16:44:34 +0000
Subject: Re: [GIT PULL 00/18] KVM: s390: Features for 5.1
Message-Id: <4a1c37ee-82bc-55d1-0b3e-8c8e3af692a7@redhat.com>
In-Reply-To: <1550835749-26436-1-git-send-email-frankja@linux.ibm.com>
References: <1550835749-26436-1-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 22/02/19 12:42, Janosch Frank wrote:
> Paolo, Radim,
> 
> here are the s390 updates for KVM for 5.1. The largest change is the
> introduction of the GIB, which stores interruptions for guests that
> have no running vcpu.
> The "s390/cio: add function chsc_sgib()" patch has been reviewed by
> our s390 IO maintainer.
> 
> The rest is a bit of cleanup and a preparation for processor
> subfunction cpu model management usage. Some of our instructions
> indicate, which functions they provide, like different crypto
> algorithms that are added with new machines.
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-5.1-1
> 
> for you to fetch changes up to 11ba5961a2156a4f210627ed8421387e2531b100:
> 
>   KVM: s390: add debug logging for cpu model subfunctions (2019-02-22 11:04:35 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Features for 5.1
> 
> - Clarify KVM related kernel messages
> - Interrupt cleanup
> - Introduction of the Guest Information Block (GIB)
> - Preparation for processor subfunctions in cpu model
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>       KVM: s390: implement subfunction processor calls
>       KVM: s390: add debug logging for cpu model subfunctions
> 
> Michael Mueller (16):
>       KVM: s390: clarify kvm related kernel message
>       KVM: s390: drop obsolete else path
>       KVM: s390: make bitmap declaration consistent
>       KVM: s390: move bitmap idle_mask into arch struct top level
>       KVM: s390: coding style kvm_s390_gisa_init/clear()
>       KVM: s390: use pending_irqs_no_gisa() where appropriate
>       KVM: s390: remove kvm_s390_ from gisa static inline functions
>       KVM: s390: introduce struct kvm_s390_gisa_interrupt
>       s390/cio: add function chsc_sgib()
>       KVM: s390: add the GIB and its related life-cyle functions
>       KVM: s390: add kvm reference to struct sie_page2
>       KVM: s390: add functions to (un)register GISC with GISA
>       KVM: s390: kvm_s390_gisa_clear() now clears the IPM only
>       KVM: s390: add gib_alert_irq_handler()
>       KVM: s390: start using the GIB
>       KVM: s390: fix possible null pointer dereference in pending_irqs()
> 
>  arch/s390/include/asm/cio.h      |   1 +
>  arch/s390/include/asm/irq.h      |   1 +
>  arch/s390/include/asm/isc.h      |   1 +
>  arch/s390/include/asm/kvm_host.h |  37 +++-
>  arch/s390/kernel/irq.c           |   1 +
>  arch/s390/kvm/interrupt.c        | 431 +++++++++++++++++++++++++++++++++++----
>  arch/s390/kvm/kvm-s390.c         | 190 +++++++++++++++--
>  arch/s390/kvm/kvm-s390.h         |   4 +-
>  drivers/s390/cio/chsc.c          |  37 ++++
>  drivers/s390/cio/chsc.h          |   1 +
>  10 files changed, 642 insertions(+), 62 deletions(-)
> 

Pulled, thanks.

Paolo
