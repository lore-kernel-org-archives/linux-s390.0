Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37C223322;
	Mon,  7 Apr 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050945; cv=none; b=GvoevEdMmjr3l0ZRyWyBtEUwks8UbJ8YNohGRCjzqnBspVulv7MkvI91OxpHwtAkqKeZdNRzRxwoLr6+4V8/V8uppYumCxrCyVaorIhqb/yQp4whGUuJtt359+VWIC1s9GH/1DxCG7U0kDBq1JnxAO71l4W2b7FWpK+62wIeljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050945; c=relaxed/simple;
	bh=QiTncCnd55Ia4eac1kyaB9blDFvntz5XPVt6W64q1n0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iRTjNeJuWEMHVawEY7Ir88oz8GPWgumxUD0EX0hOiKOPagtuGg5zyJUFxYGs3K/pFtJ1ZvgoJDU0BkMol5Ko/rZ/iopf2PGjOYkCv2qSY8apT8GfLre+XOVThwGL4YA8PcyjvHq5r13K57jzaPltNnAQB/REREdN7lLKy1SI3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kwvaeD/a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kwvaeD/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B551C4CEDD;
	Mon,  7 Apr 2025 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744050944;
	bh=QiTncCnd55Ia4eac1kyaB9blDFvntz5XPVt6W64q1n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwvaeD/akigjGI7ZXDY52hZRNE3FRFEN6Uc6iHtJlTKxoE0UMkjLxBOD/fgvDHGq1
	 W4Ni/q9ZjLctOHi6rmPtAnUuHHHe57o4rpfiv0IL8Pp6Z02ulY8lFGXBs6yBBc7eYu
	 XifDovhU5NidAqljsBlmq7svSzYrmQnQBYrtwkdo=
Date: Mon, 7 Apr 2025 11:35:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Hugh Dickins
 <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>, Guenter Roeck
 <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>, Jeremy Fitzhardinge
 <jeremy@goop.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 0/4] mm: Fix apply_to_pte_range() vs lazy MMU mode
Message-Id: <20250407113543.6a43461e397d58471e407323@linux-foundation.org>
In-Reply-To: <cover.1744037648.git.agordeev@linux.ibm.com>
References: <cover.1744037648.git.agordeev@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Apr 2025 17:11:26 +0200 Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> This series is an attempt to fix the violation of lazy MMU mode context
> requirement as described for arch_enter_lazy_mmu_mode():
> 
>     This mode can only be entered and left under the protection of
>     the page table locks for all page tables which may be modified.
> 
> On s390 if I make arch_enter_lazy_mmu_mode() -> preempt_enable() and
> arch_leave_lazy_mmu_mode() -> preempt_disable() I am getting this:
>
> ...
>

Could you please reorganize this into two series?  One series which
should be fast-tracked into 6.15-rcX and one series for 6.16-rc1?

And in the first series, please suggest whether its patches should be
backported into -stable and see if we can come up with suitable Fixes:
targets?

Thanks.
