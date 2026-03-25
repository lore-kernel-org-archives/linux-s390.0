Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D873537D6;
	Wed, 25 Mar 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459094; cv=none; b=tPaz1lfJ7BCd++GkiBFHAAgVgxHOuJXdcRVI+l1fspdbGPy2jlstaoio3rch1wHtaAwTZihgg8BYo2HlmOE/VPJ+fMx0EIR6LdSx/3BKDE78WqyLXLW9n/+F4nsfXEtd6GBQG5DUiv0FXjsXLnla4jrGoC3h6LYES6m2zLLjuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459094; c=relaxed/simple;
	bh=u8/+z2Bgz4Wws55sOYWKPdJx57vqhgYOwGb75l1e8t4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCaMFRngQvlSLpQerRvOcbm/OsMHWzxfRleYOqvLkEIZQCe6N1mrLSzPX7uscuBPwESkuX8q97FfvSMgiX6Fmp9wqRRxXWrIOkCKoD/chzPqTf/PEdx3Gl9EO89WHtHIjlxgGvmEu6nF4Bn1ihLjaO1z84DVtFlB5I2k0kx3TNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=U4PO+79/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqpb1XDv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="U4PO+79/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqpb1XDv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 920DA7A05FF;
	Wed, 25 Mar 2026 13:18:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 13:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774459091;
	 x=1774545491; bh=4izl9m24J0MdH0vrTEK4+4uXMVu8bNMwm/FhZz2CVdc=; b=
	U4PO+79/zAA0FkkU3YogSlYdJXQ1SpeONIStoMVCnxHq9wnoCMZUWoIR2YXxUSQr
	KrjlRwBPfTQ8E/ljD3wQ8KDxYW80tOsdczBU/7RV0WyLPTZErmh3SncVS/qw5avS
	HS5KjIjzNaw1/1Y2/c55kqr0MKQ+dxv20JI31ebPvNS9247L8X657hQFCVC4KoZU
	QYtxPAr4Dn8EQhvvU36Cgbinho4HiSglxQpcKaEziZL1ZRyeRZCYa22JsK5MvtYj
	tG52bMY4cZ2IGUFkA16Q6BdQv3rvatTcA7MzhZLdKttJGozJhq+cz21AWzqcf7t5
	fBD1LQ3HEr2gTHnF6PV8lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774459091; x=
	1774545491; bh=4izl9m24J0MdH0vrTEK4+4uXMVu8bNMwm/FhZz2CVdc=; b=m
	qpb1XDv6WSWP6VAE7r7zEWqiZl2OXosvVUYlycN/vYRuJpbA66870kXqi7arsDFu
	d6+m1B5LwQHsAVxcRwTpvzoRpZJpFafrtMYm8OTi/Yn0W9IM4fh5kZ0ha1eXBEd7
	ljd0c1BDa9/zyazTa+Jl/Ux4W/SHNZHppPIhcNexmlpnfcqcAdwloBY2s3HvasyR
	X+siNW35RsIyuGXysNO/kHChT1r9HoWGRq9yzUcrDjX8YRECzlmQPiGEaGN6HyE3
	vbtW6+zZC7MMFeTUeX/0vFfmTlnJWfX7fS3fm55dO3HazTE2vJhowcFqUglpaF2J
	gCBi78Cgy2USGWyrvOgkA==
X-ME-Sender: <xms:0xjEaR8QS7_cAtDMzaytOsQROsyFdYYRCzvvPli-E8JOxeXRfh2cOA>
    <xme:0xjEaZaqyz8kaUICit2PBUQK4ir3Vlswf89ZaWQLJIsg2G691vKXm1RK2ulgY1906
    Jrxdatbb6zUfO4bl4qpF7VXzpnbqVQggMwh985-eBTtHt3oUf1WEA>
X-ME-Received: <xmr:0xjEaXqzuULEWrYkIBGozxUYZ5mjoUdkURB59c959ZvwYhFSSgco0UEW5x8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihhf
    mheslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhope
    hksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlghesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0xjEaW1OSbEYNLFDY5M-FoNhOdGjdjZZ6XiD5xOm7eNoJfqlDN78RA>
    <xmx:0xjEaXnakkrmYKDrH61B0YSaeNVXhH0cAgnDJtYHCGZKQzjaA6J89A>
    <xmx:0xjEaab6eaS0EWAxfUrDhJ8VuZW6qsx0oPD4egC76VsxyeMTOsGzRQ>
    <xmx:0xjEaR9wpIZphF155loKWCfOBnl-VXxigrE9tqQQGr2jNdHCN8GEOg>
    <xmx:0xjEafCdy3P-Cw5s71TDZYvrCoeZJ6VhxGEoqglvfFwPNhAkGGffbX0c>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 13:18:10 -0400 (EDT)
Date: Wed, 25 Mar 2026 11:18:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v11 7/9] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260325111808.263aef2c@shazbot.org>
In-Reply-To: <20260316191544.2279-8-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
	<20260316191544.2279-8-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 12:15:42 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 36 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 17 +++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index d43745fe4c84..bbdb625e35ef 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1534,6 +1534,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 27ac280f00b9..eed69926d8a1 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -89,6 +89,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				struct vfio_info_cap *caps);
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -103,6 +105,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  
>  static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {}
> +
> +static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
> +					    u32 flags, void __user *arg,
> +					    size_t argsz)
> +{
> +	return -ENODEV;

-ENOTTY

> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 2be37eab9279..d2748dd67c55 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,42 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err;
> +	struct vfio_pci_core_device *vdev;
> +	struct zpci_dev *zdev;
> +	int head = 0;
> +	int ret;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(err));
> +	if (ret != 1)
> +		return ret;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count) {
> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +		err.pec = zdev->pending_errs.err[head].pec;
> +		zdev->pending_errs.head++;
> +		zdev->pending_errs.count--;
> +		err.pending_errors = zdev->pending_errs.count;
> +	}
> +	mutex_unlock(&zdev->pending_errs_lock);
> +
> +	err.version = 1;

Returns uninitialized kernel data for case where there are no pending
errors, initialize err with = {};

> +	if (copy_to_user(arg, &err, sizeof(err)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..21b1473e4779 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1510,6 +1510,23 @@ struct vfio_device_feature_dma_buf {
>  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery involves
> + * platform firmware and notification to operating system is done by
> + * architecture specific mechanism.  Exposing this information to userspace
> + * allows userspace to take appropriate actions to handle an error on the
> + * device.

This should include some explicit discussion of how pending_errors in
interpreted, ie. pending _additional_ errors, userspace should read
until zero.  Thanks,

Alex

> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u8 version;
> +	__u8 pending_errors;
> +	__u16 pec;
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

