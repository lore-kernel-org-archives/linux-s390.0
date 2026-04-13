Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4D344030;
	Mon, 13 Apr 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121084; cv=none; b=vDRZtweJrolZzstWMTFp0f3vVKDchCpLFbhJOUqfhPMzh9yAYTI7sKEeWdl+32DkZQaaEl01xuyQaaS1Ua1jG6HtkpsCsw22Q6nU3WdTfaGmI0zfcLqVshsLPhj+aI3Kq0yOjMQCj2gsb9zHOTgaH1ZtrQgbQ28NZKFgrSxzYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121084; c=relaxed/simple;
	bh=T65vjW3ln7RnLzou1KlmiqfAkTKogbtofHn/WGoV0OU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6W0WwzK7rs/2eT8gk6ftIAHH8LY3SHZwX6Rql7qz/0QcNQgCfcrPU8582fWoJoqqCKqoctdoGcbE7hSEAMNVU4A3batmjErQnP/Y1rhXk7PYWbw5Ovr1qSEnCg2t4imykYLC/qNw31p8MuYNkGaNmVk0yTz5kJJj0O+eCC5LgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=sFWUgu7o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z110tKhh; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="sFWUgu7o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z110tKhh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1786CEC049A;
	Mon, 13 Apr 2026 18:58:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 18:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776121082;
	 x=1776207482; bh=L53ZKnsNwzHCkMZLz5adh9nwFhC/OP8f3LxsohqLMOM=; b=
	sFWUgu7ohDodVom3kand+FiIPaYefUeu2gkZtUT0yyzPLLBQmFuJod/ydcl50gK8
	DS88F9JlFin1B4R0fY0HA5SMlEO0ajKvndw4DwqaGYPx7EscTVDiafNmN2erYpLW
	nYhIHf9rpXmXV5fQHFht7bhQjcCPg3Y6y0P2rfg7WaFtXjntt5LiUbeJQSDiqJVF
	WM9AJoIM6rUML3FeWuRVmPAAIjdDYqFFlfLaB3vOIp7xK9xWCE1+h27uXwlV2/iE
	5WCVGkyw0vOTjvqARvpYx4/LgAqiMiQtOJk/FeRuZED9j5LHvzCxN+OFboSz1cAJ
	lWaUAweApMKUHEbP75vChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776121082; x=
	1776207482; bh=L53ZKnsNwzHCkMZLz5adh9nwFhC/OP8f3LxsohqLMOM=; b=Z
	110tKhhhWlTRCYa26chwCLPZJs+Sf3fTpW4fLqAQeSITRLw1GVLP8qMoK12amXo5
	Kn3PbFYNSGU5d/m8S7IcaZADCzRyKNVh7CMLea3wPCtRohBDdZCk3NNm8UVc/SVe
	oBshLuYRIQENLQUFL9Mzoq/YjrfvG15pH/3bjr4RXYo5/5DYkxzzkiBjI4Drb6e8
	LKqjdJzHDu+vEVBqxFjPukpO/V6ORB+WvRphZU/I6hQC1y99mhF30gwZQaoppijO
	4AwkbsgwD6+QgTKTml2gd+2NRTNcQF0H+GFMiIuP/xtDiIhZA2Uv2GMNlbOS4waK
	dA/IG3hF06Re/HCEp9Snw==
X-ME-Sender: <xms:-XTdaVd5P_JnpHBprTwDxdGn4xfQv97L7HJFIghbUT5cQAmnS-H5-Q>
    <xme:-XTdabWlPaW0RPZLzKV6xsRn1BUXKmNVLsf_lxchSlFF2PrUatC79okGuRGpWy5X2
    CqKSRg90-ONGOJIyHkVqS1aBjguWfvhTwswMiiec-NYLD3zPT_fWg>
X-ME-Received: <xmr:-XTdaeA5lUAzBYpyEjQ2qBbJvLaCzqa3lYsw3EdI7rrjQatJl2VPgqKgsJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleehudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:-XTdae5ic35JrQeZbXf6K3OjNACWRPj1XO0qBmdKRv5-_l2hpP6KNA>
    <xmx:-XTdad0UW5asWts_JbBYZf_BvCv5IfLvRiMyS-XPufve9LoYHKSyZw>
    <xmx:-XTdaakPsCDUh6hasAf26gL7QMf_fMN2oqwa6hi2QzrMgHuBOz014A>
    <xmx:-XTdab6Lvq-YTIrrIZ7MC1WjZvilRW45bgDHfABpsc-_G6p6v5LpHA>
    <xmx:-nTdacsEqDwkwJILbPkeyuQ6cDHpr5DkbQiCW3RXcQGp5jqyl16WMX4N>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 18:58:00 -0400 (EDT)
