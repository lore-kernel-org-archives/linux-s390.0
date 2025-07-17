Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6361EF092;
	Thu, 17 Jul 2025 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790249; cv=none; b=OE3FCjX5yjZcwsRhW4oIn8V5UK6mQ0a1QVplRNTvWWjiG/jgn2yk4vitWieaXVn4Qqb4h+wlxdQ4oEX84l1S/c6PSeAtvqgl21RV1KIiWh2/12SlWDB4cJrnpMeFr3rkTPEk1ku6Omjboy18JH4r9k9JfkumCkvuERfYy9inKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790249; c=relaxed/simple;
	bh=vZ0u5fd3DfJ6yBk3+g+sfM/GC0NNG81eBl17aO+ZI9c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TzmsaQFA3jRTvSViIjtBZMIE7+tReVhGFAWWyf8Rao1mTNc4rv3wagpZMMYT76NhpOy+Vu4Q1QStBvpuX/vLgwj0pDIysgfhm6H8hddBveea27Bvrm/+Apc1d/Skd0y2UPxpDGJVTl+svKJyxfB64DvAW/CjpW0geLZOVEZq+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JnFTsEv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JnFTsEv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A609C4CEE3;
	Thu, 17 Jul 2025 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752790249;
	bh=vZ0u5fd3DfJ6yBk3+g+sfM/GC0NNG81eBl17aO+ZI9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JnFTsEv6asV1QHvn9oyLm0adlVD8YAwUk8D9+xSBsZ/4xRhcX7l4l0qMZNDgSRPEr
	 VDRVgiNcFppstl5irHVMQqIlu2EyZC6EiTz9tDOSSNke5t727uDO0ipCsMi5ieUTgf
	 xIAtuMC6pkfxnueF+6ZvQa0PYivWUcYkQ1GV4da4=
Date: Thu, 17 Jul 2025 15:10:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, ryabinin.a.a@gmail.com, glider@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
Message-Id: <20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
In-Reply-To: <20250717142732.292822-2-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
	<20250717142732.292822-2-snovitoll@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 19:27:21 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:

> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> This option allows us to:
> 1. Use static keys only where needed (avoiding overhead)
> 2. Use compile-time constants for arch that don't need runtime checks
> 3. Maintain optimal performance for both scenarios
> 
> Architectures that need deferred KASAN should select this option.
> Architectures that can enable KASAN early will get compile-time
> optimizations instead of runtime checks.

Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
during -rc6, especially given the lack of formal review and ack tags.

But but but, that's what the mm-new branch is for.  I guess I'll add it
to get some additional exposure, but whether I'll advance it into
mm-unstable/linux-next for this cycle is unclear.

What do you (and others) think?
