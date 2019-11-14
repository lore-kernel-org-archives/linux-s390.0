Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbfKNMHP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 07:07:15 -0500
Subject: Re: [RFC 14/37] KVM: s390: protvirt: Implement interruption injection
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-15-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <df644c13-38e8-23a7-a506-9b9853630266@redhat.com>
Date: Thu, 14 Nov 2019 13:07:02 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-15-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> From: Michael Mueller <mimu@linux.ibm.com>
>=20
> The patch implements interruption injection for the following
> list of interruption types:
>=20
>   - I/O
>     __deliver_io (III)
>=20
>   - External
>     __deliver_cpu_timer (IEI)
>     __deliver_ckc (IEI)
>     __deliver_emergency_signal (IEI)
>     __deliver_external_call (IEI)
>     __deliver_service (IEI)
>=20
>   - cpu restart
>     __deliver_restart (IRI)
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [interrupt =
masking]
> ---
[...]
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 165dea4c7f19..c919dfe4dfd3 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -324,8 +324,10 @@ static inline int gisa_tac_ipm_gisc(struct kvm_s390_=
gisa *gisa, u32 gisc)
> =20
>  static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>  {
> -=09return vcpu->kvm->arch.float_int.pending_irqs |
> -=09=09vcpu->arch.local_int.pending_irqs;
> +=09unsigned long pending =3D vcpu->kvm->arch.float_int.pending_irqs | vc=
pu->arch.local_int.pending_irqs;

The line is now pretty long, way more than 80 columns ... maybe keep it
on two lines?

> +
> +=09pending &=3D ~vcpu->kvm->arch.float_int.masked_irqs;
> +=09return pending;
>  }
[...]
> @@ -533,7 +549,6 @@ static int __must_check __deliver_pfault_init(struct =
kvm_vcpu *vcpu)
>  =09trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
>  =09=09=09=09=09 KVM_S390_INT_PFAULT_INIT,
>  =09=09=09=09=09 0, ext.ext_params2);
> -
>  =09rc  =3D put_guest_lc(vcpu, EXT_IRQ_CP_SERVICE, (u16 *) __LC_EXT_INT_C=
ODE);
>  =09rc |=3D put_guest_lc(vcpu, PFAULT_INIT, (u16 *) __LC_EXT_CPU_ADDR);
>  =09rc |=3D write_guest_lc(vcpu, __LC_EXT_OLD_PSW,

I think you can drop this hunk.

 Thomas
