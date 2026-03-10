Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFB34A3A7;
	Tue, 10 Mar 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170423; cv=none; b=Cc0n6SFSHQymzoMDsIXY7mcyM/zJNiuqJ+ZccjOoTjweKxf20qg9SL+Us/oLIhT29Kg3VEeuWDskUsH/1tLY2g+Mz1c30AemGlFNZATDXOMbAHovds9rvFjVhGHZu77F4Q2gqfcYzwuHJxB7Z5HLH4Rc9S4rqQ0+vCpIcgvs2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170423; c=relaxed/simple;
	bh=BKquBmoV40M3y0lqJeA/lU2BpqALeE5Z6zay9zHLx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qt8s87WIXnUfoGyP/I2WAD7N939KAVhsUB/0PCRu3McNq2IbOPpdPkE/pftQQQ18d015BeC6O8O8HWPXvhQlv+CPXQvUCA0j12aBIJTzrOtcbbAxs1AJLrlmhBCS/oKnimAHRKAPUCigmxohxGl24vq9qPu4nhTZ3ZJwupMmafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=t3oIHo0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xetq1kBI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="t3oIHo0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xetq1kBI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C03E014001DF;
	Tue, 10 Mar 2026 15:20:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773170418;
	 x=1773256818; bh=W7HHc+ZtldYz/im+eEU6fPQakLip/I7XgmXSF2g/7OI=; b=
	t3oIHo0JDTW7q7mC4zn9n/mUALiTdk7SVAvmyviLYlUbrTn2A9lcp//X9cziGBim
	gWpDuHr1qYJ85vquWROEeN+/xc7wEDHQPW7lE6MCcmE4ceo55jgkSkgmnibgUjSK
	KVTSumoTnwQXXK5OfmfcMD9P9nCleGWWBvQAOb+xqgZiMdqzfUvx3pHURDWK6h3f
	4vhuBfWWJ14d0M0JML9vZ9dsc3WSnxhJVxQY63g2wSghhjm4GVmGKDsF/RB+f9E7
	DLqlD7pyfclmdefjwIASrIPMmLACVP68FZAsl0HjU4eEiUVg4Js0qGOAG/2gkHrp
	gyE6EPcwoECfvSI4M5f4hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773170418; x=
	1773256818; bh=W7HHc+ZtldYz/im+eEU6fPQakLip/I7XgmXSF2g/7OI=; b=X
	etq1kBIlVwkRcaqEDiFgoqhiX1WozDU7tcvrDXTsd+1gRyAGiSBQUnP1vIFeEWjO
	UdC6OUW4MpWOXYaolTKKW7zyMJydY1uqk9UMt7mscmyy/IyMl4qimLLePygYNbPd
	GIKMDuF5tQYmifpWXM3oxWMNmaQf49a2oPtAKaUwiJ9SnUv/DVLPPVyLRP/Cr97z
	u5i5H94HVDhA1EsDa1jaePk6s8JK7EYoGRZcLuCtlkvMFP5mxx+FG6jT5f5MrJ86
	3p5SczSmPsUz+VooHOAfETaGxicCywLpeuHXrGn36yrq+YFoxtH6HuTSSdlT5tT5
	jZpJjD9WF3xio9i29hffg==
X-ME-Sender: <xms:8m6waWPX_qMsNaesevcblCGCTHG9qP_9YxR_EUtt1GEFEjbA7YI-VA>
    <xme:8m6waRHW6oq-n-zGf-ECuKieMvd0PSHgKSbkQpuPWD0M71hEvKBzVH8zkIrQFZdJx
    ebmiZ8uGQDw4nWC0u8issOml4-D0l-TeaL5hKhRTB8QP6zflu2ekvs>
X-ME-Received: <xmr:8m6waZG3RmDamy0kZD9CHZzdZyHGIK2a31YvOWmIh-Dr7w5_Ftg15CRaEiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepvddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjuhhlihgrnhhrsehlihhnuhigrdhisghmrdgtoh
    hmpdhrtghpthhtohepshgthhhnvghllhgvsehlihhnuhigrdhisghmrdgtohhmpdhrtghp
    thhtohepfihinhhtvghrrgeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehtsh
    eslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehosggvrhhprghrsehlihhnuhig
    rdhisghmrdgtohhmpdhrtghpthhtohepghgsrgihvghrsehlihhnuhigrdhisghmrdgtoh
    hmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohephihishhhrghi
    hhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvh
    hiughirgdrtghomh
