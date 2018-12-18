From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 18 Dec 2018 11:57:23 +0000
Subject: Re: [kvm-unit-tests PATCH v3 07/13] s390x: Use interrupts in SCLP
Message-Id: <5f25a18c-f6a4-36b5-7748-05c7cf643f95@linux.ibm.com>
In-Reply-To: <9304af52-90ef-3f76-4806-774285ed2d7e@redhat.com>
References: <9304af52-90ef-3f76-4806-774285ed2d7e@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--JkbzoWkoSDzPESV8l9X09kug8ou1Zcusm"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JkbzoWkoSDzPESV8l9X09kug8ou1Zcusm
Content-Type: multipart/mixed; boundary="mHTdRQ4JhlVrv6nJuAS4nOoKBogVymHf5";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <5f25a18c-f6a4-36b5-7748-05c7cf643f95@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 07/13] s390x: Use interrupts in SCLP
References: <20181218092657.46466-1-frankja@linux.ibm.com>
 <20181218092657.46466-8-frankja@linux.ibm.com>
 <fae3b195-9c94-f7e5-2cbf-f37425d53f16@redhat.com>
In-Reply-To: <fae3b195-9c94-f7e5-2cbf-f37425d53f16@redhat.com>

--mHTdRQ4JhlVrv6nJuAS4nOoKBogVymHf5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.12.18 11:49, Thomas Huth wrote:
> On 2018-12-18 10:26, Janosch Frank wrote:
>> We need to properly implement interrupt handling for SCLP, because on
>> z/VM and LPAR SCLP calls are not synchronous!
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---

[...]

>=20
> I'd maybe rather write this as:
>=20
> 	while (sclp_busy)
> 		mb();
>=20
> ... but it should not really matter.
>=20
>  Thomas
>=20

All suggestions sound reasonable :)


--mHTdRQ4JhlVrv6nJuAS4nOoKBogVymHf5--

--JkbzoWkoSDzPESV8l9X09kug8ou1Zcusm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcGOCjAAoJEONU5rjiOLn4TmwQAJvPUqgPQd9kSQnU1RgOVlYX
xfuJ/pj5WIjdOgrQxuO5aZXmrxs7F2+0fuQC4Cx0B0Ix5II5qfIRsC3bS7cz9WdP
AAAqKfJQAA2HEZgpmrc8L9WnPtDbDam3PCcgdxdjh6ocmx/UXlvUWfZq6iZJPmIA
lFk+W4tU3LroM/D1BCQJc3Ougq5wpvB5T/ahjdtPwwY7GSvrXes+t2CqFtqDKRq/
K5VWdzyFHY1HJtyqXtCOxE3cvLxWvCVwI9AVIcsize2o9QHkeIsMJGOTlCxojeAe
ioj3QliXKuKhxxCgJ94ZnwGa+dD6Ve5mTY9l6Zyme4B+pqxrNDCsMUcf5sFP9cn8
kHJjvEcTX1tcbWncXjlg1iJomluscLam/SuLWnriZPyItcXm2il9kc6QXTlgzfr+
cxmJdiGAZfhA+fr/DMEVw6qxDnxrXkf5pvNFLP22YnQ5NJrlgdPRJnqeYZHFDr8I
ty/iZHvT6kdAb4WDzQBnhgT8a4/vdf+ZbWyhgi47WXMBwYV6HCGdcxiAXYaw4QjY
gaNTNO6Mlr44ETXEfTVafCkCY/LWPL1LmbUbqYwwCXvyftO/lI6JLWbI1/cwAZe+
Laapq55UptxoDeZ5gRKGHp7qAihvi/TE+7JIWR0xFp2JuFQquLr08lMtMeMlg+Ws
I8C0vnNqPrED6DDLyCAG
=84ob
-----END PGP SIGNATURE-----

--JkbzoWkoSDzPESV8l9X09kug8ou1Zcusm--
