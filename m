Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbfKSILU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 03:11:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJ86s32151680
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 03:11:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wayaxjbqc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 03:11:18 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 19 Nov 2019 08:11:17 -0000
Subject: Re: [RFC 23/37] KVM: s390: protvirt: Make sure prefix is always
 protected
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-24-frankja@linux.ibm.com>
 <20191118173942.0252b731.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 19 Nov 2019 09:11:11 +0100
MIME-Version: 1.0
In-Reply-To: <20191118173942.0252b731.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dTiQux0JQ55Djpg2Rsgq8qTwZonfqEr3C"
Message-Id: <db54630b-8959-feba-168e-0afecc30d4b9@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dTiQux0JQ55Djpg2Rsgq8qTwZonfqEr3C
Content-Type: multipart/mixed; boundary="WXgCMtOkbkxdPBessyThRwbnTNXHfBbyq"

--WXgCMtOkbkxdPBessyThRwbnTNXHfBbyq
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/18/19 5:39 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:45 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
> Add at least a short sentence here?

For protected VMs the lowcore does not only need to be mapped, but also
needs to be protected memory, if not we'll get a validity interception
when trying to run it.

>=20
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index eddc9508c1b1..17a78774c617 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3646,6 +3646,15 @@ static int kvm_s390_handle_requests(struct kvm_=
vcpu *vcpu)
>>  		rc =3D gmap_mprotect_notify(vcpu->arch.gmap,
>>  					  kvm_s390_get_prefix(vcpu),
>>  					  PAGE_SIZE * 2, PROT_WRITE);
>> +		if (!rc && kvm_s390_pv_is_protected(vcpu->kvm)) {
>> +			rc =3D uv_convert_to_secure(vcpu->arch.gmap,
>> +						  kvm_s390_get_prefix(vcpu));
>> +			WARN_ON_ONCE(rc && rc !=3D -EEXIST);
>> +			rc =3D uv_convert_to_secure(vcpu->arch.gmap,
>> +						  kvm_s390_get_prefix(vcpu) + PAGE_SIZE);
>> +			WARN_ON_ONCE(rc && rc !=3D -EEXIST);
>> +			rc =3D 0;
>=20
> So, what happens if we have an error other than -EEXIST (which
> presumably means that we already protected it) here? The page is not
> protected, and further accesses will get an error? (Another question:
> what can actually go wrong here?)

If KVM or QEMU write into a lowcore, we will fail the integrity check on
import and this cpu will never run again.

In retrospect a warn_on_once might be the wrong error handling here.

>=20
>> +		}
>>  		if (rc) {
>>  			kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
>>  			return rc;
>=20



--WXgCMtOkbkxdPBessyThRwbnTNXHfBbyq--

--dTiQux0JQ55Djpg2Rsgq8qTwZonfqEr3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3To6AACgkQ41TmuOI4
ufjICBAArn8chPtOBdwPrGdyUqynbSUeN2sCnMJ71dvs+8V2AKXr1lM/uiGtz4v0
6WEbkZ3k0ZAMbrE+sBAlK/ghma9Vcn6FkFFTJPoBmUTlQXlMN3HTJntqIl279AcR
gyRSk2qJgF+VLxO4YexVw4nBz8Az6ez0tDyVYtftDAf+Q0Ha/1Aivq0F68C23MKZ
rzSCHsxjTmCBFZmr1fJxeK1ad6Pw6ra0HBWUocKiLnJxcUax3oBAFs9uPoDM/I/y
5ZV8o90TSVFIDBbQR0V2Ee32s0bOj409Il3hH7hyK4PKqEtvIxZDOBXYMjSJcuPZ
M7JP7wvImzUfwEJoZ8H27fTf4V0voHZJGDAgjI9xAioOTEBL3a7enHhHEwcFoCJY
pnc81zrKeOcrL3wn4eNgsqPl5FsZ654wpqq4oVugxgogpmFn3QLiH4DGYXMm6829
vPb1utkCOvKPHITj33yh0q8HYNAEfzFMvGcz/kriHrEuBEhJPIFxr9IqiTrE2efp
LDnXDsR81CKScNsE4iPMzfUVYkYV1worMJtQQqWoZCGcngsNKjMC63hnb+HPguh7
7KvnaPOpLkly/dS2IIC8vqFpweVIUQHM+ipQucBv/32QbOVcRu38IQGeExyWhAx3
St7cDHMEZ9+RyliVxTmxfuoJbrHBNiSecZXylob3RaraLBUIRqY=
=Gtoe
-----END PGP SIGNATURE-----

--dTiQux0JQ55Djpg2Rsgq8qTwZonfqEr3C--
