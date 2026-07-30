Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CE470431;
	Thu, 30 Jul 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453206; cv=none; b=T7WpFuBhMcKsNL3SnYVvg5tVaLKCO05uFGXpSOcslpZopKgjINIBP5YlmdqNafrjl0oR+WQwV30cKpKaxK8lbyuRvvvYCiHHLjpAHfkdd9sT4KLsq81oiiyWH0fd6H9JW0TdaP3nnwIEBSnmrbt6hFM4qSWz6Cn/iQRwAG/lgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453206; c=relaxed/simple;
	bh=avxepvZWWju9S7sHePRsNaozNupgLVuPcY9AFQUoQls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLIrWr2xjW2N3lCZsrSn8iIg5eSLNua1a+a1we1VX/f7RVCHPonTNdUTsKdX8IphLE5XaVLiIt7uFU6Of5bWgnXZf7jjnISqPGPPyegJliVToBjr5T+EFb2695+wF+D+V7izB82ZNhJHzYzhrSqJ2HynY9eS1/4BNl33lv+rHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK+wCzpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK+wCzpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC601F000E9;
	Thu, 30 Jul 2026 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453204;
	bh=l3JegJnkroH/Y9kwd0pWelpz0EiOXDJ6YnZdI9R3F0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WK+wCzpBsLbH6FC4gbaY6beR0/fFuzz5P+DCY/UXVeCbI5z2ByCNglf/K1DmkfznQ
	 yf5OI5Ds0rIfDagDLa0RaJZkrQvrtiSZSUfcWLy0QPH1TvvTd+szToa8HLhJ+ybMLO
	 o6YDuOkoO4SJGb6TWoe4Jt1zQ4fdwsTU6q3zFPGIKGVDhcOLFYWGL7cXA+YESVrX99
	 GIPFj/tKDsZvN/oxIZvxOKCOBxtDbxxkGSZISXKbex/AIJk4uvq4nW0+8RWlUdMIHA
	 hPHSLFzgVDesiuzU+u4JuUTd8RfTH6AT2benCMCnLGgEyoOzKESyjamXcKYnPAZOh3
	 bDYfGyRWTlUEg==
Date: Thu, 30 Jul 2026 16:13:17 -0700
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
Subject: Re: [PATCH v2 0/6] s390: Add kCFI support
Message-ID: <20260730231317.GA2423962@ax162>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>

On Mon, Jul 27, 2026 at 04:05:07PM +0200, Heiko Carstens wrote:
> v2:
> - Select ARCH_USES_CFI_GENERIC_LLVM_PASS [Nathan Chancellor]
> - Add CONFIG_FUNCTION_GRAPH_TRACER guard to ftrace stub [bot+bpf-ci]
> - Add additional CFI offset adjustments to bpf code [sashiko-bot]
> - Move bpf patch before ARCH_SUPPORTS_CFI is selected, since there are
>   functions with missing __bpfcall atttribute [sashiko-bot]
> 
> v1:
> Add s390 kCFI support using the generic support provided by clang.
> This comes with a couple of limitations:
> 
> The generic kCFI implementation does not generate a .kcfi_traps section,
> nor is a special instruction used in case a checksum mismatch is detected.
> 
> This means in case of a checksum mismatch the kernel just crashes.
> It should be quite easy to tell by the surrounding code that a crash
> happened because of a checksum mismatch.
> 
> If clang and/or gcc provide a .kcfi_traps section it will be possible to
> print proper CFI messages instead of just crashing the kernel (enable
> ARCH_USES_CFI_TRAPS).
> 
> In addition this also means that CFI_PERMISSIVE does not work. Even if the
> option is selected the kernel will crash in case of a checksum mismatch.
> 
> However it seems to be acceptable to enable kCFI support to the kernel now
> even if it is not perfect. Later s390 specific clang and gcc extensions are
> required to improve this.

Yes, getting coverage over s390 specific code and drivers is worthwhile,
even if there is no architecture specific expansion available yet, since
most problems should be visible with either implementation. Getting that
sooner rather than later would be nice to avoid the panic when a CFI
check fails and make debugging easier but we will take what we can get.

I tested clang-18 and clang-23 with defconfig + CFI, which both properly
fails the CFI_FORWARD_PROTO LKDTM test. I built allmodconfig (which now
includes CFI=y) with both compilers, which showed no issues.

Tested-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan
