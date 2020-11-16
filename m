Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49562 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgKPHaV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 02:30:21 -0500
Subject: Re: [PATCH] md: dm-writeback: add __noreturn to BUG-ging function
References: <20201113225228.20563-1-rdunlap@infradead.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
Date: Mon, 16 Nov 2020 08:30:10 +0100
MIME-Version: 1.0
In-Reply-To: <20201113225228.20563-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org



On 13.11.20 23:52, Randy Dunlap wrote:
> Building on arch/s390/ flags this as an error, so add the
> __noreturn attribute modifier to prevent the build error.
> 
> cc1: some warnings being treated as errors
> ../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
> ../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]

ok with me, but I am asking why

the unreachable macro is not good enough. For x86 it obviously is.

form arch/s390/include/asm/bug.h
#define BUG() do {                                      \
        __EMIT_BUG(0);                                  \
        unreachable();                                  \
} while (0)


> 
> Fixes: 48debafe4f2f ("dm: add writecache target")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: dm-devel@redhat.com
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/md/dm-writecache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20201113.orig/drivers/md/dm-writecache.c
> +++ linux-next-20201113/drivers/md/dm-writecache.c
> @@ -317,7 +317,7 @@ err1:
>  	return r;
>  }
>  #else
> -static int persistent_memory_claim(struct dm_writecache *wc)
> +static int __noreturn persistent_memory_claim(struct dm_writecache *wc)
>  {
>  	BUG();
>  }
> 
