Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4F41687D;
	Wed, 12 Aug 2026 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574263; cv=none; b=fOqdVbZBXwt0XorDMF+FvTE+O1QIlD8SkU9WfEBvgkVGDAdZqVVpSLk3ID7pSq8jJ0UM9GxZsgPFxkLxm1tOqYNumVCyIDlG+UQvqQzrP3oCVcW61s3B8LOzw84pli8agzKBGww4qAwZZBKZciPgN4Y4BXNYHnGIwahPPHsLkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574263; c=relaxed/simple;
	bh=oNpqZ39JSL6Sxp/FtCeD29PJFeQlXDDVxTF/sZWofxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DwLq6HsKWmGOrHJ4DGNx3dd/9NxyGWXwre6TMq3towAoeH4opO7xdo7+M4NnsOG8T2DaiIMjZJGVTprJ//hBlZG1jwfJpNZIBAC3yh67+9ep/Yc/deboR/vxPiIt56AC5Faib1q9hl4TMUJhqm/BFOv5EQCxJ9XVVyl9NtEQ8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loqJ9hLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loqJ9hLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A28B1F000E9;
	Wed, 12 Aug 2026 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786574262;
	bh=N3nvMxG+w/kIQ5MyBumQuRe2NP9EZ3FZ/XNCPloZ7yI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=loqJ9hLles8wk7SG28n15ys6VgJi0CvaTw681n84OOBWWoyBFsqz6bfBF7HpGAdK6
	 LRwM+pzUE8/O1994trBiEI0zyHj6JGm9LkoRlBHsr/g8XjXTpadhvcEtjoNylBn7UH
	 tzIzCcdp+GQlWPgonYTuPPkZoZLfhXZqht81Eq+Ys44CSnEmg9t4z86HD+EcCYWA50
	 HcpJdKyfnV7DUxZmYGRUNcwkCDPvcDfHF3HYJDAPkOdGLJL2I6KsJmjMIueJ6bgTJC
	 ziRRSSr612NC1KCp83nVBCo4A2TAjHZuhy2+HcWQLZxms9V39xPR98jalDaVm4zIv3
	 5CBuCOgRbcKMg==
Date: Wed, 12 Aug 2026 17:37:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com
Subject: Re: [PATCH v23 0/5] [PCI] Error recovery for vfio-pci devices on
 s390x
Message-ID: <20260812223741.GA1089916@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805165518.794-1-alifm@linux.ibm.com>

On Wed, Aug 05, 2026 at 09:55:13AM -0700, Farhan Ali wrote:
> Hi Bjorn,
> 
> This patch set includes only the PCI patches of the original series for
> error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
> series into PCI and VFIO only patches to make merging easier based on
> discussion with Alex [2].
> 
> Thanks
> Farhan
> 
> [1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/
> 
> ChangeLog
> ---------
> v22: https://lore.kernel.org/all/20260720192505.2957-1-alifm@linux.ibm.com/
> v22 -> v23:
>   - Split placeholder constant into a separate patch (patch 1).
>   - Rebase on 7.2-rc6

(No need to rebase; I always apply on -rc1 regardless)

> Farhan Ali (5):
>   PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder
>     value
>   PCI: Allow per function PCI slots to fix slot reset on s390
>   PCI: Avoid saving config space state if inaccessible
>   PCI: Fail FLR when config space is inaccessible
>   PCI/MSI: Enable memory decoding before restoring MSI-X messages
> 
>  drivers/pci/hotplug/pnv_php.c     |  2 +-
>  drivers/pci/hotplug/rpaphp_slot.c |  2 +-
>  drivers/pci/msi/msi.c             | 10 +++++++
>  drivers/pci/pci.c                 | 32 ++++++++++++++++++--
>  drivers/pci/slot.c                | 50 +++++++++++++++++++++----------
>  include/linux/pci.h               |  8 +++--
>  6 files changed, 82 insertions(+), 22 deletions(-)

Applied to pci/slot for v7.3, thanks!
