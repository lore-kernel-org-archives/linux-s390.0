Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D653E7174;
	Tue, 14 Apr 2026 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175966; cv=none; b=IjcHI4S3lZ0iXNlo/kpOb9uc2+fKh9ArtYrFg/5J6d3t1kOx/QRWGm6B3j4smCMW0ERxyXkSwjvU8BewVpiNWV0+OYVRutl+2phbnrhPPIBqgryviD9s961aIkA+cg3IDuY5G02OblsVhi0R3huLXj7z8o0AsjfdoI9SYl3fprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175966; c=relaxed/simple;
	bh=uAVJpJnZIO7KMMB/lw9nwEAyap4Nw8wh6yxkAuFuE+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktssHip6aPr+kjjrTfcWsj4az1T9BlNdKW3FG8tiethKQ/e2Ygow/VNM8FGPpIrtljo1czqeqFF+WVqcD+Afp8sIErY8nZ8xJpl+JRm91BAgG9a71S5GIuHyBeTRw2KWP22LSrJfgeSY7wDb+cOCmo9/PsHLgqndD5496gsWvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Mvh+ZeAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sqLeKJEv; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Mvh+ZeAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sqLeKJEv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 477997A016A;
	Tue, 14 Apr 2026 10:12:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776175962;
	 x=1776262362; bh=qCvEqJRBfyR4i0siTqFXO2296KUNeGvlyJV4drI5uw0=; b=
	Mvh+ZeARXPjR10qPXOrSxEFATokBy45AKtJHb6u2cuKr9mOWq3ws1SutzxomogKO
	N46TVFpM1JxO3h6jcR8D5qIh0INdJHOA3+l6TcXrGrGoxB/tR/7Y9p5sCISBJT1Y
	eQeZ3oZH35+mpTrUAu+kTyHz3EoH1Maky8885NzaurOu+eDzYVOKmrvIEEP/8+73
	ZPvNEtl4GdjHzpFZks7GIr5hEHaq+fPKnVR9q7EVVXGz91CMwpdKtodnHXRUE1dP
	6FM5MA2a/nU4SaVTlwTjDCA4cFVXLB32Q18rccMHHnKlTUC6Xj3qxerdoPKAn8SR
	VGMXkeY0Syvv1LQ6l/F7mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776175962; x=
	1776262362; bh=qCvEqJRBfyR4i0siTqFXO2296KUNeGvlyJV4drI5uw0=; b=s
	qLeKJEvR2ft5njB02SO2wg3+OW+bydW9zI6xRNlm3awpKHAacB6QvghQVhcHwGpf
	fdZg+wlo3Y+oizxEGKdW0srQGC/dAlmH6A5EJCkK12cLvnohnAkX8C8wVUICFnbX
	tGNZG6Jw0dbgyV/7x4eVk168ZkY7rFwWQNozeLuwXgzhWWGRJ0RYYcMroq0RD1bZ
	k4vRby1M9X7D3TckVhGMcY1gwEmsZDHFHbnaiFQwVG9/AcZn7Cx++UpX1zDscGV6
	8gb5xVbqdkS21gw8r0acRARRsj3ZhBw7165vjjrCvDk6ppa9lpMsYpXxVsjhJ+O2
	D041b1DgWmYubqCjt3+Tw==
X-ME-Sender: <xms:WUveaWKO0mRvlcZX2YtMQrPdS6VZmw9x_TvyZ48s0naOBmXjbCgpCQ>
    <xme:WUveaWR96YJS2D9BjoxWGzXJ1M9-zj83I3rGtaCxULo7sAAQItHRhIAL9UoCiMmYN
    xJE6K2P49-gq1rlx0fuSLXGax7-jNhP6KaYzPUz6MoWzBMwKONbiiw>
X-ME-Received: <xmr:WUveaWNJ250eRNhy4-DQvGiDdQv4DxYleEBH8xHWVec6JzJXrsmgNrTgiUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:WUveabWv-w3dCzd0PX7m08Iigw9MluZr_gv3NREMvQ_G0C7eneTPIw>
    <xmx:WUveaZiP0oEdwQ7B0eu_ZOicXnHb7L9UU4Tw_f90fHWKBvIWC7_mng>
    <xmx:WUveaUhTNwnz90BhnEVpAMO6qcSZwjNL-_u1r16Qh2_cVRtplOHdjg>
    <xmx:WUveaXEwq3AZAnoyXeSgZKDxEv1Va89rQx7xnXZw-bRb_wWyb7PcQA>
    <xmx:Wkveaf7pNKOsHbMbJ2D1HS3AgpJy4sXrIsPpYZu6mEJiJZ-O-PjSfW6V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:12:40 -0400 (EDT)
