Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35595 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389724AbfKEShp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 13:37:45 -0500
Date: Tue, 5 Nov 2019 19:37:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 12/37] KVM: s390: protvirt: Handle SE notification
 interceptions
Message-ID: <20191105193730.606c3c9c.cohuck@redhat.com>
In-Reply-To: <f0837f93-ace8-b4e0-f69c-c1fbe7b95c6a@de.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-13-frankja@linux.ibm.com>
        <20191105190407.68992d92.cohuck@redhat.com>
        <f0837f93-ace8-b4e0-f69c-c1fbe7b95c6a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Tue, 5 Nov 2019 19:15:19 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 05.11.19 19:04, Cornelia Huck wrote:
> > On Thu, 24 Oct 2019 07:40:34 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Since KVM doesn't emulate any form of load control and load psw
> >> instructions anymore, we wouldn't get an interception if PSWs or CRs
> >> are changed in the guest. That means we can't inject IRQs right after
> >> the guest is enabled for them.
> >>
> >> The new interception codes solve that problem by being a notification
> >> for changes to IRQ enablement relevant bits in CRs 0, 6 and 14, as
> >> well a the machine check mask bit in the PSW.
> >>
> >> No special handling is needed for these interception codes, the KVM
> >> pre-run code will consult all necessary CRs and PSW bits and inject
> >> IRQs the guest is enabled for. =20
> >=20
> > Just to clarify: The hypervisor can still access the relevant bits for
> > pv guests, this is only about the notification, right?
> >  =20
>=20
> Yes, the hypervisor (KVM) can always read the relevant PSW bits (I,E,M) a=
nd
> CR bits to decide if an interrupt can be delivered. All other bits of PSW
> and CRx are masked though.
> This is a new intercept for notification as we do no longer get an IC4 (i=
nstruction
> to handle) for load control and friends so that we can re-check the bits.=
=20

Ok, thanks!

> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  arch/s390/include/asm/kvm_host.h |  2 ++
> >>  arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
> >>  2 files changed, 20 insertions(+) =20
> >  =20
>=20
