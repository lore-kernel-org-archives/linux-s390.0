From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 20 Sep 2018 13:16:39 +0000
Subject: Re: [RFC 02/14] s390/mm: Improve locking for huge page backings
Message-Id: <94711c75-e396-19a0-d845-aee9f5df3986@linux.ibm.com>
In-Reply-To: <95013eae-e9c5-83a4-a15e-ca731887b19b@redhat.com>
References: <95013eae-e9c5-83a4-a15e-ca731887b19b@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--7rZKFL989Fa6jYEKlXYXACekVkNIQ3ufJ"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7rZKFL989Fa6jYEKlXYXACekVkNIQ3ufJ
Content-Type: multipart/mixed; boundary="8IXOYLIB6Pnz0HJiqvpTecCXUDgzyRuQ5";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com
Message-ID: <94711c75-e396-19a0-d845-aee9f5df3986@linux.ibm.com>
Subject: Re: [RFC 02/14] s390/mm: Improve locking for huge page backings
References: <20180919084802.183381-1-frankja@linux.ibm.com>
 <20180919084802.183381-3-frankja@linux.ibm.com>
 <95013eae-e9c5-83a4-a15e-ca731887b19b@redhat.com>
In-Reply-To: <95013eae-e9c5-83a4-a15e-ca731887b19b@redhat.com>

--8IXOYLIB6Pnz0HJiqvpTecCXUDgzyRuQ5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/20/18 1:14 PM, David Hildenbrand wrote:
> On 19/09/2018 10:47, Janosch Frank wrote:
>> The gmap guest_table_lock is used to protect changes to the guest's
>> DAT tables from region 1 to segments. Therefore it also protects the
>> host to guest radix tree where each new segment mapping by gmap_link()=

>> is tracked. Changes to ptes are synchronized through the pte lock,
>> which is easyly retrievable, because the gmap shares the page tables
>> with userspace.
>>
>> With huge pages the story changes. PMD tables are not shared and we're=

>> left with the pmd lock on userspace side and the guest_table_lock on
>> the gmap side. Having two locks for an object is a guarantee for
>> locking problems.
>>
>> Therefore the guest_table_lock will only be used for population of the=

>> gmap tables and hence protecting the host_to_guest tree. While the pmd=

>> lock will be used for all changes to the pmd from both userspace and
>> the gmap.
>>
>> This means we need to retrieve the vmaddr to retrieve a gmap pmd,
>> which takes a bit longer than before. But we can now operate on
>> multiple pmds which are in disjoint segment tables instead of having a=

>> global lock.
>>
>=20
> Has the time come to document how locking works? (especially also for
> gmap shadows)

I'll add more locking instructions into the function comments for v1.

Also I'll write something longer up after KVM forum and the inclusion of
this patch set. Maybe I'll also add a simple GMAP documentation, after
all I have ~30 pages of KVM mm documentation flying around.


--8IXOYLIB6Pnz0HJiqvpTecCXUDgzyRuQ5--

--7rZKFL989Fa6jYEKlXYXACekVkNIQ3ufJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbo523AAoJEONU5rjiOLn4qigP/0t6H45U1N04wiuGT5a9E8i6
ZMFVqcc4Hi9i9aZ7JV7t8vc3eUVGjJq3lJrgH66cX1v7//331Y1MmnWW3wDYxfxn
/N9D1IMq9QsDW/ZL2CArFfB9H4TgJUmquSNa/8P5FB1I5um8AxOkVPIeyfM3vgLJ
N3ltY+7KEhfi0Rr2LjyXdxEi6S1rJZqKkhTZm6igAObp65rG91/VhEQDPwf72idh
4AXjBBCtQcWSclwFZrh6DSczG3xJtF67lKpNWXgcNmj9vnJNNtol3t9jy5ptz9lB
OP3lZNopAH8QSZpMt47X9NYvvb7yEhWhbRLLxbphyLsULPRXbpjoQuJLtsI5YNCJ
5FAIgbg10S72jrCZOvB6DF6KnRrnEEutq/zkCi9Z0UO5ol2eRKqGYIUInRNEaNIm
2ir3nJo9y3u0zdXGfT4/5iB+0Hn8AEfnGyA2Ppu7B9Q6Sonrws1wpqyZO7v/eWEJ
UX/c28ag/OX6qSU2AL08NpuHOo5QToVailq6drvyaFqmd9pufLnRFWsYEzLDrNmq
vtq9LtQAJ15TPxVuuvv9mLVs42L+eMJ5NNelSuxm07EoktOzLTCZvlJ6wVJ7VZ0C
kw2DmanJpiCe8dUnZAQ9PIfHi2DY0+7m0pf1ciEujsAATbqEQrt9BKoG9cw6Z0fN
Eceip0HE5R/GorhVDhln
=n81G
-----END PGP SIGNATURE-----

--7rZKFL989Fa6jYEKlXYXACekVkNIQ3ufJ--
