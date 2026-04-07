Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CE33D4EE;
	Tue,  7 Apr 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577222; cv=none; b=pqvmQ/lzpSmQ71MqturlXHaWphckhun+SWwjBp4y8JMosM2ItKuFyzvoDuDLPnt0Gw+2zSusMB36cZeyB9wur9RT8NOBPRsXoh7ycTQkzFHttMq8AK8FKB/R+I/5D4bteLED3twllYl7x7m17cTrD6P2CRzungjmnDvjymHyBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577222; c=relaxed/simple;
	bh=TjRC3ukra+drBP7mmN3DqZMBt4HwuVmuPAhrYphxuy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTFv3adHDcjgeZpAzAdakVQTLAFAnH/O/kue3bGf49jGS2pzR5Dm6J1UDeRbwHyayZPKJLBkgfZoKFOgHMMCiETsB4HpHXGqEeX9Yq6hTqBzdNkCO9SsA92/0xsdSosb1zUs0z98q9USd/hcRQ4iLNPK4q61AlbRIoB21gJGc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fqEjjJrf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jf+A8dFx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="fqEjjJrf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jf+A8dFx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B67671D000C4;
	Tue,  7 Apr 2026 11:53:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Apr 2026 11:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775577203;
	 x=1775663603; bh=acpwVpVHaxM2gqPzIdqA4r98PJTKh/ATVdgBNq5fB6Y=; b=
	fqEjjJrfS2MFNu2zlGMadIrOfA/jEZ4Z0ZbCr6S/nvwXPdnNXHiW4DziQCJP7geN
	JVcEFWwR45pWo/Bs3ylSJJYApzhChjidRAKW1qJSpWlyNfyRBk0ErT4zKpo/ydPf
	XD9QMnqtBEzgTI5I+V2IuYNv2tFcTQo1UDMIM/85Nt/lUewqVMz0hAmBi81rCedn
	agvKtZwS82JPPuVnYGilVbVzJzmH05wvGExG0VxM1CHx1dw7PknG34/UlW7gTYHO
	qMpvmMLZLGYJurvFt+0cHs26v1pwPyCYkHKIN+L2nQTNYu0X7GbSGW/dMJ2cDsiy
	en9F2c0FL0YeA1uX/zLt/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775577203; x=
	1775663603; bh=acpwVpVHaxM2gqPzIdqA4r98PJTKh/ATVdgBNq5fB6Y=; b=J
	f+A8dFxSdk4Cp+sjdzmyckxxB5Yu6lFUkASdAsHAlu0FCiKxNExaLzEgBAXZ64FI
	PYDA8rRnSufBqel55eNYI30cTj2lXebTnYFsFgZ5qwVOEcJ0EgB6E9lZFL4STaLc
	JTde98DxTD8EtATl1brNpWtAiM2THh0JcfdITC3TMojtLq8Z04XSeu/aW1EhmHRB
	QZkqWGB8nU3OZUVRpEEGqEa/AjEgi49iZ02cruW5skyRi94n/gdXNP9rzBN+ZFi/
	VXTkW8dHxa/qg224/WqgUXkPTYPlxXPXKGpkxg9beqU9rSTBGFoYf39+R80Nr6dh
	EhLFF15jNZjzXEhnOWFUA==
X-ME-Sender: <xms:cyjVaYiIfuJr2Sk-kCHe6kojGnxB7WC6UAJrnAEJW7l9ftibdxkKfA>
    <xme:cyjVaZIj6Rb-hA_eWeZ-E3VPnSfBy9LPsQ6ZzUBo52fZclr9jI75V7uCH4AXy5XZm
    LBR_cmA9a8F91a1vOh53ia0nk8_ux1Etu9MCFnMZdJwM6IcWdG_7A>
X-ME-Received: <xmr:cyjVafleamecdhAA8mkn2jyhf5ABwVDw_Yth5hEt2WnQKf6vK_hcnEw5bVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvuddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgsehtjeertd
    ertddvnecuhfhrohhmpeetlhgvgicuhghilhhlihgrmhhsohhnuceorghlvgigsehshhgr
    iigsohhtrdhorhhgqeenucggtffrrghtthgvrhhnpedvkeefjeekvdduhfduhfetkedugf
    duieettedvueekvdehtedvkefgudegveeuueenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspg
    hrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhifhhm
    sehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugidqshefledtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtoheptg
    hlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:cyjVaZOklGc2ohLCIAEY-lvKNTXz8IW-ycZ_PwjXIUAk7uEycT4Ujg>
    <xmx:cyjVaR5GmlRCShvpLwaw-tp_4kYS53uILAT6Vk6wU5CxC11NMTZXyA>
    <xmx:cyjVaVZuxK1v1cfGY7knPf8Tq4wfzDrBS2Ly1tp-mlUhXNJZzBkQPw>
    <xmx:cyjVaWdJ9lsnBMYUWzTtiUCkYhV19bIuL5N6dxFf9nBRCFI245-3Rw>
    <xmx:cyjVafSbeVDY6bQP9HY3fH4F96Vl0yvuNYVYHYFYlhYJW_K1xLrD-lJL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 11:53:22 -0400 (EDT)
Date: Tue, 7 Apr 2026 09:53:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v12 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260407095321.6086a080@shazbot.org>
In-Reply-To: <20260330174011.1161-6-alifm@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
	<20260330174011.1161-6-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:40:09 -0700
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
>  include/uapi/linux/vfio.h        | 18 ++++++++++++++++
>  4 files changed, 65 insertions(+)
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
> index 27ac280f00b9..647a9e8f348d 100644
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
> +	return -ENOTTY;
> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0658095ac5b1..0a8663879eee 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,42 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err = {};
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

Inconsistent that this isn't a helper exported from the previous patch.

What's the meaning of err.pec = 0?  Could this be interpreted as an
error itself?

> +
> +	err.version = 1;
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
> index bb7b89330d35..2552eef42000 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1510,6 +1510,24 @@ struct vfio_device_feature_dma_buf {
>  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery
> + * involves platform firmware and notification to operating system is done
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows userspace to take appropriate actions to handle an
> + * error on the device. The pending_errors provide any additional errors
> + * pending for the device, and userspace should read until zero.
> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u8 version;
> +	__u8 pending_errors;
> +	__u16 pec;
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 12

12 is used in linux-next by the PRECOPY_INFOv2 feature.  Thanks,

Alex

> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

