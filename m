Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597642D7BF;
	Mon,  9 Mar 2026 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041938; cv=none; b=A/vGIFBtaGLf//Pqw6mHvM6jdGyxSsybPMnMkzKCOYN+vk2Abi0lD/Wl9P1ZvJOY3yyUhXt6srt/zUPDRw66bcVwUJ/KkR3RZXnB94H+TamM8CCoI0Iet/y/ZGu1GPjQ506udUS+nmdlhV69slVH61Zy7u6PONmuqTkGnsLWQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041938; c=relaxed/simple;
	bh=KxEdllr3ONVpssJ4VlezksLnFM6tHr56Ckj8WFIfRlc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K4IhQPxrz4mQZLwiXH4CpHz+gn70X43FXFyF9p/tWFVgD1zO5YoWwOZQHvJ3FWyR/tlHNgF5p74rq1Qb/vSJP/0rfoGu7c+OJdylVDwI50RDdXHkXo2Px8oA0WAwlH7+qxlJSa7QBuIjG0vbB7QKKx4IMDJrNETK0BYXvTkIewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFsAe5do; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFsAe5do"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773041937; x=1804577937;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KxEdllr3ONVpssJ4VlezksLnFM6tHr56Ckj8WFIfRlc=;
  b=mFsAe5dogqFpSPuw3XJa/hP3JKiB1o5rmMZBajKCst+YVtzYtUycWgn2
   EVRZ1Q7Geo+U2ig9lvtCfCWQuLjMUxjMfbCadxwdC0uF70Bmh1uXU107x
   cQRG3QBNKVmSRlrQJhMyS1ZvPpUjSivys2jevnFI8KPlCOYqQx5XNeaHC
   SD3YZDzSars0UlrzsDcOaB/+IeaDlP5Z1mubnfTbbRGkmIv69gXI8GgvC
   34UsCv0GaYbLP1dsVoj3haxv7oFL/yswd56EzwoZmYZ7ZBwQ0eMsXlOJk
   0Ns9li4gnaJxOsJ5b1HdEM2CuW3hS4kujEyFtn+MclN9Tt66bLHVlr30q
   w==;
X-CSE-ConnectionGUID: HjhlJQFlQ+yi/O7dCyzBnQ==
X-CSE-MsgGUID: OC+SUNRpRyaOprc3c0LNVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="76661594"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="76661594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 00:38:56 -0700
X-CSE-ConnectionGUID: Sp8+O0lBQgSm+gCxbQs6AA==
X-CSE-MsgGUID: 7VJxtpdxSHixGJa4GYv3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="250145681"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 00:38:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 09:38:45 +0200 (EET)
To: Benjamin Block <bblock@linux.ibm.com>
cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, 
    Niklas Schnelle <schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    linux-s390 <linux-s390@vger.kernel.org>, 
    Andreas Krebbel <krebbel@linux.ibm.com>, 
    Julian Ruess <julianr@linux.ibm.com>, 
    Matthew Rosato <mjrosato@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Gerd Bayer <gbayer@linux.ibm.com>, linux-pci <linux-pci@vger.kernel.org>, 
    Tobias Schumacher <ts@linux.ibm.com>, 
    linux-kernel <linux-kernel@vger.kernel.org>, 
    Ionut Nechita <ionut.nechita@windriver.com>, 
    Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH 4/4] s390/pci: Use lock guard for
 pci_rescan_remove_lock
In-Reply-To: <7be9c8ad56f5ef9366316c3621dece9a10f3eb8b.1772815642.git.bblock@linux.ibm.com>
Message-ID: <4ad9163b-8ab6-841d-4a58-d10c7f4cdd07@linux.intel.com>
References: <cover.1772815642.git.bblock@linux.ibm.com> <7be9c8ad56f5ef9366316c3621dece9a10f3eb8b.1772815642.git.bblock@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 6 Mar 2026, Benjamin Block wrote:

> There are quite a few places in the s390 architecture code for the PCI
> subsystem where the kernel needs to lock `pci_rescan_remove_lock` now;
> which is done by calling pci_lock_rescan_remove() to lock, and
> pci_unlock_rescan_remove() to unlock the mutex.
> 
> Instead of always manually calling both functions, which induces a
> certain amount of visual clutter, and in some cases of errors, cleanup,
> and jumplabels more complexity, use either guard() or scoped_guard()
> depending on the context.
> 
> Convert all users in the s390 architecture code for PCI.
> 
> Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c       |  8 +++----
>  arch/s390/pci/pci_bus.c   |  3 +--
>  arch/s390/pci/pci_event.c | 45 +++++++++++++++++----------------------
>  arch/s390/pci/pci_iov.c   |  3 +--
>  arch/s390/pci/pci_sysfs.c |  9 +++-----
>  5 files changed, 27 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index fd16e6ad21c1..86ef1e516857 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -632,10 +632,9 @@ void pcibios_release_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(pdev);
>  
> -	pci_lock_rescan_remove();
> +	guard(pci_rescan_remove)();
>  	zpci_unmap_resources(pdev);
>  	zpci_zdev_put(zdev);
> -	pci_unlock_rescan_remove();
>  }
>  
>  int pcibios_enable_device(struct pci_dev *pdev, int mask)
> @@ -1213,9 +1212,8 @@ static int __init pci_base_init(void)
>  	if (rc)
>  		goto out_irq;
>  
> -	pci_lock_rescan_remove();
> -	rc = zpci_scan_devices();
> -	pci_unlock_rescan_remove();
> +	scoped_guard(pci_rescan_remove)
> +		rc = zpci_scan_devices();
>  	if (rc)
>  		goto out_find;
>  
> diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
> index 2b598222c621..c1b48b572e86 100644
> --- a/arch/s390/pci/pci_bus.c
> +++ b/arch/s390/pci/pci_bus.c
> @@ -82,9 +82,8 @@ int zpci_bus_scan_device(struct zpci_dev *zdev)
>  	if (!pdev)
>  		return -ENODEV;
>  
> -	pci_lock_rescan_remove();
> +	guard(pci_rescan_remove)();
>  	pci_bus_add_device(pdev);
> -	pci_unlock_rescan_remove();
>  
>  	return 0;
>  }
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index edfaeed737ac..98253706b591 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -342,9 +342,8 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
>  no_pdev:
>  	if (zdev)
>  		mutex_unlock(&zdev->state_lock);
> -	pci_lock_rescan_remove();
> +	guard(pci_rescan_remove)();
>  	zpci_zdev_put(zdev);
> -	pci_unlock_rescan_remove();
>  }
>  
>  void zpci_event_error(void *data)
> @@ -389,7 +388,6 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
>  	bool existing_zdev = !!zdev;
>  	enum zpci_state state;
> -	int rc;
>  
>  	zpci_dbg(3, "avl fid:%x, fh:%x, pec:%x\n",
>  		 ccdf->fid, ccdf->fh, ccdf->pec);
> @@ -403,12 +401,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_CONFIGURED);
>  			if (IS_ERR(zdev))
>  				break;
> -			pci_lock_rescan_remove();
> -			rc = zpci_add_device(zdev);
> -			pci_unlock_rescan_remove();
> -			if (rc) {
> -				kfree(zdev);
> -				break;
> +			scoped_guard(pci_rescan_remove) {
> +				if (zpci_add_device(zdev)) {
> +					kfree(zdev);
> +					break;
> +				}
>  			}
>  		} else {
>  			if (zdev->state == ZPCI_FN_STATE_RESERVED)
> @@ -425,12 +422,11 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  			zdev = zpci_create_device(ccdf->fid, ccdf->fh, ZPCI_FN_STATE_STANDBY);
>  			if (IS_ERR(zdev))
>  				break;
> -			pci_lock_rescan_remove();
> -			rc = zpci_add_device(zdev);
> -			pci_unlock_rescan_remove();
> -			if (rc) {
> -				kfree(zdev);
> -				break;
> +			scoped_guard(pci_rescan_remove) {
> +				if (zpci_add_device(zdev)) {
> +					kfree(zdev);
> +					break;
> +				}
>  			}
>  		} else {
>  			if (zdev->state == ZPCI_FN_STATE_RESERVED)
> @@ -459,33 +455,30 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  			/* The 0x0304 event may immediately reserve the device */
>  			if (!clp_get_state(zdev->fid, &state) &&
>  			    state == ZPCI_FN_STATE_RESERVED) {
> -				pci_lock_rescan_remove();
> +				guard(pci_rescan_remove)();
>  				zpci_device_reserved(zdev);
> -				pci_unlock_rescan_remove();
>  			}
>  		}
>  		break;
>  	case 0x0306: /* 0x308 or 0x302 for multiple devices */
> -		pci_lock_rescan_remove();
> -		zpci_remove_reserved_devices();
> -		zpci_scan_devices();
> -		pci_unlock_rescan_remove();
> +		scoped_guard(pci_rescan_remove) {
> +			zpci_remove_reserved_devices();
> +			zpci_scan_devices();
> +		}
>  		break;
>  	case 0x0308: /* Standby -> Reserved */
>  		if (!zdev)
>  			break;
> -		pci_lock_rescan_remove();
> -		zpci_device_reserved(zdev);
> -		pci_unlock_rescan_remove();
> +		scoped_guard(pci_rescan_remove)
> +			zpci_device_reserved(zdev);

Order in this series is weird. Why not introduce *guard() support before 
the fix (reorder patches 2 and 3) and then use guard direct here so you 
don't have to immediately change the code again to "convert" it to use 
*guard() in patch 4?

-- 
 i.

>  		break;
>  	default:
>  		break;
>  	}
>  	if (existing_zdev) {
>  		mutex_unlock(&zdev->state_lock);
> -		pci_lock_rescan_remove();
> +		guard(pci_rescan_remove)();
>  		zpci_zdev_put(zdev);
> -		pci_unlock_rescan_remove();
>  	}
>  }
>  
> diff --git a/arch/s390/pci/pci_iov.c b/arch/s390/pci/pci_iov.c
> index 13050ce5c3e9..1f7e4dd018e7 100644
> --- a/arch/s390/pci/pci_iov.c
> +++ b/arch/s390/pci/pci_iov.c
> @@ -38,10 +38,9 @@ void zpci_iov_map_resources(struct pci_dev *pdev)
>  
>  void zpci_iov_remove_virtfn(struct pci_dev *pdev, int vfn)
>  {
> -	pci_lock_rescan_remove();
> +	guard(pci_rescan_remove)();
>  	/* Linux' vfid's start at 0 vfn at 1 */
>  	pci_iov_remove_virtfn(pdev->physfn, vfn - 1);
> -	pci_unlock_rescan_remove();
>  }
>  
>  static int zpci_iov_link_virtfn(struct pci_dev *pdev, struct pci_dev *virtfn, int vfid)
> diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
> index c2444a23e26c..f5027aa95928 100644
> --- a/arch/s390/pci/pci_sysfs.c
> +++ b/arch/s390/pci/pci_sysfs.c
> @@ -98,9 +98,9 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
>  	WARN_ON_ONCE(!kn);
>  
>  	/* Device needs to be configured and state must not change */
> -	mutex_lock(&zdev->state_lock);
> +	guard(mutex)(&zdev->state_lock);
>  	if (zdev->state != ZPCI_FN_STATE_CONFIGURED)
> -		goto out;
> +		return count;
>  
>  	/* device_remove_file() serializes concurrent calls ignoring all but
>  	 * the first
> @@ -112,15 +112,12 @@ static ssize_t recover_store(struct device *dev, struct device_attribute *attr,
>  	 * Once it unblocks from pci_lock_rescan_remove() the original pdev
>  	 * will already be removed.
>  	 */
> -	pci_lock_rescan_remove();
> +	guard(pci_rescan_remove)();
>  	if (pci_dev_is_added(pdev)) {
>  		ret = _do_recover(pdev, zdev);
>  	}
>  	pci_rescan_bus(zdev->zbus->bus);
> -	pci_unlock_rescan_remove();
>  
> -out:
> -	mutex_unlock(&zdev->state_lock);
>  	if (kn)
>  		sysfs_unbreak_active_protection(kn);
>  	return ret ? ret : count;
> 
