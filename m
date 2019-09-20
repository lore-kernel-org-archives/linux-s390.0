Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408317AbfITIbx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Sep 2019 04:31:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8K8TBPv060637
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2019 04:31:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v4r0yny22-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2019 04:31:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 20 Sep 2019 09:31:50 +0100
Subject: Re: [kvm-unit-tests PATCH v3 3/6] s390x: Add linemode buffer to fix
 newline on every print
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-4-frankja@linux.ibm.com>
 <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 20 Sep 2019 10:31:46 +0200
MIME-Version: 1.0
In-Reply-To: <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L0YwyiZHqzRG8dvykBGYGIpfi38Dtzrre"
Message-Id: <b2730c42-27a7-1fff-0687-98b587516481@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L0YwyiZHqzRG8dvykBGYGIpfi38Dtzrre
Content-Type: multipart/mixed; boundary="QIRclMaWNmfo4Eb3LPor2gXqVYISloEpS";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <b2730c42-27a7-1fff-0687-98b587516481@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 3/6] s390x: Add linemode buffer to fix
 newline on every print
References: <20190920080356.1948-1-frankja@linux.ibm.com>
 <20190920080356.1948-4-frankja@linux.ibm.com>
 <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>
In-Reply-To: <43bb9ff6-4233-3f6f-8cdb-3a00d1662d4d@redhat.com>

--QIRclMaWNmfo4Eb3LPor2gXqVYISloEpS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/20/19 10:24 AM, David Hildenbrand wrote:
> On 20.09.19 10:03, Janosch Frank wrote:
>> Linemode seems to add a newline for each sent message which makes
>> reading rather hard. Hence we add a small buffer and only print if
>> it's full or a newline is encountered. Except for when the string is
>> longer than the buffer, then we flush the buffer and print directly.
>=20
> I think that last sentence is not correct anymore.
>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>  lib/s390x/sclp-console.c | 45 ++++++++++++++++++++++++++++++++++++---=
-
>>  1 file changed, 41 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
>> index 19416b5..e1b9000 100644
>> --- a/lib/s390x/sclp-console.c
>> +++ b/lib/s390x/sclp-console.c
>> @@ -13,6 +13,7 @@
>>  #include <asm/page.h>
>>  #include <asm/arch_def.h>
>>  #include <asm/io.h>
>> +#include <asm/spinlock.h>
>>  #include "sclp.h"
>> =20
>>  /*
>> @@ -87,6 +88,10 @@ static uint8_t _ascebc[256] =3D {
>>       0x90, 0x3F, 0x3F, 0x3F, 0x3F, 0xEA, 0x3F, 0xFF
>>  };
>> =20
>> +static char lm_buff[120];
>> +static unsigned char lm_buff_off;
>> +static struct spinlock lm_buff_lock;
>> +
>>  static void sclp_print_ascii(const char *str)
>>  {
>>  	int len =3D strlen(str);
>> @@ -103,10 +108,10 @@ static void sclp_print_ascii(const char *str)
>>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>>  }
>> =20
>> -static void sclp_print_lm(const char *str)
>> +static void lm_print(const char *buff, int len)
>>  {
>>  	unsigned char *ptr, *end, ch;
>> -	unsigned int count, offset, len;
>> +	unsigned int count, offset;
>>  	struct WriteEventData *sccb;
>>  	struct mdb *mdb;
>>  	struct mto *mto;
>> @@ -117,11 +122,10 @@ static void sclp_print_lm(const char *str)
>>  	end =3D (unsigned char *) sccb + 4096 - 1;
>>  	memset(sccb, 0, sizeof(*sccb));
>>  	ptr =3D (unsigned char *) &sccb->msg.mdb.mto;
>> -	len =3D strlen(str);
>>  	offset =3D 0;
>>  	do {
>>  		for (count =3D sizeof(*mto); offset < len; count++) {
>> -			ch =3D str[offset++];
>> +			ch =3D buff[offset++];
>>  			if (ch =3D=3D 0x0a || ptr + count > end)
>>  				break;
>>  			ptr[count] =3D _ascebc[ch];
>> @@ -148,6 +152,39 @@ static void sclp_print_lm(const char *str)
>>  	sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>>  }
>> =20
>> +
>> +/*
>> + * In contrast to the ascii console, linemode produces a new
>> + * line with every write of data. The report() function uses
>> + * several printf() calls to generate a line of data which
>> + * would all end up on different lines.
>> + *
>> + * Hence we buffer here until we encounter a \n or the buffer
>> + * is full. That means that linemode output can look a bit
>> + * different from ascii and that it takes a bit longer for
>> + * lines to appear.
>> + */
>> +static void sclp_print_lm(const char *str)
>> +{
>> +	int len =3D strlen(str), i =3D 0;
>> +
>> +	spin_lock(&lm_buff_lock);
>> +
>> +	while (len) {
>=20
> for (i =3D 0; i < len; i++)
>=20
> Then make len const and drop "len--" and "i++" from the body.

Sure, the loop was a first draft anyway.
I'm asking myself how I ended up writing something so complicated in the
first place :-)

>=20
>> +		lm_buff[lm_buff_off] =3D str[i];
>> +		lm_buff_off++;
>=20
> lm_buff[lm_buff_off++] =3D str[i];
>=20
> if you feel like saving one LOC :)
>=20
>> +		len--;
>> +		/* Buffer full or newline? */
>> +		if (str[i] =3D=3D '\n' || lm_buff_off =3D=3D (sizeof(lm_buff) - 1))=
 {
>=20
> I still prefer ARRAY_SIZE(), but this is also fine.
>=20
>> +			lm_print(lm_buff, lm_buff_off);
>> +			memset(lm_buff, 0 , sizeof(lm_buff));
>=20
> Is the memset really necessary? (I would have assumed it would only
> print until the last "\n" ?)

It's not, I just like clearing things

>=20
>> +			lm_buff_off =3D 0;
>> +		}
>> +		i++;
>> +	}
>=20
> Guess we don't care about performance, so the simple byte-based approac=
h
> should be just fine.

