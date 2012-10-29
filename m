From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/5] KVM: s390: Add a channel I/O based virtio transport driver.
Date: Mon, 29 Oct 2012 19:37:10 +0100
Message-ID: <8466E164-8A30-431B-9103-D45F97331489@suse.de>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com> <1351516046-30037-5-git-send-email-cornelia.huck@de.ibm.com> <D3058F7E-EB72-4749-AD52-485A1777CE17@suse.de> <20121029193447.05dad97b@BR9GNB5Z>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20121029193447.05dad97b@BR9GNB5Z>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 29.10.2012, at 19:34, Cornelia Huck wrote:

> On Mon, 29 Oct 2012 19:12:54 +0100
> Alexander Graf <agraf@suse.de> wrote:
> 
>> 
>> On 29.10.2012, at 14:07, Cornelia Huck wrote:
> 
>>> +static void virtio_ccw_kvm_notify(struct virtqueue *vq)
>>> +{
>>> +	struct virtio_ccw_vq_info *info = vq->priv;
>>> +	struct virtio_ccw_device *vcdev;
>>> +	struct subchannel_id schid;
>>> +	__u32 reg2;
>>> +
>>> +	vcdev = to_vc_device(info->vq->vdev);
>>> +	ccw_device_get_schid(vcdev->cdev, &schid);
>>> +	reg2 = *(__u32 *)&schid;
>> 
>> That cast looks quite ugly. Can't you just access the field in there you need? Or if it's multiple fields do a union over them? Or assemble them by hand in C?
> 
> I think the cast looks less ugly than using a union to morph it around.
> I want the schid with all fields filled out anyway, since this is what
> identifies the subchannel.

How about a helper function that returns a u32 for a struct subchannel_id in arch/s390/include/asm/schid.h then?

> 
>> 
>>> +	kvm_hypercall2(3 /* CCW_NOTIFY */, reg2, info->queue_index);
>> 
>> This wants to be a #define :)
> 
> Probably :)
> 
>> 
>>> +}
>>> +
>>> +static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev, int index)
>>> +{
>>> +	vcdev->config_block->index = index;
>>> +	vcdev->ccw->cmd_code = CCW_CMD_READ_VQ_CONF;
>>> +	vcdev->ccw->flags = 0;
>>> +	vcdev->ccw->count = sizeof(struct vq_config_block);
>>> +	vcdev->ccw->cda = (__u32)(unsigned long)(vcdev->config_block);
>> 
>> Is this casting a pointer to a u32? What if this is in highmem? Ah, I just saw the comment that ccw memory needs to be <2GB. Phew. Any plans to get rid of that limitation?
> 
> Well, we could do full-blown IDAW handling to get to 64bit addresses -
> which would need a lot of extra code in the host. I doubt whether it
> would be worth it.
> 
> (Well, we'll probably want IDAWs sometime in the future - I just think
> it's overkill for those tiny snippets.)

Ah, so it is possible? Yes, we most likely want it in the future then! Lowmem is always more limited than when you have the full memory space available :).


Alex
