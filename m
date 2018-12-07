From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 07 Dec 2018 17:02:25 +0000
Subject: Re: [kvm-unit-tests PATCH v2 6/6] s390x: Add linemode console
Message-Id: <f114e37e-f6a0-0d91-b422-ff13b5d0d1a1@linux.ibm.com>
In-Reply-To: <a7474a51-bf3a-19c6-4a79-e29757206f24@redhat.com>
References: <a7474a51-bf3a-19c6-4a79-e29757206f24@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--nZnnjAY2Ruk8eprPKjxzFQ9Bg0NBRYTVG"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nZnnjAY2Ruk8eprPKjxzFQ9Bg0NBRYTVG
Content-Type: multipart/mixed; boundary="pi0qdAcqP7QyRLhFodt9KgPIzRqpOeZR3";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <f114e37e-f6a0-0d91-b422-ff13b5d0d1a1@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 6/6] s390x: Add linemode console
References: <20181205153918.29480-1-frankja@linux.ibm.com>
 <20181205153918.29480-7-frankja@linux.ibm.com>
 <a7474a51-bf3a-19c6-4a79-e29757206f24@redhat.com>
In-Reply-To: <a7474a51-bf3a-19c6-4a79-e29757206f24@redhat.com>

--pi0qdAcqP7QyRLhFodt9KgPIzRqpOeZR3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.12.18 17:19, David Hildenbrand wrote:
> On 05.12.18 16:39, Janosch Frank wrote:
>> z/VM isn't fond of vt220, so we need line mode when running under z/VM=
=2E
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/sclp-console.c | 199 ++++++++++++++++++++++++++++++++++++++=
++++-----
>>  lib/s390x/sclp.h         |  67 ++++++++++++++++
>>  2 files changed, 245 insertions(+), 21 deletions(-)
>>
>> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
>> index 13ab03d..c31e178 100644
>> --- a/lib/s390x/sclp-console.c
>> +++ b/lib/s390x/sclp-console.c
>> @@ -11,23 +11,183 @@
[...]
>> +
>> +static bool initialized =3D false;
>=20
> false is the default after your BSS clearing patch.

Yes, already fixed

>=20
>> +
>> +static void sclp_print_ascii(const char *str)
>> +{
>> +	int len =3D strlen(str);
>> +	WriteEventData *sccb =3D (void *)_sccb;
>> +
>> +	while (sclp_busy)
>> +		/* Wait for SCLP request to complete */;
>> +	sclp_busy =3D true;
>> +	memset(sccb, 0, sizeof(*sccb));
>> +	sccb->h.length =3D sizeof(WriteEventData) + len;
>> +	sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
>> +	sccb->ebh.length =3D sizeof(EventBufferHeader) + len;
>> +	sccb->ebh.type =3D SCLP_EVENT_ASCII_CONSOLE_DATA;
>> +	memcpy(sccb->data, str, len);
>> +
>> +	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>=20
> Shouldn't we wait for a response? (see below)

Yes, already fixed

>=20
>> +}
>> +
>> +static void sclp_print_lm(const char *str)
>> +{
>> +	unsigned char *ptr, *end, ch;
>> +	unsigned int count, offset, len;
>> +	struct write_sccb *sccb;
>> +	struct msg_buf *msg;
>> +	struct mdb *mdb;
>> +	struct mto *mto;
>> +	struct go *go;
>> +
>> +	while (sclp_busy)
>> +		/* Wait for SCLP request to complete */;
>> +	sclp_busy =3D true;
>> +	sccb =3D (struct write_sccb *) _sccb;
>> +	end =3D (unsigned char *) sccb + 4096 - 1;
>> +	memset(sccb, 0, sizeof(*sccb));
>> +	ptr =3D (unsigned char *) &sccb->msg.mdb.mto;
>> +	len =3D strlen(str);
>> +	offset =3D 0;
>> +	do {
>> +		for (count =3D sizeof(*mto); offset < len; count++) {
>> +			ch =3D str[offset++];
>> +			if ((ch =3D=3D 0x0a) || (ptr + count > end))
>> +				break;
>> +			ptr[count] =3D _ascebc[ch];
>> +		}
>> +		mto =3D (struct mto *) ptr;
>> +		memset(mto, 0, sizeof(*mto));
>> +		mto->length =3D count;
>> +		mto->type =3D 4;
>> +		mto->line_type_flags =3D LNTPFLGS_ENDTEXT;
>> +		ptr +=3D count;
>> +	} while ((offset < len) && (ptr + sizeof(*mto) <=3D end));
>> +	len =3D ptr - (unsigned char *) sccb;
>> +	sccb->header.length =3D len - offsetof(struct write_sccb, header);
>> +	msg =3D &sccb->msg;
>> +	msg->header.type =3D EVTYP_MSG;
>> +	msg->header.length =3D len - offsetof(struct write_sccb, msg.header)=
;
>> +	mdb =3D &msg->mdb;
>> +	mdb->header.type =3D 1;
>> +	mdb->header.tag =3D 0xD4C4C240;
>> +	mdb->header.revision_code =3D 1;
>> +	mdb->header.length =3D len - offsetof(struct write_sccb, msg.mdb.hea=
der);
>> +	go =3D &mdb->go;
>> +	go->length =3D sizeof(*go);
>> +	go->type =3D 1;
>> +	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>=20
> Shouldn't we wait for a response? (see below)

Yes, already fixed

>=20
>> +}
>> +
>> +/*
>> + * SCLP needs to be initialized by setting a send and receive mask,
>> + * indicating which messages the control program (we) want(s) to
>> + * send/receive.
>> + */
>> +static bool sclp_set_write_mask(void)
>>  {
>>  	WriteEventMask *sccb =3D (void *)_sccb;
>> =20
>>  	while (sclp_busy)
>>  		/* Wait for SCLP request to complete */;
>=20
> Can this actually happen?
>=20
> I'd say whoever issues a request has to wait for the response. Somebody=

> who didn't, doesn't have to wait.

We could put the sclp_wait_busy() at the end of the sclp call function
and effectively make it synchronous by enforcing the wait. We don't
really need the async performance gain.

>=20
> (for multiple CPUs later on that has to be guarded by a lock in additio=
n
> to the bool)

Yeah, smp is currently on another branch, so I might just start to add
another patch and introduce locks. :-)

