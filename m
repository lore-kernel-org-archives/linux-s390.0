Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 May 2010 12:23:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 23/37] drivers/s390/char: Use kmemdup
Message-ID: <20100517122332.04cfa06a@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.1005152319490.21345@ask.diku.dk>
References: <Pine.LNX.4.64.1005152319490.21345@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 15 May 2010 23:20:07 +0200 (CEST)
Julia Lawall <julia@diku.dk> wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> Use kmemdup when some other buffer is immediately copied into the
> allocated region.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression from,to,size,flag;
> statement S;
> @@
> 
> -  to = \(kmalloc\|kzalloc\)(size,flag);
> +  to = kmemdup(from,size,flag);
>    if (to==NULL || ...) S
> -  memcpy(to, from, size);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Added to git390 as well, thanks again.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
