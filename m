Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645585;
	b=ngxyC0WroW+nUyPXMqQkHIW6OM1vgqFEQXAIj2JGFlc7z009LL9mLc2QEoKT9Yxpxo1s
	 LTbS0/4FWDMCwkIHmf0KXqucuQCxkguYcWmunGsdPe2ALvMZaZbJxUkIvUt93sK1vPRPg
	 2ukXzki8rxZJPP0t4RkUmrNN7sNp4fWlEI7yUL8nFLwYmGiu3Toiy3iaP9MxsM2vz0K18
	 qWNNRtZTKfcw8va4pPsa9Nty/uFSZTmM2Pkxh+071yShmkZknqxc6tQrq06Yo4MHTIcmv
	 VaB49a4EAwzM4L5fllDcZx24yBmdpCcFtSb+sXLUXpD0btgxHwnEXzeT6VeCXNtsVvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jTczLu9jnEFjL0f08+7pl9luQDmQRIO+KtHal9KWx0o=;
	b=g/mXb2zm76c1858UgWJxXdf15/UEA7+tH33rWcfkqGFAIBBxDRa5+f+fukalmw+JaMnP
	 eW5i1vHR4W48vlJ7/4PrIZ480JgoH9dxEO4SEM10mi3BrPox4pjmC0sU1Wmv+dX8EVcZu
	 /HFjgKEIeEGKFWRgGfgplp/x64sHGIvphdp1U4vjb4+QYGCCengpJd1LMwW8Ctph7CjGy
	 9wN+NFPzGwbBtjMTDljX5WzYTZCPetRrRqpUYGsS1wmwz6pNXEa2xQQZYcinedckMSROE
	 ef+9o3fpAku7fvK/ntg9IrnY+gUbiCv+aisUxK6vKLWtxzBrsKItUSd5Wup8NWZlxUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeVkXD14;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB9606A326;
	Mon,  2 Nov 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeVkXD14
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB191F00A16;
	Mon,  2 Nov 2026 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793645585;
	bh=jTczLu9jnEFjL0f08+7pl9luQDmQRIO+KtHal9KWx0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KeVkXD14SUd3CbY++enYfjSML1CEzVjVUCEwGzcLMdt/1zW+P58/Tf09YNv3X/gZX
	 IyVrk8F2HenqIxVYb3+pbVU+YehWCvE9y8MxM7WeekpaH2yd53YscdRu1WaG6J331a
	 iJePSCg5T97vBSyIVl5akONsVY2JcaBYrJTEncHnjul3OEhMz9B696e7yphXFENARn
	 DBwU+5b0LXIzO445l54Wh6AFQhufbirNgvIx5b3jmcOnZgk5FjhK5oyh9bEmZ0LuJp
	 LutQgR+4FHBTP33ppPmtuFR7HaEKhaMvTUHqJEF1AOKhMru+LMxdPkDTZS+oet7a2r
	 WPHePs4st/R0A==
Date: Mon, 2 Nov 2026 11:53:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Julian Braha <julianbraha@gmail.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Move testing of '-mfentry' back to Makefile
 from Kconfig
Message-ID: <20261102185300.GA1177738@ax162>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
 <20261020-kconfig-fix-mfentry-check-v1-1-428258bc0fc0@kernel.org>
 <20261030222934.0fcfa7-kees@kernel.org>
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
In-Reply-To: <20261030222934.0fcfa7-kees@kernel.org>

On Fri, Oct 30, 2026 at 03:29:58PM -0700, Kees Cook wrote:
> On Tue, Oct 20, 2026 at 02:52:18PM -0700, Nathan Chancellor wrote:
> > Ricardo reported another issue with moving this check from Kbuild to
> > Kconfig, as '-mfentry' is not supported for x86_32 without '-fno-pic',
> > which affects GCC builds that are configured with PIE enabled by
> > default. arch/x86/Makefile adds '-fno-pic' to KBUILD_CFLAGS, so this
> > works properly in Kbuild.
> 
> FWIW, Debian's i686-linux-gnu-gcc 16.2.0 hits this too: ARCH=i386
> allmodconfig fails at scripts/mod/empty.o with "'-pg' without '-mfentry'
> may be unreliable with shrink wrapping" under -Werror. With this patch
> on top of Linus's tree, the whole build is clean.
> 
> Tested-by: Kees Cook <kees@kernel.org>

Thanks for testing! This patch is now in 7.4-rc1, I never sent out a
thanks message:

  https://git.kernel.org/linus/9a6882502d353b89fd2c82b03d9267c94684e4b2

I had applied these for testing pretty quickly and never picked up tags,
which isn't great on my part :/ but at least they will live on the
mailing list.

-- 
Cheers,
Nathan
