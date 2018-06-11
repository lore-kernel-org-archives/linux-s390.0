From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
Date: Mon, 11 Jun 2018 13:49:31 +0200
Message-ID: <dd81f313-a8c2-bf2a-da4c-4669db170401@linux.ibm.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
 <d6455b0b-804f-b58e-41bc-83731979911a@linux.ibm.com>
 <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
 <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
 <010679ed-bd80-42f8-3f6f-e4dee10e82f5@linux.ibm.com>
 <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo
Content-Type: multipart/mixed; boundary="0bQrGcgO62KKUu7NthEmnKLGUSMRsJ8rm";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com,
 Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
 bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
 alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
 jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
 berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
 Janosch Frank <frankja@linux.vnet.ibm.com>
Message-ID: <dd81f313-a8c2-bf2a-da4c-4669db170401@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
 <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
 <9e30c9b0-a04c-0c4e-9d3d-37e7a53a7f72@linux.ibm.com>
 <d6455b0b-804f-b58e-41bc-83731979911a@linux.ibm.com>
 <f74f2d2d-36d3-7910-5511-3691a483b89f@linux.vnet.ibm.com>
 <ea5c2c2f-27fe-b2bf-2aa8-fbe80e77ce81@linux.ibm.com>
 <5f9c3f97-34e2-bf68-b8ca-ac9288ea5efa@linux.vnet.ibm.com>
 <b7215f0e-6ceb-2738-4584-1af7c30bd595@linux.ibm.com>
 <f1cc0d71-d2ff-6461-c450-07cc73a2973c@linux.ibm.com>
 <010679ed-bd80-42f8-3f6f-e4dee10e82f5@linux.ibm.com>
 <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>
In-Reply-To: <a5a72aad-303b-8bc9-f48b-e44aba2af27e@linux.ibm.com>

--0bQrGcgO62KKUu7NthEmnKLGUSMRsJ8rm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.06.2018 13:32, Halil Pasic wrote:
>=20
>=20
> On 06/11/2018 11:23 AM, Pierre Morel wrote:
>> On 08/06/2018 23:59, Tony Krowiak wrote:
>>> On 06/07/2018 01:15 PM, Pierre Morel wrote:
>>>>
>>
>> ...snip...
>>
>>>>>>
>>>>>>>
>>>>>>> Why maintain a list of kvm_ap_matrix structures if we don't have =
to; it is stored
>>>>>>> with the mediated matrix device which is passed in to all of the =
vfio_ap driver
>>>>>>> callbacks.
>>>>>>
>>>>>> Because using the vm_list which is a static in kvm makes you stick=
 inside the kvm code.
>>>
>>> I understand your point here, but even if we did maintain a list of k=
vm_ap_matrix structures,
>>> we still need the kvm code to configure the guest's CRYCB and eventua=
lly ECA.28. There is
>>> also code in kvm-ap.c that is called from KVM.
>>
>> The only code from kvm-ap which is called from KVM is temporary code
>> waiting for Harald to offer the clean interface to AP instructions.
>>
>>> The idea behind kvm-ap.c is that all code
>>> related to configuration of AP structures in KVM is in this one spot.=

>>
>> This I understand, but the code can be in one spot inside VFIO_AP inst=
ead
>> of inside KVM.
>> Putting the code inside KVM induce dependencies between KVM and AP
>> while the kvm/vfio interface allows to avoid this dependency.
>>
>> The purpose of VFIO_AP is to handle the CRYCB, all get/clear/set crycb=
 masks
>> functions should be in VFIO AP.
>>
>> If we use wrappers in KVM, since the CRYCB is an a SIE extension,
>> it is legitimate, the KVM interface to the CRYCB should only
>> handle bitmaps and be unaware of the vfio_ap internal structures.

Yes, please!

>>
>> Another concern, the kvm_ap_validate_queue_sharing() should not be
>> inside KVM because it is a decision of current VFIO_AP driver
>> to not share the queues between guest of level 2.
>>
>> The Z architecture does not allow to share AP queues between
>> guests of level 1 but we could re-engineer the AP bus and the '
>> VFIO AP to offer queue sharing for guest level 2.
>>
>> This would be a new VFIO_AP driver (and an AP bus extension).
>> We should not have to change KVM for this.
>>
>=20
>=20
> Pierre's proposal makes a lot of sense to me. We would not need to take=

> the kvm_lock (which we need to traverse the vm_list safely) for the
> validation, and we could have immediate validation (which is in my opin=
ion
> better).

Please do not use the kvm_lock if possible.

>=20
> Also your refcount (which is not a refcout) could go away. You simply
> traverse your list and check for duplicates when hooking up the mdev
> with KVM.
>=20
> And my opinion is if we don't have to add code to the kvm module we
> better not.
>=20
> @Janosch: Does core KVM share my opinion?

At least I do.

KVM does not care about who has which crypto queue/card.
I'd like to have a driver that does internal bookkeeping and then
registers the crycb with KVM, so the VM can use it.

>=20
> Regards,
> Halil
>=20



--0bQrGcgO62KKUu7NthEmnKLGUSMRsJ8rm--

--p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbHmHYAAoJEBcO/8Q8ZEV5AS4QAIwpHJh6L9SUp6BQhM5Sz1iN
uA8Gz3HJ8mg7zr7EJg3ExIejQlgCG9kjVwDDZcGOIyEltPD7CuCznrXZh24gq+bv
w/uqo5XAeuUCFWSffPRHJLqRu7pUxcPYT1a7z2h6PqC6RV7L1ndiXtMZx5enYC5D
Kath9KuFaPGZ6xHP73ms9i4BU7STsFbKxZXBFlDosUBk+e2nSdCh/zV1sTlv8B16
TgrvSqpkhIkLOf8+63tvZDnejg/iIlTmQQf4kA8hDQIXY1v9gyyanabsz5qlP3r/
o13fAxd1a/qfUkWN0H+skPv37ngWcALvm/1lsY9XCvkmioe49BSt3jeMe1LG+oT8
Dm1GaPrQ3gTtl7K2tUj7l9+OFihCBJFnhtDDERVXlDD6Hp9qnF2PrjyVYvmBHyPh
xBTyQ5V91PZc++8OqZb/nOyifxteso8qgwiOK3NJKVmj7wZFXPSpX8uxDYP16x+H
m0BCPPswiAed3DQjk7+n2ga7mHEb4zoCSAYUzwqQhFkdqKwzYMW5aYO4xhQW0wi7
C2oL9Ke7FgXaNIY1Hs9nEFB5M5hFpKqwtWAYk4f25gvorfG+rGAhwKBPQQSShCRr
77M9T3+ycLpGEOQh7wTZGeG2SmmzYgnC8gTnJ5tz57jWbHplxt8BGlLg35aJ1Tmk
/R8ew/jcll6tDwF2yA2/
=UnoK
-----END PGP SIGNATURE-----

--p5WSB1KGON5tNXD1JZuJXkKMiYD44HYdo--
