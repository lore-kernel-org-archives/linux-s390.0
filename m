Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Oct 2020 17:14:29 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201016151429.GD1807983@kroah.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
List-ID: <linux-s390.vger.kernel.org>
To: "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander" <graf@amazon.de>, "MacCarthaigh, Colm" <colmmacc@amazon.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>, "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, "ghammer@redhat.com" <ghammer@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Oct 16, 2020 at 02:33:15PM +0000, Catangiu, Adrian Costin wrote:
> +config VMGENID
> +	tristate "Virtual Machine Generation ID driver"
> +	depends on ACPI
> +	default M

Unless this is required to boot a machine, this should be removed.

> +	help
> +	  This is a Virtual Machine Generation ID driver which provides
> +	  a virtual machine unique identifier. The provided UUID can be
> +	  watched through the FS interface exposed by this driver, and
> +	  thus can provide notifications for VM snapshot or cloning events.

Where is the uuid exposed in the filesystem?

> +	  This enables applications and libraries that store or cache
> +	  sensitive information, to know that they need to regenerate it
> +	  after process memory has been exposed to potential copying.

Module name?

> +
>  config FSL_HV_MANAGER
>  	tristate "Freescale hypervisor management driver"
>  	depends on FSL_SOC
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index fd33124..a1f8dcc 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -4,4 +4,5 @@
>  #
>  
>  obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
> +obj-$(CONFIG_VMGENID)		+= vmgenid.o
>  obj-y				+= vboxguest/
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> new file mode 100644
> index 0000000..d314c72
> --- /dev/null
> +++ b/drivers/virt/vmgenid.c
> @@ -0,0 +1,419 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtual Machine Generation ID driver
> + *
> + * Copyright (C) 2018 Red Hat Inc, Copyright (C) 2020 Amazon.com Inc

That's not how you write copyright lines, please fix up.

