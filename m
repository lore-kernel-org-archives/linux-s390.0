Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9443CE7C
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192330; cv=none; b=QjwogxZIAbv5NTxg5CarVuNFMxT8n4s3//GbUMWjMBpoFHbesjWZdsMCcfB2AVRplLGCxELcpEJU9H0hwLj513OC6ngThjT0PMiucuFTQsLbRvo8uJtJow1N1mzBozCl+7uhF4jX3TloiMI7tvfcPCZpcY6SX1cqCqFBbPoHWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192330; c=relaxed/simple;
	bh=6StwHxlhiYcVBXEs6F8/Mmm6Map1gli+Gghs6Tvjy+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgpPN7dFQWDTGxK/k1xPFdlYWAoLA/7Mf9NtV3p+X3jFjdi8mDxrVcp5NJY/qK88TDltr0uo4Ag3bupkdaSPYXS31GVMicbaJNsHexeplfQBjNsApGYl2HYGYy2yYHpcVKdSuIgfYiw0oC5k2S8+meijjlpTXF1fYbFq4SaT5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJV0reND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJV0reND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F2B1F000FF;
	Mon,  5 Oct 2026 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192329;
	bh=CkUUeGIh3kP4fIVJghcEaOrcbgIUgfDuIpCQTsYKpyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FJV0reNDGvu7DY11soQZV1gb5UdplgsuFI33QImxR8yoJsZx4IbrISNf0obiGSLEw
	 xP7qFWGncT085atN2IwdSmGV383pGxjetlhZ69f1Ipi7RTUm2aseNfxcv7s0NBgG7b
	 T8dNpvPU/Ay2VKbi0+upMUNyi+H5F/83/1kC/2nAqXd/4LJ5+Wm3nlFmotUMutxlV6
	 kgmO/xBcj7AtN2aLAU2BotQ48s7O3LHzFLYo+cWkpGs1ALRBMaILoG2PpZuCaj7s/q
	 eMq3ZqyLQ4OI9gW9ccTp7+HW84iD63ThdKnJNQZ0eEepYm2LqE/2PF1gCNNvdQJu41
	 NGGYBtBmhqkOA==
Date: Mon, 5 Oct 2026 10:25:26 +0100
From: Simon Horman <horms@kernel.org>
To: Joseph Cathcart <josephc@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org,
	eoin.mcnamara@ibm.com, iii@de.ibm.com
Subject: Re: [PATCH v2] kexec-tools/s390: add --reuseinitrd support
Message-ID: <20261005092526.GE184916@horms.kernel.org>
References: <20260820101350.4413-1-josephc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820101350.4413-1-josephc@linux.ibm.com>

On Thu, Aug 20, 2026 at 12:13:50PM +0200, Joseph Cathcart wrote:
> Currently, the --reuseinitrd param is not supported on s390. This
> prevents testing kexec in environments such as virtme-ng, which by
> default does not store the initrd on disk.
> 
> When --reuseinitrd is specified, fetch retained initrd memory range
> from /proc/iomem and fill new kernel parmarea directly with retained
> initrd base and size, rather than memory range of a new ramdisk.
> 
> Add die() cases for when user uses --reuseinitrd:
>         - in addition to --ramdisk or --initrd
>         - while booting a crash kernel.
>         - with kexec-file-load syscall (default syscall)
>         - and no initrd entry is found in /proc/iomem
> 
> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>

Sorry if this is a duplicate.
But it seems that I applied this patch some time ago
but forgot to send out a notification about that.

So, FTR, this patch was applied as:

- kexec-tools/s390: add --reuseinitrd support
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=43c5cba85ad2

