Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388719AbfISLIG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Sep 2019 07:08:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8JAvqQI112763
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2019 07:08:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v45s66r4t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2019 07:08:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 19 Sep 2019 12:07:59 +0100
Subject: Re: [kvm-unit-tests PATCH v2 3/6] s390x: Add linemode buffer to fix
 newline on every print
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-4-frankja@linux.ibm.com>
 <ea032176-101e-3961-3c54-e5ae0b7009d6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 19 Sep 2019 13:07:55 +0200
MIME-Version: 1.0
In-Reply-To: <ea032176-101e-3961-3c54-e5ae0b7009d6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u0nRxDYobYYFcbNEQy47QYq3Z5LLujsNy"
Message-Id: <059d76c9-88e8-8fa0-aa71-ff5b74c490e7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u0nRxDYobYYFcbNEQy47QYq3Z5LLujsNy
Content-Type: multipart/mixed; boundary="qkxtEhom0ZkXSmYvXMf5qBUkkC2CIzBu7";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <059d76c9-88e8-8fa0-aa71-ff5b74c490e7@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/6] s390x: Add linemode buffer to fix
 newline on every print
References: <20190905103951.36522-1-frankja@linux.ibm.com>
 <20190905103951.36522-4-frankja@linux.ibm.com>
 <ea032176-101e-3961-3c54-e5ae0b7009d6@redhat.com>
In-Reply-To: <ea032176-101e-3961-3c54-e5ae0b7009d6@redhat.com>

--qkxtEhom0ZkXSmYvXMf5qBUkkC2CIzBu7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/11/19 9:57 AM, David Hildenbrand wrote:
> On 05.09.19 12:39, Janosch Frank wrote:
>> Linemode seems to add a newline for each sent message which makes
>> reading rather hard. Hence we add a small buffer and only print if
>> it's full or a newline is encountered. Except for when the string is
>> longer than the buffer, then we flush the buffer and print directly.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  lib/s390x/sclp-console.c | 70 +++++++++++++++++++++++++++++++++++++--=
-
>>  1 file changed, 66 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/s390x/sclp-console.c b/lib/s390x/sclp-console.c
>> index 19416b5..7397dc1 100644
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
>=20
> Just wondering, how did you come up with the 120? (my first guess would=

> have been something around 80)
>=20
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
>=20
> The rename of str->buff could have been avoided, however, the impact is=

> rather small.
>=20
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
>> @@ -148,6 +152,64 @@ static void sclp_print_lm(const char *str)
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
>> +	int len;
>> +	char *nl;
>> +
>> +	spin_lock(&lm_buff_lock);
>> +
>> +	len =3D strlen(str);
>=20
> You could do that directly when declaring the variable, doesn't have to=

> be under the lock.
>=20
>> +	/*
>> +	 * No use in copying into lm_buff, its time to flush the
>> +	 * buffer and print str until finished.
>> +	 */
>> +	if (len > sizeof(lm_buff)) {
>=20
> I find ARRAY_SIZE(lm_buf) easier to understand than sizeof(lm_buff)
>=20
>> +		if (lm_buff_off)
>> +			lm_print(lm_buff, lm_buff_off);
>> +		lm_print(str, len);
>> +		memset(lm_buff, 0 , sizeof(lm_buff));
>> +		lm_buff_off =3D 0;
>> +		goto out;
>> +	}
>> +
>> +fill:
>=20
> Is there a way to remove this goto by using a simple while loop?
>=20
>> +	len =3D len < (sizeof(lm_buff) - lm_buff_off) ? len : (sizeof(lm_buf=
f) - lm_buff_off);
>> +	if ((lm_buff_off < sizeof(lm_buff) - 1)) {
>=20
> Drop one set of ()
>=20
>> +		memcpy(&lm_buff[lm_buff_off], str, len);
>> +		lm_buff_off +=3D len;
>> +	}
>> +	/* Buffer not full and no newline */
>> +	nl =3D strchr(lm_buff, '\n');
>=20
> Why do we have to search? Shouldn't a newline be the last copied
> character only?
>=20
>> +	if (lm_buff_off !=3D sizeof(lm_buff) - 1 && !nl)
>> +		goto out;
>> +
>> +	lm_print(lm_buff, lm_buff_off);
>> +	memset(lm_buff, 0 , sizeof(lm_buff));
>> +	lm_buff_off =3D 0;
>> +
>> +	if (len < strlen(str)) {
>> +		str =3D &str[len];
>> +		len =3D strlen(str);
>> +		goto fill;
>> +	}
>=20
> This looks too complicated for my taste :) Or my caffeine level is low.=