> + * All rights reserved.
> + *	Authors:
> + *	  Adrian Catangiu <acatan@amazon.com>
> + *	  Or Idgar <oridgar@gmail.com>
> + *	  Gal Hammer <ghammer@redhat.com>
> + *
> + */
> +#include <linux/acpi.h>
> +#include <linux/cdev.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/uuid.h>
> +#include <linux/vmgenid.h>
> +
> +#define DEV_NAME "vmgenid"
> +ACPI_MODULE_NAME(DEV_NAME);
> +
> +struct dev_data {
> +	struct cdev       cdev;
> +	dev_t             dev_id;
> +	unsigned long     map_buf;
> +
> +	void              *uuid_iomap;
> +	uuid_t            uuid;
> +	wait_queue_head_t read_wait;
> +
> +	atomic_t          watchers;
> +	atomic_t          outdated_watchers;
> +	wait_queue_head_t outdated_wait;
> +};
> +
> +struct file_data {
> +	struct dev_data  *dev_data;
> +	uuid_t           acked_uuid;
> +};
> +
> +static bool vmgenid_uuid_matches(struct dev_data *priv, uuid_t *uuid)
> +{
> +	return !memcmp(uuid, &priv->uuid, sizeof(uuid_t));
> +}
> +
> +static void vmgenid_put_outdated_watchers(struct dev_data *priv)
> +{
> +	if (atomic_dec_and_test(&priv->outdated_watchers))
> +		wake_up_interruptible(&priv->outdated_wait);
> +}
> +
> +static int vmgenid_open(struct inode *inode, struct file *file)
> +{
> +	struct dev_data *priv =
> +		container_of(inode->i_cdev, struct dev_data, cdev);
> +	struct file_data *file_data =
> +		kzalloc(sizeof(struct file_data), GFP_KERNEL);
> +
> +	if (!file_data)
> +		return -ENOMEM;
> +
> +	file_data->acked_uuid = priv->uuid;
> +	file_data->dev_data = priv;
> +
> +	file->private_data = file_data;
> +	atomic_inc(&priv->watchers);
> +
> +	return 0;
> +}
> +
> +static int vmgenid_close(struct inode *inode, struct file *file)
> +{
> +	struct file_data *file_data = (struct file_data *) file->private_data;
> +	struct dev_data *priv = file_data->dev_data;
> +
> +	if (!vmgenid_uuid_matches(priv, &file_data->acked_uuid))
> +		vmgenid_put_outdated_watchers(priv);
> +	atomic_dec(&priv->watchers);
> +	kfree(file->private_data);
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +vmgenid_read(struct file *file, char __user *ubuf, size_t nbytes, loff_t *ppos)
> +{
> +	struct file_data *file_data =
> +		(struct file_data *) file->private_data;
> +	struct dev_data *priv = file_data->dev_data;
> +	ssize_t ret;
> +
> +	if (nbytes == 0)
> +		return 0;
> +	/* disallow partial UUID reads */
> +	if (nbytes < sizeof(uuid_t))
> +		return -EINVAL;
> +	nbytes = sizeof(uuid_t);
> +
> +	if (vmgenid_uuid_matches(priv, &file_data->acked_uuid)) {
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +		ret = wait_event_interruptible(
> +			priv->read_wait,
> +			!vmgenid_uuid_matches(priv, &file_data->acked_uuid)
> +		);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = copy_to_user(ubuf, &priv->uuid, nbytes);
> +	if (ret)
> +		return -EFAULT;
> +
> +	return nbytes;
> +}
> +
> +static ssize_t vmgenid_write(struct file *file, const char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct file_data *file_data = (struct file_data *) file->private_data;
> +	struct dev_data *priv = file_data->dev_data;
> +	uuid_t ack_uuid;
> +
> +	/* disallow partial UUID writes */
> +	if (count != sizeof(uuid_t))
> +		return -EINVAL;
> +	if (copy_from_user(&ack_uuid, ubuf, count))
> +		return -EFAULT;
> +	/* wrong UUID acknowledged */
> +	if (!vmgenid_uuid_matches(priv, &ack_uuid))
> +		return -EINVAL;
> +
> +	if (!vmgenid_uuid_matches(priv, &file_data->acked_uuid)) {
> +		/* update local view of UUID */
> +		file_data->acked_uuid = ack_uuid;
> +		vmgenid_put_outdated_watchers(priv);
> +	}
> +
> +	return (ssize_t)count;
> +}
> +
> +static __poll_t
> +vmgenid_poll(struct file *file, poll_table *wait)
> +{
> +	__poll_t mask = 0;
> +	struct file_data *file_data =
> +		(struct file_data *) file->private_data;
> +	struct dev_data *priv = file_data->dev_data;
> +
> +	if (!vmgenid_uuid_matches(priv, &file_data->acked_uuid))
> +		return EPOLLIN | EPOLLRDNORM;
> +
> +	poll_wait(file, &priv->read_wait, wait);
> +
> +	if (!vmgenid_uuid_matches(priv, &file_data->acked_uuid))
> +		mask = EPOLLIN | EPOLLRDNORM;
> +
> +	return mask;
> +}
> +
> +static long vmgenid_ioctl(struct file *file,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	struct file_data *file_data =
> +		(struct file_data *) file->private_data;
> +	struct dev_data *priv = file_data->dev_data;
> +	struct timespec __user *timeout = (void *) arg;
> +	struct timespec kts;
> +	ktime_t until;
> +	int ret;
> +
> +	switch (cmd) {
> +	case VMGENID_GET_OUTDATED_WATCHERS:
> +		ret = atomic_read(&priv->outdated_watchers);
> +		break;
> +	case VMGENID_WAIT_WATCHERS:
> +		if (timeout) {
> +			ret = copy_from_user(&kts, timeout, sizeof(kts));
> +			if (ret)
> +				return -EFAULT;
> +			until = timespec_to_ktime(kts);

No validation of structure fields?

And you are exposing a kernel structure to userspace?

I don't see this function in Linus's tree right now, are you sure this
builds?


> +		} else {
> +			until = KTIME_MAX;
> +		}
> +
> +		ret = wait_event_interruptible_hrtimeout(
> +			priv->outdated_wait,
> +			!atomic_read(&priv->outdated_watchers),
> +			until
> +		);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static vm_fault_t vmgenid_vm_fault(struct vm_fault *vmf)
> +{
> +	struct page *page;
> +	struct file_data *file_data =
> +			(struct file_data *) vmf->vma->vm_private_data;

You do know you don't need to cast stuff like this, right?

Also run checkpatch.pl so maintainers are not grumpy and tell you to run
checkpatch.pl.

> +	struct dev_data *priv = file_data->dev_data;
> +
> +	if (priv->map_buf) {
> +		page = virt_to_page(priv->map_buf);
> +		get_page(page);
> +		vmf->page = page;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct vmgenid_vm_ops = {
> +	.fault = vmgenid_vm_fault,
> +};
> +
> +static int vmgenid_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	if (vma->vm_pgoff != 0 || vma_pages(vma) > 1)
> +		return -EINVAL;
> +
> +	if ((vma->vm_flags & VM_WRITE) != 0)
> +		return -EPERM;
> +
> +	vma->vm_ops = &vmgenid_vm_ops;
> +	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_private_data = file->private_data;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations fops = {
> +	.owner          = THIS_MODULE,
> +	.mmap           = vmgenid_mmap,
> +	.open           = vmgenid_open,
> +	.release        = vmgenid_close,
> +	.read           = vmgenid_read,
> +	.write          = vmgenid_write,
> +	.poll           = vmgenid_poll,
> +	.compat_ioctl   = vmgenid_ioctl,
> +	.unlocked_ioctl = vmgenid_ioctl,
> +};
> +
> +static int vmgenid_acpi_map(struct dev_data *priv, acpi_handle handle)
> +{
> +	int i;
> +	phys_addr_t phys_addr;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	union acpi_object *pss;
> +	union acpi_object *element;
> +
> +	status = acpi_evaluate_object(handle, "ADDR", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
> +		return -ENODEV;
> +	}
> +	pss = buffer.pointer;
> +	if (!pss || pss->type != ACPI_TYPE_PACKAGE || pss->package.count != 2)
> +		return -EINVAL;
> +
> +	phys_addr = 0;
> +	for (i = 0; i < pss->package.count; i++) {
> +		element = &(pss->package.elements[i]);
> +		if (element->type != ACPI_TYPE_INTEGER)
> +			return -EINVAL;
> +		phys_addr |= element->integer.value << i * 32;
> +	}
> +
> +	priv->uuid_iomap = acpi_os_map_memory(phys_addr, sizeof(uuid_t));
> +	if (!priv->uuid_iomap) {
> +		pr_err("Could not map memory at 0x%llx, size %u",
> +			   phys_addr,
> +			   (u32)sizeof(uuid_t));
> +		return -ENOMEM;
> +	}
> +
> +	memcpy_fromio(&priv->uuid, priv->uuid_iomap, sizeof(uuid_t));
> +	memcpy((void *) priv->map_buf, &priv->uuid, sizeof(uuid_t));
> +
> +	return 0;
> +}
> +
> +static int vmgenid_acpi_add(struct acpi_device *device)
> +{
> +	int ret;
> +	struct dev_data *priv;
> +
> +	if (!device)
> +		return -EINVAL;
> +
> +	priv = kzalloc(sizeof(struct dev_data), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->map_buf = get_zeroed_page(GFP_KERNEL);
> +	if (!priv->map_buf) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	device->driver_data = priv;
> +
> +	init_waitqueue_head(&priv->read_wait);
> +	atomic_set(&priv->watchers, 0);
> +	atomic_set(&priv->outdated_watchers, 0);
> +	init_waitqueue_head(&priv->outdated_wait);
> +
> +	ret = vmgenid_acpi_map(priv, device->handle);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = alloc_chrdev_region(&priv->dev_id, 0, 1, DEV_NAME);

Why is this not a misc device driver instead of messing around with all
of this "by hand"?

By doing things this way, you are not creating a device node in /dev/
automatically, right?  How did you test this?

> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2020, Amazon.com Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.

License boilerplate is not needed.

> + */
> +
> +#ifndef _UAPI_LINUX_VMGENID_H
> +#define _UAPI_LINUX_VMGENID_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/time.h>
> +
> +#define VMGENID_IOCTL 0x2d
> +#define VMGENID_GET_OUTDATED_WATCHERS _IO(VMGENID_IOCTL, 1)
> +#define VMGENID_WAIT_WATCHERS         _IOW(VMGENID_IOCTL, 2, struct timespec)

Why do you need ioctls for this?  Why not just use read/write?

thanks,

greg k-h
