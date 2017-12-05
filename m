From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] KVM: s390: Fix skey emulation permission check
Date: Tue, 5 Dec 2017 10:32:03 +0100
Message-ID: <742d333c-a229-c28b-fea1-5885fdbb0358@linux.vnet.ibm.com>
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
 <20171205083321.102933-5-borntraeger@de.ibm.com>
 <20171205101359.1d3b09c3.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ix8KrddvkW04NnJrghL8rCWmjpaSUxVVS"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171205101359.1d3b09c3.cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ix8KrddvkW04NnJrghL8rCWmjpaSUxVVS
Content-Type: multipart/mixed; boundary="FrUwMqAE9uKQecu9wOsKqSNrBianOxgLG";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Message-ID: <742d333c-a229-c28b-fea1-5885fdbb0358@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] KVM: s390: Fix skey emulation permission check
References: <20171205083321.102933-1-borntraeger@de.ibm.com>
 <20171205083321.102933-5-borntraeger@de.ibm.com>
 <20171205101359.1d3b09c3.cohuck@redhat.com>
In-Reply-To: <20171205101359.1d3b09c3.cohuck@redhat.com>

--FrUwMqAE9uKQecu9wOsKqSNrBianOxgLG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.12.2017 10:13, Cornelia Huck wrote:
> On Tue,  5 Dec 2017 09:33:21 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> From: Janosch Frank <frankja@linux.vnet.ibm.com>
>>
>> All skey functions call skey_check_enable at their start, which checks=

>> if we are in the PSTATE and injects a privileged operation exception
>> if we are.
>>
>> Unfortunately they continue processing afterwards and perform the
>> operation anyhow as skey_check_enable does not deliver an error if the=

>> exception injection was successful.
>>
>> Let's move the PSTATE check into the skey functions and exit them on
>> such an occasion, also we now do not enable skey handling anymore in
>> such a case.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Fixes: a7e19ab ("KVM: s390: handle missing storage-key facility")
>> Cc: <stable@vger.kernel.org> # v4.8+
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/priv.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!

>=20
> This reminds me of something I stumbled upon the other day:
>=20
> handle_ri() and handle_gs() (both implemented in priv.c) don't seem to
> have a check for PSTATE, yet they enable ri/gs before retrying the
> instruction. Is that correct?
>=20

None of the gs instructions are privileged as far as I know. Same seems
to be true for ri as far as I've scanned the spec.

The privileged parts are the control register and PSW changes which are
handled elsewhere.


--FrUwMqAE9uKQecu9wOsKqSNrBianOxgLG--

--ix8KrddvkW04NnJrghL8rCWmjpaSUxVVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaJmeTAAoJEBcO/8Q8ZEV5+l0P/jpPvFxGHVEFXI5C62lZ+Zis
vxWJV0JNISBhVRGPRDjJnbvb1TiMI/JyPxI/yYYgzJQlZVyiR6X6QKVaf44pMmSp
oDWU0CDmdmaJyoBmHOjzn/lMudb55wlJvZH/9SBICw2lQ1lTgLeC+r/8OOCM0sj5
q6ndD1gej7xvc6Ra34jM2IfuO7rnu8OufY1CsyepeaCbnVdJDagvso2s2K5eBGWy
lp2LlltMz4+XJqBxBlkhCD9fszmj28dE9aPR63nTH9rkcPJiu+lUD3jY6ihEbw1k
BXK0GCMYziwICih7nv/oykhV9zl9ktX2PUKyPSEhcrP1zhuBzas+gCu51vDlXmci
mNQxO86xMN1ppKvtHqYa2N0BKHiSPIYoA1qu7m8WPLnTlKwC4x2AVRzZANW0vg0E
Hulr9MiBhQH/+KecqRUPg0PF5teLDxOEPb4X9uUpwwl9JiPHQrJJxi5eX5z1/XnG
GUFe8MLCPoYaECBZ8dQzG53xxoNMgcL+GOCgeQzM6YEnzfyQ1uSzzqx/mtNOYrnq
bfggDJ1izOndALYRq/3hz+sv6VNhn7RWyFFkwzmJQYExjyFogKkjEFJwG3y5kqiV
d3xSwXz6Z6Yzl+QKBnDigENm+gB3ssNvhvwuiy2y5fRjQN6q6HQamlHinxGlHOSI
e7hhzHLmScmbqRYheESa
=CWGE
-----END PGP SIGNATURE-----

--ix8KrddvkW04NnJrghL8rCWmjpaSUxVVS--
