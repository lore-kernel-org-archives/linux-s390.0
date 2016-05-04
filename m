From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Wed, 4 May 2016 10:05:45 +0200
Message-ID: <20160504100545.090be51b.cornelia.huck@de.ibm.com>
References: <1462279041-17028-1-git-send-email-borntraeger@de.ibm.com>
	<1462279041-17028-2-git-send-email-borntraeger@de.ibm.com>
	<20160503150902.GF30059@potion>
	<5729A9E1.3050706@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5729A9E1.3050706@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Wanpeng Li <kernellwp@gmail.com>, David Matlack <dmatlack@google.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 May 2016 09:50:57 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The feedback about the logic triggered some more experiments on my side.
> So I was experimenting with some different workloads/heuristics and it
> seems that even more aggressive shrinking (basically resetting to 0 as soon
> as an invalid poll comes along) does improve the cpu usage even more.

Do we still keep the shrink instead of resetting to 0 explicitly? (In
case the default shrink factor was set to != 0.) We'd lose a tuneable,
but it seems the aggressiveness is warranted.

> (So the new diff looks like)
> @@ -2034,7 +2036,9 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  out:
>         block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
> 
> -       if (halt_poll_ns) {
> +       if (!vcpu_valid_wakeup(vcpu))
> +                shrink_halt_poll_ns(vcpu);
> +       else if (halt_poll_ns) {
>                 if (block_ns <= vcpu->halt_poll_ns)
>                         ;

...making this

if (halt_poll_ns && vcpu_valid_wakeup(vcpu)) {
