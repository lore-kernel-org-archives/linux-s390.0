Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 5 Nov 2018 07:08:55 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: numa: Export __node_distance
References: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1541366886-32127-1-git-send-email-linux@roeck-us.net>
Message-Id: <20181105060855.GA3747@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Nov 04, 2018 at 01:28:06PM -0800, Guenter Roeck wrote:
> __node_distance is used by nvme, resulting in:
> 
> ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
> 
> when trying to build nvme as module.
> 
> Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I thought I had seen that patch already, but I don't find it anywhere.
> Maybe that was for another architecture. My apologies for the noise if it
> is already queued.

It's already queued here: https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-linus&id=a541f0ebcc08ed8bc0cc492eec9a86cb280a9f24

> diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
> index ae0d9e889534..d31bde0870d8 100644
> --- a/arch/s390/numa/numa.c
> +++ b/arch/s390/numa/numa.c
> @@ -53,6 +53,7 @@ int __node_distance(int a, int b)
>  {
>  	return mode->distance ? mode->distance(a, b) : 0;
>  }
> +EXPORT_SYMBOL(__node_distance);
