From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv2] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Mon, 24 Feb 2014 13:02:59 +0100
Message-ID: <530B34F3.5000602@redhat.com>
References: <53078E75.2040603@redhat.com> <1393243126-27376-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393243126-27376-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 24/02/2014 12:58, Christian Borntraeger ha scritto:
> When starting lots of dataplane devices the bootup takes very long on my
> s390 system(prototype irqfd code). With larger setups we are even able
> to trigger some timeouts in some userspace components.
> Turns out that the KVM_SET_GSI_ROUTING ioctl takes very
> long (strace claims up to 0.1 sec) when having multiple CPUs.
> This is caused by the  synchronize_rcu and the HZ=100 of s390.
> By changing the code to use a private srcu we can speed things up.
>
> This patch reduces the boot time till mounting root from 8 to 2
> seconds on my s390 guest with 100 disks.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
> ---
> v1-v2: Fix missing hunk in kvm_irq_has_notifier. This was unnoticed on
>        s390, as our code did not use it.

In fact, there are other accesses to irq_routing elsewhere in virt/kvm 
which should be changed to irq_srcu (which in turn probably means that 
it's better to make the SRCU instance per-VM).

My fault, I should have delayed the patch to after the merge window 
instead of doing a shoddy review.  I'll test the complete patch myself 
since VFIO is probably the only thing that can cover it 100%, and s390 
doesn't do VFIO.

Paolo
