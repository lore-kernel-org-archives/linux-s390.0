Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 4 Dec 2015 22:49:33 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/2] mm: bring in additional flag for fixup_user_fault to
 signal unlock
Message-ID: <20151204214933.GE29105@redhat.com>
References: <1448558822-41358-1-git-send-email-dingel@linux.vnet.ibm.com>
 <1448558822-41358-2-git-send-email-dingel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448558822-41358-2-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Eric B Munson <emunson@akamai.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mel Gorman <mgorman@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Nov 26, 2015 at 06:27:01PM +0100, Dominik Dingel wrote:
> @@ -599,6 +603,10 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  	if (!(vm_flags & vma->vm_flags))
>  		return -EFAULT;
>  
> +	if (unlocked)
> +		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
> +
> +retry:

This should move up before find_extend_vma, otherwise the vma used
below could be a dangling pointer after the "goto retry".

>  	ret = handle_mm_fault(mm, vma, address, fault_flags);
>  	if (ret & VM_FAULT_ERROR) {
>  		if (ret & VM_FAULT_OOM)
> @@ -609,12 +617,21 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  			return -EFAULT;
>  		BUG();
>  	}
> -	if (tsk) {
> +	if (tsk && !(fault_flags & FAULT_FLAG_TRIED)) {
>  		if (ret & VM_FAULT_MAJOR)
>  			tsk->maj_flt++;
>  		else
>  			tsk->min_flt++;
>  	}

It'd look cleaner if we'd move the tsk update after the retry check in
case the FAULT_FLAG_TRIED second attempt actually fails, to avoid
recording a fault for a non-really-faulting VM_FAULT_RETRY
attempt. This is what the real page fault does at least so it sounds
cleaner do the same here, but then in practice it makes very little
difference.

> +	if (ret & VM_FAULT_RETRY) {
> +		down_read(&mm->mmap_sem);
> +		if (!(fault_flags & FAULT_FLAG_TRIED)) {
> +			*unlocked = true;
> +			fault_flags &= ~FAULT_FLAG_ALLOW_RETRY;
> +			fault_flags |= FAULT_FLAG_TRIED;
> +			goto retry;
> +		}
> +	}
>  	return 0;
>  }

Rest looks great.

The futex.c should be patched to pass the unlocked pointer in a later
patch but we can also postpone it to a different patchset.

Thanks,
Andrea

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
