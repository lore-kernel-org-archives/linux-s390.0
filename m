Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B17F2528EF;
	Thu, 17 Apr 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901022; cv=none; b=jpR3i/Nvsfkec26fGVRrLV0S43qMGbXUvkAIk38lszYpNebdTdTSzbk5aAGk9ECAXqCN78Jx5IeqIsdyiKbCheJ3sX/DbpMmR5p3GPybp6rwjPyjXBJBCrnT6LsCOlpIT3SR9XHRH+70O1jAPRWzbOZZgUFsd96TuGoaptMtd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901022; c=relaxed/simple;
	bh=dxTlmjDTebXWEac5ztfrfWgKTc2cMxPySJMYSK+qkVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY/SPstEigR0hEagggb00Hu954cxZZ8g/Yey/zgZ9GvzBQOWROyxPSk/E53gvH6168D21S0dhcUMOqBUs0PCg1pbclOWMZwX4QGJyKZXSY6x0DWuc/X9Ao8FEGH7fwu4bgmGGMA0MtN9EiKxFMV7hC6hW1SbgWE8BYOBcp3ExRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=TP2EBB6H; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="TP2EBB6H"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5260648658;
	Thu, 17 Apr 2025 16:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744901019;
	bh=dxTlmjDTebXWEac5ztfrfWgKTc2cMxPySJMYSK+qkVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TP2EBB6H5l59SwArwldVyKHLQRYTXvJyj65/7XMGJdEcHw+aiytXyCb/NSisFHyPE
	 hntT0OoHHCtJbGPXnn5bypd5Ja8XxLPXkpnfX+ScO0HNMOKnBlJ6Wm9skXUskQjRAf
	 4yxrao0PvUXBu583G5R1B7+3x3uRL30TaF/JyPeM7+TyBYyDrezHf++8SElyUw5alL
	 cqLHWFj4aA8vPvW0PNol8vhVgRcKMxgfTj0dJ/BLKQppPhSWSpYZvhTyiKPA1JE/GC
	 YBagk98Fj4jW6sj4nBHZ9snL8SLjGBbPdudiiW45LdJnHHG/6Zqvqq2MRnJ9vbpiXH
	 3tYhI3dGgbFtg==
Date: Thu, 17 Apr 2025 16:43:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
	schnelle@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com,
	borntraeger@linux.ibm.com, clg@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/5] iommu/s390: support additional table regions
Message-ID: <aAETmiPYrK8_Toqm@8bytes.org>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411202433.181683-1-mjrosato@linux.ibm.com>

On Fri, Apr 11, 2025 at 04:24:28PM -0400, Matthew Rosato wrote:
> Matthew Rosato (5):
>   iommu/s390: set appropriate IOTA region type
>   iommu/s390: support cleanup of additional table regions
>   iommu/s390: support iova_to_phys for additional table regions
>   iommu/s390: support map/unmap for additional table regions
>   iommu/s390: allow larger region tables
> 
>  arch/s390/include/asm/pci_dma.h |   3 +
>  drivers/iommu/s390-iommu.c      | 345 ++++++++++++++++++++++++++++----
>  2 files changed, 314 insertions(+), 34 deletions(-)

Applied, thanks.
