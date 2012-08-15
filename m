From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 3/4] s390/kvm: Add a channel I/O based virtio transport
 driver.
Date: Wed, 15 Aug 2012 09:48:44 +0200
Message-ID: <502B545C.8000904@de.ibm.com>
References: <1344351168-2568-1-git-send-email-cornelia.huck@de.ibm.com> <1344351168-2568-4-git-send-email-cornelia.huck@de.ibm.com> <87fw7ps0x4.fsf@codemonkey.ws> <878vdgr4v2.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <878vdgr4v2.fsf@rustcorp.com.au>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

>> Have you written an appendix for the virtio specification for
>> virtio-ccw?  I think it would be good to include in this series for the
>> purposes of review.
> 
> Might be nice, but don't get fancy about it.  Text will be fine and I
> can cut & paste it in once it's finalized.

There was a patch against the virtio spec in the patch series. Did it not
make it to you?

But Anthony is right, the spec is important, because the two main things 
that we need to get right are the 2 interfaces
guest<->host and userspace(qemu)<->kvm.
Everything else is not an ABI and can be fixed later on if necessary. 

Regarding the guest<->host interface a lot of things are mandated by the 
channel-IO architecture. We have also reserved some IDs for virtio 
(control unit type 0x3832, channel path type 0x32 and channel subsystem id 0xfe)
so we just have to focus on the virtio part (thanks Rusty for the good feedback
already).

Regarding the qemu<->kvm interface it is important to have an interface that
- allows us to be architectural compliant
- which is fast
- which must not prevent features like vhost
- which allows to implement live migration
- ...?

Christian
