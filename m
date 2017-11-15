From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 22/22] RFC: s390/mm: Add gmap lock classes
Date: Wed, 15 Nov 2017 13:16:55 +0100
Message-ID: <892509a1-bdda-13f3-af64-c73f5c2b4fc0@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-23-git-send-email-frankja@linux.vnet.ibm.com>
 <91442796-11c7-6c41-fe52-1e33bc5107dc@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jFtL8uPqAuGnsk5POae2LX0LnnL8tLfXG"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <91442796-11c7-6c41-fe52-1e33bc5107dc@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jFtL8uPqAuGnsk5POae2LX0LnnL8tLfXG
Content-Type: multipart/mixed; boundary="qlsw6FdF65R6nhAWkaP5dEHaWqwHKcJ72";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <892509a1-bdda-13f3-af64-c73f5c2b4fc0@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 22/22] RFC: s390/mm: Add gmap lock classes
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-23-git-send-email-frankja@linux.vnet.ibm.com>
 <91442796-11c7-6c41-fe52-1e33bc5107dc@redhat.com>
In-Reply-To: <91442796-11c7-6c41-fe52-1e33bc5107dc@redhat.com>

--qlsw6FdF65R6nhAWkaP5dEHaWqwHKcJ72
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.11.2017 11:10, David Hildenbrand wrote:
> On 06.11.2017 23:30, Janosch Frank wrote:
>> A shadow gmap and its parent are locked right after each other when
>> doing VSIE management. Lockdep can't differentiate between the two
>> classes without some help.
>>
>> TODO: Not sure yet if I have to annotate all and if gmap_pmd_walk will=

>> be used by both shadow and parent
>=20
> Why is that new, I thought we already had the same situation before and=

> lockdep didn't complain?
>=20
> (worrying of we are now seeing a real problem and try to hide it)

In gmap_protect_rmap we now also need to take the parent's gmap page
table lock, which we didn't need before, because we only touched the
parent's ptes and had pte locks for that.


--qlsw6FdF65R6nhAWkaP5dEHaWqwHKcJ72--

--jFtL8uPqAuGnsk5POae2LX0LnnL8tLfXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaDDA3AAoJEBcO/8Q8ZEV5pVUP/A5da4GC6fuCi1+fX4HpKbCM
1yV7M8zE/pIN8+YWc8e6ovDNbtkM5m7T1DGgvB30/9trgpQXtk+gymFiKsfzVGv/
4wJ25y6MqqZMAABCKlug++T8YbK1enhP/CmPzGLxHsHkWbXptq780lTTAAaRHji6
54HKq3qn/OfAdi3sX5e29CX5ueXyinMOhMrWvg3eY8rihLcltBlJdm4CRgHCRk0a
zztIoVm5XwYRpER198bnDPxaJUSOOqBKE7dG3rNxLeqTXpUXDvwGTDCSlQnLwrrt
uTevj5COBVgt7Q8CqQpauqLCD+c8EacE+6c+Mba6Arog5Wt44BhMdGaAZfOIyBte
u2QE+Us1gI7O1yckgjLmnsRx5TRDvWGi1N67F9+tYpsXMW8NMPR/paNZZMeNY2cM
bzQLbsvhzT7tyTXv4VXhpS2wAbG2xFg0N8RXrDbVIl/+68Zswf3j3WtOSjGlpf7u
+U85DA9zuQZ7h0TKaO/5PvZfRH2Vw/+hGF+/q/wNDeyMjWMW/3+XvphanURoSCGq
Iui7C+tfZum8XucNOjvDX5LdftRJgX39CXh4b68gzLkhHODFC1xcJndjU4Jcqn7z
DSaV939KB9yy/x2a0iGahehRUduGXVC9r2jif9p+NmS4Y8q0ly3/xBiG0gUgcqt0
PzThTbAb04ziedg3L2cn
=NEab
-----END PGP SIGNATURE-----

--jFtL8uPqAuGnsk5POae2LX0LnnL8tLfXG--
