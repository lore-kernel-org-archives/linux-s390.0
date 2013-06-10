From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 10 Jun 2013 15:05:43 +0000
Subject: Re: [PATCH 3.9.y] s390: Add pgste to ptep_modify_prot_start()
Message-Id: <20130610150543.GA6341@osiris>
In-Reply-To: <1370808564.5614.14.camel@deadeye.wl.decadent.org.uk>
References: <1370808564.5614.14.camel@deadeye.wl.decadent.org.uk>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Jun 09, 2013 at 09:09:24PM +0100, Ben Hutchings wrote:
> Commit 52f36be0f4e2 's390/pgtable: Fix check for pgste/storage key
> handling', which was commit b56433cb782d upstream, added a use of
> pgste to ptep_modify_prot_start(), but this variable does not exist.
> In mainline, pgste was added by commit d3383632d4e8 's390/mm: add pte
> invalidation notifier for kvm' and initialised to the return value of
> pgste_get_lock(ptep).  Initialise it similarly here.
> 
> Compile-tested only.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1063,11 +1063,12 @@ static inline pte_t ptep_modify_prot_sta
>  					   unsigned long address,
>  					   pte_t *ptep)
>  {
> +	pgste_t pgste;
>  	pte_t pte;
>  
>  	mm->context.flush_mm = 1;
>  	if (mm_has_pgste(mm))
> -		pgste_get_lock(ptep);
> +		pgste = pgste_get_lock(ptep);
>  
>  	pte = *ptep;
>  	if (!mm_exclusive(mm))

Looks good. Thanks!
