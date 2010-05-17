Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 May 2010 12:23:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/10] drivers/s390/char: Use kstrdup
Message-ID: <20100517122314.0c639383@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.64.1005142303180.28935@ask.diku.dk>
References: <Pine.LNX.4.64.1005142127100.28935@ask.diku.dk>
	<Pine.LNX.4.64.1005142210320.28935@ask.diku.dk>
	<Pine.LNX.4.64.1005142303180.28935@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 14 May 2010 23:03:51 +0200 (CEST)
Julia Lawall <julia@diku.dk> wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> Use kstrdup when the goal of an allocation is copy a string into the
> allocated region.  Additionally drop the now unused variable len.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression from,to;
> expression flag,E1,E2;
> statement S;
> @@
> 
> -  to = kmalloc(strlen(from) + 1,flag);
> +  to = kstrdup(from, flag);
>    ... when != \(from = E1 \| to = E1 \)
>    if (to==NULL || ...) S
>    ... when != \(from = E2 \| to = E2 \)
> -  strcpy(to, from);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Added to git390, thanks Julia.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
