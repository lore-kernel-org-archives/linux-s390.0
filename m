Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbfK2O5e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:57:34 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATEv1cP137424
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:57:33 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjvfgjd4y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:57:32 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 29 Nov 2019 14:57:30 -0000
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
References: <20191129142122.21528-1-frankja@linux.ibm.com>
 <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
 <8e1aa1af-d929-e36b-f341-aa7dbe27f6a4@linux.ibm.com>
 <227a8fce-7e14-030e-b0a4-17e4521eed98@redhat.com>
 <dedd1d55-bebb-059e-c8c9-7c2771afa157@linux.ibm.com>
 <708d16c2-fa18-8ab9-afb5-44b5af638cb4@de.ibm.com>
 <487af903-bb8c-a7c5-b81d-dc0ce1bb7b75@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 29 Nov 2019 15:57:25 +0100
MIME-Version: 1.0
In-Reply-To: <487af903-bb8c-a7c5-b81d-dc0ce1bb7b75@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cF8bNpwVQ5YdbbcAhcXMt455c6MVLITt6"
Message-Id: <933de98c-2299-caf8-e237-011164273837@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, mihajlov@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cF8bNpwVQ5YdbbcAhcXMt455c6MVLITt6
Content-Type: multipart/mixed; boundary="RN7g0jipp5AzTpwRCyr5KiXbmJ5ajzhlM"

--RN7g0jipp5AzTpwRCyr5KiXbmJ5ajzhlM
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/19 3:48 PM, David Hildenbrand wrote:
> On 29.11.19 15:39, Christian Borntraeger wrote:
>>
>>
>> On 29.11.19 15:38, Janosch Frank wrote:
>> [...]
>>>>>> As we now have two interfaces to achieve the same thing (initial r=
eset),
>>>>>> I do wonder if we should simply introduce
>>>>>>
>>>>>> KVM_S390_NORMAL_RESET
>>>>>> KVM_S390_CLEAR_RESET
>>>>>>
>>>>>> instead ...
>>>>>>
>>>>>> Then you can do KVM_S390_NORMAL_RESET for the bugfix and
>>>>>> KVM_S390_CLEAR_RESET later for PV.
>>>>>>
>>>>>> Does anything speak against that?
>>>>>
>>>>> Apart from loosing one more ioctl number probably not
>>>>
>>>> Do we care? (I think not, but maybe I am missing something :) )
>>>>
>>>
>>> I don't, maybe somebody else does
>>> Btw. I'm struggling to find a good name for the capability:
>>> KVM_CAP_S390_VCPU_ADDITIONAL_RESETS ?
>>
>> KVM_CAP_S390_VCPU_RESETS ?
>=20
> Either that or two separate ones if you're not going to introduce them
> at the same time ...
>=20

This is starting to get messy...


--RN7g0jipp5AzTpwRCyr5KiXbmJ5ajzhlM--

--cF8bNpwVQ5YdbbcAhcXMt455c6MVLITt6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3hMdUACgkQ41TmuOI4
ufhQtxAAwEwuU3+IpE0svAnZz5oNNq6GsxP/KumtbIrxPOmkwY39NCoAUhQZFTNg
dR1YFi1NlW5li3pkRSAoP1urkvpaC0RWy91fs1bEse4XJSlUXG8BKFHk5kDToUbJ
JlzkaUjj/pJ+qxNljCUijojtfqKzrrxBcymBHnctG7+ZLJ0N7zurjx2ikRiesjSO
KmxIfoMFs6xbWypAEuexlyj5j9Z0Uz5V4gm85L16bTsR9mzKW/LuOnJcx5GiyEeO
VJo/Z4VAMBPSMWyvPWg7iN+G0sg7LMUhbQ7i17ZYmjYTVIoBlrsOORQW/OO8Ph/3
0R+OuEOtZ0IJ1HBSurSQwH7hOh/D5SyJwLUPq/YMiYQQprobwYBLB1mV5Ck+ipTg
4C7cAS8mgvxlqVJQNo3yC/ELDTCgxIJhG4Ex7k2gPbyhjMrOgXRoAIuQOHFkJYGk
IQ53j7o76xYQM3KhgHThRlicEW2E3ooNf6kCbDJ5McJeFgUgUVIFtXTjIZEkZGIb
Lxq/VnTzF1J1XJR2gp3F+BzFCKSP8d4EMqtIENXTm8ISPwU7Te4NXGdZVwi/1TQt
weE3B6fArpUC+khlwxTSqydfjmFTVlOr5VGDiyJboDaEk8hdT0GBdwrkD9N+jIrV
x4x5GOu/NVAb4W7BS48MV9PSyP5FRjhC+JDyLEp0reBPpYH+gE4=
=Oyp1
-----END PGP SIGNATURE-----

--cF8bNpwVQ5YdbbcAhcXMt455c6MVLITt6--
