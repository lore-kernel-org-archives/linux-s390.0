Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589476;
	b=xnWgt+E0LmHwMEPeO3XrxIwc9FWLzmvO7YmFAwR87uD9/4zQEgmGAfNf2PFPqVcI03sk
	 eJ7gTnrFjDU6DNGMz49ZSPhBaRlfvCg+YTAfpaTFlT0MzuPYCHZzyp2h57SqaWVGuFtLF
	 iXXoL/AhC/PWwXrmQPxBGpYupHi6quyeVyNRXfZC47amTks5cwmNfynXx3IpJKUuOpyXH
	 jTJjkO1h9DqULsvJWdNyAZWeFvcmstyCudnWrmJPbRa/pRPa6Dl1t907N74ogW9UXk/Hs
	 +dt35hkGj1sLX11xK5Tx9WeRUTJQmFy/H6lzRhCLBsJC/RCblre+Dz8OVDr4w/57+yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589476;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NBhDg0MImfwiV+iHiymSrZLY650URSUr2OCe7I0lP7s=;
	b=Nd9XxMpRJcOHeMokUgCzPqBsMtBcRA7DmZAFhYlf91JgP07oPycJmEUtZLx0lgFy3X1y
	 B9CXACHCxWatTrO0rJ7KoDBXju5ehY4RuLNbCGPt2w4+MTSCH6yFcaCjROeDS2rUIvbt4
	 fpaPJHasQPjBTI+B8RxNKl+y6L+h4HyeO5/97KAL9Dpno7w/R6dKtCcp1YD65ibUvs/H6
	 4lPlZSXrcdNzdvgynTIC6zo6vkG281M1njOwfGxb8K/4CWZt1xbZ5GEwAZlI8sVAHidOI
	 YS1K5vu/NuHxaUEDd7/0yzwvfOufG17o+Z90jtIOvbN6P83l/yrn9c3jfshY9DN9NMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfKyyfjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BA606A31B;
	Wed, 21 Oct 2026 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfKyyfjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC2F1F000C4;
	Wed, 21 Oct 2026 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792589475;
	bh=NBhDg0MImfwiV+iHiymSrZLY650URSUr2OCe7I0lP7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FfKyyfjLxY4t10V3FZAwIoIRJlpfBFriMsHOzRjl6y9GW+d/oAVJRuSEFFNYY30oK
	 4Wy8svGO4K40yoIjLfQq5PE+PMtFU2DXGSGlNoIWgXvfkyXIw3nUbfPbVEeHpCaR9e
	 pQnu4azjWHZ20SXREnOjDxosH6HsgbiEx8+ajX8afstJvNuSuOoRS9G7McQQawfjxy
	 icSnk1QJ6HlFNkk0qhy50tHbCuzlMd2th6sg3riowch+924Th4u3Iv0DtcHWvCjVzs
	 QFLKfJ8DngIwjAp3vJSs39fJSp7jza5YYU/jl0xLLgqNewNPsnY8rvMwjTTEkelj5I
	 OeKUBP0E49mrQ==
Date: Wed, 21 Oct 2026 14:31:10 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Julian Braha <julianbraha@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Ribalda <ribalda@chromium.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: Fallout from moving '-mfentry' check into
 Kconfig stage
Message-ID: <ati-j1mVIgpjfhIt@gremlin>
References: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>
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
In-Reply-To: <20261020-kconfig-fix-mfentry-check-v1-0-428258bc0fc0@kernel.org>

On Tue, Oct 20, 2026 at 02:52:17PM -0700, Nathan Chancellor wrote:
> Hi all,
>
> Ricardo reported an issue from moving the compiler test for '-mfentry'
> into Kconfig. In testing that patch, I noticed that the kernel.org GCC
> builds for s390 were not probing correctly for '-mfentry' support.
>
> The first patch moves the check for '-mfentry' back into Kbuild where we
> have the proper information for whether this flag is actually supported.
>
> The second patch documents the reasons for these issues for future
> travelers to hopefully avoid these problems.
>
> I plan to take this via kbuild-fixes after sufficient review/comments.

Also a valid solution :)

LGTM so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>
> ---
> Nathan Chancellor (2):
>       kbuild: Move testing of '-mfentry' back to Makefile from Kconfig
>       scripts/Kconfig.toolchain: Highlight cc-option differences between Kconfig and Kbuild
>
>  Makefile                  |  3 ++-
>  scripts/Kconfig.toolchain | 23 +++++++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> ---
> base-commit: 997208ce9f43f01febac956cf9aeffe89945e3c1
> change-id: 20261020-kconfig-fix-mfentry-check-50525bc5a6ca
>
> Best regards,
> --
> Cheers,
> Nathan
>

--
Cheers, Lorenzo
