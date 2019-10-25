Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407022AbfJYIpc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 04:45:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P8jGao139848
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:45:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vuw8jh54r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:45:29 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 25 Oct 2019 09:43:01 +0100
Subject: Re: [RFC 06/37] s390: UV: Add import and export to UV library
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-7-frankja@linux.ibm.com>
 <32166470-43c1-f454-440f-3f660b995ca2@redhat.com>
 <ed8860e6-176a-64dd-e697-5ed80dd3c872@linux.ibm.com>
 <257d9326-9af9-5986-aeb0-4323fb66c81d@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 25 Oct 2019 10:42:56 +0200
MIME-Version: 1.0
In-Reply-To: <257d9326-9af9-5986-aeb0-4323fb66c81d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6skXUzixN5Qi5HVOxqnOjlrIZKm4JQKu2"
Message-Id: <5de9ace7-a635-d758-276e-942c5f95e18f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6skXUzixN5Qi5HVOxqnOjlrIZKm4JQKu2
Content-Type: multipart/mixed; boundary="Gd0evvNHPAA9G1tLqEauLZv7MBzQ0gNzM"

--Gd0evvNHPAA9G1tLqEauLZv7MBzQ0gNzM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/25/19 10:40 AM, David Hildenbrand wrote:
> On 25.10.19 10:39, Janosch Frank wrote:
>> On 10/25/19 10:31 AM, David Hildenbrand wrote:
>>> On 24.10.19 13:40, Janosch Frank wrote:
>>>> The convert to/from secure (or also "import/export") ultravisor call=
s
>>>> are need for page management, i.e. paging, of secure execution VM.
>>>>
>>>> Export encrypts a secure guest's page and makes it accessible to the=

>>>> guest for paging.
>>>
>>> How does paging play along with pinning the pages (from
>>> uv_convert_to_secure() -> kvm_s390_pv_pin_page()) in a follow up patc=
h?
>>> Can you paint me the bigger picture?
>>
>> That's a stale comment I should have removed before sending...
>> The current patches do not support paging.
>=20
> Note that once you pin you really have to disable the balloon in the=20
> QEMU (inhibit it).
>=20

Yes, and you need the iommu for virtio.
We didn't yet fully discuss how to handle that.



--Gd0evvNHPAA9G1tLqEauLZv7MBzQ0gNzM--

--6skXUzixN5Qi5HVOxqnOjlrIZKm4JQKu2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2ytZAACgkQ41TmuOI4
ufh+WQ//U7uCWIaS1WtgrMqyVdi7syehMxI74UXuA2nC+zMvNw21ZPV7bsE6E/e7
5Iu2t5joiKbFKC/+eAXYp8IVgKm/miDIKv5HGLVrYhh3yCtAj0A0QtTn3plCF3n/
AUx/oJj7pC6kQymm8hc2HC3a4IEK3+hP70rQDK6tUNJwgZAkjTC2AZyZA3p+9Cdo
wcXxlZM635fgB/AhkU/xP9dGC27GNpwKpK/fSjWVi6SdWlZoYZZLmuTCSRv4Tz8d
uin5NnB4gnk0lbdAMrEeRyhf94ZvqDnIKQJW9WOfx+jfmEZSHOW6rEUn3aghXBJY
32yjzzz0dhJttJKVS+jbmyPZ3Eg+yUhVGAl0tT+Ih87vZ2VslagNL5NDwOw/PdwJ
YJTfVV3VkYXUNrzGAVUx5OKv570UHvF6PEcLiuqAzCJWUFG13mt7tPmZCdwHfTRH
xQQlAGGlhF19xkJ34jJqbVucyvEzaQInqe46mXKBh2q+BbhpWMRNAM1X6hC2OlSj
itk8+ZU7xYAuqoe8P6lPM+d6MVA/wRnJH4sFTLI4AgqUi7fNoIwJCPu7iPGUVIjD
8+aAbGcYmQDHCT3eOVbkCO66gcpGXE619PrmekBT1VXf3babVKiubi2eVuiCM8Tk
54WZyTEO2vl6jLSEv5cn4ICWmdqjXcbMvlnymCANw0cTsSS1uEg=
=2v4M
-----END PGP SIGNATURE-----

--6skXUzixN5Qi5HVOxqnOjlrIZKm4JQKu2--
