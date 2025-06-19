Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306223AB95;
	Thu, 19 Jun 2025 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311847; cv=none; b=a5rFdG/ytdkBkFzS8beGSChhu1VcPnCClxZu2CW3tuD+DpRtoEbW5oasra+6rVxDtmoYa0u85eJOaGDp5zc0P0S9mJTc5NVc8I1LuVnuth6KjgWw4qiLWVENwz4eoV3hCar4JZPxcOMyTNiU2JHo/9kLAro2IjsnPm6XwprbvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311847; c=relaxed/simple;
	bh=52uw0NQcf5nihxhmjL59nvgPCruxZJbKveF+vLTbT9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbJsees37TEXjnkqPnFn60n8esPJveSWTqpHVhZph7LXHIc0lhdaAPkhNYI0HFeYEsvcD6DVZMB4fiz9S0za+OfDNvZAYwcv7pVpX8vf/iOu3YYpRwoFMaSHlTknlQJXHf+xWSEOtBYld4/FInCYd1mqsHUnxk/Bci06e2ZZfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO445R6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO445R6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75664C4CEEA;
	Thu, 19 Jun 2025 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750311846;
	bh=52uw0NQcf5nihxhmjL59nvgPCruxZJbKveF+vLTbT9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HO445R6+OAGiKmC8TLlHe/8nQdfhSr1pmEEVz6I5Pma5vcPbLfTtYBr+KSm8F5+W0
	 760Ear1g0uCvzzIVZlh0PT60BOr/fgbZOJpj9QQaebMZyAguTGmREJMvLWwOl1bIlX
	 x+Z3/3s9QyPRnMSmL+qjtd9QwNTHKcTqXHfDzvI48pHX3ZJwlad8srJSdrH00XUAMA
	 XvvmQsUZKlVAP8zTU7pUo9TRw2805kOM+rvlKJXBvuad2IoIM7o+ogSTw1cVPeOmsY
	 l6abUyFPH5lkB5zXbIbt9w0NqgA1R+6fsEXpCFzS+OSShF4M1ZyCukx9OHKgDejTSL
	 wL5r16cLytZMA==
Date: Thu, 19 Jun 2025 08:43:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v6] mm/percpu: Conditionally define _shared_alloc_tag via
 CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
Message-ID: <aFOjm8pHuWTceIiD@kernel.org>
References: <20250618015809.1235761-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618015809.1235761-1-hao.ge@linux.dev>

On Wed, Jun 18, 2025 at 09:58:09AM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Recently discovered this entry while checking kallsyms on ARM64:
> ffff800083e509c0 D _shared_alloc_tag
> 
> If ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
> s390 and alpha architectures), there's no need to statically define
> the percpu variable _shared_alloc_tag.
> 
> Therefore, we need to implement isolation for this purpose.
> 
> When building the core kernel code for s390 or alpha architectures,
> ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
> by #if defined(MODULE)). However, when building modules for these
> architectures, the macro is explicitly defined.
> 
> Therefore, we remove all instances of ARCH_NEEDS_WEAK_PER_CPU from
> the code and introduced CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
> replace the relevant logic. We can now conditionally define the perpcu
> variable _shared_alloc_tag based on CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU.
> This allows architectures (such as s390/alpha) that require weak
> definitions for percpu variables in modules to include the definition,
> while others can omit it via compile-time exclusion.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.