>=20
>>  	sclp_busy =3D true;
>> +	memset(_sccb, 0, sizeof(*sccb));
>>  	sccb->h.length =3D sizeof(WriteEventMask);
>> -	sccb->mask_length =3D sizeof(unsigned int);
>> -	sccb->receive_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> -	sccb->cp_receive_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> -	sccb->send_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> -	sccb->cp_send_mask =3D SCLP_EVENT_MASK_MSG_ASCII;
>> +	sccb->h.function_code =3D 0;
>> +	sccb->mask_length =3D sizeof(sccb_mask_t);
>> +
>> +	/* For now we don't process sclp input. */
>> +	sccb->cp_receive_mask =3D 0;
>> +	/* We send ASCII and line mode. */
>> +	sccb->cp_send_mask =3D SCLP_EVENT_MASK_MSG_ASCII | SCLP_EVENT_MASK_M=
SG;
>> =20
>>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
>> +	while (sclp_busy) {
>> +	}
>> +	if (sccb->h.response_code !=3D SCLP_RC_NORMAL_COMPLETION)
>> +		return false;
>=20
> Hmm, what do do in this case?  I don't see that the caller is fixed up
> (you changed the return type from void to bool)

I don't know, there used to be a TODO there...
I thought about calling exit(1);

>=20
> I "initialized" actually worth keeping around? I'd say let's just
> continue as if it succeeded. (we cannot really do anything about it, ca=
n
> we?)

There is the problem of prints that come before the initialization.
PGM interrupts while sclp_busy =3D=3D true is also fun if they want to pr=
int.




--pi0qdAcqP7QyRLhFodt9KgPIzRqpOeZR3--

--nZnnjAY2Ruk8eprPKjxzFQ9Bg0NBRYTVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcCqeiAAoJEONU5rjiOLn4tisP/RE45YP4HaMR30ONNUdTOPBq
zOAc80X5j7ic0vjFM2zP09Z9sMOcF7o3syLfpQSkgFeegOPZIidVdGv3RpA1kH5z
I2IjICkb4KV1O5FPNssopVwcAEix5ecUJNcs0jyPMoqEVomZpxor9KJeRk19VldV
CGlz0pqD8Ux68tTIK3Bst9oj6SsL2rRwt2GsypdRTi0/K/sDjbyAlv/EPGy94Yx3
cIXpX2C2Iz4s5Y0llRcCeJmpjS8uTjT5ESWIAahMV+bya8SlzUGwoOZKcq6TfNiB
l/YVqST+vJi1M3AEy5d33LJwNsXSSmZ/XZTMy3YMBVcOYNFzPX2KxHeEOKvdBhfT
zCsv/tjmb89mK+kK3k+m6Hcr+6cfliDRD+pbuZbJYrJcvtTshFIJYAWrt6KVV1T0
wH2eyiprL9fIoR9B9n9l7vMTsfZ21ZUZuffqqdHPvQiBhvcLAopT1uz5kqczjZK7
47ZQgZh9cMQV5cLTziBBuFTYKFmhZ7VA3ELe7Hz/h7saAb5KqlJLZ3oJdYau1soZ
0/CsOmTJnGOp0EpHniqOs51tbk8xO/pHdktZ9yy0hHIeIkRS9ky8gaJMOZQSrRoi
zP4sDeYnal7XONcRbz+9aw6Q5yfUuF4MBEawTKmIEhYI9YJCcV6EJLeaCmgpfIKq
j/c849BteAq6bSdI0gKQ
=RGS3
-----END PGP SIGNATURE-----

--nZnnjAY2Ruk8eprPKjxzFQ9Bg0NBRYTVG--
