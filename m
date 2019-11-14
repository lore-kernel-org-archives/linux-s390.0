Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbfKNQEy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:04:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEG2vPu127545
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:04:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w993ekgmj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:04:49 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 16:04:22 -0000
Subject: Re: [RFC 20/37] KVM: S390: protvirt: Introduce instruction data area
 bounce buffer
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-21-frankja@linux.ibm.com>
 <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 17:04:17 +0100
MIME-Version: 1.0
In-Reply-To: <ad0f9b90-3ce4-c2d2-b661-635fe439f7e2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LHV2TP065q4fcdyLCT5MnbeA9lSe9eCJf"
Message-Id: <05b2ee44-5a6f-079d-61e0-defd01efd4d0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LHV2TP065q4fcdyLCT5MnbeA9lSe9eCJf
Content-Type: multipart/mixed; boundary="b79egI7UokBcavN5IBeTFrakOUwGwXgLU"

--b79egI7UokBcavN5IBeTFrakOUwGwXgLU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 4:36 PM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> Now that we can't access guest memory anymore, we have a dedicated
>> sattelite block that's a bounce buffer for instruction data.
>=20
> "satellite block that is ..."
>=20
>> We re-use the memop interface to copy the instruction data to / from
>> userspace. This lets us re-use a lot of QEMU code which used that
>> interface to make logical guest memory accesses which are not possible=

>> anymore in protected mode anyway.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  5 ++++-
>>  arch/s390/kvm/kvm-s390.c         | 31 +++++++++++++++++++++++++++++++=