Date: Mon, 13 Apr 2026 16:57:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260413165758.0f87312b@shazbot.org>
In-Reply-To: <20260413210608.2912-6-alifm@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
	<20260413210608.2912-6-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 14:06:06 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      |  3 +++
>  arch/s390/pci/pci_event.c        | 19 +++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 31 +++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 20 ++++++++++++++++++++
>  6 files changed, 84 insertions(+)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 9a6a4eb9d7c1..9c8ee97d7e8a 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -360,6 +360,9 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>  int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>  void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>  void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
> +				      struct zpci_ccdf_err *ccdf,
> +				      int *count);
>  
>  #ifdef CONFIG_NUMA
>  
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index c279a9f50a64..c8714d4a32fa 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -74,6 +74,25 @@ static void zpci_store_pci_error(struct pci_dev *pdev,
>  	zdev->pending_errs.count++;
>  }
>  
> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
> +				      struct zpci_ccdf_err *ccdf,
> +				      int *count)
> +{
> +	int head = 0;

Unnecessary.  Should also be a blank line between variable declaration
and code.

> +	*count = 0;

But why do we zero this and not ccdf?

> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count) {
> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +		memcpy(ccdf, &zdev->pending_errs.err[head],
> +		       sizeof(struct zpci_ccdf_err));
> +		zdev->pending_errs.head++;
> +		zdev->pending_errs.count--;
> +		*count = zdev->pending_errs.count;
> +	}
> +}

You've describe in the uAPI now how pec = 0 means no error, but why not
remove that ambiguity altogether and return -ENOMSG in that case.  We
could start here and pass it through:

{
	int head;

	guard(mutex)(&zdev->pending_errs_lock);

	if (!zdev->pending_errs.count)
		return -ENOMSG;

	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
	memcpy(ccdf, &zdev->pending_errs.err[head],
	       sizeof(struct zpci_ccdf_err));
	zdev->pending_errs.head++;
	zdev->pending_errs.count--;
	*count = zdev->pending_errs.count;

	return 0;
}

> +EXPORT_SYMBOL_GPL(zpci_get_pending_error_and_count);
> +
>  void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>  {
>  	guard(mutex)(&zdev->pending_errs_lock);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index ad52abc46c04..5403730786a1 100644
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
> index fca9d0dfac90..4e7162234a2e 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				struct vfio_info_cap *caps);
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
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
> index 0658095ac5b1..ee1647f0ffe6 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,37 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err = {};
> +	struct vfio_pci_core_device *vdev;
> +	struct zpci_ccdf_err ccdf = {};
> +	struct zpci_dev *zdev;
> +	int pending_errors = 0;
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
> +	zpci_get_pending_error_and_count(zdev, &ccdf, &pending_errors);
> +
> +	err.version = 1;
> +	err.pec = ccdf.pec;
> +	err.pending_errors = pending_errors;
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
> index 5de618a3a5ee..2980ca39dd38 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
> + * involves platform firmware and notification to operating system is done
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows it to take appropriate actions to handle an
> + * error on the device. The pending_errors provide any additional errors
> + * pending for the device, and userspace should read until zero. A value of
> + * 0 for pending_errors and pec would indicate no pending errors that need
> + * to be handled.
> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u8 version;
> +	__u8 pending_errors;
> +	__u16 pec;
> +};

I assume .version is for compatibility, but we don't define a strategy
for using it or specify what the version should be for this table.  It
doesn't seem like there's actually an value-add to having it.

I'm also not clear why we need to report .pending_errors.  It mostly
seems like another ambiguous feature of this API.  The value seems
volatile and the suggestion is to read until zero, so why provide the
value at all, the user can just read until -ENOMSG.

At that point, maybe we don't even need a return structure at all,
return small positive values for pec or -errno.  The internal API could
match, avoiding the pass by address parameters.  Thanks,

Alex


> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

