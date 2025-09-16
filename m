Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AA2DC78E;
	Tue, 16 Sep 2025 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993815; cv=none; b=dL0J4oJQbSwpbfPkGUBaW7uII5bvSywJn9NbO2y0lrq2DIoyxBrj+OjyvB7m3hx1GwGSjn5NrcY7zC+HqkN/k7rPOStcBdgVj7V+Jr4u1W4pGqx6VxK+j1HCOJ/IbmA/3ezgnf47Fskf+jIH9ajjAPd0LGoo0LAVtxNG6CJ/1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993815; c=relaxed/simple;
	bh=CfVil0FdRSS0PaXQXnEL2MuMd3+XojlUadD8GRWQi7w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lWaNExEOINSJiYchYCOC5M5M9aohNp8Ue92UacxyeBg9F6Wuotr1Qzdx5ebVZaErEMFK7i7MS0llscolIejxHbvVGWSr2JYzV1XQ7E4eE41uwZHhn1ZGbAFzNcmlEy7nvbhA3ZEMojtlmARMR0AgnDGLmeL7SmEJSx0ikURb7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CNf7AHxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CNf7AHxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04DAC4CEEB;
	Tue, 16 Sep 2025 03:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757993814;
	bh=CfVil0FdRSS0PaXQXnEL2MuMd3+XojlUadD8GRWQi7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CNf7AHxNVzyFResUYW5usorS95/1cgWEfQBxIXzVgEh5LcEryf/UaE9d6FXnmevp/
	 hUOvt/SIiD7/Xfzhk6DVSSkzymHadep7a/+dLaY5Vb+n0WLbUQmf5rY9iYjBaJbYhP
	 EK//AR137efTrjN+qYgc2VP+Ya6Cv8E6hGsRI3+Y=
Date: Mon, 15 Sep 2025 20:36:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, ryabinin.a.a@gmail.com,
 christophe.leroy@csgroup.eu, bhe@redhat.com, hca@linux.ibm.com,
 zhangqing@loongson.cn, chenhuacai@loongson.cn, davidgow@google.com,
 glider@google.com, dvyukov@google.com, alexghiti@rivosinc.com,
 alex@ghiti.fr, agordeev@linux.ibm.com, vincenzo.frascino@arm.com,
 elver@google.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify
 static key across modes
Message-Id: <20250915203653.c17d501a5f4b68936a0e3ea9@linux-foundation.org>
In-Reply-To: <CACzwLxh4pJOBbU2fHKCPWkHHCuLtDW-rh52788u2Q6+nG-+bTA@mail.gmail.com>
References: <20250810125746.1105476-1-snovitoll@gmail.com>
	<20250810125746.1105476-2-snovitoll@gmail.com>
	<CA+fCnZdFp69ZHbccLSEKYH3i7g6r2WdQ0qzyf+quLnA0tjfXJg@mail.gmail.com>
	<CACzwLxh4pJOBbU2fHKCPWkHHCuLtDW-rh52788u2Q6+nG-+bTA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 09:30:03 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.com> wrote:

> On Wed, Sep 3, 2025 at 6:01 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>

[400+ lines removed - people, please have mercy]

>
> > > @@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
> > >  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
> > >                                 unsigned long ip)
> > >  {
> > > -       if (!kasan_arch_is_ready() || is_kfence_address(object))
> > > +       if (is_kfence_address(object))
> > >                 return false;
> >
> > Why is the check removed here and in some other places below? This
> > need to be explained in the commit message.
> 
> kasan_arch_is_ready which was unified with kasan_enabled, was removed
> here because
> __kasan_slab_pre_free is called from include/linux/kasan.h [1] where
> there's already kasan_enabled() check.
> 
> [1] https://elixir.bootlin.com/linux/v6.16.7/source/include/linux/kasan.h#L198
> 
> Please let me know if v7 is required with the change in the git commit
> message only.

Neither works - please send along the appropriate paragraph and I'll
paste it in, can't get easier than that.

> >
>
> [another ~250 lines snipped]
>
