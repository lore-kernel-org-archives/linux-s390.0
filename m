Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE826A1AC
	for <linux-s390@vger.kernel.org>; Mon,  3 Nov 2025 06:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149980; cv=none; b=XkeV8Gv8hbS6PJngkiVi/JRGiUP/q/b5kJL+yVajyuv/ePXQiUBBSka1iTRABppcTx7OEtTQp8xlU+pt19D7dDIz0bgirho4xZ+MLNAb29nCZmENhep04ehyiO7c4+nPSHPHEIyvW1pAzLCrbLhHA7ApxeWB8/IZTr6ZckIjqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149980; c=relaxed/simple;
	bh=aNWT1S8ZE3WFAX7jq/LAX4FFPsVg9T8Q53OEL4HSo8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDpbGTd4sxhL0IFQ3AbMmA5GMCaDQxdzFyB35IwAjlR6VZfuvSQDzupjzZmlNcCi+vpGdTB1n81uh8J+cd8Kz1Z7ZJLDIcyTKDGBe7GBbE9f5uRPUrUG1CkAYmaNZq03Q/lPi9SXjs4tBeLLaR5VnwIlpT/TEdwnqxycOgv3AI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WP9bvsoq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WP9bvsoq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2959197b68eso184775ad.1
        for <linux-s390@vger.kernel.org>; Sun, 02 Nov 2025 22:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762149978; x=1762754778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=daEhgCusceEtpwe81ptEC+bKqGITwloFYe7hKEHFGD0=;
        b=WP9bvsoq8vhBv3AZfCZVv9OYxit2eKoz3dFIQIW0pvoS+myz985i9PidF4GcW4F5nv
         nAmQagrLw4AUX+iwq83U/bORt3/COP5uFfxgn8QZQOnRmrBAwzhdHv1+AwyqndUuQzZa
         60due/gvgAKtZVVjIDpysgAK4U0EfbCSchPvHhVUxGd5haBf1twio8gotLUugsQ/P0bq
         TSKiw1ZtvB3KT7WvpZHsJYXQTJ4v5R+Gpt+gI8pncegVjrDvneYnhelS6e42HMbuFdnr
         rRoF+uRTdemSk1z62s4zLQQhSqAGVdUV5TKWBE6alXkHZTZNn5p3kEs+LmKqz26EsD+V
         pNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762149978; x=1762754778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daEhgCusceEtpwe81ptEC+bKqGITwloFYe7hKEHFGD0=;
        b=WA3vgall+Q1KuGV9KNm82MM4RWe86bI6nDtX8AWMOO/rKwV7nwSqYBuTCoQ7a1MaTN
         acWgHn6tr+NKzaMY4snNB6Sl33UnoRLTyh/cF29EETqwcsQ4o0e52pfBu82T/vYSZvgs
         PylHf/4b+srbzr6g0EcQfb6o1Ax21KTycAy39qRd9JVDL8hL8IH6fa5YeCyoeatXYGQk
         uOXjeQsdLOvyrfl26sIUDkpqKUW8gF4eGbQ4fomJu6f7xB/1ePdNYOn34Fws2WPvYvOG
         QP3TnxuN56E8Qqn8V2YZnASe3iFodhQ3YIn+oxrd2xH5QVfHPRcqFXSc2CVV5svcyCVv
         om1A==
X-Forwarded-Encrypted: i=1; AJvYcCXW73f8u96d4P+61HW+TFsH+OG0cq8OmYPVvxkMCzf8hwrCo/yKNj7MoLS98L8euHj5ItJ6aW1ea+mo@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlNW2pYwHEnYxMsCcQAfF58Vcnu08nSvGI+4oY32LP44M4zM9
	NTj+dUjTqTtDDpCWlag5mDWhkPtn1mfWINWXDb0iF4BcY1a1bhw6uwpARDsz4Jh34Q==
X-Gm-Gg: ASbGncs1pwWeEIzgjZeEoXv6+T/OiroBShEJhUIB3VVE9xA0MIStv0LNQ16f/jULsTx
	4dn7N2QpekdMrzDNkOxvpc3FHzlwLPHzgof+hKI4lTY4WdQshOgirM0VI801qdqCHxQX8pJ/qDQ
	51zTZfHzZmojP08ldOiRh/6+Xj9SxYD3prlL1QC81lK1WwOanxUoQsQzIub16j1NLgitvVu04hg
	e2d3A2w6cqwzRlGoX91KGXT93rFLZ+1zGFbehxnQcePvKolWkHKk2uiRTu56uRVaRZnLPufse2d
	pFd8FeWfPGRxNCEZcwQPFEBpwCbtNFu5ZiGZk3VO3zjjaTnwSQRB4zDaPWjbfe8J0fP5zUi4T9x
	SOrQGXY8cfOlR/YFHsG3WLxoH9uBdBxAayxM+e/R3irm0cbKUV5/RFiuVaWFTzOuugqCALyajnh
	BAvz9zpb54uTQbXNOm8mBGICS3SVA1Z4h4gBVm1A==
