From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/5] KVM: s390: Add a channel I/O based virtio transport driver.
Date: Mon, 29 Oct 2012 19:12:54 +0100
Message-ID: <D3058F7E-EB72-4749-AD52-485A1777CE17@suse.de>
References: <1351516046-30037-1-git-send-email-cornelia.huck@de.ibm.com> <1351516046-30037-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1351516046-30037-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 29.10.2012, at 14:07, Cornelia Huck wrote:

> Add a driver for kvm guests that matches virtual ccw devices provided
> by the host as virtio bridge devices.
> 
> These virtio-ccw devices use a special set of channel commands in order
> to perform virtio functions.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> arch/s390/include/asm/irq.h   |   1 +
> arch/s390/kernel/irq.c        |   1 +
> drivers/s390/kvm/Makefile     |   2 +-
> drivers/s390/kvm/virtio_ccw.c | 842 ++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 845 insertions(+), 1 deletion(-)
> create mode 100644 drivers/s390/kvm/virtio_ccw.c
> 
> diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
> index 6703dd9..ad2ad6b 100644
> --- a/arch/s390/include/asm/irq.h
> +++ b/arch/s390/include/asm/irq.h
> @@ -33,6 +33,7 @@ enum interruption_class {
> 	IOINT_APB,
> 	IOINT_ADM,
> 	IOINT_CSC,
> +	IOINT_VIR,
> 	NMI_NMI,
> 	NR_IRQS,
> };
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index 6cdc55b..97c171a 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -58,6 +58,7 @@ static const struct irq_class intrclass_names[] = {
> 	[IOINT_APB]  = {.name = "APB", .desc = "[I/O] AP Bus"},
> 	[IOINT_ADM]  = {.name = "ADM", .desc = "[I/O] EADM Subchannel"},
> 	[IOINT_CSC]  = {.name = "CSC", .desc = "[I/O] CHSC Subchannel"},
> +	[IOINT_VIR]  = {.name = "VIR", .desc = "[I/O] Virtual I/O Devices"},
> 	[NMI_NMI]    = {.name = "NMI", .desc = "[NMI] Machine Check"},
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
> index 0000000..4be878f
> --- /dev/null
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -0,0 +1,842 @@
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
> +#include <asm/schid.h>
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
> +	struct ccw1 *ccw;
> +	__u32 area;
> +	__u32 curr_io;
> +	int err;
> +	wait_queue_head_t wait_q;
> +	spinlock_t lock;
> +	struct list_head virtqueues;
> +	unsigned long indicators;
> +	unsigned long indicators2;
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
> +#define CCW_CMD_SET_CONF_IND 0x53
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
> +#define VIRTIO_CCW_DOING_SET_CONF_IND 0x04000000
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
> +		ret = 0;
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
> +	ret = ccw_device_start(vcdev->cdev, vcdev->ccw, intparm, 0, 0);
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

That cast looks quite ugly. Can't you just access the field in there you need? Or if it's multiple fields do a union over them? Or assemble them by hand in C?

> +	kvm_hypercall2(3 /* CCW_NOTIFY */, reg2, info->queue_index);

This wants to be a #define :)

> +}
> +
> +static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev, int index)
> +{
> +	vcdev->config_block->index = index;
> +	vcdev->ccw->cmd_code = CCW_CMD_READ_VQ_CONF;
> +	vcdev->ccw->flags = 0;
> +	vcdev->ccw->count = sizeof(struct vq_config_block);
> +	vcdev->ccw->cda = (__u32)(unsigned long)(vcdev->config_block);

Is this casting a pointer to a u32? What if this is in highmem? Ah, I just saw the comment that ccw memory needs to be <2GB. Phew. Any plans to get rid of that limitation?


Alex
