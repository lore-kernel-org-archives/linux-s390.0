Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00742170A12
	for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376217; cv=none; b=mvqKp/35k59u34TEPWpE6YxFCmT6HalHE9cFiqDKxeO1Xm3xEqXZMFCA+tBXTfAAvkg96LHUwIhSO8vKFtPQmDaaJxOcG45flRQcvCy+ODLRL5yS9i1Aw1/dNZY6sltz6JGkf0G/kTOuXGY7U+4Np4tVNcMqPsa1i/RQZK1+neM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376217; c=relaxed/simple;
	bh=a/5m2zK58zkx4nM/V+xJ6JyzxFdkSfEPu9cHhxirWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciRWPK5x7GJOxnbs7ATPAKS7YK/VHAhJGxct6I/XmcF5OFdjjt8QzBjYEYPGpSy7XlZO8gDFmc5/yn+QG2jCtHHnLv2TgMi1LHf+HzdRpJc26Qepv0AAA15dmTOg/Kshw1AKyw1obTOPTKPceXgehDdujXnBBL2JwcNqJYc/7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CrMCQFrj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CrMCQFrj"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9a7bea3cfso98574285a.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Sep 2024 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727376215; x=1727981015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvJvu5IaRTnr9xdXUsqatTaQ8tmdeCfcwtrsxrBZQ1g=;
        b=CrMCQFrjp3k8NQEJJANc/66ALMaYqp0s3IjxWAaegdxslX0Pol8Ulrn2TNv12Sk6o0
         /EdRPk52EyZoX536taouv1lVyzj87icX4m7t1JXVDGpO/6kzZ3aFpcBPs1PfEebiZ/cw
         xvcGdj/DasxCs1qwMZpmDFeJi2SQEb39H9aRLzMDrExT2pHqO8cHVBo0JdkJ/9zWmbff
         I8hxYl7z0yg2G7lVn7If5NmxoxHiLJRMfK2yZt8jUoLPICGqFOvDp+LAQsVs82inG6JA
         X+xZIehXGgQyUffAXFZ7drpoljIUiJ/Y+OGVZTQtbxVfeOAH4joc8IPhU8MnXkEsghFm
         wVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727376215; x=1727981015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvJvu5IaRTnr9xdXUsqatTaQ8tmdeCfcwtrsxrBZQ1g=;
        b=RrhvPrgwaXHPZpX1+/4CgrRRtA6SQTlpNY7cqTr4bFDWu3NeWW2DhWe8OG1rDwV4Hr
         DZXXRi4FzGIqDLEYKI6Hnx8TQwuBKGRkZbT9Es37K3vpPYUJymQoc5O5YMPWqedD7boP
         +4SiqNoGk3gQznb36jUzug0hyz8k3Vq+ey3IuYtg2JaQYGdchTmYYC2mfGFrhc18/MqW
         gkHwyjCJ3KloxwcEnzEkTUpzmuEg26nbn4Z/sg+Nf7EC5/DDm3VS86WYlF4uBppcI2EO
         mnY6fK0kWgPF/2ab039J2eq3CTeObZSLcPX+qHGmeS0ELtzItloSe05LxsXvP0BdM6ol
         Ro5w==
X-Forwarded-Encrypted: i=1; AJvYcCW/OJVsraW3eQJ3QHoAx9H8+sF/CvXsQVuIJUKf5GbBcNtaOi5evuYYUAL2m3Z/nEpiStao29OoNZ15@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNh5xXLLDasJbRDoO5IEpaJPUJtGqGvr9PawNzFCIy0NGrJth
	6mN9RKncOzW1XOEwfjXbIjW1Vk+bsq0sGHDHlcgjJaOsL9GyMxf3HrsooXEAW32bSbeZaaJWjgo
	M
X-Google-Smtp-Source: AGHT+IHahoaHFJtuu1gsK0aQtYJow2bdyMNiogW2IcChPTuHJqaCLBrGWEI30mWx2ZRm25asoXWR5w==
X-Received: by 2002:a05:620a:44c2:b0:7a9:b425:6 with SMTP id af79cd13be357-7ae37838380mr75987185a.24.1727376214700;
        Thu, 26 Sep 2024 11:43:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782a221sm15168385a.73.2024.09.26.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 11:43:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sttSf-000qCj-2k;
	Thu, 26 Sep 2024 15:43:33 -0300
Date: Thu, 26 Sep 2024 15:43:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	baolu.lu@linux.intel.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com, jroedel@suse.de,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] iommu/s390: Implement blocking domain
Message-ID: <20240926184333.GD9634@ziepe.ca>
References: <20240910211516.137933-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910211516.137933-1-mjrosato@linux.ibm.com>

On Tue, Sep 10, 2024 at 05:15:16PM -0400, Matthew Rosato wrote:
> This fixes a crash when surprise hot-unplugging a PCI device. This crash
> happens because during hot-unplug __iommu_group_set_domain_nofail()
> attaching the default domain fails when the platform no longer
> recognizes the device as it has already been removed and we end up with
> a NULL domain pointer and UAF. This is exactly the case referred to in
> the second comment in __iommu_device_set_domain() and just as stated
> there if we can instead attach the blocking domain the UAF is prevented
> as this can handle the already removed device. Implement the blocking
> domain to use this handling.  With this change, the crash is fixed but
> we still hit a warning attempting to change DMA ownership on a blocked
> device.
> 
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Co-developed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> Changes for v4:
> - fix lockdep assert
> Changes for v3:
> - make blocking_domain type iommu_domain
> - change zdev->s390_domain to type iommu_domain and remove most uses
> - remove s390_iommu_detach_device, use blocking domain attach
> - add spinlock to serialize zdev->s390_domain change / access to counters
> ---
>  arch/s390/include/asm/pci.h |  4 +-
>  arch/s390/pci/pci.c         |  3 ++
>  arch/s390/pci/pci_debug.c   | 10 ++++-
>  drivers/iommu/s390-iommu.c  | 73 +++++++++++++++++++++++--------------
>  4 files changed, 59 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
