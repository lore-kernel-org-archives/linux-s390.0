Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:32681
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390289AbfIWW2m (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 18:28:42 -0400
From: Parav Pandit <parav@mellanox.com>
Subject: RE: [PATCH 4/6] virtio: introduce a mdev based transport
Date: Mon, 23 Sep 2019 22:28:30 +0000
Message-ID: <AM0PR05MB4866178BECC3C96DA7046590D1850@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190923130331.29324-1-jasowang@redhat.com>
 <20190923130331.29324-5-jasowang@redhat.com>
In-Reply-To: <20190923130331.29324-5-jasowang@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "cunming.liang@intel.com" <cunming.liang@intel.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>, "freude@linux.ibm.com" <freude@linux.ibm.com>, "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>, Ido Shamay <idos@mellanox.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>



> -----Original Message-----
> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, September 23, 2019 8:03 AM
> To: kvm@vger.kernel.org; linux-s390@vger.kernel.org; linux-
> kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; intel-
> gfx@lists.freedesktop.org; intel-gvt-dev@lists.freedesktop.org;
> kwankhede@nvidia.com; alex.williamson@redhat.com; mst@redhat.com;
> tiwei.bie@intel.com
> Cc: virtualization@lists.linux-foundation.org; netdev@vger.kernel.org;
> cohuck@redhat.com; maxime.coquelin@redhat.com;
> cunming.liang@intel.com; zhihong.wang@intel.com;
> rob.miller@broadcom.com; xiao.w.wang@intel.com;
> haotian.wang@sifive.com; zhenyuw@linux.intel.com; zhi.a.wang@intel.com;
> jani.nikula@linux.intel.com; joonas.lahtinen@linux.intel.com;
> rodrigo.vivi@intel.com; airlied@linux.ie; daniel@ffwll.ch;
> farman@linux.ibm.com; pasic@linux.ibm.com; sebott@linux.ibm.com;
> oberpar@linux.ibm.com; heiko.carstens@de.ibm.com; gor@linux.ibm.com;
> borntraeger@de.ibm.com; akrowiak@linux.ibm.com; freude@linux.ibm.com;
> lingshan.zhu@intel.com; Ido Shamay <idos@mellanox.com>;
> eperezma@redhat.com; lulu@redhat.com; Parav Pandit
> <parav@mellanox.com>; Jason Wang <jasowang@redhat.com>
> Subject: [PATCH 4/6] virtio: introduce a mdev based transport
>=20
> This patch introduces a new mdev transport for virtio. This is used to us=
e kernel
> virtio driver to drive the mediated device that is capable of populating
> virtqueue directly.
>=20
> A new virtio-mdev driver will be registered to the mdev bus, when a new v=
irtio-
> mdev device is probed, it will register the device with mdev based config=
 ops.
> This means it is a software transport between mdev driver and mdev device=
.
> The transport was implemented through device specific opswhich is a part =
of
> mdev_parent_ops now.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/vfio/mdev/Kconfig       |   7 +
>  drivers/vfio/mdev/Makefile      |   1 +
>  drivers/vfio/mdev/virtio_mdev.c | 416 ++++++++++++++++++++++++++++++++
>  4 files changed, 425 insertions(+)
>  create mode 100644 drivers/vfio/mdev/virtio_mdev.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89832b316500..820ec250cc52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17202,6 +17202,7 @@ F:	include/linux/virtio*.h
>  F:	include/uapi/linux/virtio_*.h
>  F:	drivers/crypto/virtio/
>  F:	mm/balloon_compaction.c
> +F:	drivers/vfio/mdev/virtio_mdev.c
>=20
>  VIRTIO BLOCK AND SCSI DRIVERS
>  M:	"Michael S. Tsirkin" <mst@redhat.com>
> diff --git a/drivers/vfio/mdev/Kconfig b/drivers/vfio/mdev/Kconfig index
> 5da27f2100f9..c488c31fc137 100644
> --- a/drivers/vfio/mdev/Kconfig
> +++ b/drivers/vfio/mdev/Kconfig
> @@ -16,3 +16,10 @@ config VFIO_MDEV_DEVICE
>  	default n
>  	help
>  	  VFIO based driver for Mediated devices.
> +
> +config VIRTIO_MDEV_DEVICE
> +	tristate "VIRTIO driver for Mediated devices"
> +	depends on VFIO_MDEV && VIRTIO
> +	default n
> +	help
> +	  VIRTIO based driver for Mediated devices.
> diff --git a/drivers/vfio/mdev/Makefile b/drivers/vfio/mdev/Makefile inde=
x
> 101516fdf375..99d31e29c23e 100644
> --- a/drivers/vfio/mdev/Makefile
> +++ b/drivers/vfio/mdev/Makefile
> @@ -4,3 +4,4 @@ mdev-y :=3D mdev_core.o mdev_sysfs.o mdev_driver.o
>=20
>  obj-$(CONFIG_VFIO_MDEV) +=3D mdev.o
>  obj-$(CONFIG_VFIO_MDEV_DEVICE) +=3D vfio_mdev.o
> +obj-$(CONFIG_VIRTIO_MDEV_DEVICE) +=3D virtio_mdev.o
> diff --git a/drivers/vfio/mdev/virtio_mdev.c b/drivers/vfio/mdev/virtio_m=
dev.c
> new file mode 100644 index 000000000000..919a082adc9c
> --- /dev/null
> +++ b/drivers/vfio/mdev/virtio_mdev.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VIRTIO based driver for Mediated device
> + *
> + * Copyright (c) 2019, Red Hat. All rights reserved.
> + *     Author: Jason Wang <jasowang@redhat.com>
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/uuid.h>
> +#include <linux/mdev.h>
> +#include <linux/virtio_mdev.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
> +#include "mdev_private.h"
> +
> +#define DRIVER_VERSION  "0.1"
> +#define DRIVER_AUTHOR   "Red Hat Corporation"
> +#define DRIVER_DESC     "VIRTIO based driver for Mediated device"
> +
> +#define to_virtio_mdev_device(dev) \
> +	container_of(dev, struct virtio_mdev_device, vdev)
> +
> +struct virtio_mdev_device {
> +	struct virtio_device vdev;
> +	struct mdev_device *mdev;
> +	unsigned long version;
> +
> +	struct virtqueue **vqs;
Every lock must need a comment to describe what it locks.
I don't see this lock is used in this patch. Please introduce in the patch =
that uses it.
> +	spinlock_t lock;
> +};
> +
> +struct virtio_mdev_vq_info {
> +	/* the actual virtqueue */
> +	struct virtqueue *vq;
> +
> +	/* the list node for the virtqueues list */
> +	struct list_head node;
> +};
> +
> +static struct mdev_device *vm_get_mdev(struct virtio_device *vdev) {
> +	struct virtio_mdev_device *vm_dev =3D to_virtio_mdev_device(vdev);
> +	struct mdev_device *mdev =3D vm_dev->mdev;
> +
> +	return mdev;
> +}
> +
> +static const struct virtio_mdev_parent_ops *mdev_get_parent_ops(struct
> +mdev_device *mdev) {
> +	struct mdev_parent *parent =3D mdev->parent;
> +
> +	return parent->ops->device_ops;
> +}
> +
> +static void virtio_mdev_get(struct virtio_device *vdev, unsigned offset,
> +			    void *buf, unsigned len)
> +{
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	ops->get_config(mdev, offset, buf, len); }
> +
> +static void virtio_mdev_set(struct virtio_device *vdev, unsigned offset,
> +			    const void *buf, unsigned len)
> +{
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	ops->set_config(mdev, offset, buf, len); }
> +
> +static u32 virtio_mdev_generation(struct virtio_device *vdev) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	return ops->get_generation(mdev);
> +}
> +
> +static u8 virtio_mdev_get_status(struct virtio_device *vdev) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	return ops->get_status(mdev);
> +}
> +
> +static void virtio_mdev_set_status(struct virtio_device *vdev, u8
> +status) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	return ops->set_status(mdev, status);
> +}
> +
> +static void virtio_mdev_reset(struct virtio_device *vdev) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	return ops->set_status(mdev, 0);
> +}
> +
> +static bool virtio_mdev_notify(struct virtqueue *vq) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vq->vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	ops->kick_vq(mdev, vq->index);
> +
> +	return true;
> +}
> +
> +static irqreturn_t virtio_mdev_config_cb(void *private) {
> +	struct virtio_mdev_device *vm_dev =3D private;
> +
> +	virtio_config_changed(&vm_dev->vdev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t virtio_mdev_virtqueue_cb(void *private) {
> +	struct virtio_mdev_vq_info *info =3D private;
> +
> +	return vring_interrupt(0, info->vq);
> +}
> +
> +static struct virtqueue *
> +virtio_mdev_setup_vq(struct virtio_device *vdev, unsigned index,
> +		     void (*callback)(struct virtqueue *vq),
> +		     const char *name, bool ctx)
> +{
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +	struct virtio_mdev_vq_info *info;
> +	struct virtio_mdev_callback cb;
> +	struct virtqueue *vq;
> +	u32 align, num;
> +	u64 desc_addr, driver_addr, device_addr;
> +	int err;
> +
> +	if (!name)
> +		return NULL;
> +
> +	/* Queue shouldn't already be set up. */
> +	if (ops->get_vq_ready(mdev, index)) {
> +		err =3D -ENOENT;
> +		goto error_available;
> +	}
> +
No need for a goto, to single return done later.
Just do=20
	if (ops->get_vq_ready(mdev, index))
		return -ENOENT;

> +	/* Allocate and fill out our active queue description */
> +	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		err =3D -ENOMEM;
> +		goto error_kmalloc;
> +	}
> +
Similar to above one.

> +	num =3D ops->get_queue_max(mdev);
> +	if (num =3D=3D 0) {
> +		err =3D -ENOENT;
> +		goto error_new_virtqueue;
> +	}
> +
> +	/* Create the vring */
> +	align =3D ops->get_vq_align(mdev);
> +	vq =3D vring_create_virtqueue(index, num, align, vdev,
> +				    true, true, ctx,
> +				    virtio_mdev_notify, callback, name);
> +	if (!vq) {
> +		err =3D -ENOMEM;
> +		goto error_new_virtqueue;
> +	}
> +
> +	/* Setup virtqueue callback */
> +	cb.callback =3D virtio_mdev_virtqueue_cb;
> +	cb.private =3D info;
> +	ops->set_vq_cb(mdev, index, &cb);
> +	ops->set_vq_num(mdev, index, virtqueue_get_vring_size(vq));
> +
> +	desc_addr =3D virtqueue_get_desc_addr(vq);
> +	driver_addr =3D virtqueue_get_avail_addr(vq);
> +	device_addr =3D virtqueue_get_used_addr(vq);
> +
> +	if (ops->set_vq_address(mdev, index,
> +				desc_addr, driver_addr,
> +				device_addr)) {
> +		err =3D -EINVAL;
> +		goto err_vq;
> +	}
> +
> +	ops->set_vq_ready(mdev, index, 1);
> +
> +	vq->priv =3D info;
> +	info->vq =3D vq;
> +
> +	return vq;
> +
> +err_vq:
> +	vring_del_virtqueue(vq);
> +error_new_virtqueue:
> +	ops->set_vq_ready(mdev, index, 0);
> +	WARN_ON(ops->get_vq_ready(mdev, index));
> +	kfree(info);
> +error_kmalloc:
> +error_available:
> +	return ERR_PTR(err);
> +
> +}
> +
> +static void virtio_mdev_del_vq(struct virtqueue *vq) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vq->vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +	struct virtio_mdev_vq_info *info =3D vq->priv;
> +	unsigned int index =3D vq->index;
> +
> +	/* Select and deactivate the queue */
> +	ops->set_vq_ready(mdev, index, 0);
> +	WARN_ON(ops->get_vq_ready(mdev, index));
> +
> +	vring_del_virtqueue(vq);
> +
> +	kfree(info);
> +}
> +
> +static void virtio_mdev_del_vqs(struct virtio_device *vdev) {
> +	struct virtqueue *vq, *n;
> +
> +	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
> +		virtio_mdev_del_vq(vq);
> +}
> +
> +static int virtio_mdev_find_vqs(struct virtio_device *vdev, unsigned nvq=
s,
> +				struct virtqueue *vqs[],
> +				vq_callback_t *callbacks[],
> +				const char * const names[],
> +				const bool *ctx,
> +				struct irq_affinity *desc)
> +{
> +	struct virtio_mdev_device *vm_dev =3D to_virtio_mdev_device(vdev);
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +	struct virtio_mdev_callback cb;
> +	int i, err, queue_idx =3D 0;
> +
> +	vm_dev->vqs =3D kmalloc_array(queue_idx, sizeof(*vm_dev->vqs),
> +				    GFP_KERNEL);
> +	if (!vm_dev->vqs)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nvqs; ++i) {
> +		if (!names[i]) {
> +			vqs[i] =3D NULL;
> +			continue;
> +		}
> +
> +		vqs[i] =3D virtio_mdev_setup_vq(vdev, queue_idx++,
> +					      callbacks[i], names[i], ctx ?
> +					      ctx[i] : false);
> +		if (IS_ERR(vqs[i])) {
> +			err =3D PTR_ERR(vqs[i]);
> +			goto err_setup_vq;
> +		}
> +	}
> +
> +	cb.callback =3D virtio_mdev_config_cb;
> +	cb.private =3D vm_dev;
> +	ops->set_config_cb(mdev, &cb);
> +
> +	return 0;
> +
> +err_setup_vq:
> +	kfree(vm_dev->vqs);
> +	virtio_mdev_del_vqs(vdev);
> +	return err;
> +}
> +
> +static u64 virtio_mdev_get_features(struct virtio_device *vdev) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	return ops->get_features(mdev);
> +}
> +
> +static int virtio_mdev_finalize_features(struct virtio_device *vdev) {
> +	struct mdev_device *mdev =3D vm_get_mdev(vdev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +
> +	/* Give virtio_ring a chance to accept features. */
> +	vring_transport_features(vdev);
> +
> +	return ops->set_features(mdev, vdev->features); }
> +
> +static const char *virtio_mdev_bus_name(struct virtio_device *vdev) {
> +	struct virtio_mdev_device *vm_dev =3D to_virtio_mdev_device(vdev);
> +	struct mdev_device *mdev =3D vm_dev->mdev;
> +
> +	return dev_name(&mdev->dev);
> +}
> +
> +static const struct virtio_config_ops virtio_mdev_config_ops =3D {
> +	.get		=3D virtio_mdev_get,
> +	.set		=3D virtio_mdev_set,
> +	.generation	=3D virtio_mdev_generation,
> +	.get_status	=3D virtio_mdev_get_status,
> +	.set_status	=3D virtio_mdev_set_status,
> +	.reset		=3D virtio_mdev_reset,
> +	.find_vqs	=3D virtio_mdev_find_vqs,
> +	.del_vqs	=3D virtio_mdev_del_vqs,
> +	.get_features	=3D virtio_mdev_get_features,
> +	.finalize_features =3D virtio_mdev_finalize_features,
> +	.bus_name	=3D virtio_mdev_bus_name,
> +};
> +
> +static void virtio_mdev_release_dev(struct device *_d) {
> +	struct virtio_device *vdev =3D
> +	       container_of(_d, struct virtio_device, dev);
> +	struct virtio_mdev_device *vm_dev =3D
> +	       container_of(vdev, struct virtio_mdev_device, vdev);
> +
> +	devm_kfree(_d, vm_dev);
> +}
> +
> +static int virtio_mdev_probe(struct device *dev) {
> +	struct mdev_device *mdev =3D to_mdev_device(dev);
> +	const struct virtio_mdev_parent_ops *ops =3D
> mdev_get_parent_ops(mdev);
> +	struct virtio_mdev_device *vm_dev;
> +	int rc;
> +
> +	vm_dev =3D devm_kzalloc(dev, sizeof(*vm_dev), GFP_KERNEL);
> +	if (!vm_dev)
> +		return -ENOMEM;
> +
> +	vm_dev->vdev.dev.parent =3D dev;
> +	vm_dev->vdev.dev.release =3D virtio_mdev_release_dev;
> +	vm_dev->vdev.config =3D &virtio_mdev_config_ops;
> +	vm_dev->mdev =3D mdev;
> +	vm_dev->vqs =3D NULL;
> +	spin_lock_init(&vm_dev->lock);
> +
> +	vm_dev->version =3D ops->get_version(mdev);
> +	if (vm_dev->version !=3D 1) {
> +		dev_err(dev, "Version %ld not supported!\n",
> +			vm_dev->version);
> +		return -ENXIO;
> +	}
> +
> +	vm_dev->vdev.id.device =3D ops->get_device_id(mdev);
> +	if (vm_dev->vdev.id.device =3D=3D 0)
> +		return -ENODEV;
> +
> +	vm_dev->vdev.id.vendor =3D ops->get_vendor_id(mdev);
> +	rc =3D register_virtio_device(&vm_dev->vdev);
> +	if (rc)
> +		put_device(dev);
> +
> +	dev_set_drvdata(dev, vm_dev);
No need to set drvdata when there is error returned from register_virtio_de=
vice().

> +
> +	return rc;
> +
Extra line not needed.
> +}
> +
> +static void virtio_mdev_remove(struct device *dev) {
> +	struct virtio_mdev_device *vm_dev =3D dev_get_drvdata(dev);
> +
> +	unregister_virtio_device(&vm_dev->vdev);
> +}
> +
> +static struct mdev_class_id id_table[] =3D {
> +	{ MDEV_ID_VIRTIO },
> +	{ 0 },
> +};
> +
> +static struct mdev_driver virtio_mdev_driver =3D {
> +	.name	=3D "virtio_mdev",
> +	.probe	=3D virtio_mdev_probe,
> +	.remove	=3D virtio_mdev_remove,
No need for tab, just do single white space.

> +	.id_table =3D id_table,
> +};
> +
> +static int __init virtio_mdev_init(void) {
> +	return mdev_register_driver(&virtio_mdev_driver, THIS_MODULE); }
> +
> +static void __exit virtio_mdev_exit(void) {
> +	mdev_unregister_driver(&virtio_mdev_driver);
> +}
> +
> +module_init(virtio_mdev_init)
> +module_exit(virtio_mdev_exit)
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> --
> 2.19.1
