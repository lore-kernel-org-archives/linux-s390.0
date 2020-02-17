Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728723AbgBQOrc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 09:47:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEje8J135077
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:47:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6af35bqy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 09:47:30 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 17 Feb 2020 14:47:28 -0000
Subject: Re: [PATCH v2 20/42] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-21-borntraeger@de.ibm.com>
 <ad84934a-3d18-d56e-5658-1d8b8292f6b3@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 17 Feb 2020 15:47:22 +0100
MIME-Version: 1.0
In-Reply-To: <ad84934a-3d18-d56e-5658-1d8b8292f6b3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IkuIXpRklqXzRNnAQahw4MRfuWI3zCvXn"
Message-Id: <d16b7ba2-38fc-5128-bd40-587d96e7936f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IkuIXpRklqXzRNnAQahw4MRfuWI3zCvXn
Content-Type: multipart/mixed; boundary="mYNSzJHYaFYGc2zZRNKkMgoP2vJy4rek4"

--mYNSzJHYaFYGc2zZRNKkMgoP2vJy4rek4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/17/20 12:08 PM, David Hildenbrand wrote:
>> @@ -4460,6 +4489,10 @@ static long kvm_s390_guest_mem_op(struct kvm_vc=
pu *vcpu,
>> =20
>>  	switch (mop->op) {
>>  	case KVM_S390_MEMOP_LOGICAL_READ:
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			r =3D -EINVAL;
>> +			break;
>> +		}
>=20
> Could we have a possible race with disabling code, especially while
> concurrently freeing? (sorry if I ask again, there was just a flood of
> emails)
>=20
>>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>>  			r =3D check_gva_range(vcpu, mop->gaddr, mop->ar,
>>  					    mop->size, GACC_FETCH);
>> @@ -4472,6 +4505,10 @@ static long kvm_s390_guest_mem_op(struct kvm_vc=
pu *vcpu,
>>  		}
>>  		break;
>>  	case KVM_S390_MEMOP_LOGICAL_WRITE:
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			r =3D -EINVAL;
>> +			break;
>> +		}
>=20
> dito
>=20
>>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>>  			r =3D check_gva_range(vcpu, mop->gaddr, mop->ar,
>>  					    mop->size, GACC_STORE);
>> @@ -4483,6 +4520,11 @@ static long kvm_s390_guest_mem_op(struct kvm_vc=
pu *vcpu,
>>  		}
>>  		r =3D write_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
>>  		break;
>> +	case KVM_S390_MEMOP_SIDA_READ:
>> +	case KVM_S390_MEMOP_SIDA_WRITE:
>> +		/* we are locked against sida going away by the vcpu->mutex */
>> +		r =3D kvm_s390_guest_sida_op(vcpu, mop);
>> +		break;
>>  	default:
>>  		r =3D -EINVAL;
>>  	}
>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>> index 09573e36c329..80169a9b43ec 100644
>> --- a/arch/s390/kvm/pv.c
>> +++ b/arch/s390/kvm/pv.c
>> @@ -92,6 +92,7 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u=
16 *rc, u16 *rrc)
>> =20
>>  	free_pages(vcpu->arch.pv.stor_base,
>>  		   get_order(uv_info.guest_cpu_stor_len));
>> +	free_page(sida_origin(vcpu->arch.sie_block));
>>  	vcpu->arch.sie_block->pv_handle_cpu =3D 0;
>>  	vcpu->arch.sie_block->pv_handle_config =3D 0;
>>  	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
>> @@ -121,6 +122,14 @@ int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu,=
 u16 *rc, u16 *rrc)
>>  	uvcb.state_origin =3D (u64)vcpu->arch.sie_block;
>>  	uvcb.stor_origin =3D (u64)vcpu->arch.pv.stor_base;
>> =20
>> +	/* Alloc Secure Instruction Data Area Designation */
>> +	vcpu->arch.sie_block->sidad =3D __get_free_page(GFP_KERNEL | __GFP_Z=
ERO);
>> +	if (!vcpu->arch.sie_block->sidad) {
>> +		free_pages(vcpu->arch.pv.stor_base,
>> +			   get_order(uv_info.guest_cpu_stor_len));
>> +		return -ENOMEM;
>> +	}
>> +
>>  	cc =3D uv_call(0, (u64)&uvcb);
>>  	*rc =3D uvcb.header.rc;
>>  	*rrc =3D uvcb.header.rrc;
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 207915488502..0fdee1bc3798 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -475,11 +475,15 @@ struct kvm_s390_mem_op {
>>  	__u32 op;		/* type of operation */
>>  	__u64 buf;		/* buffer in userspace */
>>  	__u8 ar;		/* the access register number */
>> -	__u8 reserved[31];	/* should be set to 0 */
>> +	__u8 reserved21[3];	/* should be set to 0 */
>> +	__u32 sida_offset;	/* offset into the sida */
>> +	__u8 reserved28[24];	/* should be set to 0 */
>>  };
>=20
> As discussed, I'd prefer an overlaying layout for the sida, as the ar
> does not make any sense (correct me if I'm wrong :) )

That wouldn't work, because we still check mop->ar < 16 in
kvm_s390_guest_mem_op(). Also we currently check mop contents twice
because we overload mem_op() with the SIDA operations.

Using a separate IOCTL is cleaner...

>=20
> __u32 op;		/* type of operation */
> __u64 buf;		/* buffer in userspace */
> uinon {
> 	__u8 ar;		/* the access register number */
> 	__u32 sida_offset;	/* offset into the sida */
> 	__u8 reserved[32];	/* should be set to 0 */
> };
>=20
> With something like that
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>


--mYNSzJHYaFYGc2zZRNKkMgoP2vJy4rek4--

--IkuIXpRklqXzRNnAQahw4MRfuWI3zCvXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5Kp3oACgkQ41TmuOI4
ufgs6Q//aDV6FqgoBX20jYAgoT6m9sEyCYx2T19DB7kB3E1nnmL1FQtRu/M+0pX8
lsHAD6pFor40xWvlmsWMbaZ9bfhLf5dv34TYPz3anU50FND4a0N+1MLMUJUrzjYo
R6dvT9qfcvelv9LmZlcrZE4sQY4ZZP2E3u5e5hls47setDMm1mrNGv2YO/0GFea4
vnWUuWAJTiTO99ICYin7NYgHdO8doXPhH1LNSdTQUogkJ0WBJi5QoWoq5o6H7G9f
Q6dA93OJNrLI31Y+Ft9GXhm3KBet2b2IGIIt2p0r9QX0pIeRQ2eouSzUVifcTeHf
L4m1CGSI18rBqbVZxLWwTqk2m3KKwB61g8V8cn0p46ZS4l8GMj8d/UGPNR+4h/jl
7nfUNkQ6W62Hgb72ezqSz6l/WRKMV2sieLHGBUqJSyJb2i9DzuXsHlJ1EqTex6rG
Izno9ZDp2+YglqNoYqnTpEKcF/4rWob5r5YDf8qBkF+Psj8m2AcIzruP/2I+Q27n
1+piMp/NOi3m/n2EJm40VrPLU0lKhiPzZ7EAhknLq2zySDsIu6xSFC4fUMURThYN
Y56dMhaSnd+MLEmOuFNav3UxWKwbjrKUz+1qyGo5cqcrXAbZQUiiASEJk+Q8yOII
Yw4B388ctnkL3cn095itQUB0ubw3uw+C4sGK55YdW6sjMGG57zE=
=G8op
-----END PGP SIGNATURE-----

--IkuIXpRklqXzRNnAQahw4MRfuWI3zCvXn--
