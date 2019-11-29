Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21090 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfK2OiS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:38:18 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATEbBKI141700
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:38:16 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar9qnjn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:38:15 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 29 Nov 2019 14:38:11 -0000
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
References: <20191129142122.21528-1-frankja@linux.ibm.com>
 <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
 <8e1aa1af-d929-e36b-f341-aa7dbe27f6a4@linux.ibm.com>
 <227a8fce-7e14-030e-b0a4-17e4521eed98@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 29 Nov 2019 15:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <227a8fce-7e14-030e-b0a4-17e4521eed98@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O7ZyLn69Q7iRXtPD42loc0ahgJtYCs7ZN"
Message-Id: <dedd1d55-bebb-059e-c8c9-7c2771afa157@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O7ZyLn69Q7iRXtPD42loc0ahgJtYCs7ZN
Content-Type: multipart/mixed; boundary="5PhmEEphpWeC52LNOo9hagPm6Jzf7QKO3"

--5PhmEEphpWeC52LNOo9hagPm6Jzf7QKO3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/19 3:33 PM, David Hildenbrand wrote:
> On 29.11.19 15:33, Janosch Frank wrote:
>> On 11/29/19 3:31 PM, David Hildenbrand wrote:
>>> On 29.11.19 15:21, Janosch Frank wrote:
>>>> The architecture states that we need to reset local IRQs for all CPU=

>>>> resets. Because the old reset interface did not support the normal C=
PU
>>>> reset we never did that.
>>>>
>>>> Now that we have a new interface, let's properly clear out local IRQ=
s
>>>> and let this commit be a reminder.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  arch/s390/kvm/kvm-s390.c | 25 ++++++++++++++++++++++++-
>>>>  include/uapi/linux/kvm.h |  7 +++++++
>>>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index d9e6bf3d54f0..2f74ff46b176 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm=
, long ext)
>>>>  	case KVM_CAP_S390_CMMA_MIGRATION:
>>>>  	case KVM_CAP_S390_AIS:
>>>>  	case KVM_CAP_S390_AIS_MIGRATION:
>>>> +	case KVM_CAP_S390_VCPU_RESETS:
>>>>  		r =3D 1;
>>>>  		break;
>>>>  	case KVM_CAP_S390_HPAGE_1M:
>>>> @@ -3293,6 +3294,25 @@ static int kvm_arch_vcpu_ioctl_initial_reset(=
struct kvm_vcpu *vcpu)
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> +static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu, unsigne=
d long type)
>>>> +{
>>>> +	int rc =3D -EINVAL;
>>>> +
>>>> +	switch (type) {
>>>> +	case KVM_S390_VCPU_RESET_NORMAL:
>>>> +		rc =3D 0;
>>>> +		kvm_clear_async_pf_completion_queue(vcpu);
>>>> +		kvm_s390_clear_local_irqs(vcpu);
>>>> +		break;
>>>> +	case KVM_S390_VCPU_RESET_INITIAL:
>>>> +		/* fallthrough */
>>>> +	case KVM_S390_VCPU_RESET_CLEAR:
>>>> +		rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>>>
>>> As we now have two interfaces to achieve the same thing (initial rese=
t),
>>> I do wonder if we should simply introduce
>>>
>>> KVM_S390_NORMAL_RESET
>>> KVM_S390_CLEAR_RESET
>>>
>>> instead ...
>>>
>>> Then you can do KVM_S390_NORMAL_RESET for the bugfix and
>>> KVM_S390_CLEAR_RESET later for PV.
>>>
>>> Does anything speak against that?
>>
>> Apart from loosing one more ioctl number probably not
>=20
> Do we care? (I think not, but maybe I am missing something :) )
>=20

I don't, maybe somebody else does
Btw. I'm struggling to find a good name for the capability:
KVM_CAP_S390_VCPU_ADDITIONAL_RESETS ?


--5PhmEEphpWeC52LNOo9hagPm6Jzf7QKO3--

--O7ZyLn69Q7iRXtPD42loc0ahgJtYCs7ZN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3hLU0ACgkQ41TmuOI4
ufhIAw//Yb+eOtFEGZnQsCfQ75MFU416FSQXZr3hHiGoSE6I8mjcJDuxcZF4SLPK
DPL2mR0GYGuwcrYa5HtzTLhK3yf8rQeV3OT5ldDs8/kfMMRULWQpdjufezfpPQnP
U7X/uDOpZzlYiyquSgWh2iwtj5JZipAkZaZo2otrj3ce1BRTcQBm6SdHMorltCgf
69tYKFEYhNRlYqhAveADDWX/OE+7MfbhV6MWvntWgAlAxMlXNgLypy7OWaV/oAma
gNPLqIWD/fy1yo18Ma0p7Kw8Qs8pGVaKWRLuPY7g1uEjpHqHmaPmxvAfF5GvsXSf
Ys9fY5rDM6tnGoPomF6I8zYrKOiFI/GL4YPefpHCxn5rLBXZmMSsYI9uPsJlH43p
LQDtYIsfEaxchi26luXAj0FpqUenZycRX4TA8mii4HZNg1N/U7IntH1WXBKszsG+
q/Ca87u/H0w8tdDYms/S/MQSzOLpEj7m0cZsIQ4TF09hTmmJy/XsfAevC3TglART
9XJjk7hl2JBTD/YsSjZTQYKE2KM+kVF8ZFGUwAmYP7TuO4KPiuBlU7WyV3siz7i2
tNa/wxAhM7FHZ+r3iantOrrsfRXZv7xPVp1Hif73GL3URkqzGR12ZPSZm1o4p0CJ
Y8vEFr0HTWsUqlffJr7DUr2KcOeCWnRDHgeCuPShD2gHSgu8ajc=
=SZ+G
-----END PGP SIGNATURE-----

--O7ZyLn69Q7iRXtPD42loc0ahgJtYCs7ZN--
