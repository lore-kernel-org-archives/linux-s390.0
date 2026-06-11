Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38423630B7;
	Thu, 11 Jun 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163322; cv=none; b=ZpKevQ3/R53C35X1Weuc5q0K0AtYwQIZo8tZ2ISBHywRgZ62lp+EdwB1DX/VLXqi4lr7l+ieX9GCioBEQsmJ4/fYG7ez+TsBihJJ555MPqhO6+CFEsRLZVG/ML9SzOg/HPgW19j0BE7OQTAV/2INj+nssX9Hf7mnvuNobPxODMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163322; c=relaxed/simple;
	bh=TzgMTwGX2whiLtuSSGLT29Et1A+aIa1g13YstftP9Vo=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ARJAnu3oVK3GgybxRPYKvIhU7M7wAkmZ6zFMSpf9oTmapfJ439ScoIqL0mr69YxoAyUM4e+GHvf9W3QV00U1QguDQ+ACEjBZP10aTw4MO77gNkvHcf7IZoZGVwDof0KndUkwONnpwVZdUJ9hYfO9OkPsJ4XUhS8AHpx6cn9rcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z01QBw/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z01QBw/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3651F00893;
	Thu, 11 Jun 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781163319;
	bh=mo/64/HPY/6XXdxYXG0j1Rf2IH961OLjSb7/zYXIAp0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Z01QBw/hVD0yzmyR9h/PeeyZ0iRCgAk+/aPcn16UqS3zZfuWeP7a6qWfdqmwQ64c7
	 SUPKR2ROzkbXWRdLbWoisYB51wZF40L8vvw0MozUehUzOXbcsSsnQ0fbgMJJmCHGkW
	 z+TuJ9RV3obUIo8CPP/tRZUPc5Hs7F5upTIG6t0fkoVPZxquwXwNgAinfjXUhvkvqU
	 6YeQ2LjisVMoDUHycAma+Lu74RYAWxQFblvBsWwIvRFb7/kKDiutnbSyvdf+3vpuqS
	 Dp2GHlTRm5vmXa5cb7jZrXcCPOVrqwZElTLvCkH94I9VrnrjiQ9+mME23BBp+rSEGk
	 5s8EcKr+hihgQ==
Message-ID: <c52f5bc48973b580c8df41764acb73e4@kernel.org>
Date: Thu, 11 Jun 2026 07:35:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Sumit Semwal" <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate
 Kconfig
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
Cc: Brian.Starkey@arm.com, afd@ti.com, agordeev@linux.ibm.com, arnd@linaro.org, benjamin.gaignard@collabora.com, chleroy@kernel.org, christian.koenig@amd.com, djbw@kernel.org, dri-devel@lists.freedesktop.org, gerald.schaefer@linux.ibm.com, hch@infradead.org, jgg@ziepe.ca, jiri@resnulli.us, jstultz@google.com, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com, mpe@ellerman.id.au, mripard@kernel.org, npiggin@gmail.com, sumit.semwal@linaro.org, thomas.lendacky@amd.com, tjmercier@google.com, x86@kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

On Wed, 10 Jun 2026 19:53:29 +0530, Sumit Semwal wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While system heap and system_cc_shared heap share a lot of code
> and hence the same source file, their users have different needs.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
