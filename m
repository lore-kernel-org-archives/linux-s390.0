From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [GIT PULL 2/2] KVM: s390/mm: try a cow on read only pages for
 key ops
Date: Tue, 26 Aug 2014 20:06:11 -0700
Message-ID: <1409108771.30127.21.camel@deadeye.wl.decadent.org.uk>
References: <1408972211-27122-1-git-send-email-borntraeger@de.ibm.com>
	 <1408972211-27122-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1408972211-27122-3-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2014-08-25 at 15:10 +0200, Christian Borntraeger wrote:
> The PFMF instruction handler  blindly wrote the storage key even if
> the page was mapped R/O in the host. Lets try a COW before continuing
> and bail out in case of errors.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/s390/mm/pgtable.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 19daa53..5404a62 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -986,11 +986,21 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
>  	pte_t *ptep;
>  
>  	down_read(&mm->mmap_sem);
> +retry:
>  	ptep = get_locked_pte(current->mm, addr, &ptl);
>  	if (unlikely(!ptep)) {
>  		up_read(&mm->mmap_sem);
>  		return -EFAULT;
>  	}
> +	if (!(pte_val(*ptep) & _PAGE_INVALID) &&
> +	     (pte_val(*ptep) & _PAGE_PROTECT)) {
> +			pte_unmap_unlock(*ptep, ptl);
> +			if (fixup_user_fault(current, mm, addr, FAULT_FLAG_WRITE)) {
> +				up_read(&mm->mmap_sem);
> +				return -EFAULT;
> +			}
> +			goto retry;
> +		}

Every line below the first 'if' is indented one tab stop too far.

Ben.

>  	new = old = pgste_get_lock(ptep);
>  	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |

-- 
Ben Hutchings
No political challenge can be met by shopping. - George Monbiot
