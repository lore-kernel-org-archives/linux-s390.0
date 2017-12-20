From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 21/22] KVM: s390: Add KVM HPAGE capability
Date: Wed, 20 Dec 2017 14:17:24 +0100
Message-ID: <9def7f57-5cab-8b7b-e213-83d5b07727a0@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-22-git-send-email-frankja@linux.vnet.ibm.com>
 <20171220140236.7043f9a7.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wNGP5cEVmVzVNWpkE6hm524wlPu1eTcin"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220140236.7043f9a7.cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNGP5cEVmVzVNWpkE6hm524wlPu1eTcin
Content-Type: multipart/mixed; boundary="9pQvNbnli1pbGxSyYXoB5H1wJ1hXT9enU";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com,
 david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
Message-ID: <9def7f57-5cab-8b7b-e213-83d5b07727a0@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 21/22] KVM: s390: Add KVM HPAGE capability
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-22-git-send-email-frankja@linux.vnet.ibm.com>
 <20171220140236.7043f9a7.cohuck@redhat.com>
In-Reply-To: <20171220140236.7043f9a7.cohuck@redhat.com>

--9pQvNbnli1pbGxSyYXoB5H1wJ1hXT9enU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.12.2017 14:02, Cornelia Huck wrote:
> On Wed, 13 Dec 2017 13:53:32 +0100
> Janosch Frank <frankja@linux.vnet.ibm.com> wrote:
>=20
>> KVM huge page backing support can not be easily tested under
>> s390. Currently testing is only possible after most of the guest has
>> already been set up.
>>
>> To indicate, that KVM has huge page backing support, we add the
>> KVM_CAP_S390_HPAGE capability. This does not mean, that transparent
>> huge pages are supported.
>=20
> Do you expect to use a different cap for non-1MB huge pages? If yes,
> this should probably be mentioned here.

Yes probably KVM_CAP_S390_HPAGE2, but this will not come in the near futu=
re.
However this commit message lacks the information, that we only support
1m pages, I'll add that.

1m guest backing pages ought to be enough for everybody (TM) and the
pain to support 2g pages is expected to be a magnitude bigger than the
one for this patchset.

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  Documentation/virtual/kvm/api.txt | 10 ++++++++++
>>  arch/s390/kvm/kvm-s390.c          |  1 +
>>  include/uapi/linux/kvm.h          |  1 +
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual=
/kvm/api.txt
>> index 57d3ee9..a56b0af 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -4369,3 +4369,13 @@ Parameters: none
>>  This capability indicates if the flic device will be able to get/set =
the
>>  AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute and =
allows
>>  to discover this without having to create a flic device.
>> +
>> +8.14 KVM_CAP_S390_HPAGE
>> +
>> +Architectures: s390
>> +This capability, if KVM_CHECK_EXTENSION indicates that it is
>> +available, means that KVM supports VMs that are memory backed through=

>> +hugetlbfs with 1 megabyte pages.
>> +
>> +While it is generally possible to create and start a VM without this
>> +support, the VM will not be functional.
>=20
> This sentence applies only to the hugepage case, doesn't it?

Yes, of course.
I'll do a: s/a/such a/

Expect a QEMU fencing patch next year.


--9pQvNbnli1pbGxSyYXoB5H1wJ1hXT9enU--

--wNGP5cEVmVzVNWpkE6hm524wlPu1eTcin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaOmLkAAoJEBcO/8Q8ZEV5cB4QAKUALUMXBucj8t0WtBNr9s03
2TzGqFyijolvc5kb5wAfleyPxWMdlWKpfkbuPLUVjSV9vIgpZRRfh0w2Fmxrlgl5
o5NMU4TNKcvF9y5+6lKpzzWvXtetx1QJwYyXq764PmdVycE/YHvBc9r7rnCPD1On
qpVDjC9JRTIg5KxIDdbjid48Vzk2DNsofAlHJLm/RmmDzls8XJDRc1MT2H3X1MgK
k7kRQF6gQreNiE68yM7eu8lgErEOXye4I4SVUSitfzIrGqubWTIwrLvx28QDfl8r
w4yI5cz/MLF1uE+FuJgvZKwQjnMCk2ZNdTPRAiKywww9zZykp0syh0uLo1gtprMk
SUMHcK/Nto6oe4+Joih1wktHWpLovzL0f646WuPSjuymlZbIqyswHI4XzCqWSJwb
DZdX/2Ox2P25yY9/rzJyY2ztw5Gcggany5LaMBeFe9IPSouEINgH2RPDTVpwkfM2
a7ugnne6RuW07qykPODhGKbCL8sXae6Um+FS7Ok+9JQqNrXE4DmFUYpUel4gIPE0
G7vv47yUoKc7tV2ijUCy9nPgzPtUagavKBwiqMP0AMhzSeVGSDUqM0rZlCI/5T7g
nwN0RijckuQP/JQxj8HRTgrKxvqF/NaDtBYceLEKiLaZrXIOAMps8xMzfobYr0c/
Wy76zqQcpQjsyvSd65W1
=pjpy
-----END PGP SIGNATURE-----

--wNGP5cEVmVzVNWpkE6hm524wlPu1eTcin--
