From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] KVM: s390: use switch vs jump table in interrupt.c
Date: Thu, 8 Feb 2018 09:23:44 +0100
Message-ID: <3ffbd281-6829-135c-6848-84df67b344b4@linux.vnet.ibm.com>
References: <20180206141743.24497-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D2k5bYEJ3lDuDLGXJ5qBdk1P9PKta8Xq6"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206141743.24497-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D2k5bYEJ3lDuDLGXJ5qBdk1P9PKta8Xq6
Content-Type: multipart/mixed; boundary="Sda81qPjbw2A2exgJHpPOgX1BQd6bf8qJ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Message-ID: <3ffbd281-6829-135c-6848-84df67b344b4@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] KVM: s390: use switch vs jump table in interrupt.c
References: <20180206141743.24497-1-david@redhat.com>
In-Reply-To: <20180206141743.24497-1-david@redhat.com>

--Sda81qPjbw2A2exgJHpPOgX1BQd6bf8qJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.2018 15:17, David Hildenbrand wrote:
> Just like for the interception handlers, let's also use a switch-case
> in our interrupt delivery code.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>


> ---
>  arch/s390/kvm/interrupt.c | 84 ++++++++++++++++++++++++++++-----------=
--------
>  1 file changed, 50 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index aabf46f5f883..3ea9cfa31b16 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -187,12 +187,6 @@ static int cpu_timer_irq_pending(struct kvm_vcpu *=
vcpu)
>  	return kvm_s390_get_cpu_timer(vcpu) >> 63;
>  }
>=20
> -static inline int is_ioirq(unsigned long irq_type)
> -{
> -	return ((irq_type >=3D IRQ_PEND_IO_ISC_7) &&
> -		(irq_type <=3D IRQ_PEND_IO_ISC_0));
> -}
> -
>  static uint64_t isc_to_isc_bits(int isc)
>  {
>  	return (0x80 >> isc) << 24;
> @@ -1011,24 +1005,6 @@ static int __must_check __deliver_io(struct kvm_=
vcpu *vcpu,
>  	return rc;
>  }
>=20
> -typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
> -
> -static const deliver_irq_t deliver_irq_funcs[] =3D {
> -	[IRQ_PEND_MCHK_EX]        =3D __deliver_machine_check,
> -	[IRQ_PEND_MCHK_REP]       =3D __deliver_machine_check,
> -	[IRQ_PEND_PROG]           =3D __deliver_prog,
> -	[IRQ_PEND_EXT_EMERGENCY]  =3D __deliver_emergency_signal,
> -	[IRQ_PEND_EXT_EXTERNAL]   =3D __deliver_external_call,
> -	[IRQ_PEND_EXT_CLOCK_COMP] =3D __deliver_ckc,
> -	[IRQ_PEND_EXT_CPU_TIMER]  =3D __deliver_cpu_timer,
> -	[IRQ_PEND_RESTART]        =3D __deliver_restart,
> -	[IRQ_PEND_SET_PREFIX]     =3D __deliver_set_prefix,
> -	[IRQ_PEND_PFAULT_INIT]    =3D __deliver_pfault_init,
> -	[IRQ_PEND_EXT_SERVICE]    =3D __deliver_service,
> -	[IRQ_PEND_PFAULT_DONE]    =3D __deliver_pfault_done,
> -	[IRQ_PEND_VIRTIO]         =3D __deliver_virtio,
> -};
> -
>  /* Check whether an external call is pending (deliverable or not) */
>  int kvm_s390_ext_call_pending(struct kvm_vcpu *vcpu)
>  {
> @@ -1192,7 +1168,6 @@ void kvm_s390_clear_local_irqs(struct kvm_vcpu *v=
cpu)
>  int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *=
vcpu)
>  {
>  	struct kvm_s390_local_interrupt *li =3D &vcpu->arch.local_int;
> -	deliver_irq_t func;
>  	int rc =3D 0;
>  	unsigned long irq_type;
>  	unsigned long irqs;
> @@ -1212,16 +1187,57 @@ int __must_check kvm_s390_deliver_pending_inter=
rupts(struct kvm_vcpu *vcpu)
>  	while ((irqs =3D deliverable_irqs(vcpu)) && !rc) {
>  		/* bits are in the reverse order of interrupt priority */
>  		irq_type =3D find_last_bit(&irqs, IRQ_PEND_COUNT);
> -		if (is_ioirq(irq_type)) {
> +		switch (irq_type) {
> +		case IRQ_PEND_IO_ISC_0:
> +		case IRQ_PEND_IO_ISC_1:
> +		case IRQ_PEND_IO_ISC_2:
> +		case IRQ_PEND_IO_ISC_3:
> +		case IRQ_PEND_IO_ISC_4:
> +		case IRQ_PEND_IO_ISC_5:
> +		case IRQ_PEND_IO_ISC_6:
> +		case IRQ_PEND_IO_ISC_7:
>  			rc =3D __deliver_io(vcpu, irq_type);
> -		} else {
> -			func =3D deliver_irq_funcs[irq_type];
> -			if (!func) {
> -				WARN_ON_ONCE(func =3D=3D NULL);
> -				clear_bit(irq_type, &li->pending_irqs);
> -				continue;
> -			}
> -			rc =3D func(vcpu);
> +			break;
> +		case IRQ_PEND_MCHK_EX:
> +		case IRQ_PEND_MCHK_REP:
> +			rc =3D __deliver_machine_check(vcpu);
> +			break;
> +		case IRQ_PEND_PROG:
> +			rc =3D __deliver_prog(vcpu);
> +			break;
> +		case IRQ_PEND_EXT_EMERGENCY:
> +			rc =3D __deliver_emergency_signal(vcpu);
> +			break;
> +		case IRQ_PEND_EXT_EXTERNAL:
> +			rc =3D __deliver_external_call(vcpu);
> +			break;
> +		case IRQ_PEND_EXT_CLOCK_COMP:
> +			rc =3D __deliver_ckc(vcpu);
> +			break;
> +		case IRQ_PEND_EXT_CPU_TIMER:
> +			rc =3D __deliver_cpu_timer(vcpu);
> +			break;
> +		case IRQ_PEND_RESTART:
> +			rc =3D __deliver_restart(vcpu);
> +			break;
> +		case IRQ_PEND_SET_PREFIX:
> +			rc =3D __deliver_set_prefix(vcpu);
> +			break;
> +		case IRQ_PEND_PFAULT_INIT:
> +			rc =3D __deliver_pfault_init(vcpu);
> +			break;
> +		case IRQ_PEND_EXT_SERVICE:
> +			rc =3D __deliver_service(vcpu);
> +			break;
> +		case IRQ_PEND_PFAULT_DONE:
> +			rc =3D __deliver_pfault_done(vcpu);
> +			break;
> +		case IRQ_PEND_VIRTIO:
> +			rc =3D __deliver_virtio(vcpu);
> +			break;
> +		default:
> +			WARN_ONCE(1, "Unknown pending irq type %ld", irq_type);
> +			clear_bit(irq_type, &li->pending_irqs);
>  		}
>  	}
>=20



--Sda81qPjbw2A2exgJHpPOgX1BQd6bf8qJ--

--D2k5bYEJ3lDuDLGXJ5qBdk1P9PKta8Xq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJafAkYAAoJEBcO/8Q8ZEV5LPoP/1uvGpX3LmqbfVM+PAun+0jo
BORwOO9Kflr2uzjvhA7vxnyArIZ6DZabKBDuv/yHfE7quf9YyiWcF1B2iWjSZaM2
CbXLttsyOAiYvACuX90sGqJjJPDO4N5W1l2ZqZQf/UOrZyfKQUjZw0yowbKbUaX7
ZXZH5PEfLv1uOQIAo0UavRpjZDX2Uw1yxjto5yVyQL47qBvKngkJivqbwa/7zfnD
hIyZXs+D4Mf4HvxkayAwNz64qdDjTDGPkPT1zdrpegHpdBhOyOOG3/eyB8pItO21
jEO1qY6lRl8eYrljctmDT7o2YMNDJUc44MMX5OKtQq0UwA2MwroAOzPootveo9f1
KvpY6l1dQd3t8zCBA5gz3r5bME1P8wOn1Vy8TCgStVmpK4IGc0rNOxIG9Na47vMq
aiQ69cnGm/0/EaPD3iZKeHaSoXIyaKvzL/eyhX/a3EQHvCVxyKSaYsNG4FhXf+3f
H/HJflxN7JESAqjQU/kVBrKdlembDV9If+QDotfmOrTuwPuFlVLXwehKu3tQwYRH
j034HwGKw3SBkki9n7zXPsmdnwtAZIbsetIm8BdJkgK9mWFwAlP4EiwyEK00gdFz
UXquTgnORPSBVNC9FIF1nEL7FntHJU9zdut3xbYDNVjGDsRtQD3oo8eJsSVb4vYV
EZe8+IjaEsfvo+b9HKXW
=Xt2y
-----END PGP SIGNATURE-----

--D2k5bYEJ3lDuDLGXJ5qBdk1P9PKta8Xq6--
