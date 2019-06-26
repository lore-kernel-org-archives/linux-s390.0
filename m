Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH RESEND 6/8] parisc: Use mmap_base, not mmap_legacy_base,
 as low_limit for bottom-up mmap
References: <20190620050328.8942-1-alex@ghiti.fr>
 <20190620050328.8942-7-alex@ghiti.fr>
 <438124ff-6838-7ced-044c-ca57a6b9cc91@gmx.de>
Message-ID: <7fb32983-3444-0747-4e5f-812d1b4d84c2@ghiti.fr>
Date: Wed, 26 Jun 2019 01:20:51 -0400
MIME-Version: 1.0
In-Reply-To: <438124ff-6838-7ced-044c-ca57a6b9cc91@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <james.bottomley@hansenpartnership.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

On 6/25/19 10:09 AM, Helge Deller wrote:
> On 20.06.19 07:03, Alexandre Ghiti wrote:
>> Bottom-up mmap scheme is used twice:
>>
>> - for legacy mode, in which mmap_legacy_base and mmap_base are equal.
>>
>> - in case of mmap failure in top-down mode, where there is no need to go
>> through the whole address space again for the bottom-up fallback: the goal
>> of this fallback is to find, as a last resort, space between the top-down
>> mmap base and the stack, which is the only place not covered by the
>> top-down mmap.
>>
>> Then this commit removes the usage of mmap_legacy_base field from parisc
>> code.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Boot-tested on parisc and seems to work nicely, thus:
>
> Acked-by: Helge Deller <deller@gmx.de>

Thanks Helge,

Alex

>
> Helge
>
>
>
>> ---
>>   arch/parisc/kernel/sys_parisc.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
>> index 5d458a44b09c..e987f3a8eb0b 100644
>> --- a/arch/parisc/kernel/sys_parisc.c
>> +++ b/arch/parisc/kernel/sys_parisc.c
>> @@ -119,7 +119,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>>
>>   	info.flags = 0;
>>   	info.length = len;
>> -	info.low_limit = mm->mmap_legacy_base;
>> +	info.low_limit = mm->mmap_base;
>>   	info.high_limit = mmap_upper_limit(NULL);
>>   	info.align_mask = last_mmap ? (PAGE_MASK & (SHM_COLOUR - 1)) : 0;
>>   	info.align_offset = shared_align_offset(last_mmap, pgoff);
>> @@ -240,13 +240,11 @@ static unsigned long mmap_legacy_base(void)
>>    */
>>   void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>>   {
>> -	mm->mmap_legacy_base = mmap_legacy_base();
>> -	mm->mmap_base = mmap_upper_limit(rlim_stack);
>> -
>>   	if (mmap_is_legacy()) {
>> -		mm->mmap_base = mm->mmap_legacy_base;
>> +		mm->mmap_base = mmap_legacy_base();
>>   		mm->get_unmapped_area = arch_get_unmapped_area;
>>   	} else {
>> +		mm->mmap_base = mmap_upper_limit(rlim_stack);
>>   		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>>   	}
>>   }
>>