>>  arch/s390/kvm/pv.c               |  9 +++++++++
>>  3 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index 5deabf9734d9..2a8a1e21e1c3 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -308,7 +308,10 @@ struct kvm_s390_sie_block {
>>  #define CRYCB_FORMAT2 0x00000003
>>  	__u32	crycbd;			/* 0x00fc */
>>  	__u64	gcr[16];		/* 0x0100 */
>> -	__u64	gbea;			/* 0x0180 */
>> +	union {
>> +		__u64	gbea;			/* 0x0180 */
>> +		__u64	sidad;
>> +	};
>>  	__u8    reserved188[8];		/* 0x0188 */
>>  	__u64   sdnxo;			/* 0x0190 */
>>  	__u8    reserved198[8];		/* 0x0198 */
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 97d3a81e5074..6747cb6cf062 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4416,6 +4416,13 @@ static long kvm_s390_guest_mem_op(struct kvm_vc=
pu *vcpu,
>>  	if (mop->size > MEM_OP_MAX_SIZE)
>>  		return -E2BIG;
>> =20
>> +	/* Protected guests move instruction data over the satellite
>> +	 * block which has its own size limit
>> +	 */
>> +	if (kvm_s390_pv_is_protected(vcpu->kvm) &&
>> +	    mop->size > ((vcpu->arch.sie_block->sidad & 0x0f) + 1) * PAGE_SI=
ZE)
>> +		return -E2BIG;
>> +
>>  	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>>  		tmpbuf =3D vmalloc(mop->size);
>>  		if (!tmpbuf)
>> @@ -4427,10 +4434,22 @@ static long kvm_s390_guest_mem_op(struct kvm_v=
cpu *vcpu,
>>  	switch (mop->op) {
>>  	case KVM_S390_MEMOP_LOGICAL_READ:
>>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>> +			if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +				r =3D 0;
>> +				break;
>=20
> Please add a short comment to the code why this is required / ok.
>=20
>> +			}
>>  			r =3D check_gva_range(vcpu, mop->gaddr, mop->ar,
>>  					    mop->size, GACC_FETCH);
>>  			break;
>>  		}
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			r =3D 0;
>> +			if (copy_to_user(uaddr, (void *)vcpu->arch.sie_block->sidad +
>> +					 (mop->gaddr & ~PAGE_MASK),
>=20
> That looks bogus. Couldn't userspace use mop->gaddr =3D 4095 and mop->s=
ize
> =3D 4095 to read most of the page beyond the sidad page (assuming that =
it
> is mapped, too)?
> I think you have to take mop->gaddr into account in your new check at
> the beginning of the function, too.

Ah, right, that needs some fixing.

>=20
> Or should the ioctl maybe even be restricted to mop->gaddr =3D=3D 0 now=
? Is
> there maybe also a way to validate that gaddr & PAGE_MASK really matche=
s
> the page that we have in sidad?

There was one lonely usage of the ioctl where we still read from an
offset, either in IO or SCLP. Having 0 as a requirement would certainly
help, but I was a bit afraid of changing too many things in qemu.

>=20
>> +					 mop->size))
>> +				r =3D -EFAULT;
>> +			break;
>> +		}
>>  		r =3D read_guest(vcpu, mop->gaddr, mop->ar, tmpbuf, mop->size);
>>  		if (r =3D=3D 0) {
>>  			if (copy_to_user(uaddr, tmpbuf, mop->size))
>> @@ -4439,10 +4458,22 @@ static long kvm_s390_guest_mem_op(struct kvm_v=
cpu *vcpu,
>>  		break;
>>  	case KVM_S390_MEMOP_LOGICAL_WRITE:
>>  		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>> +			if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +				r =3D 0;
>> +				break;
>> +			}
>>  			r =3D check_gva_range(vcpu, mop->gaddr, mop->ar,
>>  					    mop->size, GACC_STORE);
>>  			break;
>>  		}
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			r =3D 0;
>> +			if (copy_from_user((void *)vcpu->arch.sie_block->sidad +
>> +					   (mop->gaddr & ~PAGE_MASK), uaddr,
>> +					   mop->size))
>=20
> dito, of course.
>=20
>> +				r =3D -EFAULT;
>> +			break;
>> +		}
>>  		if (copy_from_user(tmpbuf, uaddr, mop->size)) {
>>  			r =3D -EFAULT;
>>  			break;
>=20
>  Thomas
>=20



--b79egI7UokBcavN5IBeTFrakOUwGwXgLU--

--LHV2TP065q4fcdyLCT5MnbeA9lSe9eCJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NewEACgkQ41TmuOI4
ufgz0hAApNI27GtJjb9UxXU3LyiuWVhwMghvGethg4YF4+y26XA2w5Z4kIy5C/qV
l6A8xzn9CrQNTcLtEVBrnlXax8T7U7P8FXEWq1h4u644XN6Tyj7t0zKIHgv+kXo8
eXMKRmxaV8YoRo4aMNTpdPvLlkWEX/YgkKiToBaC9BkgDh9xeixhaTsrUiRkCwMf
oHwkXeHFGG7EyN6AS59YKN3F6Qv7TWVTR63l1p4banWZjlyRvMy8/zOCvHHWnJhu
OAivUD338DBBA8Q03VTb20m0L8MG6o2CNbYsUznjGAFrNLTQEm2+56xWxDfNmB9r
xnWb54X7Fe+bRv4GqtLbyI6KWXJwMNkfJzGxCl5dfccqFzPkyN2q9b8RbgydH0hK
4Tr7RieWf/xYx2G5xzpZEDqFkkUypDCdqNDpilS1xPkIRtw62avKqxz9jPw+uqx1
+CZ2r83Hh1X0us8jz6WJHxDYNDLzJIG1bgnj2m3bm/wTTGr32QI7ZcvdwB9xh5LH
1wtiF/6Vhu4nLsD7wV7rWvokQN6NK+BgVuJbAvavdxZsap2EVFKPgpuR/8pmElqd
xdD+crI38FvM3NRqCDoCxqx8iJL8h+caFkqB3HBdUoSXBjVcSB6wALxcWgaKGYxE
LSlVsKf3a1v72k4CcSn29gI4GoHhQTLPcRfaZmeX993W1hEcKYs=
=zJz+
-----END PGP SIGNATURE-----

--LHV2TP065q4fcdyLCT5MnbeA9lSe9eCJf--
