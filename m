Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726482AbfKNQCF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:02:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEFu3Dn019098
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:02:03 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w98jpc615-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:01:27 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 16:00:46 -0000
Subject: Re: [RFC 21/37] KVM: S390: protvirt: Instruction emulation
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-22-frankja@linux.ibm.com>
 <20191114163819.4fb4bed1.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 17:00:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191114163819.4fb4bed1.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="inn8F68ytwU9e9c4sIqhVBsNilow3Ta6d"
Message-Id: <d25f2feb-2c40-efae-9970-e08c871de94e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--inn8F68ytwU9e9c4sIqhVBsNilow3Ta6d
Content-Type: multipart/mixed; boundary="FCnCkHKGqYIED1pdS398bmqp0uAAphmfy"

--FCnCkHKGqYIED1pdS398bmqp0uAAphmfy
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 4:38 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:43 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> We have two new SIE exit codes 104 for a secure instruction
>> interception, on which the SIE needs hypervisor action to complete the=

>> instruction.
>>
>> And 108 which is merely a notification and provides data for tracking
>> and management, like for the lowcore we set notification bits for the
>> lowcore pages.
>=20
> What about the following:
>=20
> "With protected virtualization, we have two new SIE exit codes:
>=20
> - 104 indicates a secure instruction interception; the hypervisor needs=

>   to complete emulation of the instruction.
> - 108 is merely a notification providing data for tracking and
>   management in the hypervisor; for example, we set notification bits
>   for the lowcore pages."
>=20
> ?
>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  2 ++
>>  arch/s390/kvm/intercept.c        | 23 +++++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/=
kvm_host.h
>> index 2a8a1e21e1c3..a42dfe98128b 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -212,6 +212,8 @@ struct kvm_s390_sie_block {
>>  #define ICPT_KSS	0x5c
>>  #define ICPT_PV_MCHKR	0x60
>>  #define ICPT_PV_INT_EN	0x64
>> +#define ICPT_PV_INSTR	0x68
>> +#define ICPT_PV_NOT	0x6c
>=20
> Maybe ICPT_PV_NOTIF?

NOTF?

>=20
>>  	__u8	icptcode;		/* 0x0050 */
>>  	__u8	icptstatus;		/* 0x0051 */
>>  	__u16	ihcpu;			/* 0x0052 */
>> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
>> index b013a9c88d43..a1df8a43c88b 100644
>> --- a/arch/s390/kvm/intercept.c
>> +++ b/arch/s390/kvm/intercept.c
>> @@ -451,6 +451,23 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
>>  	return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
>>  }
>> =20
>> +static int handle_pv_spx(struct kvm_vcpu *vcpu)
>> +{
>> +	u32 pref =3D *(u32 *)vcpu->arch.sie_block->sidad;
>> +
>> +	kvm_s390_set_prefix(vcpu, pref);
>> +	trace_kvm_s390_handle_prefix(vcpu, 1, pref);
>> +	return 0;
>> +}
>> +
>> +static int handle_pv_not(struct kvm_vcpu *vcpu)
>> +{
>> +	if (vcpu->arch.sie_block->ipa =3D=3D 0xb210)
>> +		return handle_pv_spx(vcpu);
>> +
>> +	return handle_instruction(vcpu);
>=20
> Hm... if I understood it correctly, we are getting this one because the=

> SIE informs us about things that it handled itself (but which we
> should be aware of). What can handle_instruction() do in this case?

There used to be an instruction which I could just pipe through normal
instruction handling. But I can't really remember what it was, too many
firmware changes in that area since then.

I'll mark it as a TODO for thinking about it with some coffee.

>=20
>> +}
>> +
>>  int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>>  {
>>  	int rc, per_rc =3D 0;
>> @@ -505,6 +522,12 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcp=
u)
>>  		 */
>>  		rc =3D 0;
>>  	break;
>> +	case ICPT_PV_INSTR:
>> +		rc =3D handle_instruction(vcpu);
>> +		break;
>> +	case ICPT_PV_NOT:
>> +		rc =3D handle_pv_not(vcpu);
>> +		break;
>>  	default:
>>  		return -EOPNOTSUPP;
>>  	}
>=20



--FCnCkHKGqYIED1pdS398bmqp0uAAphmfy--

--inn8F68ytwU9e9c4sIqhVBsNilow3Ta6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NeikACgkQ41TmuOI4
ufjPmBAAiYVxSY40wrV7Yk7+Up9eFqQ6ZECpcVeq3B01X+IxfqSJn+Ad9zfa6PFa
GQfzrGDDlYPzV5taLgino/0ZYTBC1ra/s+8DkUQIvkmXtSlGtP9S8CVJ32YEd0Jc
xtyd7KusXH04SX+OhaiTXAX128JaxeMv3ZXO87l/84t8qkfFEkszPQu6jR1QKgjA
nMb818QGTLmOHScyDBVOEAq0tgMU0WYEPzPMAuR6B5SlPdt5ciKg2J6hTpwK3o5Q
EB0x7YqCBKnH/DNr0U2b7QjXCR1beuWdnxBJTJ2gH0tw0XLhTRwllJpnCkWdjfr6
Ff6yMJlNCnWYCvqwkQXFjGZymmQih/AF9Wj3hRMsZOyaM+mPrqrkjhu9aaBsRxC7
tCFLcbf79ecIdDJIA1hNuCaRVZB6WImnpJbKbQg/f7VJSMb8BUncd+uJ07NFtdAe
L86ltSll+fN1mds6ORLQxuftW0C8P/FkP3t3dOX6vOTlzP+LlGlhPUU7r5MrM/2l
auE6dnGvm2MzzUo7QcSO1j1SYLdeomc6WW3PdCL+DYFZKQ+d1zG8OGH0JZT15jYa
XgFfKM4haA4YuFaYf+NpCr4SliM4TLjeWc0dJkhxrY9K1OqyVhT0t4k5pKWMehAw
WmIetlF7J19mGwe0+VpoCfMWpgQvdOed0ezuuj6RvJP8Iw7SXbo=
=w6Wb
-----END PGP SIGNATURE-----

--inn8F68ytwU9e9c4sIqhVBsNilow3Ta6d--
