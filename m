Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfICI4p (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Sep 2019 04:56:45 -0400
Subject: Re: [kvm-unit-tests PATCH 6/6] s390x: SMP test
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-7-frankja@linux.ibm.com>
 <50b70561-f39d-6edc-600a-ccb707fe5b92@redhat.com>
 <03b3850b-ad7d-3b2c-957e-f236849d37b3@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5281efbb-d236-17b7-0ae2-c9d8302e14b0@redhat.com>
Date: Tue, 3 Sep 2019 10:56:34 +0200
MIME-Version: 1.0
In-Reply-To: <03b3850b-ad7d-3b2c-957e-f236849d37b3@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UOyCBDMZOfgwkr6L19nMhEPyZVXnBVnCu"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UOyCBDMZOfgwkr6L19nMhEPyZVXnBVnCu
Content-Type: multipart/mixed; boundary="xr0S2C29r069nSfoX3CbZt3tKGL1mrofX";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <5281efbb-d236-17b7-0ae2-c9d8302e14b0@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 6/6] s390x: SMP test
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-7-frankja@linux.ibm.com>
 <50b70561-f39d-6edc-600a-ccb707fe5b92@redhat.com>
 <03b3850b-ad7d-3b2c-957e-f236849d37b3@linux.ibm.com>
In-Reply-To: <03b3850b-ad7d-3b2c-957e-f236849d37b3@linux.ibm.com>

--xr0S2C29r069nSfoX3CbZt3tKGL1mrofX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/09/2019 10.44, Janosch Frank wrote:
> On 9/2/19 5:40 PM, Thomas Huth wrote:
>> On 29/08/2019 14.14, Janosch Frank wrote:
[...]
>>> +	smp_cpu_stop_store_status(1);
>>> +	mb();
>>> +	report("stop store status",
>>> +	       lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore);
>>
>> That confused me. Why does the prefix_sa of the lowcore of CPU 0 match=

>> the prefix of CPU 1 ? I'd rather expect cpu->lowcore->prefix_sa to
>> contain this value?
>=20
> Store status saves at absolute 0, i.e. we get the status in cpu0's lowc=
ore.

Ah, now that you mention it, the PoP indeed talks about "absolut"
locations here. TIL, thanks for the explanation!

 Thomas


--xr0S2C29r069nSfoX3CbZt3tKGL1mrofX--

--UOyCBDMZOfgwkr6L19nMhEPyZVXnBVnCu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1uKscACgkQLtnXdP5w
LbV1fw/+LHwrrm4CJeHP3+vC4hbfWxe/paS0rEoUWt9SsqN5WPfXJNuHnSy4wzwp
eNW/93YXrSbQHIltGX859BmMQBqxQBwg14LgZkhtqh9mgMi/NJcDK6O0Hl0H/XMC
/HfpF9cFv3OkqZ0V50OmiidnHV+K7p9mpD+dYsA/hsIMf/FLM+2kaTYGkV1jKW8V
c1ZHU+ZrNBTwUIizB6Po8M6uXvC0LidNy3Ly86LWIE2XpEai1vezpm8+atRKvQD6
gNdh7O0Mfi1dMqDw0vWv1xJRmzxNCEkmDBX4WVfqiigmnu0Co/Ke/jf6OLstmz2R
8O3btLmYKZpInReu5LQxBzZyXIdgfmIYRnp2jHEoXVyENtzB7LE+5FMPMs0NGkfZ
x7y+h+q4W4dmTwm6+SiE3MhD8Po/+iY3wcal7wroRaMlUqS7s1uxyVLca94iP5Kv
xQSzT3nylSU9rTyQzSYKmkHoRW3suEtXa3uezDEZyNiDv9mKsM3XnZCc72QYUEmf
Q3ZbYuYODOQ/VQFDC+LxQRyLGHgKqSHS9pKX5GJGm4wyMiaeGqX24YoabV+OUhm7
nRh9BEEl4rNaOsb0ySA7HabEnaJKQ6s9um4sA6eht+X2X7A0cU5bCVFv0SxgnQEA
YOIXE6OplrTZ4OETtr77fFRDNdNSqL/T+vOdA+ew9YePw+IW0X4=
=Akpx
-----END PGP SIGNATURE-----

--UOyCBDMZOfgwkr6L19nMhEPyZVXnBVnCu--
