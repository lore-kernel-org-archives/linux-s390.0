Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC75A4FD;
	Thu, 13 Jun 2024 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321449; cv=none; b=Ikk80dkzjQbqSNak06EbPOa26lq8o7R8MrfhvUaVzjJz1eK2Dtb19PMks4RMmi8PgLnmIVcRTZTkHD9Q7ZXznczFiCP7rqCPTiKemiMqQwELTQuDzz+ubR3zh4IdHy9OH2q989Q61hvZmS+z1e/r7NeIPjU5EeuXM8YpJ4M9Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321449; c=relaxed/simple;
	bh=PW00fcWzZ7rP+l8wtSRyUhUcthMcm78zijiC8gH1ZzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVicknJBq4KzoUReVGE6Opowgq2Ad7dUCpCxTFVSmw+YY1kpqz1sTsoJZbt7v+OcLuXFnUJBDzI5fwUR7D1HS8Bdx+t1m0IRnbjaaHpp+ZAAQ3Mg8uYVpnArCYZhyhwGYVuZDxOoDzJGprfaxXv3bfl8s6MvUk+lKQyEbX5RQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtjrlNte; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtjrlNte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F9DC2BBFC;
	Thu, 13 Jun 2024 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718321448;
	bh=PW00fcWzZ7rP+l8wtSRyUhUcthMcm78zijiC8gH1ZzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtjrlNtei/CJSiX6UYG5KNZw73izRuSmLgW6A1GZEsLtaRKZQtHYNomLZTK9GNhnb
	 ctaZmJz31OO7MhKgOyloDCSRsTVCQ+3pymkq++vM5g/ycWf8GL6sC9XILt/hqm1hN4
	 u8lHbBjbxkwwFRKscoBM45TSTGv1ij52Ox2IUN8DcZrvbZNM5eOKMxd1RJDRDNDQwh
	 21olhu2jjss3qs9lfSmbXZtoDpRBSeZWqXnerR22r1spRA4hNhRgB/oG9ZXebs5Mcd
	 WjbOYVgj981QV1rjP5Tutpr6MxPKlhTEs4jJQ2/Kofj5DRn1fURfmmU5ZJ37suFRxw
	 jDUBTjYRCc4Mg==
From: SeongJae Park <sj@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: SeongJae Park <sj@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Pekka Enberg <penberg@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v4 12/35] kmsan: Support SLAB_POISON
Date: Thu, 13 Jun 2024 16:30:44 -0700
Message-Id: <20240613233044.117000-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613153924.961511-13-iii@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ilya,

On Thu, 13 Jun 2024 17:34:14 +0200 Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Avoid false KMSAN negatives with SLUB_DEBUG by allowing
> kmsan_slab_free() to poison the freed memory, and by preventing
> init_object() from unpoisoning new allocations by using __memset().
> 
> There are two alternatives to this approach. First, init_object()
> can be marked with __no_sanitize_memory. This annotation should be used
> with great care, because it drops all instrumentation from the
> function, and any shadow writes will be lost. Even though this is not a
> concern with the current init_object() implementation, this may change
> in the future.
> 
> Second, kmsan_poison_memory() calls may be added after memset() calls.
> The downside is that init_object() is called from
> free_debug_processing(), in which case poisoning will erase the
> distinction between simply uninitialized memory and UAF.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  mm/kmsan/hooks.c |  2 +-
>  mm/slub.c        | 13 +++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
[...]
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1139,7 +1139,12 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  	unsigned int poison_size = s->object_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
> -		memset(p - s->red_left_pad, val, s->red_left_pad);
> +		/*
> +		 * Use __memset() here and below in order to avoid overwriting
> +		 * the KMSAN shadow. Keeping the shadow makes it possible to
> +		 * distinguish uninit-value from use-after-free.
> +		 */
> +		__memset(p - s->red_left_pad, val, s->red_left_pad);

I found my build test[1] fails with below error on latest mm-unstable branch.
'git bisect' points me this patch.

      CC      mm/slub.o
    /mm/slub.c: In function 'init_object':
    /mm/slub.c:1147:17: error: implicit declaration of function '__memset'; did you mean 'memset'? [-Werror=implicit-function-declaration]
     1147 |                 __memset(p - s->red_left_pad, val, s->red_left_pad);
          |                 ^~~~~~~~
          |                 memset
    cc1: some warnings being treated as errors

I haven't looked in deep, but reporting first.  Do you have any idea?

[1] https://github.com/awslabs/damon-tests/blob/next/corr/tests/build_m68k.sh


Thanks,
SJ

[...]
