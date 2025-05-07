Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38326B2CA
	for <linux-s390@vger.kernel.org>; Wed,  7 May 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635960; cv=none; b=Rjnsh5kbhWcUcOyCzbxQwTwbbV6EV0It4WdBONkvg1VPHmgBld5yCm7uJ8x9PfqkKBDv/lHwHRtP+BjhazHQq8h7YR7zP6QhBuWSTu0MpZyna4oAyiPQQOGi7rGUuwPSB0f/AqKUfwaLBZgE9Jb2/r/+rDEXi58MXQnNrx94rd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635960; c=relaxed/simple;
	bh=SRq+NEPftKip+W//xKmZkL1Q76aXXHvyE7hxVGJ8buE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtgthxD183yQwdGNpWCUWh8qbFNDJd8hglKOY7SXMfjFBi+AADOhtL4k2LaeH5D83snKsbfPRgTH9v36RlCJmg7r5y977vji1rNl4WeG+utkBQKdwbLAdL+PyfWQH/YW4CZdqkbxRRrxclRgaRWqUIza7YlHIVLC3nxH7hNUqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cdBlN5Np; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cdBlN5Np"
Date: Wed, 7 May 2025 18:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746635944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zb+SGIpxZ2i/VssN+N0+bs8AQInuxHpANS0MYc/FZCk=;
	b=cdBlN5NpDyu9tl5cWVL01+s2VGA+1OQ7iBEbZ7+NGpnZ851sLcUJEIJEr/JygOrY/DGMOg
	XVO1IYz/BjosJ/kMeaxP/bNUnJ0M3hTMmaSmiKFly7cBhdI605DJRSgKSfkFASXTyaiOfC
	cwYcs8jC2rtNYuJBumRvrP30TLLBATc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com
Subject: Re: [kvm-unit-tests PATCH v3 09/16] scripts: Add support for kvmtool
Message-ID: <20250507-17ee3d8f1b384ab89848e63c@orel>
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
 <20250507151256.167769-10-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507151256.167769-10-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 07, 2025 at 04:12:49PM +0100, Alexandru Elisei wrote:
> Teach the arm runner to use kvmtool when kvm-unit-tests has been configured
> appropriately.
> 
> The test is ran using run_test_status(), and a 0 return code (which means
> success) is converted to 1, because kvmtool does not have a testdev device
> to return the test exit code, so kvm-unit-tests must always parse the
> "EXIT: STATUS" line for the exit code.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arm/run               | 161 ++++++++++++++++++++++++++----------------
>  powerpc/run           |   4 +-
>  riscv/run             |   4 +-
>  s390x/run             |   2 +-
>  scripts/arch-run.bash | 112 +++++++++++------------------
>  scripts/vmm.bash      |  89 +++++++++++++++++++++++
>  x86/run               |   4 +-
>  7 files changed, 236 insertions(+), 140 deletions(-)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
