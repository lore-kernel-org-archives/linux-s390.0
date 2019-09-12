Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:33338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfILMJT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 08:09:19 -0400
Subject: Re: [PATCH V2 2/2] mm/pgtable/debug: Add test validating architecture
 page table helpers
References: <1568268173-31302-1-git-send-email-anshuman.khandual@arm.com>
 <1568268173-31302-3-git-send-email-anshuman.khandual@arm.com>
 <20190912110016.srrydg2krplscbgq@box>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0116e7b7-cee5-c821-cc54-f4e397c774b2@arm.com>
Date: Thu, 12 Sep 2019 17:39:13 +0530
MIME-Version: 1.0
In-Reply-To: <20190912110016.srrydg2krplscbgq@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org



On 09/12/2019 04:30 PM, Kirill A. Shutemov wrote:
> On Thu, Sep 12, 2019 at 11:32:53AM +0530, Anshuman Khandual wrote:
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Anshuman Khandual <anshuman.khandual@arm.com>");
>> +MODULE_DESCRIPTION("Test architecture page table helpers");
> 
> It's not module. Why?

Not any more. Nothing in particular. Just that module_init() code gets
executed after page allocator init which is needed here. But I guess
probably not a great way to get this test started.

> 
> BTW, I think we should make all code here __init (or it's variants) so it
> can be discarded on boot. It has not use after that.

Sounds good, will change. Will mark all these functions as __init and
will trigger the test with late_initcall().
