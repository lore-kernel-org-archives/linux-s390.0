Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399399;
	b=N5mle2nkR9aCIx4Dta3Bvgi354nw0py+p/qszGA1qQ9QqXQh15bUd3wlJcipWj0aJ0gq
	 E4738R/31r7iZRGIjs6b36v5H2uG0sbERjP7VnJxWSLh6RuBDWI1ALg1scdJFWsbTDfp6
	 x5SH2W6PQil8hrLtL5sYKSphrI5LGfYNuoMP6VBss7RfzpHGNoSVuWLZWmY77n7uCnj6K
	 7OwmWUggonSgOncUkEWd/DzqkoinBPUHBndzHUV84EeTHGltfMkQyx9ge/NCxDjaQJxl1
	 vxDPMcASCdjJyXLqAyakAi0l+ZLvILgKDMgW0R8aIsDtgraaMm4TH9BA9YTv26L6jgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399399;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aSkk09/yktJ+E/or+xyblvOstjgnyc2a5E9M6YN6VME=;
	b=obDKNrEuUQUy9/FSgbTIlejjYMlmwN5yCG7kFwrY2U4gZkV5yy3BdsWk7Ya+ecsL2Oa3
	 WYRNmOffdbKdP/NtYpkzxzBnewrj3nYVsFOA6gPXuWgUZ1o/3Mo9yZcnEK3Ie4QCWdVqP
	 HCVQtCuvucA59OiRqtkzXW1eEd+ZNUVXnvGzSgCPziD3yhqXrtriitRexEsw8uCr9x8Ri
	 aZQ0rbeuNP85yGjBC0EfjyAUkVmHB6bkDWyGm3AldxflKGa9d5emijYmLHmwFJzuqI/sF
	 ukMoP1F3ONWl3kfXPf2wZkVhBjniY8KRG3JkmmYQOEzUYZhrQYApDiQbT64nedbSPdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtBzDAft;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A9606A31A;
	Fri, 30 Oct 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtBzDAft
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026931F0093A;
	Fri, 30 Oct 2026 22:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399399;
	bh=aSkk09/yktJ+E/or+xyblvOstjgnyc2a5E9M6YN6VME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RtBzDAftLyTiCB+s6T9O9f+u3CAcRFnr10MXb9DzJ5uWDLheTgqJlCsSLGJN2SzRB
	 R8igDMHThaWXXvTzlNcrPM2I27DjlcEXfSbJvdFMSo0RCh8TqxW8JQjEbLgNFv1lET
	 IgYRiPFEocjgrFPIUQh5k1I+X5wmB5xx3zlP2dF5iGfmKi1QoiIVLezo9PV/uSAkip
	 HaJyuKFZSo9wsiymImiHOeUxCkwz80Wnb30FqoWkwbLvAo3pfucBtPCH6Jjs22e9SI
	 1piJDPwscdARR9cgJEqJ25AwjPky0+Ik8QrMpb8Ry3bDCTGYoVZN+VG0q6xdKfKqbd
	 lZsh+sm7B47oA==
Date: Fri, 30 Oct 2026 15:29:58 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Julian Braha <julianbraha@gmail.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Move testing of '-mfentry' back to Makefile
 from Kconfig
Message-ID: <20261030222934.0fcfa7-kees@kernel.org>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
 <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>

On Tue, Oct 20, 2026 at 02:52:18PM -0700, Nathan Chancellor wrote:
> Ricardo reported another issue with moving this check from Kbuild to
> Kconfig, as '-mfentry' is not supported for x86_32 without '-fno-pic',
> which affects GCC builds that are configured with PIE enabled by
> default. arch/x86/Makefile adds '-fno-pic' to KBUILD_CFLAGS, so this
> works properly in Kbuild.

FWIW, Debian's i686-linux-gnu-gcc 16.2.0 hits this too: ARCH=i386
allmodconfig fails at scripts/mod/empty.o with "'-pg' without '-mfentry'
may be unreliable with shrink wrapping" under -Werror. With this patch
on top of Linus's tree, the whole build is clean.

Tested-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
