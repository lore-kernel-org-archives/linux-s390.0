From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [GIT PULL 0/9] KVM: s390: Fixes and features for kvm/next (4.6)
 part 2
Date: Thu, 10 Mar 2016 17:07:45 +0100
Message-ID: <56E19BD1.5000803@redhat.com>
References: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457624219-110920-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 10/03/2016 16:36, Christian Borntraeger wrote:
> Paolo,
> 
> the remaining patches for 4.6 on the s390 side.
> 
> The following changes since commit 1763f8d09d522b3ac998229dcf038476e88b78fc:
> 
>   KVM: s390: bail out early on fatal signal in dirty logging (2016-02-10 13:12:57 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.6-2
> 
> for you to fetch changes up to c54f0d6ae057444453f5167e66ed999e8cf26936:
> 
>   KVM: s390: allocate only one DMA page per VM (2016-03-08 13:57:54 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Fixes and features for kvm/next (4.6) part 2
> 
> - add watchdog diagnose to trace event decoder
> - better handle the cpu timer when not inside the guest
> - only provide STFLE if the CPU model has STFLE
> - reduce DMA page usage
> 
> ----------------------------------------------------------------
> Alexander Yarygin (1):
>       KVM: s390: Add diag "watchdog functions" to trace event decoding
> 
> David Hildenbrand (8):
>       KVM: s390: store cpu id in vcpu->cpu when scheduled in
>       KVM: s390: abstract access to the VCPU cpu timer
>       KVM: s390: step VCPU cpu timer during kvm_run ioctl
>       KVM: s390: protect VCPU cpu timer with a seqcount
>       KVM: s390: step the VCPU timer while in enabled wait
>       KVM: s390: wake up when the VCPU cpu timer expires
>       KVM: s390: enable STFLE interpretation only if enabled for the guest
>       KVM: s390: allocate only one DMA page per VM
> 
>  arch/s390/include/asm/kvm_host.h |  33 +++++--
>  arch/s390/include/uapi/asm/sie.h |   1 +
>  arch/s390/kvm/interrupt.c        |  53 ++++++++----
>  arch/s390/kvm/kvm-s390.c         | 180 +++++++++++++++++++++++++++++----------
>  arch/s390/kvm/kvm-s390.h         |  11 ++-
>  arch/s390/kvm/priv.c             |   2 +-
>  6 files changed, 209 insertions(+), 71 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Pulled, thanks!

Paolo
