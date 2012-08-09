From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] s390: Add new channel I/O based virtio
 transport.
Date: Thu, 9 Aug 2012 09:21:03 +0200
Message-ID: <20120809092103.4317b357@BR9GNB5Z>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-4-git-send-email-cornelia.huck@de.ibm.com>
	<CAAu8pHvt+17+EF=k7ZOx1bKpO=33PVXfBNQJWzNpYmqKkhR1ZQ@mail.gmail.com>
	<20120808102820.799d3d9a@BR9GNB5Z>
	<CAAu8pHsOiAgGGu8101CAm31goVMjO3d=1Oh1m4PAq6xTqhfpGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAAu8pHsOiAgGGu8101CAm31goVMjO3d=1Oh1m4PAq6xTqhfpGQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 Aug 2012 19:03:14 +0000
Blue Swirl <blauwirbel@gmail.com> wrote:


> >> > +struct vq_info_block {
> >> > +    uint64_t queue;
> >> > +    uint16_t num;
> >> > +} QEMU_PACKED;
> >> > +
> >> > +struct vq_config_block {
> >> > +    uint16_t index;
> >> > +    uint16_t num;
> >> > +} QEMU_PACKED;
> >>
> >> Aren't these KVM structures? They should be defined in a KVM header
> >> file file in linux-headers.
> >
> > Not really, virtio-ccw isn't tied to kvm.
> >
> > I see this more as command blocks that are specific to the "control
> > unit" - like something that would be defined in an attachment
> > specification for a classic s390 device (and in the virtio spec in this
> > case) and modeled as C structures here.
> 
> OK. Then please use CamelCase for these too.
> 

OK.