X-ME-Proxy: <xmx:8m6waQAKERLv9e4ylSGvFQHFv8Q5V522eWwUlm8UjtutKu-G6SKrgw>
    <xmx:8m6waenyOzW6BAWm1psOalulGiD_Ir0KH51ew-iBHV9GwA8-vrhuJA>
    <xmx:8m6wae64_tzbIyQwY5Bm5iRHhrm-1JhRj6y0duYMkIQ-LEZ8uWS8Sw>
    <xmx:8m6waVvubtYBNZk9qzXgHfVMXUERNxMraX4BNY40_RDbIRqKHqhveg>
    <xmx:8m6waUg9KxRNuypsEj7dohqJ2Emh9yg9s7UMxbeM5PPvW2ZnXnkRPU9p>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 15:20:16 -0400 (EDT)
Date: Tue, 10 Mar 2026 13:20:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Julian Ruess <julianr@linux.ibm.com>
Cc: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
 oberpar@linux.ibm.com, gbayer@linux.ibm.com, Jason Gunthorpe
 <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
 hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260310132015.6e4453be@shazbot.org>
In-Reply-To: <20260305-vfio_pci_ism-v3-2-1217076c81d9@linux.ibm.com>
References: <20260305-vfio_pci_ism-v3-0-1217076c81d9@linux.ibm.com>
	<20260305-vfio_pci_ism-v3-2-1217076c81d9@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 13:20:14 +0100
Julian Ruess <julianr@linux.ibm.com> wrote:

