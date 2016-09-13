Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 13 Sep 2016 08:47:13 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: cleanup with list_first_entry_or_null()
References: <1473703839-1185-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473703839-1185-1-git-send-email-yamada.masahiro@socionext.com>
Message-Id: <20160913064713.GB4047@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-s390@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 13, 2016 at 03:10:39AM +0900, Masahiro Yamada wrote:
> The combo of list_empty() check and return list_first_entry()
> can be replaced with list_first_entry_or_null().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/kernel/crash_dump.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index 29df848..621907d 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -71,9 +71,8 @@ struct save_area * __init save_area_alloc(bool is_boot_cpu)
>   */
>  struct save_area * __init save_area_boot_cpu(void)
>  {
> -	if (list_empty(&dump_save_areas))
> -		return NULL;
> -	return list_first_entry(&dump_save_areas, struct save_area, list);
> +	return list_first_entry_or_null(&dump_save_areas, struct save_area,
> +					list);

Applied, however without the line break in order to improve readability.

Thanks!