X-Google-Smtp-Source: AGHT+IEluRFzLqUGHbmfa87kzbGcxD4xtCtUDt3Aesdz6fP5oqFYMacpJF/LHmpqMlg6+1lRT50KTA==
X-Received: by 2002:a17:902:ea08:b0:294:faad:8cb4 with SMTP id d9443c01a7336-29554b85496mr5533065ad.8.1762149977826;
        Sun, 02 Nov 2025 22:06:17 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a9bad978c4sm5062872b3a.13.2025.11.02.22.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:06:17 -0800 (PST)
Date: Mon, 3 Nov 2025 06:06:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	David Airlie <airlied@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Brett Creeley <brett.creeley@amd.com>,
	dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>, linux-s390@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, qat-linux@intel.com,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 02/22] vfio/hisi: Convert to the get_region_info op
Message-ID: <aQhGTwg4kpuP8pgF@google.com>
References: <0-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
 <2-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-679a6fa27d31+209-vfio_get_region_info_op_jgg@nvidia.com>

On Thu, Oct 23, 2025 at 08:09:16PM -0300, Jason Gunthorpe wrote:
> Change the function signature of hisi_acc_vfio_pci_ioctl()
> and re-indent it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 57 +++++++++----------
>  1 file changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index fde33f54e99ec5..f06dcfcf09599f 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1324,43 +1324,39 @@ static ssize_t hisi_acc_vfio_pci_read(struct vfio_device *core_vdev,
>  	return vfio_pci_core_read(core_vdev, buf, new_count, ppos);
>  }
>  
> -static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
> -				    unsigned long arg)
> +static int hisi_acc_vfio_get_region(struct vfio_device *core_vdev,
> +				    struct vfio_region_info __user *arg)
>  {
> -	if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
> -		struct vfio_pci_core_device *vdev =
> -			container_of(core_vdev, struct vfio_pci_core_device, vdev);
> -		struct pci_dev *pdev = vdev->pdev;
> -		struct vfio_region_info info;
> -		unsigned long minsz;
> +	struct vfio_pci_core_device *vdev =
> +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct vfio_region_info info;
> +	unsigned long minsz;
>  
> -		minsz = offsetofend(struct vfio_region_info, offset);
> +	minsz = offsetofend(struct vfio_region_info, offset);
>  
> -		if (copy_from_user(&info, (void __user *)arg, minsz))
> -			return -EFAULT;
> +	if (copy_from_user(&info, arg, minsz))
> +		return -EFAULT;
>  
> -		if (info.argsz < minsz)
> -			return -EINVAL;
> +	if (info.argsz < minsz)
> +		return -EINVAL;
>  
> -		if (info.index == VFIO_PCI_BAR2_REGION_INDEX) {
> -			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
> +	if (info.index != VFIO_PCI_BAR2_REGION_INDEX)
> +		return vfio_pci_ioctl_get_region_info(core_vdev, arg);
>  

I'm curious to learn the reason for flipping polarity here? (apart from
readability).

> -			/*
> -			 * ACC VF dev BAR2 region consists of both functional
> -			 * register space and migration control register space.
> -			 * Report only the functional region to Guest.
> -			 */
> -			info.size = pci_resource_len(pdev, info.index) / 2;
> +	info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
>  
> -			info.flags = VFIO_REGION_INFO_FLAG_READ |
> -					VFIO_REGION_INFO_FLAG_WRITE |
> -					VFIO_REGION_INFO_FLAG_MMAP;
> +	/*
> +	 * ACC VF dev BAR2 region consists of both functional
> +	 * register space and migration control register space.
> +	 * Report only the functional region to Guest.
> +	 */
> +	info.size = pci_resource_len(pdev, info.index) / 2;
>  
> -			return copy_to_user((void __user *)arg, &info, minsz) ?
> -					    -EFAULT : 0;
> -		}
> -	}
> -	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
> +	info.flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE |
> +		     VFIO_REGION_INFO_FLAG_MMAP;
> +
> +	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
>  }
>  
>  static int hisi_acc_vf_debug_check(struct seq_file *seq, struct vfio_device *vdev)
> @@ -1557,7 +1553,8 @@ static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
>  	.release = vfio_pci_core_release_dev,
>  	.open_device = hisi_acc_vfio_pci_open_device,
>  	.close_device = hisi_acc_vfio_pci_close_device,
> -	.ioctl = hisi_acc_vfio_pci_ioctl,
> +	.ioctl = vfio_pci_core_ioctl,
> +	.get_region_info = hisi_acc_vfio_get_region,
>  	.device_feature = vfio_pci_core_ioctl_feature,
>  	.read = hisi_acc_vfio_pci_read,
>  	.write = hisi_acc_vfio_pci_write,

The change seems to maintain original functionality and LGTM.
Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
