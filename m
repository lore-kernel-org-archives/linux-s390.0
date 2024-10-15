Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7661C8FC6;
	Tue, 15 Oct 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980378; cv=none; b=foPgZBbo3Gmg7VSR+dyO6Hv8MDTc4db0VdpuHeytpLTWn0YlB6x86Yt67xtDcWDM52QPLBPBHmylNVFd4/XD4DB4lUfz9UEZ9EXiO6fuhdy4Y5hm32TB89wjrgN9J6D0PYqK9dKIBn/+UbJlqx+szhoIYEJzRfymFXkvek390yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980378; c=relaxed/simple;
	bh=EepgD9d4v/+9jc/WvMevuwWb2suEbr0HuUfpjflMhDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9Rjrs/ESUXo81PBSDCUuY/DABvHyQaEkqisLbRuvWImShLBzh8g/hx60l0ebihoQtAVCtiJ56fg0sDDs51k1mYnL3mp14zpwBwYU1CY5gIIYvgbSX/HJjx+YeuYKSGB294tahOX7AOENHvMHU+WmjZejEqGgB72PI34VxP7IAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=pl0+qx/f; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="pl0+qx/f"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A8C9A2A7853;
	Tue, 15 Oct 2024 10:19:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980375;
	bh=EepgD9d4v/+9jc/WvMevuwWb2suEbr0HuUfpjflMhDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pl0+qx/fFyy41duXy5whsSLQtPjpSDAvxxITER81RGXxfOem9PgWER4D6CfGBfk80
	 zeii2/o/wQSkBcUYNbl+l3pXoCDuQpcVXIGyuMNKur+swLUyK0CbX0qlHOXvYl58GC
	 48TrYSwjFhBr/o4pM4K0OufM2L/DxprEs2W15grMm0Tu+ymjTEd7bKt7g6e6Vcb/SR
	 J86L6+UgqKR4lIZ8Ivcn/1m2LOXj5kLhMF5Uhz1dcP2clSh5S0rBhO5ss/i+ADRYXY
	 4lXPPUJJm5KMiq4y5ZzKiVumBo5AswHlYB9GbMbvYr5tDkwLku3LIf/+IaJHxXtfaK
	 uqel1WcZ9bWAQ==
Date: Tue, 15 Oct 2024 10:19:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
	schnelle@linux.ibm.com, jgg@ziepe.ca, baolu.lu@linux.intel.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, jroedel@suse.de, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4] iommu/s390: Implement blocking domain
Message-ID: <Zw4llofDpZrFblJh@8bytes.org>
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

Applied, thanks.
