From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: add vcpu stat counters for many
 instruction
Date: Wed, 24 Jan 2018 13:27:32 +0100
Message-ID: <12d2bcbd-e2e3-c029-2b7f-b4cc22a6f193@linux.vnet.ibm.com>
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
 <20180124113235.31485-2-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zmcsv1u3wePnKGBWm5GziJMRsizAQdT7V"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124113235.31485-2-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zmcsv1u3wePnKGBWm5GziJMRsizAQdT7V
Content-Type: multipart/mixed; boundary="TGIMvmVHzFvZb3j5pdluYBeneppxPK6EZ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>
Message-ID: <12d2bcbd-e2e3-c029-2b7f-b4cc22a6f193@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] KVM: s390: add vcpu stat counters for many
 instruction
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
 <20180124113235.31485-2-borntraeger@de.ibm.com>
In-Reply-To: <20180124113235.31485-2-borntraeger@de.ibm.com>

--TGIMvmVHzFvZb3j5pdluYBeneppxPK6EZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.01.2018 12:32, Christian Borntraeger wrote:
> The overall instruction counter is larger than the sum of the
> single counters. We should try to catch all instruction handlers
> to make this match the summary counter.
> Let us add sck,tb,sske,iske,rrbe,tb,tpi,tsch,lpsw,pswe.....
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>

[...]
>=20
>  static int handle_io_inst(struct kvm_vcpu *vcpu)
>  {
> +
>  	VCPU_EVENT(vcpu, 4, "%s", "I/O instruction");

Whitespace damage

>=20
>  	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
> @@ -527,6 +545,7 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>  		if (vcpu->arch.sie_block->ipa =3D=3D 0xb235)
>  			return handle_tsch(vcpu);
>  		/* Handle in userspace. */
> +		vcpu->stat.instruction_io++;
>  		return -EOPNOTSUPP;
>  	} else {
>  		/*


--TGIMvmVHzFvZb3j5pdluYBeneppxPK6EZ--

--zmcsv1u3wePnKGBWm5GziJMRsizAQdT7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaaHu0AAoJEBcO/8Q8ZEV5yxgP/0JAJqjFHw9P1Bzih7axWuDc
Snyz3F2MbVz93aiZQ2H6qPS9LbKjMUcUSVnVo1ajt9oCAYFokJfOWQxMCh7jBpVh
KuzYFukqq4UoyEqQYHNUnei5I1oD7oFNNp6Lc/FL9nKduoFdW03BguA7FtiJ9VOC
C5/WZQz/vHcOPV0/74veYVw/ZBe14TAfqIzEjyqPSja4VwcTYe3iSQVq6mdQxEsL
cEahKklv5lr2ILJ5Gna4Hc/khdiVHS8DClL/EUO/iXNoieq2YQ07uIjDjt/bDzqa
Q4PYEsbYBCorhoIBLvela2h8Zgg8Iu3gUFdoS+NOuYDFXYXQyUEO+6KMsnzX6RTL
ZLzrz3xjl04X4kU8PIRXHvrMTPXdShkKeCH/D7eOEI+axdi1msnkj2W4CgJ8UbVW
riIJ63hD2kjNb6mDYDjr7OR9bTGA6+C7llvKTqaxUhV8dQ6yyShY4ILejNESRchX
uPZy6X8sfqyl0hAM5mmnRMZ8kIOktKBL9pIo1o05jQe+dGZHIsZifbJGyfTgzzO/
BpHy4OL9zt9bF7pY+WMEGVMC8nUEcbFRaDLJLvmy4loBoIBbhCTvt4hqqYWws4/K
JYjatlpNzZy0g+AN1e2R9EOdWdSeSOhJxuggjqe/l508Qz9kp9RqYaQlZTeHn1UJ
BqXul6mjUY0kPrRbLKC4
=Lq5f
-----END PGP SIGNATURE-----

--zmcsv1u3wePnKGBWm5GziJMRsizAQdT7V--
