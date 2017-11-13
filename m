From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] s390x/mm: cleanup gmap_pte_op_walk()
Date: Mon, 13 Nov 2017 16:19:00 +0100
Message-ID: <ba803651-3177-ef92-9378-001f4bdf0489@linux.vnet.ibm.com>
References: <20171110151805.7541-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bO2KpX1dpq1KEcMTVIalmwSwaNrDkNqqR"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171110151805.7541-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bO2KpX1dpq1KEcMTVIalmwSwaNrDkNqqR
Content-Type: multipart/mixed; boundary="voti0NfbDCBiV4LkqEWrrH1k3q9Vpnegw";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <ba803651-3177-ef92-9378-001f4bdf0489@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] s390x/mm: cleanup gmap_pte_op_walk()
References: <20171110151805.7541-1-david@redhat.com>
In-Reply-To: <20171110151805.7541-1-david@redhat.com>

--voti0NfbDCBiV4LkqEWrrH1k3q9Vpnegw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This is KVM, not qemu, subject s/x//


On 10.11.2017 16:18, David Hildenbrand wrote:
> gmap_mprotect_notify() refuses shadow gmaps. Turns out that
> a) gmap_protect_range()
> b) gmap_read_table()
> c) gmap_pte_op_walk()
>=20
> Are never called for gmap shadows. And never should be. This dates back=

> to gmap shadow prototypes where we allowed to call mprotect_notify() on=

> the gmap shadow (to get notified about the prefix pages getting removed=
).
> This is avoided by always getting notified about any change on the gmap=

> shadow.
>=20
> The only real function for walking page tables on shadow gmaps is
> gmap_table_walk().
>=20
> So, essentially, these functions should never get called and
> gmap_pte_op_walk() can be cleaned up. Add some checks to callers of
> gmap_pte_op_walk().

This already made sense when discussing, but I traced the callers anyhow
to make sure we didn't accidentally forget one.

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com> with one nit belo=
w

> @@ -889,7 +879,6 @@ static void gmap_pte_op_end(spinlock_t *ptl)
>   *
>   * Called with sg->mm->mmap_sem in read.
>   *
> - * Note: Can also be called for shadow gmaps.

How about also getting rid of the line above this one?


--voti0NfbDCBiV4LkqEWrrH1k3q9Vpnegw--

--bO2KpX1dpq1KEcMTVIalmwSwaNrDkNqqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaCbf9AAoJEBcO/8Q8ZEV5mMMP/RYbe+awD9NAzS1RrRVpxWZJ
lZcvQMLDqAgJ2nd4GTZROZR+S8cVohsEnpnqEoKPiy9nKMeCes+itqGuq9FH0LwR
g7BpGFuDdB4oDVLAcNJUdTvyv8QNGNNmeLgBeSuSKxLiYgmcDzOpB1/NioY6NV5u
MjmfiAH+jxJM1n3Dzo3lItBCLNWYyIq4OSqNN/gRQ+f2EsDp8kEKmgH+uwwZqCvk
XfdG1Z8Vz9h7d0mpbX3HotFLID2hx6a6yZS82/jDZXh2wsDO1XED0vcN/qp+UtQF
Jmn+4kVp8+E2tIMN49cJg4+1WUlngyNic4Tv2h6wZ5CwfUqYcm635nmi8kFq9EEx
+48beWKqc9FP10khRT8kdcszbL6f5NGWLsBFh0wR7ruWYaryWH1ck0Ks1mxludB4
J0ItY6+HHRFFDRXGXqiQEwmanCoFZMzTkHesLuWlccnty+9D3Yr1FZLLIY28pbYb
CM2PZ/GKk1+pwZGyiefcjfsCYDVsDv833u7NSV/erfTgnWDMcEBbYpjM73GMrVzn
czId2VKdUeHOG5WngO8XXfbUgK5YBRcFwNu+9OR8f2ySfKFDtVKYpK8bcDigdvDd
EycjYLGCLcZJQwchLV1k6zLWAXYwDOlrywMMCXvoPjv6vk+caOpcQpUTACrXriJV
Ceh5Lve4JzvA4gZifImk
=HBkP
-----END PGP SIGNATURE-----

--bO2KpX1dpq1KEcMTVIalmwSwaNrDkNqqR--
