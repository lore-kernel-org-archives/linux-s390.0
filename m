From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 16 Oct 2018 09:00:12 +0000
Subject: Re: [RFC 07/14] s390/mm: Add gmap_idte_global
Message-Id: <bc03524a-6cd7-f286-663f-ceb5da541944@linux.ibm.com>
In-Reply-To: <2b3c107c-fdf4-d6c0-145a-597203b4807d@redhat.com>
References: <2b3c107c-fdf4-d6c0-145a-597203b4807d@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--i2XvjkMSFgmcv5xenCae8Y5U90q5gYRZp"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i2XvjkMSFgmcv5xenCae8Y5U90q5gYRZp
Content-Type: multipart/mixed; boundary="QWeO3gqUVbKd2t20QmvwBFiEQ6AKGdJpA";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, schwidefsky@de.ibm.com
Message-ID: <bc03524a-6cd7-f286-663f-ceb5da541944@linux.ibm.com>
Subject: Re: [RFC 07/14] s390/mm: Add gmap_idte_global
References: <20180919084802.183381-1-frankja@linux.ibm.com>
 <20180919084802.183381-8-frankja@linux.ibm.com>
 <108a5c7b-60ac-5764-e297-89fa7dcbfa59@redhat.com>
 <8cef155f-408e-1b79-3932-d94e1b50cfb2@linux.ibm.com>
 <2b3c107c-fdf4-d6c0-145a-597203b4807d@redhat.com>
In-Reply-To: <2b3c107c-fdf4-d6c0-145a-597203b4807d@redhat.com>

--QWeO3gqUVbKd2t20QmvwBFiEQ6AKGdJpA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.10.18 10:37, David Hildenbrand wrote:
> On 16/10/2018 10:35, Janosch Frank wrote:
>> On 16.10.18 10:22, David Hildenbrand wrote:
>>> On 19/09/2018 10:47, Janosch Frank wrote:
>>>> Introduce a function to do a idte global flush on a gmap pmd and
>>>> remove some code duplication.
>>>
>>> I'd call this patch
>>> "s390x/mm: factor out idte global flush into gmap_idte_global"
>>
>> I can offer:
>>
>> s390/mm: Factor out guest related idte global flushes into gmap_idte_g=
lobal
>>
>> or
>>
>> s390x/mm: Factor out gmap idte global flushes into gmap_idte_global
>>
>=20
> Works both for me. I guess this patch makes sense even without the othe=
r
> parts?
>=20

Without this series I don't feel an urge to have it included, the third
caller that is introduced later made it painful enough to add it.


--QWeO3gqUVbKd2t20QmvwBFiEQ6AKGdJpA--

--i2XvjkMSFgmcv5xenCae8Y5U90q5gYRZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbxaicAAoJEONU5rjiOLn4nTsQAIVacEU8LPlbRwjKeIFdH25g
npznefRk4bxYe4xfwWpOSyXPGwwRr9i5yp3H2wbJICQLgf4BffPOl5tt52Gcdc2I
MkiUcJXqZiSlY/b/nTIAxZJlVrmN5lnfxrdADXTc+U9yQLlAobuvvZmXxrtjxUZD
gqyLBtNIcnZvmjJW8IzoNoqUmX6S+yhyZ+vqnBb5UZ0YoEpqVNejUo+H0ysctenf
QQGdc0LpfzVGkYkjevlGZQmnmgBeWDnAtntqNMzRIG4fDdcdyNQ2RnJxZQ80ioIu
TBJMyzc+C4V9CO9Rqa95c8X19QN6qAVJfyrsjW/EURPA4nureM6OEfV98yiVtG6n
/OpMTrOycjzDmqzWiIWyeKoNUSm+TdBOLrRjKq0rna0pkOyDt6IxeKnZocs4SGeb
3DOcP7TwWHdF0qKkYFw32AvRZoxarG+Azgl7xEpq25Wqwrue1lxU4XY6nhLKf+f9
hx4KzbdyX5m7Na5rQ/lDQXeZ9jQ+33ftObZMcAm3DGBrFoVXwLYpZlEyNWen98kU
QGCjDIjNbanJVOldtZD0u4VjCZnLu744fRRJxYkbBGk4kZ/pfdbmYCNRG3p4gTW6
dA6Mu+YlqtCSUrF+SQrinCUVScouWjjv77VfcH7J6CMQHZQ699XNKZe+R2k0Jfgb
6YEln42NWrgOn2Y5T1XB
=dPD+
-----END PGP SIGNATURE-----

--i2XvjkMSFgmcv5xenCae8Y5U90q5gYRZp--
