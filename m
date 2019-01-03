From: Thomas Huth <thuth@redhat.com>
Date: Thu, 03 Jan 2019 14:37:54 +0000
Subject: Re: [kvm-unit-tests PATCH v4 13/13] lib/report: Add stamps to reports
Message-Id: <5353006d-6be9-9015-668d-94c9bef76f56@redhat.com>
In-Reply-To: <6af8b769-76f3-dbc2-e41a-50773894c75f@linux.ibm.com>
References: <6af8b769-76f3-dbc2-e41a-50773894c75f@linux.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--s9EEuCtBGI2cvmvPHtnRWkio8AfVoaJf1"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s9EEuCtBGI2cvmvPHtnRWkio8AfVoaJf1
Content-Type: multipart/mixed; boundary="fJ8LLWDFLLShEXhfJ2G4wRkahNf42krD7";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>
Message-ID: <5353006d-6be9-9015-668d-94c9bef76f56@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 13/13] lib/report: Add stamps to reports
References: <20190103100806.9039-1-frankja@linux.ibm.com>
 <20190103100806.9039-14-frankja@linux.ibm.com>
 <2a0edbd7-d0c8-4245-83fc-19b811bb9ed4@redhat.com>
 <6af8b769-76f3-dbc2-e41a-50773894c75f@linux.ibm.com>
In-Reply-To: <6af8b769-76f3-dbc2-e41a-50773894c75f@linux.ibm.com>

--fJ8LLWDFLLShEXhfJ2G4wRkahNf42krD7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-01-03 15:32, Janosch Frank wrote:
> On 03.01.19 14:55, Thomas Huth wrote:
>> On 2019-01-03 11:08, Janosch Frank wrote:
>>> Lets add a function to get stamps for our reports. It'll help with
>>> finding the test case that was causing problems in dumps.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  lib/libcflat.h |  1 +
>>>  lib/report.c   | 10 ++++++++++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/lib/libcflat.h b/lib/libcflat.h
>>> index 7529958..4d462f8 100644
>>> --- a/lib/libcflat.h
>>> +++ b/lib/libcflat.h
>>> @@ -98,6 +98,7 @@ extern int vsnprintf(char *buf, int size, const cha=
r *fmt, va_list va)
>>>  extern int vprintf(const char *fmt, va_list va)
>>>  					__attribute__((format(printf, 1, 0)));
>>> =20
>>> +extern void report_register_stamp(char * (*func)(void));
>>>  void report_prefix_pushf(const char *prefix_fmt, ...)
>>>  					__attribute__((format(printf, 1, 2)));
>>>  extern void report_prefix_push(const char *prefix);
>>> diff --git a/lib/report.c b/lib/report.c
>>> index ca9b4fd..586db63 100644
>>> --- a/lib/report.c
>>> +++ b/lib/report.c
>>> @@ -16,9 +16,17 @@
>>>  static unsigned int tests, failures, xfailures, skipped;
>>>  static char prefixes[256];
>>>  static struct spinlock lock;
>>> +static char * (*stamp_func)(void);
>>> =20
>>>  #define PREFIX_DELIMITER ": "
>>> =20
>>> +void report_register_stamp(char * (*func)(void))
>>> +{
>>> +	spin_lock(&lock);
>>> +	stamp_func =3D func;
>>> +	spin_unlock(&lock);
>>> +}
>>> +
>>>  void report_pass(void)
>>>  {
>>>  	spin_lock(&lock);
>>> @@ -90,6 +98,8 @@ static void va_report(const char *msg_fmt,
>>>  	spin_lock(&lock);
>>> =20
>>>  	tests++;
>>> +	if (stamp_func)
>>> +		printf("%s ", stamp_func());
>>>  	printf("%s: ", prefix);
>>>  	puts(prefixes);
>>>  	vprintf(msg_fmt, va);
>>>
>>
>> Looks fine to me, but I think you should rather defer this patch to th=
e
>> point in time when you also enable it for the s390x tests?
>>
>>  Thomas
>>
>=20
> This series came up because of some internal testing need which I can't=

> upstream right now. So internally I already had it enabled but mostly
> hard coded.
>=20
> If there's absolutely no upstream need I'll put it on my bench for latt=
er :)

Generally, it does not make much sense to include functions in upstream
if they are not used yet. E.g. if you later forget to send your
patch(es) that use it, we just have dead code in the upstream repository
that nobody uses.  So either also send your patch that adds this to the
s390x code, or please delay it to a later point in time.

 Thanks,
  Thomas


--fJ8LLWDFLLShEXhfJ2G4wRkahNf42krD7--

--s9EEuCtBGI2cvmvPHtnRWkio8AfVoaJf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcLh5GAAoJEC7Z13T+cC21E8QQAJ7R3XSQzk0/Z8gCx4uqobiE
Kox7b8aMVZoQuw6SyFzZ4gf+43Ly1WWWQhOo7b9xGdSI+Fpa4qx2Hb4VD0mo78jo
snBXQkVPPE5vf5KKaOfMrWXgwXpItlsZZs5odWKUPIIbaq73kqGR5ePiWMS0Noiw
jYbDrAwGu7NriJYIcuKWuFmE3yZTJ6HQV6EXFmlJKeqd+Nln3wpaPeBlrealAMys
l9iren95zjX/pAYOwsIYO8ptUUrHtv539/GHOeazID3aB1H2tEHeA7Rz6nwBKElG
++qmfiQMj8TlTBef+b10FDsyl1VQm5mSBtvWhBJ3jTX15IPR68/6mNo1n0QTSAvi
farJ0OJUlw0YY3Rwx1bDJZo7+WeO2G6uyLCGBHGfIiUHOcFFIjHPkk+egIEAZBTK
qBgyh8wQGzq2+RaysQWsaWNRri01GtUBKCytytMOZjGRlQbNumbsiXYsCO9rpcHM
troEiP0hUWAWBE7W5KlckDLOICQmtWcQWG54/J6vpPupH0ekESyc1XZYkdX/1hQi
plqpc0IVuzenCfXq2Pj5AoxTVy32vOU8j078drERmqJFkpLk2IIQ37ehhLmioGXk
CuE0Lk6BnCRAwOoz02WYw3WgJvrW/dUsfKqRAoD4m+femaDYAACWbDLUSPOzk/YH
8FtTDTi3VCrcJilNU5P7
=EpNJ
-----END PGP SIGNATURE-----

--s9EEuCtBGI2cvmvPHtnRWkio8AfVoaJf1--
