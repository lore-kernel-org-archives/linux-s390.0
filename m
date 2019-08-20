Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTP3Q (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 11:29:16 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Diag288 test
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-3-frankja@linux.ibm.com>
 <6f25a51e-136e-1afb-215d-a2639fbd5510@redhat.com>
 <caf41bc6-6dcf-fa68-6b44-d8bcc1479acb@linux.ibm.com>
 <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>
 <56dad820-ea3c-27e0-c56c-7acc38632296@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f07aa0b4-5ac1-ab09-0989-352ee6681436@redhat.com>
Date: Tue, 20 Aug 2019 17:29:06 +0200
MIME-Version: 1.0
In-Reply-To: <56dad820-ea3c-27e0-c56c-7acc38632296@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z611oqS51spBhIIZNB9c5A6ps16KGaJhE"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z611oqS51spBhIIZNB9c5A6ps16KGaJhE
Content-Type: multipart/mixed; boundary="xKoALVO9E6hDsP41gbRBNNxuUCLMWjMdg";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <f07aa0b4-5ac1-ab09-0989-352ee6681436@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Diag288 test
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-3-frankja@linux.ibm.com>
 <6f25a51e-136e-1afb-215d-a2639fbd5510@redhat.com>
 <caf41bc6-6dcf-fa68-6b44-d8bcc1479acb@linux.ibm.com>
 <7e9f7043-14d9-8fc5-9302-cce8acdd5351@redhat.com>
 <56dad820-ea3c-27e0-c56c-7acc38632296@linux.ibm.com>
In-Reply-To: <56dad820-ea3c-27e0-c56c-7acc38632296@linux.ibm.com>

--xKoALVO9E6hDsP41gbRBNNxuUCLMWjMdg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 5:21 PM, Janosch Frank wrote:
> On 8/20/19 2:55 PM, Thomas Huth wrote:
>> On 8/20/19 2:25 PM, Janosch Frank wrote:
>>> On 8/20/19 1:59 PM, Thomas Huth wrote:
>>>> On 8/20/19 12:55 PM, Janosch Frank wrote:
> [...]
>>>> ... maybe we could also introduce such a variable as a global variab=
le
>>>> in lib/s390x/ since this is already the third or fourth time that we=
 use
>>>> it in the kvm-unit-tests...
>>>
>>> Sure I also thought about that, any particular place?
>>
>> No clue. Maybe lib/s390x/mmu.c ? Or a new file called lowcore.c ?
>>
>>>>> +static inline void diag288_uneven(void)
>>>>> +{
>>>>> +	register unsigned long fc asm("1") =3D 0;
>>>>> +	register unsigned long time asm("1") =3D 15;
>>>>
>>>> So you're setting register 1 twice? And "time" is not really used in=
 the
>>>> inline assembly below? How's that supposed to work? Looks like a bug=
 to
>>>> me... if not, please explain with a comment in the code here.
>>>
>>> Well I'm waiting for a spec exception here, so it doesn't have to wor=
k.> I'll probably just remove the register variables and do a:
>>>
>>> "diag %r1,%r2,0x288"
>>
>> Yes, I think that's easier to understand.
>>
>> BTW, is there another documentation of diag 288 beside the "CP
>> programming services" manual? At least my version of that specificatio=
n
>> does not say that the fc register has to be even...
>=20
> I used the non-public lpar documentation...

Ok, if it's specified there, then the check is fine with me.

>>>>> +static void test_bite(void)
>>>>> +{
>>>>> +	if (lc->restart_old_psw.addr) {
>>>>> +		report("restart", true);
>>>>> +		return;
>>>>> +	}
>>>>> +	lc->restart_new_psw.addr =3D (uint64_t)test_bite;
>>>>> +	diag288(CODE_INIT, 15, ACTION_RESTART);
>>>>> +	while(1) {};
>>>>
>>>> Should this maybe timeout after a minute or so?
>>>
>>> Well run_tests.sh does timeout externally.
>>> Do you need it backed into the test?
>>
>> I sometimes also run the tests without the wrapper script, so in that
>> case it would be convenient ... but I can also quit QEMU manually in
>> that case, so it's not a big issue.
>=20
> How about setting the clock comparator, that should trigger an
> unexpected external interrupt?

Sounds like an idea (if this is not getting too complicated... otherwise
just leave it as it is).

 Thomas



--xKoALVO9E6hDsP41gbRBNNxuUCLMWjMdg--

--z611oqS51spBhIIZNB9c5A6ps16KGaJhE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1cEcIACgkQLtnXdP5w
LbUSqA//avTRXV83gD2C7fHipO/1h+CwVDyWpTb3IROAgKSipiUOrlX3nvLNgps8
PLV4LW6TpqMkdvN9pgu56br66ylMoXuSaNkVmwj13EfRIzxxajz8RfTf6vDnkQV7
JJAJAnjRlcpdkiIjoEeETgfgmQ1HR06P1e5P2Y766GVQWuwYceBm0DWQh+wPjXIR
uMwOVzCle79Jdbhx1wiV/Ev7UEbt7e2WJlHuQtNaU62zxCIlcj+KXWenKIqKzM/d
SalDiPCq+62cX4IuTrQf9jbGeNeL1oNhUTKN5a6OQgXkToB94GSFkSP7S6oo/OHB
c6biVYSZ+M1Xv/9Wx8NoMcwoTg4QL/K7hxMoUIDBpir4Dn5cbIE85veAgJakmA8L
p9w3t5Gwnsye6C9a1QGxe1Y1vBXXSP3/yLt1CCUJrH6Tdy0J1EiOVorQ55Dlr37h
o6vwHI3bAZsINg8R77LiMWi3nNH4xi0InJxp2Ko1jAbufVLOR8Fi6mR9yttGa3Be
FCe5Xh8358gh7glQeIr3uo/C6z66hDPA6wa9pUSXWCtpjtKYkJl9jEkarC4kNIlG
OpqvWatl0XJ2rk5OqhD/Gt0p5SojhIZdcgucvau+dDgEkM2J/IIXJANIR+xkNJ4L
k0XK4LpiFzW2hdKnPML5MqY6SKZkbhHjxYR5sjTFo3+M2Nyc6lY=
=j4c8
-----END PGP SIGNATURE-----

--z611oqS51spBhIIZNB9c5A6ps16KGaJhE--
