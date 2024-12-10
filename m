Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998481727;
	Tue, 10 Dec 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799565; cv=none; b=XAx6ePPlk0NHIZQbkQiUNZ3+2xOjKOami/tHiJragkWuuymerwPKuZRfxP6wkj541VOHm4s6Dk8q6ltEmB6UodC9fBW6WY0YqKUQbzmOd8iHPHpzAVUjvreGd5taaL2IkmNX4rh5lvq0f8w0zTlylS7vGg5BDXvEVh5ZnghqD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799565; c=relaxed/simple;
	bh=f9Ld5/tN7J9t9E2p92p+1WX2c8lX9Pyu1YBmBrWwB8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBk67me0g1gkYJD2gj/20vjnbN/DqcIuB9iD8BV7ea6LceKyiUSaBtT63vrcif3hzSk/BpNTWFh6nV8LDuEYwJKOQGPoa8fhrfIp2XDnWF8jkiAs159MXh5caqBielugv0MyYyU/ugQLXLsublWyWhLqnzVQ78KohYcn0nQUXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXtmQmjP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXtmQmjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733799564; x=1765335564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f9Ld5/tN7J9t9E2p92p+1WX2c8lX9Pyu1YBmBrWwB8w=;
  b=QXtmQmjPC8PqxBLFsIw/ZkvgT44Jub5YBv9oR6InbwjnGPb2DTzZz3gv
   zoA3zBte/ERFYdhMTfvUgsTsX4agG2JMFkC+jxnvHtkLgrSViMRJFYssk
   ufxfm7Tpwm123aj7w5rM58/RrPjs4u3bbSjNIzrEdWEB5m1mOKNK/WWi7
   VAQMhVWyOd7Ll9/+MPVpBUXS+9l8uEF6CKbFbZHCfu7bmhnheUwv5WMju
   RoDHDqd94wY2fyDdruN3eYhPaEa38o+xR+0oT58gcPzo+paIDrIYKU585
   w+yB7e0mjU2SOnPQnii46xk9PgTJYKU2JD3vAeDMOygteS7tZtwYg43qa
   Q==;
X-CSE-ConnectionGUID: Mv4VhM4aQ1W9q1nI1I4H5g==
X-CSE-MsgGUID: zJ2DcPQRQQmmnaznElTjCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37811425"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="37811425"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 18:59:23 -0800
X-CSE-ConnectionGUID: BBVtQdtSQxChcrx56XGyaQ==
X-CSE-MsgGUID: rUnBTS7BR7ej3VS1Wvbidg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="95104133"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 18:59:20 -0800
Message-ID: <3db6f346-0cb4-41f7-b532-91bcb0265849@linux.intel.com>
Date: Tue, 10 Dec 2024 10:57:49 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iommu: document missing def_domain_type return
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
 schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 clegoate@redhat.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
 <20241209192403.107090-6-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241209192403.107090-6-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 03:24, Matthew Rosato wrote:
> In addition to IOMMU_DOMAIN_DMA, def_domain_type can also return
> IOMMU_DOMAIN_DMA_FQ when applicable, else flush queues will never be
> used.
> 
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> ---
>   include/linux/iommu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 05279109c732..d0da1918d2de 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -585,6 +585,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>    * @def_domain_type: device default domain type, return value:
>    *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
>    *		- IOMMU_DOMAIN_DMA: must use a dma domain
> + *              - IOMMU_DOMAIN_DMA_FQ: dma domain with batch invalidation

In which case must an iommu driver return IOMMU_DOMAIN_DMA_FQ?

The flush queue is a policy of "when and how to synchronize the IOTLB"
in dma-iommu.c. The iommu driver actually has no need to understand such
policy.

By the way, "dma domain" in this comment is a bit confusing, it reads
better if we make it like:

- IOMMU_DOMAIN_IDENTITY: must use an identity domain
- IOMMU_DOMAIN_DMA: must use a paging domain

Thanks,
baolu
