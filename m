From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] mm: export symbol dependencies of is_zero_pfn()
Date: Fri, 12 Sep 2014 23:19:27 +0200
Message-ID: <CAKv+Gu8=9tVmKtp5s_SyXF7mGjZ7r9x4iBYnyYfNpBogA9ShVg@mail.gmail.com>
References: <1410553043-575-1-git-send-email-ard.biesheuvel@linaro.org>
	<20140912141429.17d570d1a7e1cb99ec73f0f7@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140912141429.17d570d1a7e1cb99ec73f0f7@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, Christoffer Dall <christoffer.dall@linaro.org>, linux-mm@kvack.org, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, ralf@linux-mips.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 12 September 2014 23:14, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 12 Sep 2014 22:17:23 +0200 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> In order to make the static inline function is_zero_pfn() callable by
>> modules, export its symbol dependencies 'zero_pfn' and (for s390 and
>> mips) 'zero_page_mask'.
>
> So hexagon and score get the export if/when needed.
>

Exactly.

>> We need this for KVM, as CONFIG_KVM is a tristate for all supported
>> architectures except ARM and arm64, and testing a pfn whether it refers
>> to the zero page is required to correctly distinguish the zero page
>> from other special RAM ranges that may also have the PG_reserved bit
>> set, but need to be treated as MMIO memory.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/mips/mm/init.c | 1 +
>>  arch/s390/mm/init.c | 1 +
>>  mm/memory.c         | 2 ++
>
> Looks OK to me.  Please include the patch in whichever tree is is that
> needs it, and merge it up via that tree.
>

Thanks.

@Paolo: could you please take this (with Andrew's ack), and put it
before the patch you took earlier today?

Thanks,
Ard.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
