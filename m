Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] s390: drop smp_mb in vdso_init
References: <1452010645-25380-1-git-send-email-mst@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <568E24C1.7090109@de.ibm.com>
Date: Thu, 7 Jan 2016 09:41:37 +0100
MIME-Version: 1.0
In-Reply-To: <1452010645-25380-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 01/05/2016 05:17 PM, Michael S. Tsirkin wrote:
> The initial s390 vdso code is heavily influenced by the powerpc version
> which does have a smp_wmb in vdso_init right before the vdso_ready=1
> assignment. s390 has no need for that.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Untested.
> 
>  arch/s390/kernel/vdso.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
> index 59eddb0..a1cfd37 100644
> --- a/arch/s390/kernel/vdso.c
> +++ b/arch/s390/kernel/vdso.c
> @@ -299,8 +299,6 @@ static int __init vdso_init(void)
> 
>  	get_page(virt_to_page(vdso_data));
> 
> -	smp_mb();
> -
>  	return 0;
>  }
>  early_initcall(vdso_init);
> 

applied to the s390 tree.
Thanks.
