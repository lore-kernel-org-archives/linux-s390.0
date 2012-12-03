From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 03 Dec 2012 16:02:36 +0000
Subject: Re: [PATCH -next] s390/pci: fix potential NULL pointer dereference in dma_free_seg_table()
Message-Id: <20121203110236.15958af0@mschwide>
In-Reply-To: <CAPgLHd-CdtheHfnGzpogmgV8_3of8Px2gZKokgt7PtgCFUSPFQ@mail.gmail.com>
References: <CAPgLHd-CdtheHfnGzpogmgV8_3of8Px2gZKokgt7PtgCFUSPFQ@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Dec 2012 08:08:23 -0500
Wei Yongjun <weiyj.lk@gmail.com> wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The dereference to 'zdev' should be moved below the NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Added this patch as well. Thanks again.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
