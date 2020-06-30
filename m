Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgF3TKN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 15:10:13 -0400
Subject: Re: [RFC PATCH v3 0/3] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
References: <20200616195053.99253-1-farman@linux.ibm.com>
 <5ae6151b-31de-eca6-2917-4e23ecd4f0df@linux.ibm.com>
 <20200629165629.24f21585.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <02b20850-55cd-331a-8fb5-e9bec3386c2a@linux.ibm.com>
Date: Tue, 30 Jun 2020 15:10:01 -0400
MIME-Version: 1.0
In-Reply-To: <20200629165629.24f21585.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DZ377plPwm31pIgKpRukNuGMwGNiL2quw"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DZ377plPwm31pIgKpRukNuGMwGNiL2quw
Content-Type: multipart/mixed; boundary="dG7ZCo16tKZbI45eZdHNLXssd8jJzdNZy"

--dG7ZCo16tKZbI45eZdHNLXssd8jJzdNZy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 6/29/20 10:56 AM, Cornelia Huck wrote:
> On Wed, 17 Jun 2020 07:24:17 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
>=20
>> On 6/16/20 3:50 PM, Eric Farman wrote:
>>> Let's continue our discussion of the handling of vfio-ccw interrupts.=

>>>
>>> The initial fix [1] relied upon the interrupt path's examination of t=
he
>>> FSM state, and freeing all resources if it were CP_PENDING. But the
>>> interface used by HALT/CLEAR SUBCHANNEL doesn't affect the FSM state.=

>>> Consider this sequence:
>>>
>>>     CPU 1                           CPU 2
>>>     CLEAR (state=3DIDLE/no change)
>>>                                     START [2]
>>>     INTERRUPT (set state=3DIDLE)
>>>                                     INTERRUPT (set state=3DIDLE)
>>>
>>> This translates to a couple of possible scenarios:
>>>
>>>  A) The START gets a cc2 because of the outstanding CLEAR, -EBUSY is
>>>     returned, resources are freed, and state remains IDLE
>>>  B) The START gets a cc0 because the CLEAR has already presented an
>>>     interrupt, and state is set to CP_PENDING
>>>
>>> If the START gets a cc0 before the CLEAR INTERRUPT (stacked onto a
>>> workqueue by the IRQ context) gets a chance to run, then the INTERRUP=
T
>>> will release the channel program memory prematurely. If the two
>>> operations run concurrently, then the FSM state set to CP_PROCESSING
>>> will prevent the cp_free() from being invoked. But the io_mutex
>>> boundary on that path will pause itself until the START completes,
>>> and then allow the FSM to be reset to IDLE without considering the
>>> outstanding START. Neither scenario would be considered good.
>>>
>>> Having said all of that, in v2 Conny suggested [3] the following:
>>>  =20
>>>> - Detach the cp from the subchannel (or better, remove the 1:1
>>>>   relationship). By that I mean building the cp as a separately
>>>>   allocated structure (maybe embedding a kref, but that might not be=

>>>>   needed), and appending it to a list after SSCH with cc=3D0. Discar=
d it
>>>>   if cc!=3D0.
>>>> - Remove the CP_PENDING state. The state is either IDLE after any
>>>>   successful SSCH/HSCH/CSCH, or a new state in that case. But no
>>>>   special state for SSCH.
>>>> - A successful CSCH removes the first queued request, if any.
>>>> - A final interrupt removes the first queued request, if any. =20
>>>
>>> What I have implemented here is basically this, with a few changes:
>>>
>>>  - I don't queue cp's. Since there should only be one START in proces=
s
>>>    at a time, and HALT/CLEAR doesn't build a cp, I didn't see a press=
ing
>>>    need to introduce that complexity.
>>>  - Furthermore, while I initially made a separately allocated cp, add=
ing
>>>    an alloc for a cp on each I/O AND moving the guest_cp alloc from t=
he
>>>    probe path to the I/O path seems excessive. So I implemented a
>>>    "started" flag to the cp, set after a cc0 from the START, and exam=
ine
>>>    that on the interrupt path to determine whether cp_free() is neede=
d. =20
>>
>> FYI... After a day or two of running, I sprung a kernel debug oops for=

>> list corruption in ccwchain_free(). I'm going to blame this piece, sin=
ce
>> it was the last thing I changed and I hadn't come across any such dama=
ge
>> since v2. So either "started" is a bad idea, or a broken one. Or both.=
 :)
>=20
> Have you come to any conclusion wrt 'started'? Not wanting to generate
> stress, just asking :)
>=20

I've talked myself out of it, and gone back to your original proposal of
a separately allocated cp. (Still no queuing.) Too early to pass
judgement though.

Yesterday, when running with a cp_free() call after a CSCH, I was
getting all sorts of errors very early on, so at the moment I've pulled
that back out again. If it looks good in this form, I'll put that as a
separate patch and write up some doc for a discussion on that point.


--dG7ZCo16tKZbI45eZdHNLXssd8jJzdNZy--

--DZ377plPwm31pIgKpRukNuGMwGNiL2quw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJe+44SAAoJELljG2S8dU+pJ6IH/1bQKIXTrFJFkdtKcDbNA9LK
C91575EJj5ErIBSU93JCuwCg6OByfkdF0No7g4KgwBTcg3CXa9rIO2+LcxHK4vBu
Z97E35nL0ghSLFQDvAuptiuw+11eZjrwws9h97QzV1xiMOq1d2WLJGR/vfjkdlDU
EGwY5/gSMMlLkB26ib2w//gHqMEpJghujSMCczQ6zLxIBH0en8pAd6mLdjH1/vba
5dVlkxBefYOSF3a6vTH/vX32ryKhj5Eqm13ofxWlpVUixevlToXzkOjty2N3KNSX
01KLq2RcfOjqMRNsXU84vWY7gYnq+DNUiTBtRK7J6FIvf/BqpC88MVpIZeF1KLM=
=uLzm
-----END PGP SIGNATURE-----

--DZ377plPwm31pIgKpRukNuGMwGNiL2quw--
