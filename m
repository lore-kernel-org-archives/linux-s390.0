Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726473AbfKNQDa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 11:03:30 -0500
Date: Thu, 14 Nov 2019 17:03:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 17/37] DOCUMENTATION: protvirt: Instruction emulation
Message-ID: <20191114170313.3606d554.cohuck@redhat.com>
In-Reply-To: <b94125ec-256c-7d7b-929e-fdbabcacb142@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-18-frankja@linux.ibm.com>
        <20191114161526.1100f4fe.cohuck@redhat.com>
        <20191114162024.13f17aa9@p-imbrenda.boeblingen.de.ibm.com>
        <20191114164136.0be3f058.cohuck@redhat.com>
        <b94125ec-256c-7d7b-929e-fdbabcacb142@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7N204=Db5u+575pzVvjR10_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

--Sig_/7N204=Db5u+575pzVvjR10_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 16:55:46 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/14/19 4:41 PM, Cornelia Huck wrote:
> > On Thu, 14 Nov 2019 16:20:24 +0100
> > Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> >  =20
> >> On Thu, 14 Nov 2019 16:15:26 +0100
> >> Cornelia Huck <cohuck@redhat.com> wrote:
> >> =20
> >>> On Thu, 24 Oct 2019 07:40:39 -0400
> >>> Janosch Frank <frankja@linux.ibm.com> wrote:

> >>>> +The Secure Instruction Data Area contains instruction storage
> >>>> +data. Data for diag 500 is exempt from that and has to be moved
> >>>> +through shared buffers to KVM.     =20
> >>>
> >>> I find this paragraph a bit confusing. What does that imply for diag
> >>> 500 interception? Data is still present in gprs 1-4?   =20
> >>
> >> no registers are leaked in the registers. registers are always only
> >> exposed through the state description. =20
> >=20
> > So, what is so special about diag 500, then? =20
>=20
> That's mostly a confusion on my side.
> The SIDAD is 4k max, so we can only move IO "management" data over it
> like ORBs and stuff. My intention was to point out, that the data which
> is to be transferred (disk contents, etc.) can't go over the SIDAD but
> needs to be in a shared page.
>=20
> diag500 was mostly a notification mechanism without a lot of data, right?

Yes; the main information in there are the schid identifying the
subchannel, the virtqueue number, and a cookie value, all of which fit
into the registers.

So this goes via the sidad as well?

--Sig_/7N204=Db5u+575pzVvjR10_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3NesIACgkQ3s9rk8bw
L6992A//R5paNyASTYTl6I+duLvHrUaIGbDYOWp7fkUDxgSrF5yYNi4CxEgRmcOV
4fGfXW7pv5j3w9nUTPWEFBraTw/ROJLVoZZJ2Y4yS2Ssg7NBJI2L6Z1V1FqHencc
rEoV6isH/ZunVP4ulrJsmXwheQilH988Flok3etzZWhuglLUzmjSTDIknjmH//iX
0jv4JI/Hvwa61DXstSvGaaosGt57VpFPb0VQtA9gre8nj4s985Eydbh1qulSABjn
wVI54UG0VoMr4waTbPHXRMDDlKgjUQ/6snw4SYZnUQEzucaRfExJKAB4AOzivaO5
Q/HdxQXdJxqwTPXtGv/nXNu4zndYe7go0K0oLrNpAAN8RQGvk9kZk+RrkKJQvvhE
F2rU4894FZoFbbmvpQe7bNGzcICyt2dBMqVrk5V5JDAhk9/DkMKJ7wFH7/EpWRPv
OpvIF/YrEdWYaWOpgZwpT3905jF45u+2+KN/apcA7SH+tU0C0C3saNcJtzSGN4fw
thJObx6aa+V6txBUgLwWPjFo+AscyxDTlzu+IMv9PSk5dNeKFw4R0MTK0hLnwl8o
8kypQfjKh6/WNAx7xc9fM/oZEnv7Gy0bpVKLdVrZxaOerPjaRuMt4PgzeRQFTlBw
N087qidV+XBOeJGbJhaa00XTG3YmqofdO3/6yQVlUH21bhmrKcw=
=F00O
-----END PGP SIGNATURE-----

--Sig_/7N204=Db5u+575pzVvjR10_--
