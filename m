From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH v2] s390/virtio-ccw: Adapter interrupt support.
Date: Tue, 09 Jul 2013 15:27:14 +0200
Message-ID: <51DC0FB2.50308@de.ibm.com>
References: <1373369645-3184-1-git-send-email-cornelia.huck@de.ibm.com> <1373369645-3184-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1373369645-3184-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On 09/07/13 13:34, Cornelia Huck wrote:
> Handle the new CCW_CMD_SET_IND_ADAPTER command enabling adapter interrupts
> on guest request. When active, host->guest notifications will be handled
> via global_indicator -> queue indicators instead of queue indicators +
> subchannel I/O interrupt. Indicators for virtqueues may be present at an
> offset.
> 

You might want to add why we want adapter interrupts:
- no test subchannel -> less qemu mutex contention
- no test subchannel -> we can implement something like irqfd without moving
most of ccw device mgmt into the kernel
- interrupt coalescing
- the guest common I/O layer already supports adapter interrupts
for all newer hardware


the interesting part of this patch is the guest<->host interface. As far as I
can see, we are able to register 
- an isc per device
- an arbitrary summary indicator byte per device
- an arbitrary bit position in guest memory where the queue indicator bits of this
device start

This allows for packing the indicators for all virtqueues  of all devices or
spreading them in memory. The layout and amount of coalescing of bits is then 
an optimization that can be changed all the time without the need to change 
the interface.

> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
