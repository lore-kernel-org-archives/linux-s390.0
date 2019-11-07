Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727300AbfKGJAE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Nov 2019 04:00:04 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA78vbCJ126682
        for <linux-s390@vger.kernel.org>; Thu, 7 Nov 2019 04:00:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41w518rm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2019 04:00:01 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 7 Nov 2019 08:59:54 -0000
Subject: Re: [RFC 30/37] DOCUMENTATION: protvirt: Diag 308 IPL
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-31-frankja@linux.ibm.com>
 <20191106174855.13a50f42.cohuck@redhat.com>
 <6dd98dfe-63ce-374c-9b04-00cdeceee905@linux.ibm.com>
 <20191106183754.68e1be0f.cohuck@redhat.com>
 <faacad49-3f91-08f3-d1ee-d31f31ac38bb@linux.ibm.com>
 <20191107095323.0ede44b5.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 7 Nov 2019 09:59:49 +0100
MIME-Version: 1.0
In-Reply-To: <20191107095323.0ede44b5.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ItZ2vptM4eZ6xUoUd2jOtqT7MuqSuqZM2"
Message-Id: <be94339f-90cf-3ce9-aaec-f6031dc11aeb@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ItZ2vptM4eZ6xUoUd2jOtqT7MuqSuqZM2
Content-Type: multipart/mixed; boundary="FL9wyKq4wi5P9CXhZ7lUKwCELV7ie8FM1"

--FL9wyKq4wi5P9CXhZ7lUKwCELV7ie8FM1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/7/19 9:53 AM, Cornelia Huck wrote:
> On Wed, 6 Nov 2019 22:02:41 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 11/6/19 6:37 PM, Cornelia Huck wrote:
>>> On Wed, 6 Nov 2019 18:05:22 +0100
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> On 11/6/19 5:48 PM, Cornelia Huck wrote: =20
>>>>> On Thu, 24 Oct 2019 07:40:52 -0400
>>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>>>    =20
>>>>>> Description of changes that are necessary to move a KVM VM into
>>>>>> Protected Virtualization mode.
>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> ---
>>>>>>  Documentation/virtual/kvm/s390-pv-boot.txt | 62 +++++++++++++++++=
+++++
>>>>>>  1 file changed, 62 insertions(+)
>>>>>>  create mode 100644 Documentation/virtual/kvm/s390-pv-boot.txt =20
>>>  =20
>>>>> So... what do we IPL from? Is there still a need for the bios?
>>>>>
>>>>> (Sorry, I'm a bit confused here.)
>>>>>    =20
>>>>
>>>> We load a blob via the bios (all methods are supported) and that blo=
b
>>>> moves itself into protected mode. I.e. it has a small unprotected st=
ub,
>>>> the rest is an encrypted kernel.
>>>> =20
>>>
>>> Ok. The magic is in the loaded kernel, and we don't need modification=
s
>>> to the bios?
>>>  =20
>>
>> Yes.
>>
>> The order is:
>> * We load a blob via the bios or direct kernel boot.
>> * That blob consists of a small stub, a header and an encrypted blob
>> glued together
>> * The small stub does the diag 308 subcode 8 and 10.
>> * Subcode 8 basically passes the header that describes the encrypted
>> blob to the Ultravisor (well rather registers it with qemu to pass on =
later)
>> * Subcode 10 tells QEMU to move the VM into protected mode
>> * A lot of APIs in KVM and the Ultravisor are called
>> * The protected VM starts
>> * A memory mover copies the now unencrypted, but protected kernel to i=
ts
>> intended place and jumps into the entry function
>> * Linux boots and detects, that it is protected and needs to use bounc=
e
>> buffers
>>
>=20
> Thanks, this explanation makes things much clearer.

NP
We seem to assume that all of this is easily understandable, but we are
obviously biased :-)
I'll try to improve Documentation by adding Pierre to the discussion, as
he wasn't involved in the project yet.



--FL9wyKq4wi5P9CXhZ7lUKwCELV7ie8FM1--

--ItZ2vptM4eZ6xUoUd2jOtqT7MuqSuqZM2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3D3QUACgkQ41TmuOI4
ufj6Pg//ZJTbUfemkydo3lvAjiJQYdOwQjrin7iFQg5HqwQv7+AjChfCt7hJ+n5T
Q4Vz0Dm1l4iIfhnchptUiYYBW4Eez9GMmo9VQc27Gs/4jbBAjCIlVN7MrYwg72Pf
X9tH4kH+cYqfeORf+Qs20unIIr854GYVMwjm5zLMMtqaEiK+dc0eD41sGc5csLJF
H5VHwrSufIS89auWLf7AWDU/L4ix1+XOrBEpHjogjEWzDk0GaqGiibsVxbNbeVLa
THtv/vE1ZoHlvznnrNLXA6g14OG75GMa0FicijtdNEqSVzJfzReYPlirC3u9BSma
uU52cv3ARpZ55xC7K5a4puYokX5z8zlGYRmcYK6mhbW4RUehWlm3ELE2mN3MBoZc
WIdAZJynsOaiVbiN2XD8PgME19Bud1TPprJUn0ElvGXRTU8zrx7OnIMDX8yNZuae
yCLl+lVOy3b/VWOydw8NdLQB7aGGAa9+i0nF1fNJC0VRK1gQGWo1XyK6Xed/eb3x
PWr4dlKaeUpJYn/lhOznbt95FzShHUg6Im2eoHH7mT+z0JFSi0QVVgL2wbk4Ki9C
7jy9OFdXQ857Ambq4ftP1D8iJjZmxJVP8f6gRmVxUbI38F14ThKAIZp+OYGgxIe3
VczRdDQlVZ1zJk2u4W8X/g/hG1Ty4dKL3Y0HiAyXhCJOBfMBSDw=
=4u0W
-----END PGP SIGNATURE-----

--ItZ2vptM4eZ6xUoUd2jOtqT7MuqSuqZM2--
