From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 28 Feb 2013 12:50:01 +0000
Subject: Re: [PATCH -next] s390/pci: use kmem_cache_zalloc instead of kmem_cache_alloc/memset
Message-Id: <20130228125000.GC4819@osiris>
In-Reply-To: <CAPgLHd_ioTOW81brF-Yk9ssx2nXrFcbOShqHP+AsFyWyoUqe3A@mail.gmail.com>
References: <CAPgLHd_ioTOW81brF-Yk9ssx2nXrFcbOShqHP+AsFyWyoUqe3A@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 25, 2013 at 10:09:25PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Using kmem_cache_zalloc() instead of kmem_cache_alloc() and memset().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

[...]

> -	zdev->fmb = kmem_cache_alloc(zdev_fmb_cache, GFP_KERNEL);
> +	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
>  	if (!zdev->fmb)
>  		return -ENOMEM;
> -	memset(zdev->fmb, 0, sizeof(*zdev->fmb));
>  	WARN_ON((u64) zdev->fmb & 0xf);

Applied. Thanks!
