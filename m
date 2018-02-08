From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] KVM: s390: use switch vs jump table in intercept.c
Date: Thu, 8 Feb 2018 09:30:11 +0100
Message-ID: <534e2dae-16e7-31a9-5e1d-3fab4d659a66@linux.vnet.ibm.com>
References: <20180206112127.19014-3-borntraeger@de.ibm.com>
 <20180206124700.19177-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6pWplpae9fwOYZqTRM1JwzKrLzphLHF7a"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180206124700.19177-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6pWplpae9fwOYZqTRM1JwzKrLzphLHF7a
Content-Type: multipart/mixed; boundary="Un9fZPpJzGPGWz1o8G8EHC2YYRx80GN9f";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
Message-ID: <534e2dae-16e7-31a9-5e1d-3fab4d659a66@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] KVM: s390: use switch vs jump table in intercept.c
References: <20180206112127.19014-3-borntraeger@de.ibm.com>
 <20180206124700.19177-1-borntraeger@de.ibm.com>
In-Reply-To: <20180206124700.19177-1-borntraeger@de.ibm.com>

--Un9fZPpJzGPGWz1o8G8EHC2YYRx80GN9f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.2018 13:47, Christian Borntraeger wrote:
> Instead of having huge jump tables for function selection,
> let's use normal switch/case statements for the instruction
> handlers in intercept.c We can now also get rid of
> intercept_handler_t.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Looks good to me and results in less scrolling to find the handlers.

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>


> ---
>  arch/s390/kvm/intercept.c | 51 +++++++++++++++++++++++++++------------=
--------
>  arch/s390/kvm/kvm-s390.h  |  2 --
>  2 files changed, 29 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 9c7d70715862..07c6e81163bf 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -22,22 +22,6 @@
>  #include "trace.h"
>  #include "trace-s390.h"
>=20
> -
> -static const intercept_handler_t instruction_handlers[256] =3D {
> -	[0x01] =3D kvm_s390_handle_01,
> -	[0x82] =3D kvm_s390_handle_lpsw,
> -	[0x83] =3D kvm_s390_handle_diag,
> -	[0xaa] =3D kvm_s390_handle_aa,
> -	[0xae] =3D kvm_s390_handle_sigp,
> -	[0xb2] =3D kvm_s390_handle_b2,
> -	[0xb6] =3D kvm_s390_handle_stctl,
> -	[0xb7] =3D kvm_s390_handle_lctl,
> -	[0xb9] =3D kvm_s390_handle_b9,
> -	[0xe3] =3D kvm_s390_handle_e3,
> -	[0xe5] =3D kvm_s390_handle_e5,
> -	[0xeb] =3D kvm_s390_handle_eb,
> -};
> -
>  u8 kvm_s390_get_ilen(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_sie_block *sie_block =3D vcpu->arch.sie_block;
> @@ -129,16 +113,39 @@ static int handle_validity(struct kvm_vcpu *vcpu)=

>=20
>  static int handle_instruction(struct kvm_vcpu *vcpu)
>  {
> -	intercept_handler_t handler;
> -
>  	vcpu->stat.exit_instruction++;
>  	trace_kvm_s390_intercept_instruction(vcpu,
>  					     vcpu->arch.sie_block->ipa,
>  					     vcpu->arch.sie_block->ipb);
> -	handler =3D instruction_handlers[vcpu->arch.sie_block->ipa >> 8];
> -	if (handler)
> -		return handler(vcpu);
> -	return -EOPNOTSUPP;
> +
> +	switch (vcpu->arch.sie_block->ipa >> 8) {
> +	case 0x01:
> +		return kvm_s390_handle_01(vcpu);
> +	case 0x82:
> +		return kvm_s390_handle_lpsw(vcpu);
> +	case 0x83:
> +		return kvm_s390_handle_diag(vcpu);
> +	case 0xaa:
> +		return kvm_s390_handle_aa(vcpu);
> +	case 0xae:
> +		return kvm_s390_handle_sigp(vcpu);
> +	case 0xb2:
> +		return kvm_s390_handle_b2(vcpu);
> +	case 0xb6:
> +		return kvm_s390_handle_stctl(vcpu);
> +	case 0xb7:
> +		return kvm_s390_handle_lctl(vcpu);
> +	case 0xb9:
> +		return kvm_s390_handle_b9(vcpu);
> +	case 0xe3:
> +		return kvm_s390_handle_e3(vcpu);
> +	case 0xe5:
> +		return kvm_s390_handle_e5(vcpu);
> +	case 0xeb:
> +		return kvm_s390_handle_eb(vcpu);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>=20
>  static int inject_prog_on_prog_intercept(struct kvm_vcpu *vcpu)
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index bd31b37b0e6f..3c0a975c2477 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -19,8 +19,6 @@
>  #include <asm/processor.h>
>  #include <asm/sclp.h>
>=20
> -typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
> -
>  /* Transactional Memory Execution related macros */
>  #define IS_TE_ENABLED(vcpu)	((vcpu->arch.sie_block->ecb & ECB_TE))
>  #define TDB_FORMAT1		1
>=20



--Un9fZPpJzGPGWz1o8G8EHC2YYRx80GN9f--

--6pWplpae9fwOYZqTRM1JwzKrLzphLHF7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJafAqTAAoJEBcO/8Q8ZEV5kvoP/1nQAVgTS+bMIVtQZGYlGtz+
KQxQB+GHyqb0Vh974xaANeh8To2MoBm8Cr3X4rv/nhFQY5L5h7Puz9c+djkum3GW
i6GkF3Zj8WmFGHM6eV9P9C/J5dx1QpLu4gElgqsaSW6gJZt+9W4x/u+ms+Oan1OT
b5ibCB9efSjsV3mwWXPcY937v5z1sOTEHqfB51ZtW4wOC92JZvYuiXbYSuoTQDCs
7XjNN1P32Os9uTh+9BhEDhW5tDH3iJ9V+2Xu5r3faajEFRt1upOjH/RprACSqwhe
eFETZ/jhQko9PrLH8A6jBoOtuymTEk5ZyQUmdUkqARsnh/IR6kIHSUed3QA8dRj/
EoIBV4zEcTbD9HZMWssztwYjacnMPBJrqSKQ1bwpTDow+mZ8S7vlpIjsl16IfX4a
2DLiteL8ip1xvEuXvZZ5W2YSeew4kk5tc0A/3liLu0NykKwseAf75h3ud8XQjaP4
Z22hTha2uW7PgGXAAVvJ4Z9Voh/T9DrEg2P5RMqLC/k89PCw1rlsgOTND6Q2rlJ4
G8qHHFnnjW5aJH0vt2kD5t2SWAz63ydXmdJOgT3K4inouWjHRiy9BEdc03SJ4unt
NoXKXNe7rF5nPNeFmIPX4/Zxmy/O0JY7RZaE/3JTm93baNMqcqF92lKMgk4D1GSw
ytDVMJuExVFFsMmFjj6U
=c4XH
-----END PGP SIGNATURE-----

--6pWplpae9fwOYZqTRM1JwzKrLzphLHF7a--
