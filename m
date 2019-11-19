Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfKSINT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 03:13:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJ86rtB151591
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 03:13:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wayaxjdma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 03:13:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 19 Nov 2019 08:13:16 -0000
Subject: Re: [RFC 36/37] KVM: s390: protvirt: Support cmd 5 operation state
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-37-frankja@linux.ibm.com>
 <20191118183842.36688a81.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 19 Nov 2019 09:13:11 +0100
MIME-Version: 1.0
In-Reply-To: <20191118183842.36688a81.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gXRvC5ZMi5gtu4I8P6lKGeAW1ut7Ub9Ic"
Message-Id: <44b320d8-604d-8497-59a3-defc41472ba5@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gXRvC5ZMi5gtu4I8P6lKGeAW1ut7Ub9Ic
Content-Type: multipart/mixed; boundary="1MSDSL0H1jtdlGEEfZLivWwpLGkPF5Zcq"

--1MSDSL0H1jtdlGEEfZLivWwpLGkPF5Zcq
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/18/19 6:38 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:58 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Code 5 for the set cpu state UV call tells the UV to load a PSW from
>> the SE header (first IPL) or from guest location 0x0 (diag 308 subcode=

>> 0/1). Also it sets the cpu into operating state afterwards, so we can
>> start it.
>=20
> I'm a bit confused by the patch description: Does this mean that the UV=

> does the transition to operating state? Does the hypervisor get a
> notification for that?

CMD 5 is defined as "load psw and set to operating".
Currently QEMU will still go out and do a "set to operating" after the
cmd 5 because our current infrastructure does it and it's basically a
nop, so I didn't want to put in the effort to remove it.

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 1 +
>>  arch/s390/kvm/kvm-s390.c   | 4 ++++
>>  include/uapi/linux/kvm.h   | 1 +
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 33b52ba306af..8d10ae731458 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -163,6 +163,7 @@ struct uv_cb_unp {
>>  #define PV_CPU_STATE_OPR	1
>>  #define PV_CPU_STATE_STP	2
>>  #define PV_CPU_STATE_CHKSTP	3
>> +#define PV_CPU_STATE_OPR_LOAD	5
>> =20
>>  struct uv_cb_cpu_set_state {
>>  	struct uv_cb_header header;
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index cc5feb67f145..5cc9108c94e4 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4652,6 +4652,10 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_v=
cpu *vcpu,
>>  		r =3D kvm_s390_pv_destroy_cpu(vcpu);
>>  		break;
>>  	}
>> +	case KVM_PV_VCPU_SET_IPL_PSW: {
>> +		r =3D kvm_s390_pv_set_cpu_state(vcpu, PV_CPU_STATE_OPR_LOAD);
>> +		break;
>> +	}
>>  	default:
>>  		r =3D -ENOTTY;
>>  	}
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 2846ed5e5dd9..973007d27d55 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1483,6 +1483,7 @@ enum pv_cmd_id {
>>  	KVM_PV_VM_UNSHARE,
>>  	KVM_PV_VCPU_CREATE,
>>  	KVM_PV_VCPU_DESTROY,
>> +	KVM_PV_VCPU_SET_IPL_PSW,
>>  };
>> =20
>>  struct kvm_pv_cmd {
>=20



--1MSDSL0H1jtdlGEEfZLivWwpLGkPF5Zcq--

--gXRvC5ZMi5gtu4I8P6lKGeAW1ut7Ub9Ic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3TpBcACgkQ41TmuOI4
ufisphAAlkQNPbD8yxn4GCTR+EeFWa76Mjem9uPOySYbda5Xucp61izC9MFJx9+z
UFvaZ6KVXEjoOK9LHkKXBCF2E1VJ6nHnos2A5eKhbtx75d0P6r43wjDX8vvBVa6u
fqvZy8fFsqZix6SZGL4FA3pm3sfHcGk3h35HdsYox8f1jvthT8Yv67y9xP4ca/ur
TYCoUae31JFuGZmdBXKGAS8ihV8QYqgsU4x4kvBfHBDJVG4QHLvMdq5eMzxD9K2t
gF952x9adjm25nxeSbZjT9IIPG/jQlE016nGEtTXJna6sFmW0Q3AhVjfL9tWQdUe
CLGOIqj6IednSDxU8Ud6TAacgoQ4Q+W3mWpGpqx8UaclIe1sSPIL9mtOkNYIC190
AmUQrMZZMTOObU7dLw6Cov1avrXULaN3cBqnkngWbKk+yBzpb7ng+JiAtib4JOuc
H87g9NsNMNBMaShicXHQWTbCLRr9v6Tvt7ahuVlfA8VcVhQ42Bj7n3+4md+jl7HG
9gGfovHn7CBLyj3eOMJgMa3oe/BUOcONm9WHGNTy+DahMppmrL56of3M0WmRL8sO
xk0kNAT8eEj6iH0QXkME2ut+VUL7yzaKI3IlOYysM37YgHqWv0aNugtEz5r+APZk
AvloZMkNAVe9wDQRypSmWGS3hnlZagfl2047iWtUqbyi8B2TBiY=
=RTd0
-----END PGP SIGNATURE-----

--gXRvC5ZMi5gtu4I8P6lKGeAW1ut7Ub9Ic--
