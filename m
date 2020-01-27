Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729308AbgA0Jwn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Jan 2020 04:52:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R9abPS136315
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2020 04:52:42 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrhv0561n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2020 04:52:42 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 27 Jan 2020 09:52:39 -0000
Subject: Re: [PATCH v7] KVM: s390: Add new reset vcpu API
References: <20200110114540.90713-1-frankja@linux.ibm.com>
 <5a26e1af-ecdc-b815-248e-ee93a7c51ff5@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 27 Jan 2020 10:52:35 +0100
MIME-Version: 1.0
In-Reply-To: <5a26e1af-ecdc-b815-248e-ee93a7c51ff5@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g4OvIP98IRpDGBfv6m5cnR3O6RSIZEFCA"
Message-Id: <db6d8d0f-8a5e-8c4a-bfbb-027102a21213@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g4OvIP98IRpDGBfv6m5cnR3O6RSIZEFCA
Content-Type: multipart/mixed; boundary="02iP0sB2oxB1TW2ZyRm2TC88btekSx4Xo"

--02iP0sB2oxB1TW2ZyRm2TC88btekSx4Xo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/27/20 9:05 AM, Christian Borntraeger wrote:
>=20
>=20
> On 10.01.20 12:45, Janosch Frank wrote:
> [...]
>> +static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_sync_regs *regs =3D &vcpu->run->s.regs;
>> +
>> +	/* Clear reset is a superset of the initial reset */
>> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>> +
>> +	memset(&regs->gprs, 0, sizeof(regs->gprs));
>=20
>=20
>=20
>> +	/* Will be picked up because of save_fpu_regs() in the initial reset=
 */
>> +	memset(&current->thread.fpu.vxrs, 0, sizeof(current->thread.fpu.vxrs=
));
>=20
> So I checked with a userspace that sets f8(call-saved) to 0x123 during =
this ioctl.
> f8 is 0 afterwards. The guest f8 is also correct, just because QEMU doe=
s clear out
> its copy of the fprs and syncs that back via synv regs.
>=20
> So this must be
>=20
> 	/* we have not synced the registers from kvm_run to the thread
> 	   structure. We must clear out kvm_run*/
> 	memset(&regs->vrs, 0, sizeof(regs->vrs));

Great, thanks!
Meanwhile I had a look at the missing pieces and the guarded storage rese=
ts.

>=20
>=20
>> +	memset(&regs->acrs, 0, sizeof(regs->acrs));
>> +
>> +	regs->etoken =3D 0;
>> +	regs->etoken_extension =3D 0;
>> +
>> +	memset(&regs->gscb, 0, sizeof(regs->gscb));
> [....]
>=20



--02iP0sB2oxB1TW2ZyRm2TC88btekSx4Xo--

--g4OvIP98IRpDGBfv6m5cnR3O6RSIZEFCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4usuMACgkQ41TmuOI4
ufjCwQ/+LQARNMZP0wkIZDaccxY9c3rXw2pEet7nb2i3nWW62BOYl0kYYJrGffgC
J1GnuW8wrJj/7LZ3ULkHlvW67Tsup5EAuUgJ/AomZclaeoetDeq7i7gRBSsKVd3d
LNqwLKwQ5AU1v5vSV6igIB7PLZxniZiQojkJMbxpOW74BK/Fb+v/y3raP2MINiWC
8rZAOVwAAoeku8quNHb1tFi4anQtEcvJOxX0z8d+R9CgFQdkXxPgu5X5FV6+5gAB
HJpT1S282PQUVYcbI9zt1fW2il/8gZp1CzyV8HKWAyvyC8KBIBqsuFaQr1b7bvN2
n/OQBpiNn0IVA89gZjc5+TVSrgNe+AZDr6G3ZQEHImTPF1FX2StqJ0l4gNaQB3rm
NwsMb6y5QdKBf8f7rnuvAtZCvOQvECaELn3mN7m/QSjFUuzh2xobFKG3faK+47n1
36ojml6/JeUjbMFAE1Hyesv+9nqtJAfkEHLPDm/S336dP+p+68Yli5CiFJD814qT
k1pYkxVCV8R4DWY0XL9rqmsa7jnDBhTVAl1mU+Sv5oI9ovtry2JIJNTvC0iPHMnW
duCBqJMls8zta9DO51D00lkDxNOEy7nxLecwk1TiUN1o5y96EnO8jhYFtaRxRmzS
GNL6CubZzeSiMVhjbt//TNbnNJ3U/VTmcndh98AMZxigPduAM/o=
=UQ9y
-----END PGP SIGNATURE-----

--g4OvIP98IRpDGBfv6m5cnR3O6RSIZEFCA--
