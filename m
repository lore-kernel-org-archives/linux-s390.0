Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D32FB991
	for <linux-s390@vger.kernel.org>; Wed, 13 Aug 2025 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125801; cv=none; b=CpDUMgMGaJRIN14i7xJtrG/u6jUhnVUeb68OYGqP8t1Qo9aex9njdMYRMNypmz2d4du9DQQ2gRdXV2YBLjA/ADln7Ya0Mleqi9GDWabaIHP5mZdVOKSFp61qyY7WaaW+oFc/IUIgDsmYhurae+Sif6gj5LXg8yb4tN3tCAJC4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125801; c=relaxed/simple;
	bh=4e0l/gwaTIMLD9bL4migSckiVZwpKkWavSLci6fpGpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9K4ZT4Z9b0VHBjPhV2khsbyTIyw2k4xx1736GeBbu7xnEkFII2TEpl+FFvxJ8z0TcOrq+dFY96kwGZTBuwLzZuCyBc6O8lFYaTh78/Cx/39A7iD8ioyY6ea4UofWGCRTFOqBZQO4XDE68cKPGy8NirRmneim5n4q6wd/WQqToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHH2wnGo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHH2wnGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755125798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLeTfhKhkO7buQ+Gq1sRAvaCeEwy+ke7zDoFKoCbE0A=;
	b=jHH2wnGoAZuROb7+2DO/RsEQDDh37ykKYu2WLqb5Z9eYybOq8etrvfFFrhETHn0BpH5mk6
	2eqioMBpfYJGA0GMj4zqWh43a0IGtn5n+wR+DhJwkx6Q7oeLAIL2Kb4KN9DkGd8ZTbtHan
	hv55rcn6faHDcc2kkjpqVN6nRuu7XnY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-EZsh4mvdPfC0oJlMLWLPbg-1; Wed, 13 Aug 2025 18:56:37 -0400
X-MC-Unique: EZsh4mvdPfC0oJlMLWLPbg-1
X-Mimecast-MFC-AGG-ID: EZsh4mvdPfC0oJlMLWLPbg_1755125796
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e5700121d7so958215ab.2
        for <linux-s390@vger.kernel.org>; Wed, 13 Aug 2025 15:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125796; x=1755730596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLeTfhKhkO7buQ+Gq1sRAvaCeEwy+ke7zDoFKoCbE0A=;
        b=XIbktdVqfnb0WjuikR2tyer1DUaDlpUO4fYV0Xo9dTzVFEWIXIiQHmcFWfe+MOSOFa
         mj+Saw+DEnkbk9rO++Fylz0gJmLIp9TO9CurovauejlDNOd46plMKeD17baWHHI4DGhz
         +rJTdfd9zRv+LG8YB5/pFZFhoHIdr5iH4ITufmTO7IS/w4sn5SvSyqkDrgkNz3SnblLv
         ahq2Lbbbp68rhq0/vN2q6KJVLRmHxNVhq11NznbcX91b1998W0unO5C5tdFlx22v+K7l
         CbPGmB5UygbA62Lghq25Phkl0TTi2UlHXmcuU4l6BM+FXTe3bwFKKXNxKYtU6re1EODx
         REUg==
X-Gm-Message-State: AOJu0YxG08MBysFkdrN/JdAR3TVXxjTv4PoO6+C/cvZZavvaex9A0Td0
	g/fLCbOPrjUFdBvdmXssAacwcjBEEEYzrHg8083yluhLIzGpH/ugIEHtofK86XFWx+crg0FmYL+
	C31yNOJSphBEhsebuLkWDc3u/hgpxiBwqXDImh47ljdJTRoP6tMHY4jqADqR+h0A=
X-Gm-Gg: ASbGncuDFsbhtNal0acm9Ecr6n4NALKNg2Rt0gtC/y8oREehPvN27Ein5CVycvYs9/B
	I2WgEGX3ybPbE5CkpAXbF57QzctMH5+/uGieav6Gr0pUj5xLqgaZ4P0l2ZSKU0wnHb6c8PbVsIU
	UXFlvfc+rst9v6TAspkkeALaCam44IXf/5ioH5S0zSA3gQsbREfS9SXDBIhTNMVVoypI6uY5/mD
	bRQiizRJnx1pQtznhudbsYirAxdFNpDC+/wCGl3MNBBGcqD3qyMziXY1kEtmhM4upTkegvklmyS
	RG7biJMw/we5NxbB/QQPm1hjxHD+l1ZCRUNIFtMBxpw=
X-Received: by 2002:a05:6e02:216a:b0:3e5:151e:6652 with SMTP id e9e14a558f8ab-3e57077bac5mr4982745ab.2.1755125796303;
        Wed, 13 Aug 2025 15:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGktdX8bRcKWgKmUrfDsEuQvcB5qH6b2PxIASOhiJyxcRZsecjKLRc1k18NJ79Q05dhZSHjaQ==
X-Received: by 2002:a05:6e02:216a:b0:3e5:151e:6652 with SMTP id e9e14a558f8ab-3e57077bac5mr4982635ab.2.1755125795883;
        Wed, 13 Aug 2025 15:56:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cc1bb3sm60160555ab.32.2025.08.13.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 15:56:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:56:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com
Subject: Re: [PATCH v1 5/6] vfio-pci/zdev: Perform platform specific
 function reset for zPCI
