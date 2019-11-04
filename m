Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbfKDRR5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 12:17:57 -0500
Date: Mon, 4 Nov 2019 18:17:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
Message-ID: <20191104181743.3792924a.cohuck@redhat.com>
In-Reply-To: <8a68fcbb-1dea-414f-7d48-e4647f7985fe@redhat.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-10-frankja@linux.ibm.com>
        <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
        <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
        <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
        <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
        <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
        <69ddb6a7-8f69-fbc4-63a4-4f5695117078@de.ibm.com>
        <1fad0466-1eeb-7d24-8015-98af9b564f74@redhat.com>
        <8a68fcbb-1dea-414f-7d48-e4647f7985fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Mon, 4 Nov 2019 15:42:11 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.11.19 15:08, David Hildenbrand wrote:
> > On 04.11.19 14:58, Christian Borntraeger wrote: =20
> >>
> >>
> >> On 04.11.19 11:19, David Hildenbrand wrote: =20
> >>>>>> to synchronize page import/export with the I/O for paging. For exa=
mple you can actually
> >>>>>> fault in a page that is currently under paging I/O. What do you do=
? import (so that the
> >>>>>> guest can run) or export (so that the I/O will work). As this turn=
ed out to be harder then
> >>>>>> we though we decided to defer paging to a later point in time. =20
> >>>>>
> >>>>> I don't quite see the issue yet. If you page out, the page will
> >>>>> automatically (on access) be converted to !secure/encrypted memory.=
 If
> >>>>> the UV/guest wants to access it, it will be automatically converted=
 to
> >>>>> secure/unencrypted memory. If you have concurrent access, it will b=
e
> >>>>> converted back and forth until one party is done. =20
> >>>>
> >>>> IO does not trigger an export on an imported page, but an error
> >>>> condition in the IO subsystem. The page code does not read pages thr=
ough =20
> >>>
> >>> Ah, that makes it much clearer. Thanks!
> >>> =20
> >>>> the cpu, but often just asks the device to read directly and that's
> >>>> where everything goes wrong. We could bounce swapping, but chose to =
pin
> >>>> for now until we find a proper solution to that problem which nicely
> >>>> integrates into linux. =20
> >>>
> >>> How hard would it be to
> >>>
> >>> 1. Detect the error condition
> >>> 2. Try a read on the affected page from the CPU (will will automatica=
lly convert to encrypted/!secure)
> >>> 3. Restart the I/O
> >>>
> >>> I assume that this is a corner case where we don't really have to car=
e about performance in the first shot. =20
> >>
> >> We have looked into this. You would need to implement this in the low =
level
> >> handler for every I/O. DASD, FCP, PCI based NVME, iscsi. Where do you =
want
> >> to stop? =20
> >=20
> > If that's the real fix, we should do that. Maybe one can focus on the
> > real use cases first. But I am no I/O expert, so my judgment might be
> > completely wrong.
> >  =20
>=20
> Oh, and by the way, as discussed you really only have to care about=20
> accesses via "real" I/O devices (IOW, not via the CPU). When accessing=20
> via the CPU, you should have automatic conversion back and forth. As I=20
> am no expert on I/O, I have no idea how iscsi fits into this picture=20
> here (especially on s390x).
>=20

By "real" I/O devices, you mean things like channel devices, right? (So
everything where you basically hand off control to a different kind of
processor.)

For classic channel I/O (as used by dasd), I'd expect something like
getting a check condition on a ccw if the CU or device cannot access
the memory. You will know how far the channel program has progressed,
and might be able to restart (from the beginning or from that point).
Probably has a chance of working for a subset of channel programs.

For QDIO (as used by FCP), I have no idea how this is could work, as we
have long-running channel programs there and any error basically kills
the queues, which you would have to re-setup from the beginning.

For PCI devices, I have no idea how the instructions even act.

From my point of view, that error/restart approach looks nice on paper,
but it seems hard to make it work in the general case (and I'm unsure
if it's possible at all.)
