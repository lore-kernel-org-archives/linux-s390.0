Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbfKUQCt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Nov 2019 11:02:49 -0500
Date: Thu, 21 Nov 2019 17:02:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
Message-ID: <20191121170237.72e0bd45.cohuck@redhat.com>
In-Reply-To: <802c298d-d2da-83c4-c222-67bb78131988@linux.ibm.com>
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
        <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
        <20191113140539.4d153d5f.cohuck@redhat.com>
        <802c298d-d2da-83c4-c222-67bb78131988@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 14 Nov 2019 11:11:18 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2019-11-13 14:05, Cornelia Huck wrote:
> > On Wed, 13 Nov 2019 13:23:19 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > =20
> >> This simple test test the I/O reading by the SUB Channel by:
> >> - initializing the Channel SubSystem with predefined CSSID:
> >>    0xfe000000 CSSID for a Virtual CCW =20
> > 0 should be fine with recent QEMU versions as well, I guess? =20
> Right
>=20
>=20
> > =20
> >>    0x00090000 SSID for CCW-PONG =20
> > subchannel id, or subchannel set id? =20
>=20
> hum, only part of, I had SSID (Subchannel Set ID) 4 (a.k.a m bit) + Bit=
=20
> 47=C2=A0 =3D1
>=20
> But as you said, I can use CSSID 0 and m =3D 0 which makes:
>=20
> Subsystem Identification word =3D 0x00010000

Yeah, I was mainly confused by the name 'SSID'.

> >> - initializing the ORB pointing to a single READ CCW =20
> > Out of curiosity: Would using a NOP also be an option? =20
>=20
> It will work but will not be handled by this device, css.c intercept it=
=20
> in sch_handle_start_func_virtual.
>=20
> AFAIU If we want to have a really good testing environment, for driver=20
> testing for exemple, then it would be interesting to add a new=20
> do_subchannel_work callback like do_subchannel_work_emulation along with=
=20
> the _virtual and _paththrough variantes.
>=20
> Having a dedicated callback for emulation, we can answer to any CSS=20
> instructions and SSCH commands, including NOP and TIC.

I guess that depends on what you want to test; if you actually want to
test device emulation as used by virtio etc., you obviously want to go
through the existing _virtual callback :)

The actual motivation behind my question was:
Is it possible to e.g. throw NOP (or TIC, or something else not
device-specific) at a normal, existing virtio device for test purposes?
You'd end up testing the common emulation code without needing any
extra support in QEMU. No idea how useful that would be.

>=20
> My goal here was to quickly develop a device answering to some basic=20
> READ/WRITE command to start memory transfers from inside a guest without=
=20
> Linux and without implementing VIRTIO in KVM tests.

Yes, if you want to do some simple memory transfers, virtio is probably
not the first choice. Would e.g. doing a SenseID or so actually be
useful in some way already? After all, it does transfer memory (but
only in one direction).

> >> +static inline int rsch(unsigned long schid) =20
> > I don't think anyone has tried rsch with QEMU before; sounds like a
> > good idea to test this :) =20
>=20
> With an do_subchannel_work_emulation() callback?

You probably need to build a simple channel program that suspends
itself and can be resumed later.
