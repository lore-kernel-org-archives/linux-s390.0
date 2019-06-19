Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39059 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSFyh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Jun 2019 01:54:37 -0400
From: Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH RESEND 1/8] s390: Start fallback of top-down mmap at
 mm->mmap_base
References: <20190619054224.5983-1-alex@ghiti.fr>
 <20190619054224.5983-2-alex@ghiti.fr>
Message-ID: <4fcd8c83-dc33-12ab-3ba2-85a8d851674d@ghiti.fr>
Date: Wed, 19 Jun 2019 01:54:20 -0400
MIME-Version: 1.0
In-Reply-To: <20190619054224.5983-2-alex@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: "James E . J . Bottomley" <james.bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

Really sorry about that, my connection is weird this morning, I'll retry 
tomorrow.

Sorry again,

Alex

On 6/19/19 1:42 AM, Alexandre Ghiti wrote:
> In case of mmap failure in top-down mode, there is no need to go through
> the whole address space again for the bottom-up fallback: the goal of this
> fallback is to find, as a last resort, space between the top-down mmap base
> and the stack, which is the only place not covered by the top-down mmap.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/s390/mm/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index cbc718ba6d78..4a222969843b 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -166,7 +166,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>   	if (addr & ~PAGE_MASK) {
>   		VM_BUG_ON(addr != -ENOMEM);
>   		info.flags = 0;
> -		info.low_limit = TASK_UNMAPPED_BASE;
> +		info.low_limit = mm->mmap_base;
>   		info.high_limit = TASK_SIZE;
>   		addr = vm_unmapped_area(&info);
>   		if (addr & ~PAGE_MASK)
