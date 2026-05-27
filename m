Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4246AF25;
	Wed, 27 May 2026 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905787; cv=none; b=DueYXlfNBgC0uVDfzgfzwjxmwhG+fWo8R24N3p2RB00/2zR1XRPbU3oob8GqistCu9MzNGDz5WaQshPqs2+7VQ4HdEqF9N42ddt+Bs3x0N26RZShvXRvE/UZhHg26Wn4tgF4TBowtZb+p5AiSJooB8oMj0WkG6Gjyx8IX9N8XVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905787; c=relaxed/simple;
	bh=1VT4vh1CF0YV6Dj6+BM41l9UxaTUWIN/MOLzryPXFf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prI0kI3MQVBY9G3yop7zRHU9nWnVHjT0GcUsiAXTJc8x9b1YoI5UTUSJKnp1gQSnyzKh8a+1ZLieEFvdxBb9isK4ZkY+bUPpPPoDJOUhbZegEjDTz/vat8dZRdWBelGfHVaMG4pIl8cKT1w9CSOKUtKEm0IocqKRIGtDc+bxXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BSyfa/0G; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BSyfa/0G"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFB0B40E01B5;
	Wed, 27 May 2026 18:16:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hOVssZXizJI1; Wed, 27 May 2026 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1779905772; bh=yKtFY4BBYMPRlzCIJJQtbW5x/y0DZW6pYUq+N5xMMmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSyfa/0GmQmX7Oe2vHTD+nbiGKxsP0fxObUh9NlRN+UHJXUPOJ3yd/0nydBIT9yCf
	 pCR3EocFI14rWJT4k+n1HljCFvorak7nDVDyU2S7ucKOyUCPVd6jLVyfxZefXMz070
	 a+mMn2YRegoVBuE7qbIb2qaquDBnDh5byKQvsLttgNE9xdAfhrg88R4UdIQVUaCSqg
	 JfiCj3Jd+6AImBQHRBlIBx/52nnzWsU+3vzxtGW517fcKoh0DxEtqTd3STS3T1tykN
	 j0pcE+Zcqc+r3gTkadjgJaWDYea6f/aUn+Fvw2vouAeS4CCT6+kGyKgv885YAr7dCd
	 YxHlyYOzcDYSZVBwFJwotFPaNFJ6VTT/CJemzYjIgt7ZwHxqHaewpP/Jn1AYWSD2BI
	 fSfdj1h1l2pSliLhyA183HiVEvtEz5zHuSawQ0NaaZP7S3tUNLzM0KBcZUpnhOwXGO
	 uJwRhAn0sAI7G5JelmOgn4Txtqpkn2rXz66NBF3Nmg9vI5A/gcH0LdSsKv3yaY7dnT
	 ds/fIx6K/yI0ABhJxtqbmJ4WxM47LUo0XAVLdeBxb8R65K/G3iCP4ZzTvEUUg4/UsB
	 k9eWl+aoHEuKDH6sD0iPA7m41OQ1cbbfTjvZoGFC5aT4HS45feFtPF25igyXJRH7Es
	 mjsWNqk1Q0OcuQoAKpE4LrZg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00:b8a3:f58e:8829:9ca6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9F3740E00BA;
	Wed, 27 May 2026 18:15:51 +0000 (UTC)
Date: Wed, 27 May 2026 11:15:49 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mripard@kernel.org,
	sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <20260527181549.GBahc01Xflm2yo5OqI@fat_crate.local>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527160716.GN2487554@ziepe.ca>

On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > Setting memory decrypted is a dangerous operations and should only
> > be available to core code.  We should have various allocators for
> > decrypted code, but not export the functionality to random code.
> 
> At the very least an EXPORT_SYMBOL_NS.
> 
> Looks like there are about 3 modules using it already..

Looks like more to me...

In any case, we exported them back then for some framebuffer things:

95cf9264d5f3 ("x86, drm, fbdev: Do not specify encrypted memory for video mappings")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
