From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Wed, 4 May 2016 09:50:57 +0200
Message-ID: <5729A9E1.3050706@de.ibm.com>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
 <1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
 <20160503150902.GF30059@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160503150902.GF30059@potion>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/03/2016 05:09 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2016-05-03 14:37+0200, Christian Borntraeger:
>> Some wakeups should not be considered a sucessful poll. For example =
on
>> s390 I/O interrupts are usually floating, which means that _ALL_ CPU=
s
>> would be considered runnable - letting all vCPUs poll all the time f=
or
>> transactional like workload, even if one vCPU would be enough.
>> This can result in huge CPU usage for large guests.
>> This patch lets architectures provide a way to qualify wakeups if th=
ey
>> should be considered a good/bad wakeups in regard to polls.
>>
>> For s390 the implementation will fence of halt polling for anything =
but
>> known good, single vCPU events. The s390 implementation for floating
>> interrupts does a wakeup for one vCPU, but the interrupt will be del=
ivered
>> by whatever CPU checks first for a pending interrupt. We prefer the
>> woken up CPU by marking the poll of this CPU as "good" poll.
>> This code will also mark several other wakeup reasons like IPI or
>> expired timers as "good". This will of course also mark some events =
as
>> not sucessful. As  KVM on z runs always as a 2nd level hypervisor,
>> we prefer to not poll, unless we are really sure, though.
>>
>> This patch successfully limits the CPU usage for cases like uperf 1b=
yte
>> transactional ping pong workload or wakeup heavy workload like OLTP
>> while still providing a proper speedup.
>>
>> This also introduced a new vcpu stat "halt_poll_no_tuning" that mark=
s
>> wakeups that are considered not good for polling.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: David Matlack <dmatlack@google.com>
>> Cc: Wanpeng Li <kernellwp@gmail.com>
>> ---
>=20
> Thanks for all explanations,
>=20
> Acked-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>=20


The feedback about the logic triggered some more experiments on my side=
=2E
So I was experimenting with some different workloads/heuristics and it
seems that even more aggressive shrinking (basically resetting to 0 as =
soon
as an invalid poll comes along) does improve the cpu usage even more.

patch on top
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ffe0545..c168662 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2036,12 +2036,13 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 out:
        block_ns =3D ktime_to_ns(cur) - ktime_to_ns(start);
=20
-       if (halt_poll_ns) {
+       if (!vcpu_valid_wakeup(vcpu))
+                shrink_halt_poll_ns(vcpu);
+       else if (halt_poll_ns) {
                if (block_ns <=3D vcpu->halt_poll_ns)
                        ;
                /* we had a long block, shrink polling */
-               else if (!vcpu_valid_wakeup(vcpu) ||
-                       (vcpu->halt_poll_ns && block_ns > halt_poll_ns)=
)
+               else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
                        shrink_halt_poll_ns(vcpu);
                /* we had a short halt and our poll time is too small *=
/
                else if (vcpu->halt_poll_ns < halt_poll_ns &&


the uperf 1byte:1byte workload seems to have all the benefits still.
I have asked the performance folks to test several other workloads if
we loose some of the benefits.
So I will defer this patch until I have a full picture which heuristics
is best. Hopefully I have some answers next week.=20

(So the new diff looks like)
@@ -2034,7 +2036,9 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 out:
        block_ns =3D ktime_to_ns(cur) - ktime_to_ns(start);
=20
-       if (halt_poll_ns) {
+       if (!vcpu_valid_wakeup(vcpu))
+                shrink_halt_poll_ns(vcpu);
+       else if (halt_poll_ns) {
                if (block_ns <=3D vcpu->halt_poll_ns)
                        ;
