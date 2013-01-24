From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] [PATCH 08/11] s390: Add new channel I/O based virtio
 transport.
Date: Thu, 24 Jan 2013 16:33:28 +0100
Message-ID: <51015448.2030506@suse.de>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com> <1359030491-46725-9-git-send-email-cornelia.huck@de.ibm.com> <51013492.9070703@suse.de> <20130124154244.0d898ef2@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130124154244.0d898ef2@gondolin>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Am 24.01.2013 15:42, schrieb Cornelia Huck:
> On Thu, 24 Jan 2013 14:18:10 +0100
> Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>=20
> Forgot one point :)
>=20
>>> +/* DeviceState to VirtioCcwData. Note: used on datapath,
>>> + * be careful and test performance if you change this.
>>> + */
>>> +static inline VirtioCcwData *to_virtio_ccw_data_fast(DeviceState *=
d)
>>> +{
>>> +    return container_of(d, VirtioCcwData, parent_obj);
>>> +}
>>> +
>>> +/* DeviceState to VirtioCcwData. TODO: use QOM. */
>>
>> Are the prerequisites to resolve this TODO not yet in qemu.git?
>=20
> This is copied verbatim from s390-virtio-bus/virtio-pci; my guess it
> that it will be resolved tree-wide.
>=20
>>
>>> +static inline VirtioCcwData *to_virtio_ccw_data(DeviceState *d)
>>> +{
>>> +    return container_of(d, VirtioCcwData, parent_obj);
>>> +}
>>> +

You did introduce VIRTIO_CCW_DEVICE(obj) though, no? Then you can drop
this function and use it instead. Can be a follow-up but it seems a
file-local issue to me.

Cheers,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=C3=
=BCrnberg
