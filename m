Return-Path: <linux-kernel-owner+w=401wt.eu-S1754047AbYCLR6T@vger.kernel.org>
Date: Wed, 12 Mar 2008 13:57:51 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
Subject: Re: [patch 01/10] Add new fields for System z10 to /proc/sysinfo
Message-ID: <20080312175751.GB10653@josefsipek.net>
References: <20080312173155.703966894@de.ibm.com> <20080312173216.213008370@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080312173216.213008370@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 12, 2008 at 06:31:56PM +0100, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Add permanent and temporary model capacity and the corresponding
> capacity value fields for the three capacity identifiers to the
> output of /proc/sysinfo.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
> 
>  drivers/s390/sysinfo.c |   21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> Index: quilt-2.6/drivers/s390/sysinfo.c
> ===================================================================
> --- quilt-2.6.orig/drivers/s390/sysinfo.c
> +++ quilt-2.6/drivers/s390/sysinfo.c
> @@ -26,6 +26,11 @@ struct sysinfo_1_1_1 {
>  	char sequence[16];
>  	char plant[4];
>  	char model[16];
> +	char model_perm_cap[16];
> +	char model_temp_cap[16];
> +	char model_cap_rating[4];
> +	char model_perm_cap_rating[4];
> +	char model_temp_cap_rating[4];
>  };

I'd try to be safer, and make the struct __attribute__((packed))...

Josef 'Jeff' Sipek.

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
