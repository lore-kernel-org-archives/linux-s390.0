Return-Path: <linux-kernel-owner+w=401wt.eu-S1754415AbYJFKxF@vger.kernel.org>
Date: Mon, 6 Oct 2008 12:52:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] drivers/s390/cio/chsc_sch.c: Correct use of ! and &
Message-ID: <20081006105227.GA6303@osiris.boeblingen.de.ibm.com>
References: <Pine.LNX.4.64.0810042205090.19286@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0810042205090.19286@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Oct 04, 2008 at 10:05:47PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> In commit e6bafba5b4765a5a252f1b8d31cbf6d2459da337, a bug was fixed that
> involved converting !x & y to !(x & y).  The code below shows the same
> pattern, and thus should perhaps be fixed in the same way.  In particular,
> the result of !scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND is
> always just !scsw_stctl(&request->irb.scsw).
> [...]
> -	if (!scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND)
> +	if (!(scsw_stctl(&request->irb.scsw) & SCSW_STCTL_STATUS_PEND))
>  		return -EIO;
>  	backed_up = scsw_cstat(&request->irb.scsw) & SCHN_STAT_CHAIN_CHECK;
>  	request->irb.scsw.cmd.cstat &= ~SCHN_STAT_CHAIN_CHECK;

Nice finding. Thank you!
