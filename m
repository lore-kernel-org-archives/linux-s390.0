Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232522DCC1C;
	Tue, 23 Jun 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232391; cv=none; b=X8lyyYY7rRa7u5rDbN3buiUmtKWbzVOpKXbZeNlvE7IMQIwRCng9JFt4dmPK9yqKoReb1W77hhs+a5GpQ8Wx8x0bgp+usiUowARAqaqtb/uwPfk9SbuqsswxqrNFM1203hX+1CtoVIhWwp0nJHelVjCe00uMk4jBFzia7OmKRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232391; c=relaxed/simple;
	bh=yeo7JSfde5yHDo56u955/eNNI3G2a26sViMwEaODPoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LZLJs9u9yT/DVTF3bpqhIEY99OO4kx8S86odgXhP8j8dMtrcIkeJMBd7spmRcfbZxiWHgho8AXEHh4+rj3UT1c8Uo4JJu+QUxF5pbwW/mdoWtu6uFMRGqg8Ndd4AQad66c3iKfngRNbqRufNKxX/hnAmAqB9WDvsaXtcSVJN9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJVqFcVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJVqFcVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8981A1F000E9;
	Tue, 23 Jun 2026 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782232389;
	bh=yHcJgKgcNpooi6kS03tC02GgQ7jUj1QYimB910EmFiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FJVqFcVYll99sWq1gPUp5BOKZmfxubSNmzR0j0L7GXWuJxRpspA8qDbTPQ/KiqLc/
	 6r4eeX5t3+7oRzb8j1dXrA6LqiXSNY2+qn2P5U/gIm1pJgFqtSUMlyH5AqoPuJerCS
	 u+owEjxINuwQIRwjfbim3JKOlhYDBmVayb34kSyMTOn41B64Pdvt9DSLa603oRu1D6
	 yI1p+oBTvXxDC9CurOO005JewAzVCYkoNU4KAnHUkx9V0YvrFHK5WTu4ZMb7Fdo4iv
	 Mm7jJCdJgA4Ep1OJpPwzlLolgy+TGb+Oh4CUgoUcNdJ+wBLUH+9RkushzDLHWT0CJs
	 gToj0mFtCtCrw==
Date: Tue, 23 Jun 2026 11:33:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com
Subject: Re: [PATCH v19 0/3] [VFIO] Error recovery for vfio-pci devices on
 s390x
Message-ID: <20260623163308.GA817537@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2dcd383-e93b-4771-916d-d836df5f48c2@linux.ibm.com>

On Tue, Jun 23, 2026 at 09:19:03AM -0700, Farhan Ali wrote:
> Polite ping for this series :)

We're more than halfway through the v7.2 merge window, so it's too
late to add things for v7.2.  We'll get back to this after v7.2-rc1,
i.e., next week.

> On 6/15/2026 11:36 AM, Farhan Ali wrote:
> > Hi Alex,
> > 
> > This patch set includes only the VFIO patches of the original series for
> > error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
> > series into PCI and VFIO only patches to make merging easier based on our
> > discussion [2].
> > 
> > Thanks
> > Farhan
> > 
> > [1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
> > [2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/
> > 
> > ChangeLog
> > ---------
> > v18 https://lore.kernel.org/all/20260603182415.2324-1-alifm@linux.ibm.com/
> > v18 -> v19
> >   - Fix hole in struct vfio_device_feature_zpci_err.
> >   - Remove reset_done() callback for vfio-pci driver.
> >   - Rebase on 7.1-rc7
> > 
> > v17 -> v18
> >   - Print a warn with dev_warn_ratelimited() for copy_to_user failure.
> >   - Rebase on 7.1-rc6.
> >   - Break patch series into VFIO patch set.
> > 
> > Farhan Ali (3):
> >    s390/pci: Store PCI error information for passthrough devices
> >    vfio-pci/zdev: Add a device feature for error information
> >    vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
> > 
> >   arch/s390/include/asm/pci.h       |  32 +++++++
> >   arch/s390/pci/pci.c               |   1 +
> >   arch/s390/pci/pci_event.c         | 137 +++++++++++++++++++-----------
> >   drivers/vfio/pci/vfio_pci_core.c  |  10 +--
> >   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
> >   drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
> >   drivers/vfio/pci/vfio_pci_zdev.c  |  61 ++++++++++++-
> >   include/uapi/linux/vfio.h         |  30 +++++++
> >   8 files changed, 221 insertions(+), 62 deletions(-)
> > 
