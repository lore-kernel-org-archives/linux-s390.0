Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0221B192;
	Wed, 26 Feb 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599601; cv=none; b=D7sI/4kOxWAClUnuiGd6907DHtshxndJwjDqqpZ8ON4AAHB0zWz2dKAuRpUFZcIfzTewbCPDcEhpoxwcsijAILLb5PK0wawtFkNtOgdRSvqgFb3QTnFqJgENAVUTdh/Os1quabIjpssRr90zBYZ1H95Urh2z+OVLOL+CU8lINQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599601; c=relaxed/simple;
	bh=yMWz6moEgRjlkMd5jFnex7P2z8dKHRE0Vn23vCnj+4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnaOKTZ76z/J4ZdjWQig8NOn/MALPBQwF2aRCW3RtEZz+QNqDomGvyGnf/4+mM8rui2enB+imuFpThUhZ5XtQSWuNFnLNfUtlHNir8pTv41w5IaInBF5W2b+2xIc++0gPZ+sY6JMRgTnZBVNb88I6xQx80IwVocklzgTmvfTUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EDBC4CED6;
	Wed, 26 Feb 2025 19:53:17 +0000 (UTC)
Date: Wed, 26 Feb 2025 19:53:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V3 5/5] mm: Rename GENERIC_PTDUMP and PTDUMP_CORE
Message-ID: <Z79xK3xJWm0vH5jH@arm.com>
References: <20250226122404.1927473-1-anshuman.khandual@arm.com>
 <20250226122404.1927473-6-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226122404.1927473-6-anshuman.khandual@arm.com>

On Wed, Feb 26, 2025 at 05:54:04PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 6cf4aae05219..b2931d1ae0fb 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -7,7 +7,7 @@
>  
>  #include <linux/ptdump.h>
>  
> -#ifdef CONFIG_PTDUMP_CORE
> +#ifdef CONFIG_PTDUMP

Do we need this #ifdef at all? I haven't tried but usually, if the
feature is not enabled, the header file on its own should be harmless.

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
