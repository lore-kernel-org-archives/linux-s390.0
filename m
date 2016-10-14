From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 14 Oct 2016 10:24:55 +0000
Subject: Re: [PATCH 1/1] s390: mm: use hugetlb_bad_size()
Message-Id: <20161014102455.GB4047@osiris>
In-Reply-To: <1476375607-7973-1-git-send-email-mayhs11saini@gmail.com>
References: <1476375607-7973-1-git-send-email-mayhs11saini@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 13, 2016 at 09:50:07PM +0530, Shyam Saini wrote:
> Update setup_hugepagesz() to call hugetlb_bad_size() when unsupported
> hugepage size is found.
> 
> ----------
> This patch is not tested on actual s390 architecture
> 
> Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> ---
>  arch/s390/mm/hugetlbpage.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index cd404aa..4a0c5bc 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -217,6 +217,7 @@ static __init int setup_hugepagesz(char *opt)
>  	} else if (MACHINE_HAS_EDAT2 && size == PUD_SIZE) {
>  		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>  	} else {
> +		hugetlb_bad_size();

Applied, thanks!
