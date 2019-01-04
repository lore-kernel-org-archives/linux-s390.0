From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 04 Jan 2019 10:06:41 +0000
Subject: Re: [kvm-unit-tests PATCH v4 12/13] s390x: Add time functions to lib
Message-Id: <881fe54e-b8b0-bc4a-c497-85a4f7c5aecc@linux.ibm.com>
In-Reply-To: <20190104084225.GB4396@osiris>
References: <20190104084225.GB4396@osiris>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--CvHCjPKqO84wTpHSmn6dZD0DsWLYVDyhr"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CvHCjPKqO84wTpHSmn6dZD0DsWLYVDyhr
Content-Type: multipart/mixed; boundary="tAwSXV5ey3Vpx42w43MDohYugoZsk2QMg";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <881fe54e-b8b0-bc4a-c497-85a4f7c5aecc@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v4 12/13] s390x: Add time functions to lib
References: <20190103100806.9039-1-frankja@linux.ibm.com>
 <20190103100806.9039-13-frankja@linux.ibm.com>
 <f0260b3a-996b-aae4-dc3a-de4ef3a176ba@redhat.com>
 <20190104084225.GB4396@osiris>
In-Reply-To: <20190104084225.GB4396@osiris>

--tAwSXV5ey3Vpx42w43MDohYugoZsk2QMg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.01.19 09:42, Heiko Carstens wrote:
> On Thu, Jan 03, 2019 at 02:52:15PM +0100, Thomas Huth wrote:
>> On 2019-01-03 11:08, Janosch Frank wrote:
>>> +/*
>>> + * STCKE returns 16 bytes, which include the epoch, tod value and a
>>> + * programmable field. The value has to be trimmed to be able to wor=
k
>>> + * with it. As there's still some time to 2042, this code is not rea=
dy
>>> + * for multi epoch values.
>>> + */
>>> +static inline void stcke(char *tod)
>>> +{
>>> +	asm volatile(
>>> +		"	stcke	%[tod]\n"
>>> +		: [tod] "=3DQ" (tod)
>>> +		: : "cc");
>>> +}
>>
>> I'm not an inline-assembly wizzard, but the "=3DQ" constraint looks wr=
ong
>> to me here. Are you sure that this is working as expected?
>=20
> Yes, this is wrong. That's the reason why the kernel variant has the
> typedef + cast (see get_tod_clock_ext() in arch/s390/include/asm/timex.=
h).
>=20
> The variant above tells the compiler that only a single byte is written=
 to.
>=20

Yep, was removed yesterday already.
If tests for multi epoch enablement come up they'll have to introduce it
again.

For now I'll keep #12 and #13 on hold until they are needed upstream, I
think there will not be huge conflicts in that area if the need to
upstream it arises later.


--tAwSXV5ey3Vpx42w43MDohYugoZsk2QMg--

--CvHCjPKqO84wTpHSmn6dZD0DsWLYVDyhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcLzAyAAoJEONU5rjiOLn4gsAQAIMxPd7xhDhxPdgtKOt8gSpz
zlcmhsTSO1GEbmvqGdnPrp9Nuq1RuoIKTzIttFeFIJlUp7VF5b28Rirm2+U3rV2N
yGCfLoYzZ6ZbnlOYQSetrPMN6w4/hXy1ZD38GzKYdbZ4jjYRccD4BUlvFVX2Q68R
oOGXoRzSj+tlThKsSsfiUUZruG+xBmVcZoIi7GtWZVcALhXkJ7y/wjcpnc0Z4a1a
FrQNfYZiLiXil4DHXQ1wrfub6P8y5udE+khzc2YtiqMPAv6euKWXmJNdWrt5FIVP
nHD99Vna3SZu/HwQorf3WKpGHwslYbHyAxQdX7HvXNop2x7sd4b3/mELGpZLJi+7
yS6FweKsaxxLYeiMkC+rHRb0B9b67lZ43oukkqg9y52FdPHbQ6CSClsxhbgD4fOp
7IezBm7eFhGAAe6qiJNkcwH/80s3sCEIvtYOqnUWVyYIFACiebIL6kf5+Geh9oLp
2FU0owtjDQucScuBbA5FHFehafMtRwycJnAodKGaN4g8xui7W+b+Y30QhOACVc7G
LgvhdHQMqHjRdqe/ivPbvLmEyBIObBKzsWWZPP48I/FyB7gRG1oBruvOxPaooMZC
J0z8IaNKi8nUzTqz0V/exTKk9OfyYZ0DC4iiVzUcMCwxHtUT2RuMyiYMqx3UNl1H
SXd/dzHucdGyb6h+lKxW
=Rc48
-----END PGP SIGNATURE-----

--CvHCjPKqO84wTpHSmn6dZD0DsWLYVDyhr--
