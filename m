From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 31 Oct 2018 08:25:12 +0000
Subject: Re: [PATCH 03/10] KVM: s390: factor out nullify_gisa()
Message-Id: <938101fc-0840-7270-68c7-00cdd150efb3@linux.ibm.com>
In-Reply-To: <20181025123751.48809-4-mimu@linux.ibm.com>
References: <20181025123751.48809-4-mimu@linux.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--JF45VwyApr2jbkjJCwlTai9KI2MNjxteo"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JF45VwyApr2jbkjJCwlTai9KI2MNjxteo
Content-Type: multipart/mixed; boundary="EmG1HoKllkhti7jROSn5AWFoSmiDAVvvN";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Michael Mueller <mimu@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Sebastian Ott <sebott@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
 Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <938101fc-0840-7270-68c7-00cdd150efb3@linux.ibm.com>
Subject: Re: [PATCH 03/10] KVM: s390: factor out nullify_gisa()
References: <20181025123751.48809-1-mimu@linux.ibm.com>
 <20181025123751.48809-4-mimu@linux.ibm.com>
In-Reply-To: <20181025123751.48809-4-mimu@linux.ibm.com>

--EmG1HoKllkhti7jROSn5AWFoSmiDAVvvN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.18 14:37, Michael Mueller wrote:
> This function will be used by the GIB alert handler and during
> the GISA clear operation. Thus it gets factored out here.
>=20
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 3789a9ad8dee..ce258d6b7c06 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2886,11 +2886,16 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcp=
u, __u8 __user *buf, int len)
>  	return n;
>  }
> =20
> +static void nullify_gisa(struct kvm_s390_gisa *gisa)
> +{
> +	memset(gisa, 0, sizeof(struct kvm_s390_gisa));
> +	gisa->next_alert =3D (u32)(u64)gisa;
> +}
> +
>  void kvm_s390_gisa_clear(struct kvm *kvm)
>  {
>  	if (kvm->arch.gisa) {
> -		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
> -		kvm->arch.gisa->next_alert =3D (u32)(u64)kvm->arch.gisa;
> +		nullify_gisa(kvm->arch.gisa);
>  		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
>  	}
>  }
>=20



--EmG1HoKllkhti7jROSn5AWFoSmiDAVvvN--

--JF45VwyApr2jbkjJCwlTai9KI2MNjxteo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJb2WboAAoJEONU5rjiOLn4m8kP/RLHoKSSHnfLDpiy+Ewpq6zm
7RQb46SWK7TJyKV34ZsUc76edtoLgFiG2qLYmgbomvZReNBrrIfAhXcqOyPeW99+
7PMLwMfKn/G74YH0jHQNbrckWVfNOMCqzgV4pX7FocF2QH1hNJcyhd7EsynlL2Ul
tgU+xzNRZeDbTfEFDnA4QlI5gNbSDklAbtu9iO7XaEIs/AX2HDoA06s552MRCRLM
vU4/Q422kgs+n8RqHJBqjRxWyfGz9KnaC/HM55437G6vw+Ki5c9BdLdPbtxflKvV
IHnI3oHYJkp/iFWEagruHMqezytFltLRnpUssOt24WbyYecnSSJo7pl+34mNXNW7
ptWWMhk/jc8aWfSaJsZqyAaGmX7IBgA8da7h/CapImmhuOAmf57tVrHVuC/AIqVU
5FYujBNzGvmGq4WE4XDSr/OnNyT/qVlq5NPSBmMSk1r0U8v+DEIRK+vQOqvLCI/u
LjMdvsqxlfsQSDatokEpd7v8zYnSAVoJUo82gwBbX0tHxjO1CoiHKAy5ZepnsLrC
+dtKGNehl/kwvsP0atP3nW4rPJA9cxDkYZc0oMSdfRhWqTHZhYXPtIXNHTXCKY22
0gDVlgrgcMD3Q8Cd045bsxveFvUiVcPLFZ179W9kG/2d1RUFGQ+MqoM7kLfB6M2n
Y73o1oOp+/sqt6SxG53T
=N4mK
-----END PGP SIGNATURE-----

--JF45VwyApr2jbkjJCwlTai9KI2MNjxteo--