> Add a vfio_pci variant driver for the s390-specific Internal Shared
> Memory (ISM) devices used for inter-VM communication.
> 
> This enables the development of vfio-pci-based user space drivers for
> ISM devices.
> 
> On s390, kernel primitives such as ioread() and iowrite() are switched
> over from function handle based PCI load/stores instructions to PCI
> memory-I/O (MIO) loads/stores when these are available and not
> explicitly disabled. Since these instructions cannot be used with ISM
> devices, ensure that classic function handle-based PCI instructions are
> used instead.
> 
> The driver is still required even when MIO instructions are disabled, as
> the ISM device relies on the PCI store block (PCISTB) instruction to
> perform write operations.
> 
> Stores are not fragmented, therefore one ioctl corresponds to exactly
> one PCISTB instruction. User space must ensure to not write more than
> 4096 bytes at once to an ISM BAR which is the maximum payload of the
> PCISTB instruction.
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
> ---
>  drivers/vfio/pci/Kconfig      |   2 +
>  drivers/vfio/pci/Makefile     |   2 +
>  drivers/vfio/pci/ism/Kconfig  |  10 ++
>  drivers/vfio/pci/ism/Makefile |   3 +
>  drivers/vfio/pci/ism/main.c   | 343 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 360 insertions(+)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 1e82b44bda1a0a544e1add7f4b06edecf35aaf81..296bf01e185ecacc388ebc69e92706c99e47c814 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -60,6 +60,8 @@ config VFIO_PCI_DMABUF
>  
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
> +source "drivers/vfio/pci/ism/Kconfig"
> +
>  source "drivers/vfio/pci/hisilicon/Kconfig"
>  
>  source "drivers/vfio/pci/pds/Kconfig"
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index e0a0757dd1d2b0bc69b7e4d79441d5cacf4e1cd8..6138f1bf241df04e7419f196b404abdf9b194050 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -11,6 +11,8 @@ obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
>  
>  obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
>  
> +obj-$(CONFIG_ISM_VFIO_PCI)           += ism/
> +
>  obj-$(CONFIG_HISI_ACC_VFIO_PCI) += hisilicon/
>  
>  obj-$(CONFIG_PDS_VFIO_PCI) += pds/
> diff --git a/drivers/vfio/pci/ism/Kconfig b/drivers/vfio/pci/ism/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..02f47d25fed2d34c732b67b3a3655b64a7625467
> --- /dev/null
> +++ b/drivers/vfio/pci/ism/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config ISM_VFIO_PCI
> +	tristate "VFIO support for ISM devices"
> +	depends on S390
> +	select VFIO_PCI_CORE
> +	help
> +	  This provides user space support for IBM Internal Shared Memory (ISM)
> +	  Adapter devices using the VFIO framework.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/pci/ism/Makefile b/drivers/vfio/pci/ism/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..32cc3c66dd11395da85a2b6f05b3d97036ed8a35
> --- /dev/null
> +++ b/drivers/vfio/pci/ism/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ISM_VFIO_PCI) += ism-vfio-pci.o
> +ism-vfio-pci-y := main.o
> diff --git a/drivers/vfio/pci/ism/main.c b/drivers/vfio/pci/ism/main.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..54a378140aa3300bd1ff9f6d9c626ef56f6be067
> --- /dev/null
> +++ b/drivers/vfio/pci/ism/main.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vfio-ISM driver for s390
> + *
> + * Copyright IBM Corp.
> + */
> +
> +#include "../vfio_pci_priv.h"
> +#include "linux/slab.h"
> +
> +#define ISM_VFIO_PCI_OFFSET_SHIFT   48
> +#define ISM_VFIO_PCI_OFFSET_TO_INDEX(off) (off >> ISM_VFIO_PCI_OFFSET_SHIFT)
> +#define ISM_VFIO_PCI_INDEX_TO_OFFSET(index) ((u64)(index) << ISM_VFIO_PCI_OFFSET_SHIFT)
> +#define ISM_VFIO_PCI_OFFSET_MASK (((u64)(1) << ISM_VFIO_PCI_OFFSET_SHIFT) - 1)
> +
> +struct kmem_cache *store_block_cache;
> +
> +struct ism_vfio_pci_core_device {
> +	struct vfio_pci_core_device core_device;
> +};
> +
> +static int ism_pci_open_device(struct vfio_device *core_vdev)
> +{
> +	struct ism_vfio_pci_core_device *ivdev;
> +	struct vfio_pci_core_device *vdev;
> +	int ret;
> +
> +	ivdev = container_of(core_vdev, struct ism_vfio_pci_core_device,
> +			     core_device.vdev);
> +	vdev = &ivdev->core_device;
> +
> +	ret = vfio_pci_core_enable(vdev);
> +	if (ret)
> +		return ret;
> +
> +	vfio_pci_core_finish_enable(vdev);
> +	return 0;
> +}
> +
> +/*
> + * ism_vfio_pci_do_io_r()
> + *
> + * On s390, kernel primitives such as ioread() and iowrite() are switched over
> + * from function handle based PCI load/stores instructions to PCI memory-I/O (MIO)
> + * loads/stores when these are available and not explicitly disabled. Since these
> + * instructions cannot be used with ISM devices, ensure that classic function
> + * handle-based PCI instructions are used instead.
> + */
> +static ssize_t ism_vfio_pci_do_io_r(struct vfio_pci_core_device *vdev,
> +				    char __user *buf, loff_t off, size_t count,
> +				    int bar)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	ssize_t ret, done = 0;
> +	u64 req, length, tmp;
> +
> +	while (count) {
> +		if (count >= 8 && IS_ALIGNED(off, 8))
> +			length = 8;
> +		else if (count >= 4 && IS_ALIGNED(off, 4))
> +			length = 4;
> +		else if (count >= 2 && IS_ALIGNED(off, 2))
> +			length = 2;
> +		else
> +			length = 1;
> +		req = ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, length);
> +		/*
> +		 * Use __zpci_load() to bypass automatic use of PCI MIO instructions
> +		 * which are not supported on ISM devices
> +		 */
> +		ret = __zpci_load(&tmp, req, off);
> +		if (ret)
> +			return ret;
> +		if (copy_to_user(buf, &tmp, length))

Is there an endian issue here for 1/2/4 byte reads?  zpci_read_single()
uses a u64 target for zpci_load(), but then casts the result into the
destination buffer to place the low-order bytes.  AIUI, copy_to_user()
would start from the high-order bytes of the u64.

