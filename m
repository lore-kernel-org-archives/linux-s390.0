Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Oct 2017 11:26:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/mm: return -ENOMEM in
 arch_get_unmapped_area[_topdown]
In-Reply-To: <20171026073610.9139-1-liwang@redhat.com>
References: <20171026073610.9139-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171026112603.7c095ee6@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Li Wang <liwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, mingo@kernel.org, hughd@google.com, paul.gortmaker@windriver.com, mhocko@suse.com, shuwang@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Oct 2017 15:36:10 +0800
Li Wang <liwang@redhat.com> wrote:

> That would be very hard to get -ENOMEM returned in crst_table_upgrade()
> because the condition(addr + len <= TASK_SIZE) makes all 'end' value
> is smaller/equal than 'TASK_SIZE_TASK'. So let's move it to the upper
> layer.

I have a hard time understanding what scenario you describe. There is no
'TASK_SIZE_TASK', only TASK_SIZE, TASK_SIZE_OF and TASK_SIZE_MAX. 

The code in mmap.c checks for the per-task limit, 31-bit vs 64-bit.
pgalloc.c checks for the maximum allowed address and does not care
about the task.

> Fixes: 8ab867cb0806 (s390/mm: fix BUG_ON in crst_table_upgrade)
> Signed-off-by: Li Wang <liwang@redhat.com>

I don't think this patch fixes anything.

> ---
>  arch/s390/mm/mmap.c    | 6 ++++++
>  arch/s390/mm/pgalloc.c | 3 +--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 5bea139..8ddb13a 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -119,6 +119,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  		return addr;
> 
>  check_asce_limit:
> +	if (addr + len >= TASK_SIZE_MAX)
> +		return -ENOMEM;
> +
>  	if (addr + len > current->mm->context.asce_limit &&
>  	    addr + len <= TASK_SIZE) {
>  		rc = crst_table_upgrade(mm, addr + len);
> @@ -184,6 +187,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	}
> 
>  check_asce_limit:
> +	if (addr + len >= TASK_SIZE_MAX)
> +		return -ENOMEM;
> +
>  	if (addr + len > current->mm->context.asce_limit &&
>  	    addr + len <= TASK_SIZE) {
>  		rc = crst_table_upgrade(mm, addr + len);
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 05f1f27..5e4b887 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -84,8 +84,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
> 
>  	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
>  	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
> -	if (end >= TASK_SIZE_MAX)
> -		return -ENOMEM;
> +
>  	rc = 0;
>  	notify = 0;
>  	while (mm->context.asce_limit < end) {


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