Date: Tue, 14 Apr 2026 08:12:38 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, lukas@wunner.de,
 clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v13 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260414081238.23e2cecc@shazbot.org>
In-Reply-To: <cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
	<20260413210608.2912-6-alifm@linux.ibm.com>
	<20260413165758.0f87312b@shazbot.org>
	<cd9d7977-8b36-428c-81f2-c14b66173763@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 16:40:49 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 4/13/2026 3:57 PM, Alex Williamson wrote:
> > On Mon, 13 Apr 2026 14:06:06 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> For zPCI devices, we have platform specific error information. The platform
> >> firmware provides this error information to the operating system in an
> >> architecture specific mechanism. To enable recovery from userspace for
> >> these devices, we want to expose this error information to userspace. Add a
> >> new device feature to expose this information.
> >>
> >> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   arch/s390/include/asm/pci.h      |  3 +++
> >>   arch/s390/pci/pci_event.c        | 19 +++++++++++++++++++
> >>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
> >>   drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++++
> >>   drivers/vfio/pci/vfio_pci_zdev.c | 31 +++++++++++++++++++++++++++++++
> >>   include/uapi/linux/vfio.h        | 20 ++++++++++++++++++++
> >>   6 files changed, 84 insertions(+)
> >>
> >> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> >> index 9a6a4eb9d7c1..9c8ee97d7e8a 100644
> >> --- a/arch/s390/include/asm/pci.h
> >> +++ b/arch/s390/include/asm/pci.h
> >> @@ -360,6 +360,9 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
> >>   int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
> >>   void zpci_start_mediated_recovery(struct zpci_dev *zdev);
> >>   void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
> >> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
> >> +				      struct zpci_ccdf_err *ccdf,
> >> +				      int *count);
> >>   
> >>   #ifdef CONFIG_NUMA
> >>   
> >> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> >> index c279a9f50a64..c8714d4a32fa 100644
> >> --- a/arch/s390/pci/pci_event.c
> >> +++ b/arch/s390/pci/pci_event.c
> >> @@ -74,6 +74,25 @@ static void zpci_store_pci_error(struct pci_dev *pdev,
> >>   	zdev->pending_errs.count++;
> >>   }
> >>   
> >> +void zpci_get_pending_error_and_count(struct zpci_dev *zdev,
> >> +				      struct zpci_ccdf_err *ccdf,
> >> +				      int *count)
> >> +{
> >> +	int head = 0;  
> > Unnecessary.  Should also be a blank line between variable declaration
> > and code.
> >  
> >> +	*count = 0;  
> > But why do we zero this and not ccdf?  
> 
> I had thought of memsetting ccdf to 0, but the only caller right already 
> initializes to 0. So didn't think it was needed.

The caller initializes count as well.

> >> +
> >> +	guard(mutex)(&zdev->pending_errs_lock);
> >> +	if (zdev->pending_errs.count) {
> >> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> >> +		memcpy(ccdf, &zdev->pending_errs.err[head],
> >> +		       sizeof(struct zpci_ccdf_err));
> >> +		zdev->pending_errs.head++;
> >> +		zdev->pending_errs.count--;
> >> +		*count = zdev->pending_errs.count;
> >> +	}
> >> +}  
> > You've describe in the uAPI now how pec = 0 means no error, but why not
> > remove that ambiguity altogether and return -ENOMSG in that case.  We
> > could start here and pass it through:
> >
> > {
> > 	int head;
> >
> > 	guard(mutex)(&zdev->pending_errs_lock);
> >
> > 	if (!zdev->pending_errs.count)
> > 		return -ENOMSG;
> >
> > 	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> > 	memcpy(ccdf, &zdev->pending_errs.err[head],
> > 	       sizeof(struct zpci_ccdf_err));
> > 	zdev->pending_errs.head++;
> > 	zdev->pending_errs.count--;
> > 	*count = zdev->pending_errs.count;
> >
> > 	return 0;
> > }  
> 
> I had thought of returning an error (ENOENT was what I was going with), 
> but perhaps I misunderstood your comment from v12 about specifying pec = 
> 0 and pending error = 0 as not being an error. My assumption was as this 
> is not an error we shouldn't return an error to userspace.

I think I was trying to get clarity on how 0/0 is interpreted because
it seems like a weak point of the uAPI.  We could make a more intuitive
uAPI if we make the "I have no message of desired type" response an
explicit, unique errno, rather than a reserved pec value.

