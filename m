Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
References: <20180822095310.29145-1-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Aug 2018 12:31:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095310.29145-1-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V"
Message-Id: <02f9379d-d20d-8b69-94b9-959f46490a26@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V
Content-Type: multipart/mixed; boundary="0jNstAGar3fITyMN608yC3fb0xBQ5VF0a";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Message-ID: <02f9379d-d20d-8b69-94b9-959f46490a26@linux.ibm.com>
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
References: <20180822095310.29145-1-david@redhat.com>
In-Reply-To: <20180822095310.29145-1-david@redhat.com>

--0jNstAGar3fITyMN608yC3fb0xBQ5VF0a
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.2018 11:53, David Hildenbrand wrote:
> When DATA exceptions and vector-processing exceptions (program interrup=
ts)
> are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
> enabled in CR0.
>=20
> This can happen inside KVM when reinjecting an interrupt during program=

> interrupt intercepts. These are triggered for example when debugging th=
e
> guest (concurrent PER events result in an intercept instead of an
> injection of such interrupts).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> Only compile-tested.

It baffles me that AFP is still a thing in zArch mode. I would have
expected it to be a default 1. But then again, I just found out about it.=


POP checks out:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


>=20
>  arch/s390/include/asm/ctl_reg.h | 1 +
>  arch/s390/kvm/interrupt.c       | 8 ++++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ct=
l_reg.h
> index 4600453536c2..88f3f14baee9 100644
> --- a/arch/s390/include/asm/ctl_reg.h
> +++ b/arch/s390/include/asm/ctl_reg.h
> @@ -11,6 +11,7 @@
>  #include <linux/const.h>
> =20
>  #define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
> +#define CR0_AFP_REGISTER_CONTROL	_BITUL(63 - 45)
>  #define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
>  #define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
>  #define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index fcb55b02990e..5b5754d8f460 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -765,6 +765,14 @@ static int __must_check __deliver_prog(struct kvm_=
vcpu *vcpu)
>  		break;
>  	case PGM_VECTOR_PROCESSING:
>  	case PGM_DATA:
> +		if (vcpu->arch.sie_block->gcr[0] & CR0_AFP_REGISTER_CONTROL) {
> +			/* make sure the new fpc will be lazily loaded */
> +			save_fpu_regs();
> +			/* the DXC/VXC cannot make the fpc invalid */
> +			current->thread.fpu.fpc &=3D ~0xff00u;
> +			current->thread.fpu.fpc |=3D (pgm_info.data_exc_code << 8)
> +						   & 0xff00u;

Everything except that byte should be 0 anyway when it comes from
lowcore, why do you mask?

> +		}
>  		rc =3D put_guest_lc(vcpu, pgm_info.data_exc_code,
>  				  (u32 *)__LC_DATA_EXC_CODE);
>  		break;
>=20



--0jNstAGar3fITyMN608yC3fb0xBQ5VF0a--

--l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJbfTueAAoJEBcO/8Q8ZEV5UBcP9ilVHxrfn6HY5cD1l4nmOkE0
5/mopesnG+opPNTzwr6ywc92fmqrEp+v48T4oi50IGTrPS7HSWJLyVJ2L5YAw0Jg
ba+bgnbrFCVrPJEWaWDIBrFa3/qm84MFTBmJm1d25uVmlA/pVaMRWu735XBgkoB3
Tt+aQ66FHiMXDEYvX8HrpYjA6nNMpLh15lXnRROmS9XeYFXvYq3lO8dKGA+Jk1KW
D3lyFRn6/DbUbwEpS9zOj/C5WgzZWnLjTn4SpHSIyKmi855IHsST/w5ptS8UOt7h
U/s3dEPpK07fj1M4xa5KVwIFeqjSZz5XYg+hobnOpaBPvu09ujVLbr9QBwUDXnLq
d5nr7PaUIAI1uZUspZMRRw9ApOjbHJjHNLsror5nef26YdX5hP/1fXebP9ZIRb1T
pgUWVRZVd0MeVWQVg26jbFr1e2ZQPdQqts0uJQn2StjRLkk2LDnQDNMqp4tz0G2o
PAl45ABZj1oxdXjyvPnzCh/2u+Ktp/9GXpLk5X6+ZB9lVuKIf5npUE9JZnMXns/P
c4uMKCYrUKjXsJ331Jw+ttCVHGOi+7IyuQpM7HSPDwlEgxFh8Q1LDEnxWfnZaRZS
NGDCcSV7WrwoeR5OYDk2yPt1aE5P3PF1cecQVnYCcSlLCOw+RCVZwrGk+YWmFWpN
jwV+YmP043wz/HXHDTM=
=JTGO
-----END PGP SIGNATURE-----

--l4bQxt9GGF8Px9Rf8rR7Qe6dO42zMoX4V--
