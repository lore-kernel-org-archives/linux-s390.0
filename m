From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] kvm-390: fix wait_queue handling
Date: Mon, 20 Jul 2009 12:17:07 -0300
Message-ID: <20090720151707.GE8517@amt.cnet>
References: <Pine.LNX.4.64.0907101344350.9598@ask.diku.dk> <4A599D51.8030506@redhat.com> <200907161717.38035.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200907161717.38035.borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Julia Lawall <julia@diku.dk>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 16, 2009 at 05:17:37PM +0200, Christian Borntr=E4ger wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
>=20
> There are two waitqueues in kvm for wait handling:
> vcpu->wq for virt/kvm/kvm_main.c and
> vpcu->arch.local_int.wq for the s390 specific wait code.
>=20
> the wait handling in kvm_s390_handle_wait was broken by using differe=
nt
> wait_queues for add_wait queue and remove_wait_queue.
>=20
> There are two options to fix the problem:=20
> o  move all the s390 specific code to vcpu->wq and remove
>    vcpu->arch.local_int.wq
> o  move all the s390 specific code to vcpu->arch.local_int.wq
>=20
> This patch chooses the 2nd variant for two reasons:
> o  s390 does not use kvm_vcpu_block but implements its own enabled wa=
it
>    handling.
>    Having a separate wait_queue make it clear, that our wait mechanis=
m is
>    different
> o  the patch is much smaller
>=20
> Report-by:  Julia Lawall <julia@diku.dk>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: kvm/arch/s390/kvm/interrupt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kvm.orig/arch/s390/kvm/interrupt.c
> +++ kvm/arch/s390/kvm/interrupt.c
> @@ -386,7 +386,7 @@ no_timer:
>  	}
>  	__unset_cpu_idle(vcpu);
>  	__set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&vcpu->wq, &wait);
> +	remove_wait_queue(&vcpu->arch.local_int.wq, &wait);
>  	spin_unlock_bh(&vcpu->arch.local_int.lock);
>  	spin_unlock(&vcpu->arch.local_int.float_int->lock);
>  	hrtimer_try_to_cancel(&vcpu->arch.ckc_timer);

Applied, thanks.
