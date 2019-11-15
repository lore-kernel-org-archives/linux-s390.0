Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727486AbfKOKU7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:20:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFAHbqm112770
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:20:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nse1eqj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 05:20:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 10:20:56 -0000
Subject: Re: [RFC 31/37] KVM: s390: protvirt: Add diag 308 subcode 8 - 10
 handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-32-frankja@linux.ibm.com>
 <a1c263ff-954e-a7c3-28b4-e9bd866eb35f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 11:20:52 +0100
MIME-Version: 1.0
In-Reply-To: <a1c263ff-954e-a7c3-28b4-e9bd866eb35f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mNYpZWWMOSggPlAcZYjb8DkDdg1R4ughY"
Message-Id: <f9ecf949-3f0d-fb64-cc77-44974a71625e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mNYpZWWMOSggPlAcZYjb8DkDdg1R4ughY
Content-Type: multipart/mixed; boundary="0OjYKmcMSlh5SbpgqAJVhbT8Vo68SsmnL"

--0OjYKmcMSlh5SbpgqAJVhbT8Vo68SsmnL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 11:04 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> If the host initialized the Ultravisor, we can set stfle bit 161
>> (protected virtual IPL enhancements facility), which indicates, that
>> the IPL subcodes 8, 9 and are valid. These subcodes are used by a
>> normal guest to set/retrieve a IPIB of type 5 and transition into
>> protected mode.
>>
>> Once in protected mode, the VM will loose the facility bit, as each
>=20
> So should the bit be cleared in the host code again? ... I don't see
> this happening in this patch?
>=20
>  Thomas

No, KVM doesn't report stfle facilities in protected mode and we would
need to add it again in normal mode so just clearing it would be
pointless. In protected mode 8-10 do not intercept, so there's nothing
we need to do.

>=20
>=20
>> boot into protected mode has to go through non-protected. There is no
>> secure re-ipl with subcode 10 without a previous subcode 3.
>>
>> In protected mode, there is no subcode 4 available, as the VM has no
>> more access to its memory from non-protected mode. I.e. each IPL
>> clears.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/diag.c     | 6 ++++++
>>  arch/s390/kvm/kvm-s390.c | 5 +++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
>> index 3fb54ec2cf3e..b951dbdcb6a0 100644
>> --- a/arch/s390/kvm/diag.c
>> +++ b/arch/s390/kvm/diag.c
>> @@ -197,6 +197,12 @@ static int __diag_ipl_functions(struct kvm_vcpu *=
vcpu)
>>  	case 4:
>>  		vcpu->run->s390_reset_flags =3D 0;
>>  		break;
>> +	case 8:
>> +	case 9:
>> +	case 10:
>> +		if (!test_kvm_facility(vcpu->kvm, 161))
>> +			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +		/* fall through */
>>  	default:
>>  		return -EOPNOTSUPP;
>>  	}
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 500972a1f742..8947f1812b12 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2590,6 +2590,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned =
long type)
>>  	if (css_general_characteristics.aiv && test_facility(65))
>>  		set_kvm_facility(kvm->arch.model.fac_mask, 65);
>> =20
>> +	if (is_prot_virt_host()) {
>> +		set_kvm_facility(kvm->arch.model.fac_mask, 161);
>> +		set_kvm_facility(kvm->arch.model.fac_list, 161);
>> +	}
>> +
>>  	kvm->arch.model.cpuid =3D kvm_s390_get_initial_cpuid();
>>  	kvm->arch.model.ibc =3D sclp.ibc & 0x0fff;
>> =20
>>
>=20



--0OjYKmcMSlh5SbpgqAJVhbT8Vo68SsmnL--

--mNYpZWWMOSggPlAcZYjb8DkDdg1R4ughY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OfAQACgkQ41TmuOI4
ufgQJRAAoBtCjfumzllkyZTQ/uQSqRqjPR7uB7phjpQCIiVKgk4A09wm/u7MA/Tq
oqOHdedilCE3bh49jB7GvS9mKpzbZd7Y4T0F9uvXgbgxR/6wge+5gLBU7vHUwJnU
D4ygrcDAV2EOQqUKACIL1TvJ6WCEqp7UrWpFNLfk61j3WPUaSIje/K6v61brTOGy
4PpKg/afmFugkj7vOBu7d6WLpmuKSeSU4gdrR6+NT1hO3/AHMqOrQaSB50BMlDgl
cN57Db2AnKJlCYM7yaWEL0yKKpLi93j/q7Kn88vo+9iM6AK+SbaEDuUHO4G/pisn
ZbICi1mb7Qki9kezlHl3pyUEzBaH/RrD2NdG0qov+EOz+yjpfC4GPa+Y2zNymz+D
+gBdSYCI6YSUjoZnbXJzy2b/90wgKfJq9CzcwLQ1nvfyPTJ6p7HmUZuuPAeOZLlN
rZbF4WFgfmTMMbbAUNcEjUgLcKRXTmp3zyOSx6AGntK9ohftz7+S/KtfGvgQwdj7
N7vRxUAPCfjOo55ePb2/BOFi9pV1MREC9SF/LBML+wI+18TCTbq2PpZeWARL+LO0
a1j/HqdaBYiInUgf9SdJzOwaXSzu6gWlacbp+K8x7LwfwSC7yRIEOnBO/dNd82Pz
sENSKN4ieGLqynBr3v6xW7SDhPbI69Pn+gdRm0q8V6OyET/Answ=
=Neg9
-----END PGP SIGNATURE-----

--mNYpZWWMOSggPlAcZYjb8DkDdg1R4ughY--
