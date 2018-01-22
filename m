From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Mon, 22 Jan 2018 15:04:56 +0100
Message-ID: <df625a5f-e00b-d55a-5bf2-bcd555eb77b0@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
 <c154cb64-59be-34fe-44e0-7ee19c6b5440@linux.vnet.ibm.com>
 <d0f856de-8e82-1afa-f62d-fbb33b715db7@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zYqKMyGuf3U7KHBwgIanwQM0u0yNpQ0cw"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <d0f856de-8e82-1afa-f62d-fbb33b715db7@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zYqKMyGuf3U7KHBwgIanwQM0u0yNpQ0cw
Content-Type: multipart/mixed; boundary="m3zn9fQuQCpHfNbN6IAOQ8WhSRIkxNfsT";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <df625a5f-e00b-d55a-5bf2-bcd555eb77b0@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
 <c154cb64-59be-34fe-44e0-7ee19c6b5440@linux.vnet.ibm.com>
 <d0f856de-8e82-1afa-f62d-fbb33b715db7@redhat.com>
In-Reply-To: <d0f856de-8e82-1afa-f62d-fbb33b715db7@redhat.com>

--m3zn9fQuQCpHfNbN6IAOQ8WhSRIkxNfsT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.2018 14:29, David Hildenbrand wrote:
> On 22.01.2018 14:13, Janosch Frank wrote:
>> On 22.01.2018 12:46, David Hildenbrand wrote:
>>> On 13.12.2017 13:53, Janosch Frank wrote:
>>>> For later migration of huge pages we want to write-protect guest
>>>> PMDs. While doing this, we have to make absolutely sure, that the
>>>> guest's lowcore is always accessible when the VCPU is running. With
>>>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with=

>>>> the invalidation notification bit and kicking the guest out of the S=
IE
>>>> via a notifier function if we need to invalidate such a page.
>>>>
>>>> With PMDs we do not have PGSTEs or some other bits we could use in t=
he
>>>> host PMD. Instead we pick one of the free bits in the gmap PMD. Ever=
y
>>>> time a host pmd will be invalidated, we will check if the respective=

>>>> gmap PMD has the bit set and in that case fire up the notifier.
>>>>
>>>> In the first step we only support setting the invalidation bit, but =
we
>>>> do not support restricting access of guest pmds. It will follow
>>>> shortly.
>>>
>>> I am wondering if we could avoid having invalidation bits on PMDs
>>> completely by always splitting up a PMD huge page into PTEs.
>>>
>>> I assume this would make the code easier - as we need split up of PMD=
s
>>> either way when protecting for the shadow gmap.
>>>
>>> This would imply that also our notification handler only has to be
>>> called for 4k pages, which also makes that part easier.
>>
>> Except for 1MB shadowed segments which still need an invalidation hand=
ler.
>=20
> But that doesn't go via gmap_protect_range() / gmap_call_notifier() if =
I
> am not mistaking.

Yes, my point was that we'd still need pmdp_notify.


--m3zn9fQuQCpHfNbN6IAOQ8WhSRIkxNfsT--

--zYqKMyGuf3U7KHBwgIanwQM0u0yNpQ0cw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaZe+IAAoJEBcO/8Q8ZEV5BUMQAKRr68C+9mKeOxWMW8n7Aw8c
G1o/xESaynnfu76FjyYvNlep3cQgfXfQnhOmsykKBwB6d0jBPHI7FdYjRfHAKOBP
ydWvMi/+JuppPW0Fcc0QMiFk8a1sB7fjmx6cAfROZUuAeiHZqcBFXWBvB7tTt7IW
K0jpvj4zXjq6j5DJscJTAEM+oA/nW5CCBDNtrJNHpNNV2lhveT62zFyIuxaU6Prr
YujfObEEiubJLOKKKcpqG4ybdV10d5Qe8lnobudgjrcydUgwGzDakmfc/f43mtRK
eyFqjaiZ8v+oZ06REuHT6qnzZHWFIX3lFvbcWpPpYZhyrxwmHs9Xr6nx97hJyva6
mg1dBnpboUU7jsZLZ3ZWp5+G1DYS4gJ1NRjrGQb1AX/hGnFcOSWk+nPnSV2t7iVK
3/nCnJ3UKRDbnjy8PgkN44KpEbcK5YlBQdH0kMeJNGCxMRAUlezZH97Xv2BYlAHe
Iiy5GEsnDxJ6NVEcMqdN1yNqETd5WS3GFR1HiznmrdBY1qVm1dzpJtWH9DZoM1Ye
0TlWDSgIfGyYYnHiZEm+j6aFOOeaTchJIY6bC0QOUPvtGrWU899i7iVvCm0RM5BO
NQ9biowPXUBHCqE2eEtboM5D08GNpZdRhVUrA/Q0Id/5N/JC20sAx5F+XRnHlJUg
dS0eUW52o4XIY88i2fpY
=I62F
-----END PGP SIGNATURE-----

--zYqKMyGuf3U7KHBwgIanwQM0u0yNpQ0cw--
