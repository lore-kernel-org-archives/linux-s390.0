From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 00/10] KVM: s390: Fixes for 4.4
Date: Tue, 13 Oct 2015 16:45:30 +0200
Message-ID: <561D190A.7030001@redhat.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 13/10/2015 16:05, Christian Borntraeger wrote:
> Paolo,
> 
> The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:
> 
>   Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20151013
> 
> for you to fetch changes up to 60417fcc2b0235dfe3dcd589c56dbe3ea1a64c54:
> 
>   KVM: s390: factor out reading of the guest TOD clock (2015-10-13 15:50:35 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes for 4.4
> 
> A bunch of fixes and optimizations for interrupt and time
> handling. No fix is important enough to qualify for 4.3 or
> stable.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: remove unused variable in __inject_vm
> 
> David Hildenbrand (9):
>       KVM: s390: disabled wait cares about machine checks, not PER
>       KVM: s390: set interception requests for all floating irqs
>       KVM: s390: kvm_arch_vcpu_runnable already cares about timer interrupts
>       KVM: s390: drop out early in kvm_s390_has_irq()
>       KVM: s390: simplify in-kernel program irq injection
>       KVM: s390: correctly handle injection of pgm irqs and per events
>       KVM: s390: switch to get_tod_clock() and fix STP sync races
>       KVM: s390: factor out and fix setting of guest TOD clock
>       KVM: s390: factor out reading of the guest TOD clock
> 
>  arch/s390/kvm/interrupt.c | 116 +++++++++++++++++-----------------------------
>  arch/s390/kvm/kvm-s390.c  |  46 ++++++++----------
>  arch/s390/kvm/kvm-s390.h  |  35 ++++++++++++--
>  arch/s390/kvm/priv.c      |  19 ++------
>  4 files changed, 97 insertions(+), 119 deletions(-)
> 

Pulled, thanks.

Paolo