> >> +EXPORT_SYMBOL_GPL(zpci_get_pending_error_and_count);
> >> +
> >>   void zpci_start_mediated_recovery(struct zpci_dev *zdev)
> >>   {
> >>   	guard(mutex)(&zdev->pending_errs_lock);
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index ad52abc46c04..5403730786a1 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1534,6 +1534,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >>   		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >>   	case VFIO_DEVICE_FEATURE_DMA_BUF:
> >>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> >> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> >> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
> >>   	default:
> >>   		return -ENOTTY;
> >>   	}
> >> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> >> index fca9d0dfac90..4e7162234a2e 100644
> >> --- a/drivers/vfio/pci/vfio_pci_priv.h
> >> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> >> @@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   				struct vfio_info_cap *caps);
> >>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
> >>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> >> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> >> +			      void __user *arg, size_t argsz);
> >>   #else
> >>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   					      struct vfio_info_cap *caps)
> >> @@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >>   
> >>   static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> >>   {}
> >> +
> >> +static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
> >> +					    u32 flags, void __user *arg,
> >> +					    size_t argsz)
> >> +{
> >> +	return -ENOTTY;
> >> +}
> >>   #endif
> >>   
> >>   static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> >> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> >> index 0658095ac5b1..ee1647f0ffe6 100644
> >> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> >> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> >> @@ -141,6 +141,37 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   	return ret;
> >>   }
> >>   
> >> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> >> +			      void __user *arg, size_t argsz)
> >> +{
> >> +	struct vfio_device_feature_zpci_err err = {};
> >> +	struct vfio_pci_core_device *vdev;
> >> +	struct zpci_ccdf_err ccdf = {};
> >> +	struct zpci_dev *zdev;
> >> +	int pending_errors = 0;
> >> +	int ret;
> >> +
> >> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> >> +	zdev = to_zpci(vdev->pdev);
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> >> +				 sizeof(err));
> >> +	if (ret != 1)
> >> +		return ret;
> >> +
> >> +	zpci_get_pending_error_and_count(zdev, &ccdf, &pending_errors);
> >> +
> >> +	err.version = 1;
> >> +	err.pec = ccdf.pec;
> >> +	err.pending_errors = pending_errors;
> >> +	if (copy_to_user(arg, &err, sizeof(err)))
> >> +		return -EFAULT;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >>   {
> >>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index 5de618a3a5ee..2980ca39dd38 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -1534,6 +1534,26 @@ struct vfio_device_feature_dma_buf {
> >>    */
> >>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >>   
> >> +/**
> >> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> >> + * userspace for vfio-pci devices on s390x. On s390x, PCI error recovery
> >> + * involves platform firmware and notification to operating system is done
> >> + * by architecture specific mechanism. Exposing this information to
> >> + * userspace allows it to take appropriate actions to handle an
> >> + * error on the device. The pending_errors provide any additional errors
> >> + * pending for the device, and userspace should read until zero. A value of
> >> + * 0 for pending_errors and pec would indicate no pending errors that need
> >> + * to be handled.
> >> + */
> >> +
> >> +struct vfio_device_feature_zpci_err {
> >> +	__u8 version;
> >> +	__u8 pending_errors;
> >> +	__u16 pec;
> >> +};  
> > I assume .version is for compatibility, but we don't define a strategy
> > for using it or specify what the version should be for this table.  It
> > doesn't seem like there's actually an value-add to having it.  
> 
> Its possible we may need to extend this structure in the future if we 
> want to report more information to userspace. I at least want the 
> flexibility to do so. We had some discussion around this [1] in an 
> earlier version. I was trying to follow similar versioning pattern we 
> had around vfio-pci/zdev structures.

IMHO, the version field is a dead end towards achieving this,
especially if we don't specify from the onset the expected version
value or the compatibility semantics.  All that's going to happen is
that some userspace will hard code that it understands version 1
because that's what's currently reported and matches the struct defined
here, and you can never ever report anything other than version 1
without breaking that user.  At that point you need to come up with
some other means for the user to opt-in to a new version, whether it's
triggered by another feature (as we did with the PRECOPY_INFOv2 above
this), or we reimplement the whole v2 feature.

> > I'm also not clear why we need to report .pending_errors.  It mostly
> > seems like another ambiguous feature of this API.  The value seems
> > volatile and the suggestion is to read until zero, so why provide the
> > value at all, the user can just read until -ENOMSG.  
> 
> Since we don't explicitly return an error indicating there are no 
> available pci errors to handle, was why I added it. Is the preference to 
> just return linux error code here?

I think that can be interpreted as the .pending_errors field exists to
work around a deficiency in the uAPI rather than modifying the uAPI to
something that can explicitly return -ENOMSG.  Feels like we should
just start with a better uAPI.  Thanks,

Alex