>=20
> I think we have the following cases:
>=20
> 1. String contains newline
>  a) String fits into remaining buffer
> 	-> Copy into buffer, flush (last character is newline)
>  b) String doesn't fit into remaining buffer
> 	-> Simply flush old buffer and print remaining string?
> 2. String doesn't contain newline.
>  a) String fits into remaining buffer
> 	-> Copy into buffer, flush if full
>  b) String doesn't fit into remaining buffer
> 	-> Simply flush old buffer and print remaining string?
>=20
> Optimizing for 1b) or 2b) isn't really worth it I guess - unless we wan=
t
> to wrap *any* string at 120 characters. But then, your pre-loop handlin=
g
> would also have to be modified. I think this allow to simplify your cod=
e
> a lot.
>=20
> (how often does it happen in our current tests that we exceed 120
> characters?)

How about this?

 	char *nl;
        int len =3D strlen(str), i =3D 0;

        spin_lock(&lm_buff_lock);

	while (len) {
                lm_buff[lm_buff_off] =3D str[i];
                lm_buff_off++;
                len--;
                /* Buffer full or newline? */
                if (str[i] =3D=3D '\n' || lm_buff_off =3D=3D (sizeof(lm_b=
uff) -
1)) {
                        lm_print(lm_buff, lm_buff_off);
                        memset(lm_buff, 0 , sizeof(lm_buff));
                        lm_buff_off =3D 0;
                }
                i++;
        }
        spin_unlock(&lm_buff_lock);
        return;



>=20
>> +
>> +out:
>> +	spin_unlock(&lm_buff_lock);
>> +}
>> +
>>  /*
>>   * SCLP needs to be initialized by setting a send and receive mask,
>>   * indicating which messages the control program (we) want(s) to
>>
>=20
>=20





--qkxtEhom0ZkXSmYvXMf5qBUkkC2CIzBu7--

--u0nRxDYobYYFcbNEQy47QYq3Z5LLujsNy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2DYYsACgkQ41TmuOI4
ufhfghAAwU+49lHTmDL26a74D8u4a4fRcePpQ8lnt/vBlMeIFKdUUVFJuPEXNNzP
5oZ1bwcceHmQuY1c3ILOEw0kDtrmTTyb+23UUHWHRAhMS1TP7dR+WplrhRXgpJdI
9X6gXJqIUnByTxs//wbGSZaWoRccHiZ18t0AaS2w7nj1ozotsQp42D+nk9IsqoR1
bZbf/uOCTZx0qMqppP/sfiLNn3p3FCGA7zIkND4HrTOkSjkFuqd/f+NbvVtUvagn
HHbKjz+sIzQky58hCLrwlQj5sb/7KMLO196yd+oG/kscKxmZD7YUVODlMbHekSBb
a4KwnZxJVgw+8PJJQQ538xhaAlxOMrgjSgr4QPVoA+x/xEy1ynRxEOQMXlVESn3D
2d1C3t2fQFUb3juK2PkyMT7wD/skU4EeSi47K50ug2k9YECvk2h9lfwrJz/RVJj2
iBcuMAAs8g2i5fbsoJYL7XXS4Fpf2YU/7O0S5t9uGLK/6Pf5wNncmnbiRzt8VXuW
f3evJsEJmmJFW2pLEiFWAzDRVaF45LJ1M/IGFkxtl0p+DfGorFPIJde1c8unq/ir
xXHXceC6MS8spyeaq0+Z/Rz2dc8CIKYI5935ccXBbq18oJSz1U6UN1U573MVzp+2
eu7GIfB6a5HvnVLxZGlxBVZM95ZnQ90o0ztdmiC6J6qW5IYz2qo=
=DKGt
-----END PGP SIGNATURE-----

--u0nRxDYobYYFcbNEQy47QYq3Z5LLujsNy--
