Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 4 Jun 2014 13:09:12 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 8/10] s390/pci: use safer test on the result of
 find_first_zero_bit
In-Reply-To: <1401872880-23685-9-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <alpine.LFD.2.11.1406041308450.1560@denkbrett>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr> <1401872880-23685-9-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 Jun 2014, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
> return a larger number than the maximum position argument if that position
> is not a multiple of BITS_PER_LONG.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e1,e2,e3;
> statement S1,S2;
> @@
> 
> e1 = find_first_zero_bit(e2,e3)
> ...
> if (e1 
> - ==
> + >=
>   e3)
> S1 else S2
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  arch/s390/pci/pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -u -p a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -566,7 +566,7 @@ static int zpci_alloc_iomap(struct zpci_
> 
>  	spin_lock(&zpci_iomap_lock);
>  	entry = find_first_zero_bit(zpci_iomap, ZPCI_IOMAP_MAX_ENTRIES);
> -	if (entry == ZPCI_IOMAP_MAX_ENTRIES) {
> +	if (entry >= ZPCI_IOMAP_MAX_ENTRIES) {
>  		spin_unlock(&zpci_iomap_lock);
>  		return -ENOSPC;
>  	}
> @@ -746,7 +746,7 @@ static int zpci_alloc_domain(struct zpci
>  {
>  	spin_lock(&zpci_domain_lock);
>  	zdev->domain = find_first_zero_bit(zpci_domain, ZPCI_NR_DEVICES);
> -	if (zdev->domain == ZPCI_NR_DEVICES) {
> +	if (zdev->domain >= ZPCI_NR_DEVICES) {
>  		spin_unlock(&zpci_domain_lock);
>  		return -ENOSPC;
>  	}
> 
> 

Thanks, applied.
Sebastian
