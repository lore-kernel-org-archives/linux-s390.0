From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2 3/4] s390/kvm: Add a channel I/O based virtio transport driver.
Date: Wed, 19 Sep 2012 18:38:38 +0200
Message-ID: <04780C07-9F02-4148-B375-83C6025D6E45@suse.de>
References: <1346771622-52763-1-git-send-email-cornelia.huck@de.ibm.com> <1346771622-52763-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771622-52763-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 04.09.2012, at 17:13, Cornelia Huck wrote:

> Add a driver for kvm guests that matches virtual ccw devices provided
> by the host as virtio bridge devices.
> 
> These virtio-ccw devices use a special set of channel commands in order
> to perform virtio functions.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> 
> Changes v1->v2:
> - adapt to improved virtio-ccw channel commands
> - fix unregistration of online devices
> - add a missing spinlock initialization
> 
> ---
> arch/s390/include/asm/irq.h   |   1 +
> arch/s390/kernel/irq.c        |   1 +
> drivers/s390/kvm/Makefile     |   2 +-
> drivers/s390/kvm/virtio_ccw.c | 790 ++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 793 insertions(+), 1 deletion(-)
> create mode 100644 drivers/s390/kvm/virtio_ccw.c
> 
> diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
> index 2b9d418..b4bea53 100644
> --- a/arch/s390/include/asm/irq.h
> +++ b/arch/s390/include/asm/irq.h
> @@ -31,6 +31,7 @@ enum interruption_class {
> 	IOINT_CTC,
> 	IOINT_APB,
> 	IOINT_CSC,
> +	IOINT_VIR,
> 	NMI_NMI,
> 	NR_IRQS,
> };
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index dd7630d..2cc7eed 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -56,6 +56,7 @@ static const struct irq_class intrclass_names[] = {
> 	{.name = "CTC", .desc = "[I/O] CTC" },
> 	{.name = "APB", .desc = "[I/O] AP Bus" },
> 	{.name = "CSC", .desc = "[I/O] CHSC Subchannel" },
> +	{.name = "VIR", .desc = "[I/O] Virtual I/O Devices" },
> 	{.name = "NMI", .desc = "[NMI] Machine Check" },
> };
> 
> diff --git a/drivers/s390/kvm/Makefile b/drivers/s390/kvm/Makefile
> index 0815690..241891a 100644
> --- a/drivers/s390/kvm/Makefile
> +++ b/drivers/s390/kvm/Makefile
> @@ -6,4 +6,4 @@
> # it under the terms of the GNU General Public License (version 2 only)
> # as published by the Free Software Foundation.
> 
> -obj-$(CONFIG_S390_GUEST) += kvm_virtio.o
> +obj-$(CONFIG_S390_GUEST) += kvm_virtio.o virtio_ccw.o
> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> new file mode 100644
> index 0000000..1c9af22
> --- /dev/null
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -0,0 +1,790 @@
> +/*
> + * ccw based virtio transport
> + *
> + * Copyright IBM Corp. 2012
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License (version 2 only)
> + * as published by the Free Software Foundation.
> + *
> + *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> + */
> +
> +#include <linux/kernel_stat.h>
> +#include <linux/init.h>
> +#include <linux/bootmem.h>
> +#include <linux/err.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/slab.h>
> +#include <linux/virtio_console.h>
> +#include <linux/interrupt.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/pfn.h>
> +#include <linux/async.h>
> +#include <linux/wait.h>
> +#include <linux/list.h>
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <asm/io.h>
> +#include <asm/kvm_para.h>
> +#include <asm/setup.h>
> +#include <asm/irq.h>
> +#include <asm/cio.h>
> +#include <asm/ccwdev.h>
> +
> +/*
> + * virtio related functions
> + */
> +
> +struct vq_config_block {
> +	__u16 index;
> +	__u16 num;
> +} __attribute__ ((packed));
> +
> +#define VIRTIO_CCW_CONFIG_SIZE 0x100
> +/* same as PCI config space size, should be enough for all drivers */
> +
> +struct virtio_ccw_device {
> +	struct virtio_device vdev;
> +	__u8 status;
> +	__u8 config[VIRTIO_CCW_CONFIG_SIZE];
> +	struct ccw_device *cdev;
> +	struct ccw1 ccw;
> +	__u32 area;
> +	__u32 curr_io;
> +	int err;
> +	wait_queue_head_t wait_q;
> +	spinlock_t lock;
> +	struct list_head virtqueues;
> +	unsigned long indicators; /* XXX - works because we're under 64 bit */
> +	struct vq_config_block *config_block;
> +};
> +
> +struct vq_info_block {
> +	__u64 queue;
> +	__u32 align;
> +	__u16 index;
> +	__u16 num;
> +} __attribute__ ((packed));
> +
> +struct virtio_feature_desc {
> +	__u32 features;
> +	__u8 index;
> +} __attribute__ ((packed));
> +
> +struct virtio_ccw_vq_info {
> +	struct virtqueue *vq;
> +	int num;
> +	int queue_index;
> +	void *queue;
> +	struct vq_info_block *info_block;
> +	struct list_head node;
> +};
> +
> +#define KVM_VIRTIO_CCW_RING_ALIGN 4096
> +
> +#define CCW_CMD_SET_VQ 0x13
> +#define CCW_CMD_VDEV_RESET 0x33
> +#define CCW_CMD_SET_IND 0x43
> +#define CCW_CMD_READ_FEAT 0x12
> +#define CCW_CMD_WRITE_FEAT 0x11
> +#define CCW_CMD_READ_CONF 0x22
> +#define CCW_CMD_WRITE_CONF 0x21
> +#define CCW_CMD_WRITE_STATUS 0x31
> +#define CCW_CMD_READ_VQ_CONF 0x32
> +
> +#define VIRTIO_CCW_DOING_SET_VQ 0x00010000
> +#define VIRTIO_CCW_DOING_RESET 0x00040000
> +#define VIRTIO_CCW_DOING_READ_FEAT 0x00080000
> +#define VIRTIO_CCW_DOING_WRITE_FEAT 0x00100000
> +#define VIRTIO_CCW_DOING_READ_CONFIG 0x00200000
> +#define VIRTIO_CCW_DOING_WRITE_CONFIG 0x00400000
> +#define VIRTIO_CCW_DOING_WRITE_STATUS 0x00800000
> +#define VIRTIO_CCW_DOING_SET_IND 0x01000000
> +#define VIRTIO_CCW_DOING_READ_VQ_CONF 0x02000000
> +#define VIRTIO_CCW_INTPARM_MASK 0xffff0000
> +
> +static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
> +{
> +	return container_of(vdev, struct virtio_ccw_device, vdev);
> +}
> +
> +static int doing_io(struct virtio_ccw_device *vcdev, __u32 flag)
> +{
> +	unsigned long flags;
> +	__u32 ret;
> +
> +	spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
> +	if (vcdev->err)
> +		ret = vcdev->err;
> +	else
> +		ret = vcdev->curr_io & flag;
> +	spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
> +	return ret;
> +}
> +
> +static int ccw_io_helper(struct virtio_ccw_device *vcdev, __u32 intparm)
> +{
> +	int ret;
> +	unsigned long flags;
> +	int flag = intparm & VIRTIO_CCW_INTPARM_MASK;
> +
> +	spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
> +	ret = ccw_device_start(vcdev->cdev, &vcdev->ccw, intparm, 0, 0);
> +	if (!ret)
> +		vcdev->curr_io |= flag;
> +	spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
> +	wait_event(vcdev->wait_q, doing_io(vcdev, flag) == 0);
> +	return ret ? ret : vcdev->err;
> +}
> +
> +static void virtio_ccw_kvm_notify(struct virtqueue *vq)
> +{
> +	struct virtio_ccw_vq_info *info = vq->priv;
> +	struct virtio_ccw_device *vcdev;
> +	struct subchannel_id schid;
> +	__u32 reg2;
> +
> +	vcdev = to_vc_device(info->vq->vdev);
> +	ccw_device_get_schid(vcdev->cdev, &schid);
> +	reg2 = *(__u32 *)&schid;
> +	kvm_hypercall2(3 /* CCW_NOTIFY */, reg2, info->queue_index);
> +}
> +
> +static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev, int index)
> +{
> +	vcdev->config_block->index = index;
> +	vcdev->ccw.cmd_code = CCW_CMD_READ_VQ_CONF;
> +	vcdev->ccw.flags = 0;
> +	vcdev->ccw.count = sizeof(struct vq_config_block);
> +	vcdev->ccw.cda = (__u32)(unsigned long)(vcdev->config_block);
> +	ccw_io_helper(vcdev, VIRTIO_CCW_DOING_READ_VQ_CONF);
> +	return vcdev->config_block->num;
> +}
> +
> +static void virtio_ccw_del_vq(struct virtqueue *vq)
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vq->vdev);
> +	struct virtio_ccw_vq_info *info = vq->priv;
> +	unsigned long flags;
> +	unsigned long size;
> +	int ret;
> +
> +	/* Remove from our list. */
> +	spin_lock_irqsave(&vcdev->lock, flags);
> +	list_del(&info->node);
> +	spin_unlock_irqrestore(&vcdev->lock, flags);
> +
> +	/* Release from host. */
> +	info->info_block->queue = 0;
> +	info->info_block->align = 0;
> +	info->info_block->index = info->queue_index;
> +	info->info_block->num = 0;
> +	vcdev->ccw.cmd_code = CCW_CMD_SET_VQ;
> +	vcdev->ccw.flags = 0;
> +	vcdev->ccw.count = sizeof(*info->info_block);
> +	vcdev->ccw.cda = (__u32)(unsigned long)(info->info_block);
> +	ret = ccw_io_helper(vcdev, VIRTIO_CCW_DOING_SET_VQ | info->queue_index);
> +	if (ret)
> +		dev_warn(&vq->vdev->dev, "Error %x while deleting queue %d",
> +			 ret, info->queue_index);
> +
> +	vring_del_virtqueue(vq);
> +	size = PAGE_ALIGN(vring_size(info->num, KVM_VIRTIO_CCW_RING_ALIGN));
> +	free_pages_exact(info->queue, size);
> +	kfree(info->info_block);
> +	kfree(info);
> +}
> +
> +static void virtio_ccw_del_vqs(struct virtio_device *vdev)
> +{
> +	struct virtqueue *vq, *n;
> +
> +	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
> +		virtio_ccw_del_vq(vq);
> +}
> +
> +static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
> +					     int i, vq_callback_t *callback,
> +					     const char *name)
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	int err;
> +	struct virtqueue *vq;
> +	struct virtio_ccw_vq_info *info;
> +	unsigned long size;
> +	unsigned long flags;
> +
> +	/* Allocate queue. */
> +	info = kzalloc(sizeof(struct virtio_ccw_vq_info), GFP_KERNEL);
> +	if (!info) {
> +		dev_warn(&vcdev->cdev->dev, "no info\n");
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +	info->info_block = kzalloc(sizeof(*info->info_block),
> +				   GFP_DMA | GFP_KERNEL);
> +	if (!info->info_block) {
> +		dev_warn(&vcdev->cdev->dev, "no info block\n");
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +	info->queue_index = i;
> +	info->num = virtio_ccw_read_vq_conf(vcdev, i);
> +	size = PAGE_ALIGN(vring_size(info->num, KVM_VIRTIO_CCW_RING_ALIGN));
> +	info->queue = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> +	if (info->queue == NULL) {
> +		dev_warn(&vcdev->cdev->dev, "no queue\n");
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +	vq = vring_new_virtqueue(info->num, KVM_VIRTIO_CCW_RING_ALIGN, vdev,
> +				 true, info->queue, virtio_ccw_kvm_notify,
> +				 callback, name);
> +	if (!vq) {
> +		/* For now, we fail if we can't get the requested size. */
> +		dev_warn(&vcdev->cdev->dev, "no vq\n");
> +		err = -ENOMEM;
> +		free_pages_exact(info->queue, size);
> +		goto out_err;
> +	}
> +	info->vq = vq;
> +	vq->priv = info;
> +
> +	/* Register it with the host. */
> +	info->info_block->queue = (__u64)info->queue;
> +	info->info_block->align = KVM_VIRTIO_CCW_RING_ALIGN;
> +	info->info_block->index = info->queue_index;
> +	info->info_block->num = info->num;
> +	vcdev->ccw.cmd_code = CCW_CMD_SET_VQ;
> +	vcdev->ccw.flags = 0;
> +	vcdev->ccw.count = sizeof(*info->info_block);
> +	vcdev->ccw.cda = (__u32)(unsigned long)(info->info_block);
> +	err = ccw_io_helper(vcdev, VIRTIO_CCW_DOING_SET_VQ | info->queue_index);
> +	if (err) {
> +		dev_warn(&vcdev->cdev->dev, "SET_VQ failed\n");
> +		free_pages_exact(info->queue, size);
> +		info->vq = NULL;
> +		vq->priv = NULL;
> +		goto out_err;
> +	}
> +
> +	/* Save it to our list. */
> +	spin_lock_irqsave(&vcdev->lock, flags);
> +	list_add(&info->node, &vcdev->virtqueues);
> +	spin_unlock_irqrestore(&vcdev->lock, flags);
> +
> +	return vq;
> +
> +out_err:
> +	if (info)
> +		kfree(info->info_block);
> +	kfree(info);
> +	return ERR_PTR(err);
> +}
> +
> +static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> +			       struct virtqueue *vqs[],
> +			       vq_callback_t *callbacks[],
> +			       const char *names[])
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	int ret, i;
> +
> +	for (i = 0; i < nvqs; ++i) {
> +		vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i], names[i]);
> +		if (IS_ERR(vqs[i])) {
> +			ret = PTR_ERR(vqs[i]);
> +			vqs[i] = NULL;
> +			goto out;
> +		}
> +	}
> +	/* Register queue indicators with host. */
> +	vcdev->indicators = 0;
> +	vcdev->ccw.cmd_code = CCW_CMD_SET_IND;
> +	vcdev->ccw.flags = 0;
> +	vcdev->ccw.count = sizeof(vcdev->indicators);
> +	vcdev->ccw.cda = (__u32)(unsigned long)(&vcdev->indicators);
> +	ret = ccw_io_helper(vcdev, VIRTIO_CCW_DOING_SET_IND);
> +	if (ret)
> +		goto out;
> +	return 0;
> +out:
> +	virtio_ccw_del_vqs(vdev);
> +	return ret;
> +}
> +
> +static void virtio_ccw_reset(struct virtio_device *vdev)
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +
> +	/* Send a reset ccw on device. */
> +	vcdev->ccw.cmd_code = CCW_CMD_VDEV_RESET;
> +	vcdev->ccw.flags = 0;
> +	vcdev->ccw.count = 0;
> +	vcdev->ccw.cda = 0;
> +	ccw_io_helper(vcdev, VIRTIO_CCW_DOING_RESET);
> +}
> +
> +static u32 virtio_ccw_get_features(struct virtio_device *vdev)
> +{
> +	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> +	struct virtio_feature_desc features;
> +	int ret;
> +
> +	/* Read the feature bits from the host. */
> +	/* TODO: Features > 32 bits */
> +	features.index = 0;
> +	vcdev->ccw.cmd_code = CCW_CMD_READ_FEAT;
> +	vcdev->ccw.flags = 0;
> +	vcdev->ccw.count = sizeof(features);
> +	vcdev->ccw.cda = vcdev->area;
> +	ret = ccw_io_helper(vcdev, VIRTIO_CCW_DOING_READ_FEAT);
> +	if (ret)
> +		return 0;
> +
> +	memcpy(&features, (void *)(unsigned long)vcdev->area,
> +	       sizeof(features));
> +	return le32_to_cpu(features.features);

The fact that the features are LE is missing from the spec, right?


Alex
