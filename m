Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390/mm: Silence compiler warning when compiling without
 CONFIG_PGSTE
References: <20190407125509.6380-1-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0e63589f-190f-d3a4-b373-4188dfe54e26@redhat.com>
Date: Mon, 8 Apr 2019 09:09:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190407125509.6380-1-thuth@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07.04.19 14:55, Thomas Huth wrote:
> If CONFIG_PGSTE is not set (e.g. when compiling without KVM), GCC complains:
> 
>   CC      arch/s390/mm/pgtable.o
> arch/s390/mm/pgtable.c:413:15: warning: ‘pmd_alloc_map’ defined but not
>  used [-Wunused-function]
>  static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
>                ^~~~~~~~~~~~~
> 
> Wrap the function with "#ifdef CONFIG_PGSTE" to silence the warning.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/mm/pgtable.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 8485d6dc2754..9ebd01219812 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -410,6 +410,7 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
>  	return old;
>  }
>  
> +#ifdef CONFIG_PGSTE
>  static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
>  {
>  	pgd_t *pgd;
> @@ -427,6 +428,7 @@ static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
>  	pmd = pmd_alloc(mm, pud, addr);
>  	return pmd;
>  }
> +#endif
>  

We could also move the function down to the functions where it is used

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
