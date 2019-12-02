Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbfLBIys (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 03:54:48 -0500
Date: Mon, 2 Dec 2019 09:54:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: Add new reset vcpu API
Message-ID: <20191202095426.76386507.cohuck@redhat.com>
In-Reply-To: <933de98c-2299-caf8-e237-011164273837@linux.ibm.com>
References: <20191129142122.21528-1-frankja@linux.ibm.com>
        <bc1d057f-03a0-b850-dff8-a7156bfe3274@redhat.com>
        <8e1aa1af-d929-e36b-f341-aa7dbe27f6a4@linux.ibm.com>
        <227a8fce-7e14-030e-b0a4-17e4521eed98@redhat.com>
        <dedd1d55-bebb-059e-c8c9-7c2771afa157@linux.ibm.com>
        <708d16c2-fa18-8ab9-afb5-44b5af638cb4@de.ibm.com>
        <487af903-bb8c-a7c5-b81d-dc0ce1bb7b75@redhat.com>
        <933de98c-2299-caf8-e237-011164273837@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ftyxjIK._SdiK3yGLzWuo1I";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, thuth@redhat.com, mihajlov@linux.ibm.com, linux-s390@vger.kernel.org

--Sig_/ftyxjIK._SdiK3yGLzWuo1I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Nov 2019 15:57:25 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/29/19 3:48 PM, David Hildenbrand wrote:
> > On 29.11.19 15:39, Christian Borntraeger wrote: =20
> >>
> >>
> >> On 29.11.19 15:38, Janosch Frank wrote:
> >> [...] =20
> >>>>>> As we now have two interfaces to achieve the same thing (initial r=
eset),
> >>>>>> I do wonder if we should simply introduce
> >>>>>>
> >>>>>> KVM_S390_NORMAL_RESET
> >>>>>> KVM_S390_CLEAR_RESET
> >>>>>>
> >>>>>> instead ...
> >>>>>>
> >>>>>> Then you can do KVM_S390_NORMAL_RESET for the bugfix and
> >>>>>> KVM_S390_CLEAR_RESET later for PV.
> >>>>>>
> >>>>>> Does anything speak against that? =20
> >>>>>
> >>>>> Apart from loosing one more ioctl number probably not =20
> >>>>
> >>>> Do we care? (I think not, but maybe I am missing something :) )
> >>>> =20
> >>>
> >>> I don't, maybe somebody else does
> >>> Btw. I'm struggling to find a good name for the capability:
> >>> KVM_CAP_S390_VCPU_ADDITIONAL_RESETS ? =20
> >>
> >> KVM_CAP_S390_VCPU_RESETS ? =20
> >=20
> > Either that or two separate ones if you're not going to introduce them
> > at the same time ...
> >  =20
>=20
> This is starting to get messy...

In order to reduce the mess, simply introduce them at the same time? I
might be missing something, but is there anything speaking against it,
as you can simply invoke the initial reset handler for clear reset for
now?

Also:
KVM_CAP_S390_ENHANCED_VCPU_RESETS, maybe?

--Sig_/ftyxjIK._SdiK3yGLzWuo1I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3k0UIACgkQ3s9rk8bw
L6/5KQ//a7AU3AS3/kInhoHvJWIZmZUMyNC9h2O//HSlS+2jRuyl/5tCW2j4CXCM
fN7PHF9xIoMa0IMqMJOFkJzyM0g1sQUXBQhHhZ7rpd8eoAjCiE2spmputIHD+4Ne
UYXL0bTCUEd6KVJ3d5Re6XPIQzWi3VJd+SYU7SAp6UTV5FzX3of/RMQmKs8WKPBh
4WE6ghlQorgDnjSelmXCGav93Db/PnvX8/Z+WXdjyBvJDdvtEz2gYthnWaOS9oUf
/kX+sZKaOoaaKpzYx019biQwivJLVpySAkEAMXyatoXgJBci0xXKobc3QaWD3Hv/
8FhnpdmhOG4eUNUa9hVDJA6XV2nMFMW70JxWekIqG366wuVA8FaNliH5k0toed12
UMrIiLjLnkvNwSW70Bd11BLiP09ZdgkVHwOfY5ezkZJgI2D8iK+BhNd5XGQFsWJh
bP2/s4/mLa0iLR8EAg2XQ90Ug4MvaXYM8ORykYwvjOAA/HVe5hrpoUMd74EmzSkl
Fao7V2OKLY3RjbN+joBcbbf5lmowOXdrbBkP1tpl37FIoLc0eOr/bIiBE2Oijbdm
kdy+5FUuHMQS72k/EhHsSNIwSl2s/UWs29sNDErNvmV3KoWaAL4+mnU0SeLbY52p
yIdOn3W/SUmdhUtx3nw4hUisvxNbzuh8zBy3tuAqLe3aq7cbGkU=
=OOa8
-----END PGP SIGNATURE-----

--Sig_/ftyxjIK._SdiK3yGLzWuo1I--
