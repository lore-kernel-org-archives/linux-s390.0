From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Dec 2018 10:11:56 +0000
Subject: Re: [kvm-unit-tests RFC v3 10/13] s390x: Add linemode buffer to fix newline on every print
Message-Id: <25f6e03f-b9ec-4be7-8ed3-e2ec49742e3c@linux.ibm.com>
In-Reply-To: <9200e73b-8a1c-ec44-09b1-c6ae1e261631@redhat.com>
References: <9200e73b-8a1c-ec44-09b1-c6ae1e261631@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--88WtkU1LLTCnVtqymV4L5N3etJWZl95ul"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--88WtkU1LLTCnVtqymV4L5N3etJWZl95ul
Content-Type: multipart/mixed; boundary="k8HJoNba5cibWp7YZ4RtrNm5HQk7CtDWa";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <25f6e03f-b9ec-4be7-8ed3-e2ec49742e3c@linux.ibm.com>
Subject: Re: [kvm-unit-tests RFC v3 10/13] s390x: Add linemode buffer to fix
 newline on every print
References: <20181218092657.46466-1-frankja@linux.ibm.com>
 <20181218092657.46466-11-frankja@linux.ibm.com>
 <9200e73b-8a1c-ec44-09b1-c6ae1e261631@redhat.com>
In-Reply-To: <9200e73b-8a1c-ec44-09b1-c6ae1e261631@redhat.com>

--k8HJoNba5cibWp7YZ4RtrNm5HQk7CtDWa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.12.18 13:41, Thomas Huth wrote:
> On 2018-12-18 10:26, Janosch Frank wrote:
>> Linemode seems to add a newline for each sent message which makes
>> reading rather hard. Hence we add a small buffer that and only print
>> if it's full or a newline is encountered.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
[...]
>>  /*
>>
>=20
> That likely does not work as expected when someone is printing with the=

> '\n' not being at the end (printf("Hello\nWor"); printf("ld\n");) ...
> but it's certainly better than before, so fine for me if you resend thi=
s
> the next time without RFC.
>=20
>  Thomas
>=20

It seems to print \n on a new line, at least it does on the SE operation
message consoles I work with. If not I would have gone mad by now, as I
print a lot of data with newlines for some new tests with "%lx\n %lx\n...=
".

I'll add a comment to the new function, to make clear why that's here.


--k8HJoNba5cibWp7YZ4RtrNm5HQk7CtDWa--

--88WtkU1LLTCnVtqymV4L5N3etJWZl95ul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcGhlsAAoJEONU5rjiOLn4g9cP/i1SKp1feW5R5yMMvNOPXLqC
a0LDAsh5HtHixDkBsaUJGPkATbzuTLkN9a0Oqx3xZHmY8uRNp2F0M/DwQAK73+rE
USU9pH4U0hHfvkI7u2hwMukyy3n7cX0kFkMeA7B14pXe3tC3uiQrgDjcRe9VNnRT
rVsrgbCxDWXmoCTUluMJEOtR0WBGStwxG4XonRG6HJLAgXLgqj4C+AJgRCSuEXKs
xfQ5emeY1ulsvrEU17HnPX1XjOlxUYBxQWQ+ZwAM4CxJvPMpzlUPRft2/x1V9rZp
DVId4s21kkb19OBlqWdmVIml723D6iNFazJZyTqIn4G40e6yYY6NGxYml9dUpgJw
9fm7ecAdORvzrNqq7LC3OXpBTSJbDq7LJbNfN5iSJZvQeE0TOgaR2QlniZe9km+Q
IO7UFOhdRozPaL0XbNgmUBv65sm194P9hWZviF8uaW6TWYuFKpQ0swt5l/oEdKCG
qtvuIOgTxaPNnFxJoD+ZdLah8NqzugXSzJK+qZULLXA05b2wrBaq759zDaGjaKNQ
sGT06IlTVHFUwMK+HQDRMqqGLK4ZHYlsnfBWfStiV4vakQwsBZ7m3FXtkv2eMdz1
CCYvdJWjektwEWncwGU/MlEdIGr35LXvxeXSpVdOWz5yZY8PJLACRTDt4iW461ZV
060y0RHe3K2Nk0hrJBm1
=1tOk
-----END PGP SIGNATURE-----

--88WtkU1LLTCnVtqymV4L5N3etJWZl95ul--
