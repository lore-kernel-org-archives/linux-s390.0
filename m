From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] s390: Add new channel I/O based
 virtio transport.
Date: Thu, 24 Jan 2013 15:42:44 +0100
Message-ID: <20130124154244.0d898ef2@gondolin>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
	<1359030491-46725-9-git-send-email-cornelia.huck@de.ibm.com>
	<51013492.9070703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51013492.9070703@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2013 14:18:10 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

=46orgot one point :)

> > +/* DeviceState to VirtioCcwData. Note: used on datapath,
> > + * be careful and test performance if you change this.
> > + */
> > +static inline VirtioCcwData *to_virtio_ccw_data_fast(DeviceState *=
d)
> > +{
> > +    return container_of(d, VirtioCcwData, parent_obj);
> > +}
> > +
> > +/* DeviceState to VirtioCcwData. TODO: use QOM. */
>=20
> Are the prerequisites to resolve this TODO not yet in qemu.git?

This is copied verbatim from s390-virtio-bus/virtio-pci; my guess it
that it will be resolved tree-wide.

>=20
> > +static inline VirtioCcwData *to_virtio_ccw_data(DeviceState *d)
> > +{
> > +    return container_of(d, VirtioCcwData, parent_obj);
> > +}
> > +
