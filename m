Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729659AbgBYMvY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 07:51:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PCncsd043109
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 07:51:24 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b8j1jn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 07:51:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 25 Feb 2020 12:51:21 -0000
Subject: Re: [PATCH v4 24/36] KVM: s390: protvirt: Do only reset registers
 that are accessible
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-25-borntraeger@de.ibm.com>
 <20200225133252.479644ea.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 25 Feb 2020 13:51:12 +0100
MIME-Version: 1.0
In-Reply-To: <20200225133252.479644ea.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tkTdvCNkSbMOvKXiR3mNE5Z0kItvAA2TI"
Message-Id: <4726aa70-7c53-1985-8ada-3bfbea57e72f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tkTdvCNkSbMOvKXiR3mNE5Z0kItvAA2TI
Content-Type: multipart/mixed; boundary="CFEk8beRRdEtdlMFbFsdnMLG6vJieC0pu"

--CFEk8beRRdEtdlMFbFsdnMLG6vJieC0pu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/25/20 1:32 PM, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:40:55 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> For protected VMs the hypervisor can not access guest breaking event
>> address, program parameter, bpbc and todpr. Do not reset those fields
>> as the control block does not provide access to these fields.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 6ab4c88f2e1d..c734e89235f9 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3499,14 +3499,16 @@ static void kvm_arch_vcpu_ioctl_initial_reset(=
struct kvm_vcpu *vcpu)
>>  	kvm_s390_set_prefix(vcpu, 0);
>>  	kvm_s390_set_cpu_timer(vcpu, 0);
>>  	vcpu->arch.sie_block->ckc =3D 0;
>> -	vcpu->arch.sie_block->todpr =3D 0;
>>  	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gc=
r));
>>  	vcpu->arch.sie_block->gcr[0] =3D CR0_INITIAL_MASK;
>>  	vcpu->arch.sie_block->gcr[14] =3D CR14_INITIAL_MASK;
>>  	vcpu->run->s.regs.fpc =3D 0;
>> -	vcpu->arch.sie_block->gbea =3D 1;
>> -	vcpu->arch.sie_block->pp =3D 0;
>> -	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>> +	if (!kvm_s390_pv_cpu_is_protected(vcpu)) {
>> +		vcpu->arch.sie_block->gbea =3D 1;
>> +		vcpu->arch.sie_block->pp =3D 0;
>> +		vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>> +		vcpu->arch.sie_block->todpr =3D 0;
>=20
> What happens if we do change those values? Is it just ignored or will
> we get an exception on the next SIE entry?

Well, changing gbea is a bad idea because of the sida overlay.
I don't think that any other is checked, but I'd need to look up the
todpr changes to be completely sure.

>=20
>> +	}
>>  }
>> =20
>>  static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
>=20



--CFEk8beRRdEtdlMFbFsdnMLG6vJieC0pu--

--tkTdvCNkSbMOvKXiR3mNE5Z0kItvAA2TI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5VGEEACgkQ41TmuOI4
ufg0ShAApH/Q66NtLPlZ5Tg1Ds55t09/GFrr7EdYH0+gms2E16rPoFAVkNnRcJHv
c5aC/K8Nkh+TmrQDoXPUCN5d2kwu3YcyIz3KkoDrxM9Yw6aeIk+09NhHgupRbdk7
xA1H2LCDcMhSWB7r67gs9FRjP4rYVSfqfrFZJVh2hsWaoSDjanBsvFLa5YUaCQ06
8gyUGVROPV+szsJ03VHwoXCIKYmQx/6aw4uZCeXw4IZ499cq8ozTd1CZLsEoqoZO
rrj5PTPwoB7nmqf0vYk7GBQRjaZZrjjVFTTAq4UAI5x8qvj6psJMqorZdf55JYgB
Fei1lDB1ipeu2/aBegG6WrbgF8mR9MKMFUeln/eYszmoLjbJURjobl0CmO068wia
bZCmG/hYqDtSG9a/SyZequdR+IkkZoZMNnINI8OzblQXVQ0LGq1l6DZEWymoTHlx
rEA0h2/ceQZNxkHGvScgrIZoRbls4fqvdg+77PkStwvVG5LvVsLQOLfE0HNYgYDQ
kZ7sh8jf4ezgefXcH8BiYG/r7g83Rp/A6u2mWyJ3o+tSS65rxShG1rR5Q15pC7It
ipdxd7V9bTHvm963YR1aQktxgiKjCYVLHg3x3mr8/p690QtK0c9Mz5nbnaho5Ve2
ogl9Zr/KZu8gQPh/9afbrzc/xOl2YsgCoZYe/h0qN23QUzGVD/M=
=Tfev
-----END PGP SIGNATURE-----

--tkTdvCNkSbMOvKXiR3mNE5Z0kItvAA2TI--