;-)

>=20
>> +	spin_unlock(&lm_buff_lock);
>> +}
>> +
>>  /*
>>   * SCLP needs to be initialized by setting a send and receive mask,
>>   * indicating which messages the control program (we) want(s) to
>>
>=20
>=20
> I wonder if we have to implement some kind of fflush(), so we will flus=
h
> the buffer on any abort ... but I assume we will always end printing
> with a "\n", so we don't really care.

I haven't encountered incomplete output up to now.


--QIRclMaWNmfo4Eb3LPor2gXqVYISloEpS--

--L0YwyiZHqzRG8dvykBGYGIpfi38Dtzrre
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2EjnIACgkQ41TmuOI4
ufjS8xAAla6M89VJF6YDkQL669ZXfq2BoOq/+nt7KncybESrdDzHRAtX6U37nmEv
vOPgl9b5UwAmupYxnKG9T7VROn6Kdbo6vCFricHG8pS/5oYjm8Rnd/QDJpAdX2iT
d3MdqBWN8fJlQnlcJzFKOjX8TUrsKsyCTBxvLdeJ8WzQXhw8uKm5iAfjE0YD5NCB
8Ou7jNxA/yXrs0wVwVEC1zpCaHC4F1G4pNaCaFEBZl3oEl2FhIa0rO+4oxqaXIFG
XdTimDDuOM0aGHqGdOE7Dp6GWUezAG6oyzg+Wsh0hZvUMOFT6yWXEyF7tIVFR/KS
aL6lecQ9uWrv14160oZ5FoNttpsfShyZDfiLr1VgPYNKkKvN5XyxoAowGDF61Kll
pZJj7fDNduWymukLD11b5faYYo/tzEzvMYax2kC36TAv6rGqP1doFosYrFJvUnka
rwyEZYE2tFCC0Fmf9tMTy3D+E9AavbDfuima+baKVYcPCFbJcXUWP+hWA35DlB3w
ts4y0cnWd0Ygnzf0irp4Vv+hHdmc8yaRx/p9VvqQJxCPviNnlNRS6MStDW+7rR1X
6GJnCyI5zRkKg1iy3LxFbFxFo+bSKNo3M85nxc7NKWy7r0Ha5R5YT6MG4BMcN1Zu
X5IZTpUSu3K8Ye3zz+0mkcXVb/zWsbAbXRmxzHa6kY5011Vy+C8=
=oC1y
-----END PGP SIGNATURE-----

--L0YwyiZHqzRG8dvykBGYGIpfi38Dtzrre--
