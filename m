From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 10:00:23 +0200
Message-ID: <20160503100023.274b0f11.cornelia.huck@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
	<CANRm+Cw40QqHMjfEaqmDb5WC6xokotTATM6-5HNTJ4LwKAe3Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CANRm+Cw40QqHMjfEaqmDb5WC6xokotTATM6-5HNTJ4LwKAe3Cg@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 3 May 2016 15:50:25 +0800
Wanpeng Li <kernellwp@gmail.com> wrote:

> 2016-05-02 18:42 GMT+08:00 Christian Borntraeger <borntraeger@de.ibm.com>:
> [...]
> > Some wakeups should not be considered a sucessful poll. For example on
> > s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
> > would be considered runnable - letting all vCPUs poll all the time for
> > transactional like workload, even if one vCPU would be enough.
> > This can result in huge CPU usage for large guests.
> > This patch lets architectures provide a way to qualify wakeups if they
> > should be considered a good/bad wakeups in regard to polls.
> >
> > For s390 the implementation will fence of halt polling for anything but
> > known good, single vCPU events. The s390 implementation for floating
> > interrupts does a wakeup for one vCPU, but the interrupt will be delivered
> > by whatever CPU comes first. To limit the halt polling we only mark the
> 
> If the floating interrupt means that the 'CPU comes first' will
> deliver the interrupt to all vCPUs?

Floating interrupt on s390 means "deliver on any vcpu that matches the
criteria, but only on one".
