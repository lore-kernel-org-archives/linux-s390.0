From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 06 Aug 2009 08:30:06 +0000
Subject: Re: [PATCH] s390: remove unused irq_cpustat_t defintion
Message-Id: <20090806103006.5be057d0@skybase>
In-Reply-To: <20090805222332.GA30900@lst.de>
References: <20090805222332.GA30900@lst.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 6 Aug 2009 00:23:32 +0200
Christoph Hellwig <hch@lst.de> wrote:

> No need to defined a irq_cpustat_t type if __ARCH_IRQ_STAT is defined.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Makes sense, I'll add it to git390. Thanks Christoph.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
