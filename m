From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: shrink halt polling even more for invalid
 wakeups
Date: Tue, 17 May 2016 15:54:34 +0200
Message-ID: <573B229A.3050608@de.ibm.com>
References: <1463474962-5941-1-git-send-email-borntraeger@de.ibm.com>
 <1463474962-5941-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1463474962-5941-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Matlack <dmatlack@google.com>, Wanpeng Li <kernellwp@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/17/2016 10:49 AM, Christian Borntraeger wrote:
> commit 3491caf2755e ("KVM: halt_polling: provide a way to qualify
>  wakeups during poll") added more aggressive shrinking of the
> polling interval if the wakeup did not match some criteria. This
> still allows to keep polling enabled if the polling time was
> smaller that the current max poll time (block_ns <=3D vcpu->halt_poll=
_ns).
> Performance measurement shows that even more aggressive shrinking
> (shrink polling on any invalid wakeup) reduces absolute and relative
> (to the workload) CPU usage even further.
>=20
> Cc: David Matlack <dmatlack@google.com>
> Cc: Wanpeng Li <kernellwp@gmail.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  virt/kvm/kvm_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fbd7698..dec1ed2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2055,12 +2055,13 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  out:
>  	block_ns =3D ktime_to_ns(cur) - ktime_to_ns(start);
>=20
> -	if (halt_poll_ns) {
> +	if (!vcpu_valid_wakeup(vcpu))
> +		 shrink_halt_poll_ns(vcpu);
		^ hmpf. Small whitespace error. I can resend if wanted.

> +	else if (halt_poll_ns) {
>  		if (block_ns <=3D vcpu->halt_poll_ns)
>  			;
>  		/* we had a long block, shrink polling */
> -		else if (!vcpu_valid_wakeup(vcpu) ||
> -			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
> +		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
>  			shrink_halt_poll_ns(vcpu);
>  		/* we had a short halt and our poll time is too small */
>  		else if (vcpu->halt_poll_ns < halt_poll_ns &&
>=20
