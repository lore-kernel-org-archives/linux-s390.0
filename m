From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 14:41:23 +0200
Message-ID: <20160503144123.1b14d174@thinkpad-w530>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
	<1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

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
> by whatever CPU checks first for a pending interrupt. We prefer the
> woken up CPU by marking the poll of this CPU as "good" poll.
> This code will also mark several other wakeup reasons like IPI or
> expired timers as "good". This will of course also mark some events as
> not sucessful. As  KVM on z runs always as a 2nd level hypervisor,
> we prefer to not poll, unless we are really sure, though.
> 
> This patch successfully limits the CPU usage for cases like uperf 1byte
> transactional ping pong workload or wakeup heavy workload like OLTP
> while still providing a proper speedup.
> 
> This also introduced a new vcpu stat "halt_poll_no_tuning" that marks
> wakeups that are considered not good for polling.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> ---

You can keep my
Acked-by: David Hildenbrand <dahi@linux.vnet.ibm.com>


David
