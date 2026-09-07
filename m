Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E474A9D4F;
	Mon,  7 Sep 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784607; cv=none; b=WQX3FeoZxYbpYhuRC6dPQ/E3iV8neRpmH3TH5oCmcFMQBACYPXeYPmI07f99Gxvfk62OaU+4BC4456uQsAkJcVSjNuo5hEYM1YXnhNu9j7PxuPMtvb2g/AhjguHWErVhZBGaJXG4pMktGU6IXfazE3J1yOtWO1ekoB2OfopWIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784607; c=relaxed/simple;
	bh=E2mReioDtdPeHkxkBC3oT4CocMJFs0sLzUXgsU+H2hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob7nIxYNAYLSqpQK33QjFGZvGYHRORgs7JjQXvBsPsI0alRuw7vhbHEHHRZHbX2JiskByim8WOO7t2Ql5F2R3mIsXrs9yDe9lgJtEp2rDz4M6a6q84M/SrysfcWouAQykSRbNpaPDsKHdIl9ppxVcTIVH13OdM3TZFoLHAsyUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 144D020A089;
	Mon,  7 Sep 2026 14:36:43 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:36:41 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, 
	Farhan Ali <alifm@linux.ibm.com>, Omar Elghoul <oelghoul@linux.ibm.com>, 
	Gerd Bayer <gbayer@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ramesh Errabolu <ramesh@linux.ibm.com>, Tobias Schumacher <ts@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-s390@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
Message-ID: <ap6vw9b1ki1oHPnK@8bytes.org>
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>

On Tue, Aug 18, 2026 at 09:13:17PM +0200, Niklas Schnelle wrote:
> Cc: stable@vger.kernel.org
> Fixes: 81244074b518 ("iommu/s390: allow larger region tables")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Queued for -rc, thanks.
