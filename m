From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: s390: force bp isolation for VSIE
Date: Wed, 14 Feb 2018 12:44:18 +0100
Message-ID: <5ec41177-f405-0346-9489-9fd776552ba3@linux.vnet.ibm.com>
References: <20180214083422.44175-1-borntraeger@de.ibm.com>
 <16458103-a499-ce6d-4160-682cd9e8f926@redhat.com>
 <d452d4fe-f603-79f4-b83e-24badafb41a6@de.ibm.com>
 <2fee7e07-d85f-191a-40c1-42a13704efee@redhat.com>
 <c443d2c9-ddee-57bf-e192-4b586500e286@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OHKVh30Iuaf2aUJLpzRp8h9fjpaxUbUld"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c443d2c9-ddee-57bf-e192-4b586500e286@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OHKVh30Iuaf2aUJLpzRp8h9fjpaxUbUld
Content-Type: multipart/mixed; boundary="jPrnBSSFoPrwGnjmAn083fAgfhJhW9NkD";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>
Message-ID: <5ec41177-f405-0346-9489-9fd776552ba3@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: s390: force bp isolation for VSIE
References: <20180214083422.44175-1-borntraeger@de.ibm.com>
 <16458103-a499-ce6d-4160-682cd9e8f926@redhat.com>
 <d452d4fe-f603-79f4-b83e-24badafb41a6@de.ibm.com>
 <2fee7e07-d85f-191a-40c1-42a13704efee@redhat.com>
 <c443d2c9-ddee-57bf-e192-4b586500e286@de.ibm.com>
In-Reply-To: <c443d2c9-ddee-57bf-e192-4b586500e286@de.ibm.com>

--jPrnBSSFoPrwGnjmAn083fAgfhJhW9NkD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.02.2018 12:05, Christian Borntraeger wrote:
>=20
>=20
> On 02/14/2018 11:37 AM, David Hildenbrand wrote:
>> On 14.02.2018 11:14, Christian Borntraeger wrote:
>>>
>>>
>>> On 02/14/2018 11:06 AM, David Hildenbrand wrote:
>>>> On 14.02.2018 09:34, Christian Borntraeger wrote:
>>>>> If the guest runs with bp isolation when doing a SIE instruction,
>>>>> we must also run the nested guest with bp isolation when emulating
>>>>> that SIE instruction.

This is done by activating BPBC in the lpar, which acts as an override
for lower level guests.

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

Maybe also add a short comment, that the fpf bit is a logical or in
shadow_scb?


--jPrnBSSFoPrwGnjmAn083fAgfhJhW9NkD--

--OHKVh30Iuaf2aUJLpzRp8h9fjpaxUbUld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahCETAAoJEBcO/8Q8ZEV57SgQALdRm4K2jtCA97BifWzsxs6Q
zfzzu/SDpiyxdtyssTOzcuhBPLjhTWY7Tu5HFqMGcSF40XY8+Cg+epZVS/LRrWT6
L6zq/yxU2JrFIIhSK94Kn1jiHYtq+PidPwQ4n36GXloSEJkXsQdRyMnhX1qfQrYP
VLWhYqTtmg3G284zKbTsBmcCBArQF9qvSshZtjlq8p37X6URklvkhZLEU6GXnFN4
OziNH/4WfDkl31HPWfW48jtzp5Z/C07xWUSTnHmMgRVXRY+iR5nqn3JvWwnsGey9
u8nyICf42aAhfzyrAc3pAXYLZWaud1kFKVWSSDWMB2RIurFYzZ8qsFcbFtkOBK/v
+JCwUIjmwS1Gl/M/H9tZpesj0oadiQR/uwfY3VBCQdPYqxJw1cEtRzF4tMUBxbp9
7+BPz3wBkJXzpx6w8ftqiAbnVz85qlM6uRrx7gNh9lEUsrIDyALQZpfX8rdGwuxm
DcBL5p+ifD7ejrGPXmHBYiF9wSfjspT2pAXmqG/Yw7V+voxa8s2+Vzb+Z9idR8RP
3EuFzkbxWP929GO38uCxlbJZOVm62pkgRn56Nm09k+De9tkVLSRfL2Zgqdo+BaP9
TB1lygLUKN1loPBBpYzkjSEOaQ9zsfqmjMqjmlCYd+HXLFL2wS6zcfjvWwiBNIPH
Tne1ReAeSN03eQC19LYD
=qdWi
-----END PGP SIGNATURE-----

--OHKVh30Iuaf2aUJLpzRp8h9fjpaxUbUld--
