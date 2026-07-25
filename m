Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39E2E7374;
	Sat, 25 Jul 2026 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941212; cv=none; b=fyvdFbmrkufUD7zJ2cOXlcqLdJ3380DUm9cQwrfo4Q+HSNSPcC16J3Ftohl4eDWWD9zu4IaSEgl5k6iAuu/1LrsUto5V2eoPFKvHSz1wPPggO6VQV25v4Cqi/76zQW4Oq0kSSnikwfgJlD0FWC+vVG/I5mocu0VG85vnpcz2a/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941212; c=relaxed/simple;
	bh=1RUFjWz6Rg1f1hrlS//lgaICRxO4c3YvsrZYedb7KL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP2yo7O6074+TU/EOVdu1CvavgsBkKUKpRCqvIrVYMqNuRITaDt4O0nilIloDdanMEJ/qgl/+VZbnBfnhlTN+URYdGIxKOPMJAy1jzQ74DzLWXupr3yetoobF/mjhz5CWkn4TOOJuFXEydwoFdz5R0MalzHOeBvAungFhI4gSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpNkeymz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpNkeymz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F51F000E9;
	Sat, 25 Jul 2026 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784941211;
	bh=As1VFAV4/mE6JvvbbxmZ+Bp8mI/fGVenXZeP4wEav0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WpNkeymzxme+ejkFrlPhhO39hPAULrf6Ox8rY8fd5z66lDcD7sQMYqZ0OJIWqte6G
	 lkyDdWeFmbLddAXwFMuEdKeJrEkhhZUj3GH1SGjHUGXlgZ1QKvxbUm9U7J8jFU38OJ
	 lX+pgVE2Umo+C+zC0LEu5na/P+wWjTnlUYs/MTXAvZA/5ntkRilET4bXMRzu/nc+x/
	 MCg1V/7OAM+fxdaq7H3Kotho/ypxoMHFO6mcqiklqPugH/qnYOQzvSrhOZU6NNCQdd
	 IuHFkwsLsIZxhbyfQnzcEl1liqC9puOGMLjdXRXenKjmr1vHlgNJNVgif65YY6jIMc
	 N5UVIZqZhu7jg==
Date: Fri, 24 Jul 2026 18:00:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Dominik Steenken <dost@de.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Maxim Khmelevskii <max@linux.ibm.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, llvm@lists.linux.dev,
	bpf@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] s390/Kconfig: Select ARCH_SUPPORTS_CFI
Message-ID: <20260725010004.GA1686739@ax162>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724141318.1037434-6-hca@linux.ibm.com>

Hi Heiko,

On Fri, Jul 24, 2026 at 04:13:17PM +0200, Heiko Carstens wrote:
> With all prerequisites in place select ARCH_SUPPORTS_CFI.
> 
> Note that this support is supposed to work with the generic kcfi support
> which is provided by clang. This comes with a couple of limitations:

Consider adding

  select ARCH_USES_CFI_GENERIC_LLVM_PASS if CC_IS_CLANG

to this change in case there are problems such as the one worked around
by commit c57f5fee54df ("libeth: xdp: Disable generic kCFI pass for
libeth_xdp_tx_xmit_bulk()"). Whenever clang grows an s390 backend
expansion for kCFI, that can be version gated pretty easily.

I will test this series fully next week.

> ---
>  arch/s390/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 84404e6778d5..d57a6c02f51d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -144,6 +144,7 @@ config S390
>  	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> +	select ARCH_SUPPORTS_CFI
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>  	select ARCH_SUPPORTS_HUGETLBFS
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
> -- 
> 2.53.0
> 

-- 
Cheers,
Nathan
