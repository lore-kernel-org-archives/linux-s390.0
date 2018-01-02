From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
Date: Tue, 2 Jan 2018 01:02:58 +0100
Message-ID: <8cd50875-ad53-1cd1-f8f4-8f13da087969@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <862443e7-f7c3-ea24-9093-43cb8529175c@de.ibm.com>
 <2ae18dbd-1be3-d575-5bc4-cc0d3675d77c@redhat.com>
 <56a7166e-fc58-4796-dc38-46fdeccb70cc@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jY2aV4Nx4Rw7YwJ9pSU5BoyXJuQFtytgf"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <56a7166e-fc58-4796-dc38-46fdeccb70cc@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jY2aV4Nx4Rw7YwJ9pSU5BoyXJuQFtytgf
Content-Type: multipart/mixed; boundary="UsKSssyA9tQaCtB1IAZ9i3OHyEaYix82W";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <8cd50875-ad53-1cd1-f8f4-8f13da087969@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <862443e7-f7c3-ea24-9093-43cb8529175c@de.ibm.com>
 <2ae18dbd-1be3-d575-5bc4-cc0d3675d77c@redhat.com>
 <56a7166e-fc58-4796-dc38-46fdeccb70cc@de.ibm.com>
In-Reply-To: <56a7166e-fc58-4796-dc38-46fdeccb70cc@de.ibm.com>

--UsKSssyA9tQaCtB1IAZ9i3OHyEaYix82W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.2017 10:08, Christian Borntraeger wrote:
>=20
>=20
> On 12/21/2017 01:00 PM, David Hildenbrand wrote:
>> On 20.12.2017 13:23, Christian Borntraeger wrote:
>>> FWIW, this patch set has survived some testing on my side (with stora=
ge
>>> keys, with VSIE, with both), so I would say that after a respin with =
some=20
>>> patch sqashing we give it some more days for the last reviews and the=
n apply
>>> the whole thing via a topic branch via Martins s390 tree. I will merg=
e
>>> this branch as well to solve the potential conflicts with=20
>>> Davids patch ( s390x/mm: cleanup gmap_pte_op_walk() ) which is still
>>> pending in my tree
>>>
>>
>> "postcopy works every second try, seems to be QEMU or my setup".
>> Shouldn't we first understand why? gmap is a very sensible topic and w=
e
>> should rather spend more time understanding everything. We don't want
>> guest escalation bugs.
>=20
>=20
> I somehow missed that in the cover letter. Yes we should make sure that=
 this works (
> on the other hand I usually blame postcopy because userfault makes seve=
ral assumptions
> which are somewhat "brave". See the empty zero page issue, which could =
in theory also break
> if a postcopy guest does some clever ballooning in and out). But anyway=
 I will have a look
> after christmas into postcopy.
>=20
> FWIW; Martin and I looked over the patches and they seem good enough (a=
fter we fixed postcopy).
> I also did some testing on that and it seems to work fine so far (inclu=
ding classic migration).
>=20

Postcopy returns with this on the source and results in a paused VM
which can be resumed without any problem:
qemu-system-s390x: RP: Received invalid message 0x0000 length 0x0000

This doesn't tell me anything, but Peter Xu seems to have a Qemu series
wich improves postcopy error handling. I'll try it later today.

A second postcopy migration with the resumed VM succeeds. The VM and its
VSIE guests survive a memtester run and don't log any errors. The
destination does not log any errors...

All in all I'm not really concerned about postcopy although it certainly
needs fixing and I'll have a closer look this week.

@David: The complicated parts are the new VSIE modes and the splitting.
If you could have a look at that I'd really appreciate it.


--UsKSssyA9tQaCtB1IAZ9i3OHyEaYix82W--

--jY2aV4Nx4Rw7YwJ9pSU5BoyXJuQFtytgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaSsw6AAoJEBcO/8Q8ZEV5aD0P/25C2WUBh5QF2h+7UO6hB/X/
BK/jgg56W1WF+Nq/uCmfhf+0hesRGcOPKjHGZ47UL/HwBRLE7uOclu68U3n7NqUD
bwat2muOXmbYt+ItjHK6bhw7N/Gqav/2VGmvMrT7bQyPSTIl71wm2nC5LkV11gCM
rW5fw2SDfp1ZeJ/UnyNwjVqd5zMpshDNdkaZuFMK+NeQvfgkIyNiSFZkbkNIjvDW
kTTCIy3tJfynNgKaFP+CPPsZ49kpGeJAFO4TqcDQbvzjI1l+53C5boqgDY/lrwmO
oAxRCb4APUftRePGc8CmkzkuZONd5+ZcrJ7/le1FUEb0IVYqjSkUi8daSzbWz8Gb
QbwWOimNV/3bzONvH1iXohJOAm7rXqF6lflY6pJKiMej3LlGFaLvrc08xL0YQM/X
QdOp6TPKnkiilah5to4J6fo5FYsXFb1HvbNMygM1iqtoIFnH4nqEgqSK/iYtDtAO
PCHc74T3Ymv9sUxLibSk74OZkZtOnpy6xuhFefjz34WU89EEerncSg22SOozrURO
+bk7sFT5HY4Uo1sMd4jQn9qbsk5CmCAkfx+mc7MF/XjXeVVM5o8MydUGvo/evxSH
MghQd0Unn67vRA0czZmur6aggyvoRBAN5z/RWz0xVNvhFKizgMP31j0yV2/OnkWg
vTwtVmFy5+sVbY6cU8ob
=dcG5
-----END PGP SIGNATURE-----

--jY2aV4Nx4Rw7YwJ9pSU5BoyXJuQFtytgf--
