From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 21/22] KVM: s390: Add KVM HPAGE capability
Date: Wed, 15 Nov 2017 13:02:30 +0100
Message-ID: <87e884a5-1072-4bd4-8350-c751bbd62a53@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
 <ea2a81f6-10ff-7596-6df5-ad4a65765fe7@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EAlhHnFAdros0u6hOfIpKUjxanrLP4dLO"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ea2a81f6-10ff-7596-6df5-ad4a65765fe7@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EAlhHnFAdros0u6hOfIpKUjxanrLP4dLO
Content-Type: multipart/mixed; boundary="IPFa7JcO3rEqIUugElBFnDdJaM2Vv3UdJ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <87e884a5-1072-4bd4-8350-c751bbd62a53@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 21/22] KVM: s390: Add KVM HPAGE capability
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-22-git-send-email-frankja@linux.vnet.ibm.com>
 <ea2a81f6-10ff-7596-6df5-ad4a65765fe7@redhat.com>
In-Reply-To: <ea2a81f6-10ff-7596-6df5-ad4a65765fe7@redhat.com>

--IPFa7JcO3rEqIUugElBFnDdJaM2Vv3UdJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.11.2017 11:06, David Hildenbrand wrote:
> On 06.11.2017 23:29, Janosch Frank wrote:
>> KVM huge page backing support can not be easily tested under
>> s390. Currently testing is only possible after most of the guest has
>> already been set up.
>>
>> To indicate, that KVM has huge page backing support, we add the
>> KVM_CAP_S390_HPAGE capability. This does not mean, that transparent
>> huge pages are supported.
>=20
> Are there any plans to support it? (my feeling is that it could be
> somewhat tricky :) )

Better safe than sorry was the idea behind that.
By the way, this lacks the capability announcement in
kvm_vm_ioctl_check_extension() but I already fixed that for v2.

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  include/uapi/linux/kvm.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 8388875..2cd359a 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -930,6 +930,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_PPC_SMT_POSSIBLE 147
>>  #define KVM_CAP_HYPERV_SYNIC2 148
>>  #define KVM_CAP_HYPERV_VP_INDEX 149
>> +#define KVM_CAP_S390_HPAGE 150
>> =20
> What about facilities/features that require PGSTE to be around. Have we=

> fixed up all handlers? (I remember some features/instructions triggerin=
g
> special SIE exits in case they hit a large pmd in the gmap).
>=20
> Which of these facilities will we have to disable in user space? (e.g.
> we already handle CMM in QEMU if we detect explicit huge pages).
>=20
> (lack of public documentation makes this hard to review/understand)

Most facilities tolerate edat in a way, that changes are not necessary.
CMMA for example would still be interpreted but it would only accept the
stable/resident state. SKEYS have the RCP bypass. PFMF gets intercepted,
however, it doesn't use the GMAP, but the user mapping for clearing.
Also you already disabled a lot for VSIE, like pfmf interpretation.
Emulation in l2 for l3 and RRBE are still on the TODO list for complete
evaluation.

This is a valid concern for everyone involved and I scan as much
hardware documentation as possible. I have prepared unit tests for pfmf,
cmm, cmma and storage key operations in an effort to test as much as
possible in each level of SIE. Unfortunately I can't yet publish them,
but I will, as soon as I'm allowed.
I still wish for a way to disable skeys completely.


--IPFa7JcO3rEqIUugElBFnDdJaM2Vv3UdJ--

--EAlhHnFAdros0u6hOfIpKUjxanrLP4dLO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaDCzkAAoJEBcO/8Q8ZEV5OnYP/0y6PLPXaUJnqKinGDVogvTA
15j3hlLsScMm591syEx40oY1V1qmghgYwRsnqbdHHG9QGa6AD+lnpEP5cqU5yKF1
xDYxo/NgEzKvrIBQEi5GLJ5+HCOh0rctaFhKhvOr4+TjW2A4qP0uyFbz0gPHSZOh
b6Msf2O0lJN2Ye2UXQ7P5pf/ysL5H6xy9nyeDkaixhkyt+Mj4alL9sQbvAwoPsOt
bPjPshmPCniEvddCotjW7NM+1LITGiPn3lzFz0rUQ85GHMdpNuFkA+JCJqglQUwM
gta1BTmqQLhbjIrQgybt3JUUBcnv7jsSbywNuCclsSuz92AmvwTaWvO+S26yRh0s
cx0xDj5zj9C9po0dmRo2o79akUJALtl/u2fGDZXJWADHE452+HNjiQ6lDqKHN03e
4imSboHNRUa4CBk8uB/4Po076KOKOF77x9pRWvD/tNzu6dW1gwa4kMyuKgr42KOu
NM6RNIbLj4KT+m47z9qbKZvDmyfi5qYEbQAF20/gJtJFYjAGA+lVwXPyua0WgsFs
eOIqn4GIjT5hukpWl0E4LsT5N2RQJ/qb4qHeQQZR3o9fIKR1Q3fJdJbzvcVn8FXp
qJNrjkFWwxWhDYzcJlAJZMqeFijW3FI8GjxiA8prtBT/RfVF/F74tpyFH507M7Ma
dlRaxJG+4cZ5eqHREUR3
=Kwku
-----END PGP SIGNATURE-----

--EAlhHnFAdros0u6hOfIpKUjxanrLP4dLO--
