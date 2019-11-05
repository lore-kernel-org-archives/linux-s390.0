Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390839AbfKETgy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 14:36:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA5JXiUY060924
        for <linux-s390@vger.kernel.org>; Tue, 5 Nov 2019 14:36:54 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3dqsky6q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2019 14:36:53 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 5 Nov 2019 19:36:50 -0000
Date: Tue, 5 Nov 2019 20:36:38 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH V8] mm/debug: Add tests validating architecture page
 table helpers
In-Reply-To: <1572240562-23630-1-git-send-email-anshuman.khandual@arm.com>
References: <1572240562-23630-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191105203638.6889a994@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Christophe Leroy <christophe.leroy@c-s.fr>, Ingo Molnar <mingo@kernel.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 10:59:22 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> This adds tests which will validate architecture page table helpers and
> other accessors in their compliance with expected generic MM semantics.
> This will help various architectures in validating changes to existing
> page table helpers or addition of new ones.
> 
> This test covers basic page table entry transformations including but not
> limited to old, young, dirty, clean, write, write protect etc at various
> level along with populating intermediate entries with next page table page
> and validating them.
> 
> Test page table pages are allocated from system memory with required size
> and alignments. The mapped pfns at page table levels are derived from a
> real pfn representing a valid kernel text symbol. This test gets called
> right after page_alloc_init_late().
> 
> This gets build and run when CONFIG_DEBUG_VM_PGTABLE is selected along with
> CONFIG_VM_DEBUG. Architectures willing to subscribe this test also need to
> select CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE which for now is limited to x86 and
> arm64. Going forward, other architectures too can enable this after fixing
> build or runtime problems (if any) with their page table helpers.

I've prepared a couple of commits to our arch code to make this work on s390,
they will go upstream in the next merge window. After that, we can add s390
to the supported architectures.

We had some issues, e.g. because we do not report large entries as bad in
pxd_bad(), do not check for folded page tables in pxd_free(), or assume
that primitives like pmd_mkdirty() will only be called after pmd_mkhuge().
None of those should have any impact on current code, but your test module
revealed that we do not behave like other architectures in some aspects,
and it's good to find and fix such things to prevent possible future issues.

Thanks a lot for the effort!

Regards,
Gerald