Message-ID: <20250813165631.7c22ef0f.alex.williamson@redhat.com>
In-Reply-To: <7059025f-f337-493d-a50c-ccce8fb4beee@linux.ibm.com>
References: <20250813170821.1115-1-alifm@linux.ibm.com>
	<20250813170821.1115-6-alifm@linux.ibm.com>
	<20250813143034.36f8c3a4.alex.williamson@redhat.com>
	<7059025f-f337-493d-a50c-ccce8fb4beee@linux.ibm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 14:52:24 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 8/13/2025 1:30 PM, Alex Williamson wrote:
> > On Wed, 13 Aug 2025 10:08:19 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> For zPCI devices we should drive a platform specific function reset
> >> as part of VFIO_DEVICE_RESET. This reset is needed recover a zPCI device
> >> in error state.
> >>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   arch/s390/pci/pci.c              |  1 +
> >>   drivers/vfio/pci/vfio_pci_core.c |  4 ++++
> >>   drivers/vfio/pci/vfio_pci_priv.h |  5 ++++
> >>   drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
> >>   4 files changed, 49 insertions(+)
> >>
> >> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> >> index f795e05b5001..860a64993b58 100644
> >> --- a/arch/s390/pci/pci.c
> >> +++ b/arch/s390/pci/pci.c
> >> @@ -788,6 +788,7 @@ int zpci_hot_reset_device(struct zpci_dev *zdev)
> >>   
> >>   	return rc;
> >>   }
> >> +EXPORT_SYMBOL_GPL(zpci_hot_reset_device);
> >>   
> >>   /**
> >>    * zpci_create_device() - Create a new zpci_dev and add it to the zbus
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 7dcf5439dedc..7220a22135a9 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1227,6 +1227,10 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
> >>   	 */
> >>   	vfio_pci_set_power_state(vdev, PCI_D0);
> >>   
> >> +	ret = vfio_pci_zdev_reset(vdev);
> >> +	if (ret && ret != -ENODEV)
> >> +		return ret;
> >> +
> >>   	ret = pci_try_reset_function(vdev->pdev);
> >>   	up_write(&vdev->memory_lock);  
> > You're going to be very unhappy if this lock isn't released.
> >  
> Ah yes, thanks for catching that. Will fix this.
> 
> >  
> >>   
> >> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> >> index a9972eacb293..5288577b3170 100644
> >> --- a/drivers/vfio/pci/vfio_pci_priv.h
> >> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> >> @@ -86,6 +86,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   				struct vfio_info_cap *caps);
> >>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
> >>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> >> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev);
> >>   #else
> >>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   					      struct vfio_info_cap *caps)
> >> @@ -100,6 +101,10 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >>   
> >>   static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> >>   {}
> >> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev)
> >> +{
> >> +	return -ENODEV;
> >> +}
> >>   #endif
> >>   
> >>   static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> >> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> >> index 818235b28caa..dd1919ccb3be 100644
> >> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> >> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> >> @@ -212,6 +212,45 @@ static int vfio_pci_zdev_setup_err_region(struct vfio_pci_core_device *vdev)
> >>   	return ret;
> >>   }
> >>   
> >> +int vfio_pci_zdev_reset(struct vfio_pci_core_device *vdev)
> >> +{
> >> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> >> +	int rc = -EIO;
> >> +
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	/*
> >> +	 * If we can't get the zdev->state_lock the device state is
> >> +	 * currently undergoing a transition and we bail out - just
> >> +	 * the same as if the device's state is not configured at all.
> >> +	 */
> >> +	if (!mutex_trylock(&zdev->state_lock))
> >> +		return rc;
> >> +
> >> +	/* We can reset only if the function is configured */
> >> +	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
> >> +		goto out;
> >> +
> >> +	rc = zpci_hot_reset_device(zdev);
> >> +	if (rc != 0)
> >> +		goto out;
> >> +
> >> +	if (!vdev->pci_saved_state) {
> >> +		pci_err(vdev->pdev, "No saved available for the device");
> >> +		rc = -EIO;
> >> +		goto out;
> >> +	}
> >> +
> >> +	pci_dev_lock(vdev->pdev);
> >> +	pci_load_saved_state(vdev->pdev, vdev->pci_saved_state);
> >> +	pci_restore_state(vdev->pdev);
> >> +	pci_dev_unlock(vdev->pdev);
> >> +out:
> >> +	mutex_unlock(&zdev->state_lock);
> >> +	return rc;
> >> +}  
> > This looks like it should be a device or arch specific reset
> > implemented in drivers/pci, not vfio.  Thanks,
> >
> > Alex  
> 
> Are you suggesting to move this to an arch specific function? One thing 
> we need to do after the zpci_hot_reset_device, is to correctly restore 
> the config space of the device. And for vfio-pci bound devices we want 
> to restore the state of the device to when it was initially opened.

We generally rely on the abstraction of pci_reset_function() to select
the correct type of reset for a function scope reset.  We've gone to
quite a bit of effort to implement all device specific resets and
quirks in the PCI core to be re-used across the kernel.

Calling zpci_hot_reset_device() directly seems contradictory to those
efforts.  Should pci_reset_function() call this universally on s390x
rather than providing access to FLR/PM/SBR reset?  Why is it
universally correct here given the ioctl previously made use of
standard reset mechanisms?

The DEVICE_RESET ioctl is simply an in-place reset of the device,
without restoring the original device state.  So we're also subtly
changing that behavior here, presumably because we're targeting the
specific error recovery case.  Have you considered how this might
break non-error-recovery use cases?

I wonder if we want a different reset mechanism for this use case
rather than these subtle semantic changes.  Thanks,

Alex

