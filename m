Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Aug 2011 16:32:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 5/9] drivers/s390/block/dasd_ioctl.c: add missing kfree
Message-ID: <20110808143255.GA19688@osiris.boeblingen.de.ibm.com>
References: <1312802283-9107-5-git-send-email-julia@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1312802283-9107-5-git-send-email-julia@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, kernel-janitors@vger.kernel.org, linux390@de.ibm.com, Stefan Weinhuber <wein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 08, 2011 at 01:17:59PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Data is only used to temporarily hold information to be copied to the user
> level, so it should be freed before leaving the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)

[...]

> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/s390/block/dasd_ioctl.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks!
