Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBE13C81B;
	Tue, 22 Jul 2025 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144522; cv=none; b=EbVRQmJV+rAVogdhwi1uxbZ0EVcwrM5XOeob8p9P8kTGd9sni/zGP1Kr0RWAiwNJ1gZnf8lnuYQ4j/q8zyF/TAUQdc2+7hBF1lpwqwkv3Epl319ThUPzRdHo8xx6JpgiFBqF90KA9DOxaGW9wou8US0eSmg0+GJXH4oydGRCQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144522; c=relaxed/simple;
	bh=AT7biWnsDCxaCvU7U+iSpw4vNS5TBQoe3SiDN0kL4kw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CZ0NtP0fSQmo9csBKyhdmwvd3sBLe+bA8M6EaCQXdJdxYWRsLxmzpB/OGTDxJwbIiYMHLaWtVfbflaGSGqwn6chNYqycH3tZITEzEMfEbZtngy1ZTCMk2J8xJyPTnulo3/tQVbYzoo1t18SPqKZ0wylpwOkLLvckGOC+PFxUNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=INuAml7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="INuAml7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F17C4CEF6;
	Tue, 22 Jul 2025 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753144521;
	bh=AT7biWnsDCxaCvU7U+iSpw4vNS5TBQoe3SiDN0kL4kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=INuAml7aaOfZKzIUxI4Jtp5dIRPXceDiGCMSn/BcpBEsTc1817QQF/mLnLo7zVGvC
	 tbq9rI4BZrhjCeeHWJKHB4TAfP28laWLUpmcWr4W9hiZ6ObpNJJQoYLudeaLJcdFFn
	 UTOfW5v0jeh5cKAcLjqgeLQM4saR33e63KErjkHU=
Date: Mon, 21 Jul 2025 17:35:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 01/12] lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN
 option
Message-Id: <20250721173520.a24c29782de519dab1c59fec@linux-foundation.org>
In-Reply-To: <a1bc7a9d-817d-49cc-b7f1-79a900090136@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
	<20250717142732.292822-2-snovitoll@gmail.com>
	<20250717151048.bb6124bea54a31cd2b41faaf@linux-foundation.org>
	<a1bc7a9d-817d-49cc-b7f1-79a900090136@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 01:18:52 +0200 Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:

> >> Architectures that need deferred KASAN should select this option.
> >> Architectures that can enable KASAN early will get compile-time
> >> optimizations instead of runtime checks.
> > 
> > Looks nice and appears quite mature.  I'm reluctant to add it to mm.git
> > during -rc6, especially given the lack of formal review and ack tags.
> > 
> > But but but, that's what the mm-new branch is for.  I guess I'll add it
> > to get some additional exposure, but whether I'll advance it into
> > mm-unstable/linux-next for this cycle is unclear.
> > 
> > What do you (and others) think?
> 
> After looking a bit, it breaks UM and probably LoongArch too.
> I'd say it needs more work and not ready even for mm-new.

OK, thanks.  I'll drop the v3 series.