> +			return -EFAULT;
> +		count -= length;
> +		done += length;
> +		off += length;
> +		buf += length;
> +	}
> +	return done;
> +}
> +
> +/*
> + * ism_vfio_pci_do_io_w()
> + *
> + * Ensure that the PCI store block (PCISTB) instruction is used as required by the
> + * ISM device. The ISM device also uses a 256 TiB BAR 0 for write operations,
> + * which requires a 48bit region address space (ISM_VFIO_PCI_OFFSET_SHIFT).
> + */
> +static ssize_t ism_vfio_pci_do_io_w(struct vfio_pci_core_device *vdev,
> +				    char __user *buf, loff_t off, size_t count,
> +				    int bar)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	ssize_t ret;
> +	void *data;
> +	u64 req;
> +
> +	if (count > zdev->maxstbl)
> +		return -EINVAL;
> +	if (((off % PAGE_SIZE) + count) > PAGE_SIZE)
> +		return -EINVAL;
> +
> +	data = kmem_cache_zalloc(store_block_cache, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(data, buf, count)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
> +	req = ZPCI_CREATE_REQ(READ_ONCE(zdev->fh), bar, count);
> +	ret = __zpci_store_block(data, req, off);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = count;
> +
> +out_free:
> +	kmem_cache_free(store_block_cache, data);
> +	return ret;
> +}
> +
> +static ssize_t ism_vfio_pci_bar_rw(struct vfio_pci_core_device *vdev,
> +				   char __user *buf, size_t count, loff_t *ppos,
> +				   bool iswrite)
> +{
> +	int bar = ISM_VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +	loff_t pos = *ppos & ISM_VFIO_PCI_OFFSET_MASK;
> +	resource_size_t end;
> +	ssize_t done = 0;
> +
> +	if (pci_resource_start(vdev->pdev, bar))
> +		end = pci_resource_len(vdev->pdev, bar);
> +	else
> +		return -EINVAL;
> +
> +	if (pos >= end)
> +		return -EINVAL;
> +
> +	count = min(count, (size_t)(end - pos));
> +
> +	if (iswrite)
> +		done = ism_vfio_pci_do_io_w(vdev, buf, pos, count, bar);
> +	else
> +		done = ism_vfio_pci_do_io_r(vdev, buf, pos, count, bar);
> +
> +	if (done >= 0)
> +		*ppos += done;
> +
> +	return done;
> +}
> +
> +static ssize_t ism_vfio_pci_config_rw(struct vfio_pci_core_device *vdev,
> +				      char __user *buf, size_t count,
> +				      loff_t *ppos, bool iswrite)
> +{
> +	loff_t pos = *ppos;
> +	size_t done = 0;
> +	int ret = 0;
> +
> +	pos &= ISM_VFIO_PCI_OFFSET_MASK;
> +
> +	while (count) {
> +		/*
> +		 * zPCI must not use MIO instructions for config space access,
> +		 * so we can use common code path here.
> +		 */
> +		ret = vfio_pci_config_rw_single(vdev, buf, count, &pos, iswrite);
> +		if (ret < 0)
> +			return ret;
> +
> +		count -= ret;
> +		done += ret;
> +		buf += ret;
> +		pos += ret;
> +	}
> +
> +	*ppos += done;
> +
> +	return done;
> +}
> +
> +static ssize_t ism_vfio_pci_rw(struct vfio_device *core_vdev, char __user *buf,
> +			       size_t count, loff_t *ppos, bool iswrite)
> +{
> +	unsigned int index = ISM_VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +	struct vfio_pci_core_device *vdev;
> +	int ret;
> +
> +	vdev = container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +
> +	if (!count)
> +		return 0;
> +
> +	switch (index) {
> +	case VFIO_PCI_CONFIG_REGION_INDEX:
> +		ret = ism_vfio_pci_config_rw(vdev, buf, count, ppos, iswrite);
> +		break;
> +
> +	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
> +		ret = ism_vfio_pci_bar_rw(vdev, buf, count, ppos, iswrite);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t ism_vfio_pci_read(struct vfio_device *core_vdev,
> +				 char __user *buf, size_t count, loff_t *ppos)
> +{
> +	return ism_vfio_pci_rw(core_vdev, buf, count, ppos, false);
> +}
> +
> +static ssize_t ism_vfio_pci_write(struct vfio_device *core_vdev,
> +				  const char __user *buf, size_t count,
> +				  loff_t *ppos)
> +{
> +	return ism_vfio_pci_rw(core_vdev, (char __user *)buf, count, ppos,
> +			       true);
> +}
> +
> +static int ism_vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
> +					      struct vfio_region_info *info,
> +					      struct vfio_info_cap *caps)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct pci_dev *pdev = vdev->pdev;
> +
> +	switch (info->index) {
> +	case VFIO_PCI_CONFIG_REGION_INDEX:
> +		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
> +		info->size = pdev->cfg_size;
> +		info->flags = VFIO_REGION_INFO_FLAG_READ |
> +			      VFIO_REGION_INFO_FLAG_WRITE;
> +		break;
> +	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
> +		info->offset = ISM_VFIO_PCI_INDEX_TO_OFFSET(info->index);
> +		info->size = pci_resource_len(pdev, info->index);
> +		if (!info->size) {
> +			info->flags = 0;
> +			break;
> +		}
> +		info->flags = VFIO_REGION_INFO_FLAG_READ |
> +			      VFIO_REGION_INFO_FLAG_WRITE;
> +		break;
> +	default:
> +		info->offset = 0;
> +		info->size = 0;
> +		info->flags = 0;
> +	}
> +	return 0;
> +}
> +
> +static const struct vfio_device_ops ism_pci_ops = {
> +	.name = "ism-vfio-pci",
> +	.init = vfio_pci_core_init_dev,
> +	.release = vfio_pci_core_release_dev,
> +	.open_device = ism_pci_open_device,
> +	.close_device = vfio_pci_core_close_device,
> +	.ioctl = vfio_pci_core_ioctl,
> +	.get_region_info_caps = ism_vfio_pci_ioctl_get_region_info,
> +	.device_feature = vfio_pci_core_ioctl_feature,
> +	.read = ism_vfio_pci_read,
> +	.write = ism_vfio_pci_write,
> +	.request = vfio_pci_core_request,
> +	.match = vfio_pci_core_match,
> +	.match_token_uuid = vfio_pci_core_match_token_uuid,
> +	.bind_iommufd = vfio_iommufd_physical_bind,
> +	.unbind_iommufd = vfio_iommufd_physical_unbind,
> +	.attach_ioas = vfio_iommufd_physical_attach_ioas,
> +	.detach_ioas = vfio_iommufd_physical_detach_ioas,
> +};
> +
> +static int ism_vfio_pci_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *id)
> +{
> +	struct ism_vfio_pci_core_device *ivpcd;
> +	struct zpci_dev *zdev = to_zpci(pdev);
> +	int ret;
> +
> +	ivpcd = vfio_alloc_device(ism_vfio_pci_core_device, core_device.vdev,
> +				  &pdev->dev, &ism_pci_ops);
> +	if (IS_ERR(ivpcd))
> +		return PTR_ERR(ivpcd);
> +
> +	store_block_cache = kmem_cache_create("store_block_cache",
> +					      zdev->maxstbl, 0, 0, NULL);
> +	if (!store_block_cache)
> +		return -ENOMEM;

ivpcd is leaked here, we need a vfio_put_device().  Thanks,

Alex

> +
> +	dev_set_drvdata(&pdev->dev, &ivpcd->core_device);
> +	ret = vfio_pci_core_register_device(&ivpcd->core_device);
> +	if (ret) {
> +		kmem_cache_destroy(store_block_cache);
> +		vfio_put_device(&ivpcd->core_device.vdev);
> +	}
> +
> +	return ret;
> +}
> +
> +static void ism_vfio_pci_remove(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *core_device;
> +	struct ism_vfio_pci_core_device *ivpcd;
> +
> +	core_device = dev_get_drvdata(&pdev->dev);
> +	ivpcd = container_of(core_device, struct ism_vfio_pci_core_device,
> +			     core_device);
> +
> +	vfio_pci_core_unregister_device(&ivpcd->core_device);
> +	vfio_put_device(&ivpcd->core_device.vdev);
> +
> +	kmem_cache_destroy(store_block_cache);
> +}
> +
> +static const struct pci_device_id ism_device_table[] = {
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_IBM,
> +					  PCI_DEVICE_ID_IBM_ISM) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, ism_device_table);
> +
> +static struct pci_driver ism_vfio_pci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = ism_device_table,
> +	.probe = ism_vfio_pci_probe,
> +	.remove = ism_vfio_pci_remove,
> +	.err_handler = &vfio_pci_core_err_handlers,
> +	.driver_managed_dma = true,
> +};
> +
> +module_pci_driver(ism_vfio_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("vfio-pci variant driver for the IBM Internal Shared Memory (ISM) device");
> +MODULE_AUTHOR("IBM Corporation");
> 

