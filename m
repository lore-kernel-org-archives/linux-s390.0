Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728012AbfKDO0Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:26:16 -0500
Date: Mon, 4 Nov 2019 15:26:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 02/37] s390/protvirt: introduce host side setup
Message-ID: <20191104152603.76f50c60.cohuck@redhat.com>
In-Reply-To: <41fb411d-68b5-96be-fc0e-c88570df9d19@de.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-3-frankja@linux.ibm.com>
        <41fb411d-68b5-96be-fc0e-c88570df9d19@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Fri, 1 Nov 2019 09:53:12 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 24.10.19 13:40, Janosch Frank wrote:
> > From: Vasily Gorbik <gor@linux.ibm.com>
> >=20
> > Introduce KVM_S390_PROTECTED_VIRTUALIZATION_HOST kbuild option for
> > protected virtual machines hosting support code.
> >=20
> > Add "prot_virt" command line option which controls if the kernel
> > protected VMs support is enabled at runtime.
> >=20
> > Extend ultravisor info definitions and expose it via uv_info struct
> > filled in during startup.
> >=20
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  5 ++
> >  arch/s390/boot/Makefile                       |  2 +-
> >  arch/s390/boot/uv.c                           | 20 +++++++-
> >  arch/s390/include/asm/uv.h                    | 46 ++++++++++++++++--
> >  arch/s390/kernel/Makefile                     |  1 +
> >  arch/s390/kernel/setup.c                      |  4 --
> >  arch/s390/kernel/uv.c                         | 48 +++++++++++++++++++
> >  arch/s390/kvm/Kconfig                         |  9 ++++
> >  8 files changed, 126 insertions(+), 9 deletions(-)
> >  create mode 100644 arch/s390/kernel/uv.c

(...)

> > diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> > index d3db3d7ed077..652b36f0efca 100644
> > --- a/arch/s390/kvm/Kconfig
> > +++ b/arch/s390/kvm/Kconfig
> > @@ -55,6 +55,15 @@ config KVM_S390_UCONTROL
> >=20
> >  =09  If unsure, say N.
> >=20
> > +config KVM_S390_PROTECTED_VIRTUALIZATION_HOST
> > +=09bool "Protected guests execution support"
> > +=09depends on KVM
> > +=09---help---
> > +=09  Support hosting protected virtual machines isolated from the
> > +=09  hypervisor.
> > +
> > +=09  If unsure, say Y.
> > +
> >  # OK, it's a little counter-intuitive to do this, but it puts it neatl=
y under
> >  # the virtualization menu.
> >  source "drivers/vhost/Kconfig"
> >  =20
>=20
> As we have the prot_virt kernel paramter there is a way to fence this dur=
ing runtime
> Not sure if we really need a build time fence. We could get rid of
> CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST and just use CONFIG_KVM ins=
tead,
> assuming that in the long run all distros will enable that anyway.=20

I still need to read through the rest of this patch set to have an
informed opinion on that, which will probably take some more time.

> If other reviewers prefer to keep that extra option what about the follow=
ing to the
> help section:
>=20
> ----
> Support hosting protected virtual machines in KVM. The state of these mac=
hines like
> memory content or register content is protected from the host or host adm=
inistrators.
>=20
> Enabling this option will enable extra code that talks to a new firmware =
instance

"...that allows the host kernel to talk..." ?

> called ultravisor that will take care of protecting the guest while also =
enabling
> KVM to run this guest.
>=20
> This feature must be enable by the kernel command line option prot_virt.

s/enable by/enabled via/

>=20
> =09  If unsure, say Y.

Looks better. I'm continuing to read the rest of this series before I
say more, though :)
