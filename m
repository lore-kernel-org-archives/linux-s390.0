From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 03 Dec 2012 16:02:18 +0000
Subject: Re: [PATCH -next] s390/pci: use kmem_cache_zalloc instead of kmem_cache_alloc/memset
Message-Id: <20121203110218.3f1c9136@mschwide>
In-Reply-To: <CAPgLHd-wy1eaf0OjxHeho3Lo3ADBt=oKsU7pGR0vpbHvHiCkjg@mail.gmail.com>
References: <CAPgLHd-wy1eaf0OjxHeho3Lo3ADBt=oKsU7pGR0vpbHvHiCkjg@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Dec 2012 08:07:27 -0500
Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Using kmem_cache_zalloc() instead of kmem_cache_alloc() and memset().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Added to the features branch of the s390 tree. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
