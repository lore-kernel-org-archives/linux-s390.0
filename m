From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 17:09:02 +0200
Message-ID: <20160503150902.GF30059@potion>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
 <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

2016-05-03 14:37+0200, Christian Borntraeger:
> Some wakeups should not be considered a sucessful poll. For example o=
n
> s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
> would be considered runnable - letting all vCPUs poll all the time fo=
r
> transactional like workload, even if one vCPU would be enough.
> This can result in huge CPU usage for large guests.
> This patch lets architectures provide a way to qualify wakeups if the=
y
> should be considered a good/bad wakeups in regard to polls.
>=20
> For s390 the implementation will fence of halt polling for anything b=
ut
> known good, single vCPU events. The s390 implementation for floating
> interrupts does a wakeup for one vCPU, but the interrupt will be deli=
vered
> by whatever CPU checks first for a pending interrupt. We prefer the
> woken up CPU by marking the poll of this CPU as "good" poll.
> This code will also mark several other wakeup reasons like IPI or
> expired timers as "good". This will of course also mark some events a=
s
> not sucessful. As  KVM on z runs always as a 2nd level hypervisor,
> we prefer to not poll, unless we are really sure, though.
>=20
> This patch successfully limits the CPU usage for cases like uperf 1by=
te
> transactional ping pong workload or wakeup heavy workload like OLTP
> while still providing a proper speedup.
>=20
> This also introduced a new vcpu stat "halt_poll_no_tuning" that marks
> wakeups that are considered not good for polling.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> ---

Thanks for all explanations,

Acked-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
