Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CA190464;
	Wed,  7 Aug 2024 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000189; cv=none; b=gLqNFCNfdgrDNGVtWrr/SoDqpJ12XiZyV8SJYoO/IEah5SMG90fzDveegb7kUOmYxDECeW2GJ1d5Nu8raUv6ljsOkOoLQ7nTtOVIgBpu00PGMjlJyXlIj1owMFNRHNfWw5Cwq00ffonoDlMq1RwzA5yoIuB+Qgy4uqW9P/8/f3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000189; c=relaxed/simple;
	bh=tcCwEw94oJRiTgSV9/wM7rVN49zNEGbd3/OMrNi6krI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ss1Xeu6ZCZeyCTttoeO51aQR89d+iKcxzpZy60EQLLral0ZnuF95AzGeutD9hHfOsJMRRyvGkMFGdyXeGot1M0v2jyRSKxF/tYNq5tVCSy6tT1/sV69drwd877yMw9gbgwcq0oOsbCyxZt2jyabgqSNQrPX8htn0Rtr347ubJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGMQHYzd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGMQHYzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723000188; x=1754536188;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tcCwEw94oJRiTgSV9/wM7rVN49zNEGbd3/OMrNi6krI=;
  b=hGMQHYzdxQw9nrvRio7NT6CKkEnvHOResq4A4/R16TPCjDoNyP+Vw7XF
   uN6C5+cYn/rv0hq0vb4aDs0tjp+u2gBZdCh8Zbx64ImXzO5B6m3iWtR2r
   KYtExswuUrnXoYsM4hjjZ9FjvYlFX0TgFmuTFr23QFLn22+eWZ7onotxi
   KXr5uxOyRG5iRx396/hNeNr4KozOUKXqtoskZwGNfvtLhHNtQ4Nh7jjqY
   Y3t6GQGMjt7YBruHEDE+84pQmENZ4AmbgMqudIGHKUxOXAJhE08QeOHF0
   aBJxGDHClVUiGK7ziIQyo1bZT7XnGfhuybropB8P2G0ljFURewQmuOC3e
   A==;
X-CSE-ConnectionGUID: pbjScJNPRxOCT8Qq0gdeig==
X-CSE-MsgGUID: aJKLYnLwS36+UeA665fQPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38559649"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38559649"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:09:47 -0700
X-CSE-ConnectionGUID: TUvPvJvuQqeS1aDt7zgrnw==
X-CSE-MsgGUID: uX1GjfU/SrSzttTxOf/JXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56677655"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 20:09:43 -0700
Message-ID: <05381ccb-bdbb-4342-8a2f-11ee72454eda@linux.intel.com>
Date: Wed, 7 Aug 2024 11:09:41 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Gerd Bayer <gbayer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Implement blocking domain
To: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>
References: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240806-blocking_domain-v1-1-8abc18e37e52@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/6 21:45, Niklas Schnelle wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with
> a NULL domain pointer and UAF. This is exactly the case referred to in
> the second comment in __iommu_device_set_domain() and just as stated
> there if we can instead attach the blocking domain the UAF is prevented
> as this can handle the already removed device. Implement the blocking
> domain to use this handling. This would still leave us with a warning
> for a failed attach. As failing to attach when the device is no longer
> present is expected behavior turn this into an explicit -ENODEV error
> and don't warn for it. Also change the error return for a NULL zdev to
> -EIO as we don't want to ignore this case that would be a serious bug.
> 
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
> ---
> Note: I somewhat suspect this to be related to the following discussion
> or at least we have seen the same backtraces in reports that we suspect
> to be caused by the issue fixed with this patch. In the case I was able
> to reproduce with vfio-pci pass-through to a KVM guest I got a different
> trace though.
> 
> Organizational note: I'll be on vacation starting Thursday. Matt will
> then take over and sent new revisions as necessary.
> ---
>   drivers/iommu/iommu.c      |  7 ++++--
>   drivers/iommu/s390-iommu.c | 55 ++++++++++++++++++++++++++++++++++++++--------
>   2 files changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ed6c5cb60c5a..91b3b23bf55c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -119,8 +119,11 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>   static void __iommu_group_set_domain_nofail(struct iommu_group *group,
>   					    struct iommu_domain *new_domain)
>   {
> -	WARN_ON(__iommu_group_set_domain_internal(
> -		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
> +	int ret = __iommu_group_set_domain_internal(
> +		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +
> +	/* Allow attach to fail when the device is gone */
> +	WARN_ON(ret && ret != -ENODEV);

The return values of attach_dev have been documented in include/linux
/iommu.h:

/**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  *  Return:
  * * 0          - success
  * * EINVAL     - can indicate that device and domain are incompatible 
due to
  *                some previous configuration of the domain, in which 
case the
  *                driver shouldn't log an error, since it is legitimate 
for a
  *                caller to test reuse of existing domains. Otherwise, 
it may
  *                still represent some other fundamental problem
  * * ENOMEM     - out of memory
  * * ENOSPC     - non-ENOMEM type of resource allocation failures
  * * EBUSY      - device is attached to a domain and cannot be changed
  * * ENODEV     - device specific errors, not able to be attached
  * * <others>   - treated as ENODEV by the caller. Use is discouraged

ENODEV is obviously not suitable for the case of 'device is gone'.

Thanks,
baolu
