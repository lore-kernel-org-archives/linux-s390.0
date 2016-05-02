From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Mon, 2 May 2016 12:45:48 +0200
Message-ID: <20160502124548.1a80cf32@thinkpad-w530>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> Radim, Paolo,
> 
> can you have a look at this patch? If you are ok with it, I want to
> submit this patch with my next s390 pull request. It touches KVM common
> code, but I tried to make it a nop for everything but s390.
> 
> Christian
> 
> ----snip----
> 
> 
> Some wakeups should not be considered a sucessful poll. For example on
> s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
> would be considered runnable - letting all vCPUs poll all the time for
> transactional like workload, even if one vCPU would be enough.
> This can result in huge CPU usage for large guests.
> This patch lets architectures provide a way to qualify wakeups if they
> should be considered a good/bad wakeups in regard to polls.
> 
> For s390 the implementation will fence of halt polling for anything but
> known good, single vCPU events. The s390 implementation for floating
> interrupts does a wakeup for one vCPU, but the interrupt will be delivered
> by whatever CPU comes first. To limit the halt polling we only mark the
> woken up CPU as a valid poll. This code will also cover several other
> wakeup reasons like IPI or expired timers. This will of course also mark
> some events as not sucessful. As  KVM on z runs always as a 2nd level
> hypervisor, we prefer to not poll, unless we are really sure, though.
> 
> So we start with a minimal set and will provide additional patches in
> the future that mark additional code paths as valid wakeups, if that
> turns out to be necessary.
> 
> This patch successfully limits the CPU usage for cases like uperf 1byte
> transactional ping pong workload or wakeup heavy workload like OLTP
> while still providing a proper speedup.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/Kconfig     |  1 +
>  arch/s390/kvm/interrupt.c |  8 ++++++++
>  include/linux/kvm_host.h  | 34 ++++++++++++++++++++++++++++++++++
>  virt/kvm/Kconfig          |  4 ++++
>  virt/kvm/kvm_main.c       |  9 ++++++---
>  5 files changed, 53 insertions(+), 3 deletions(-)
> 

Acked-by: David Hildenbrand <dahi@linux.vnet.ibm.com>

David
