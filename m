Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727080AbfIIQvz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Sep 2019 12:51:55 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89GpsVo161083
        for <linux-s390@vger.kernel.org>; Mon, 9 Sep 2019 12:51:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uv86v5anr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Sep 2019 12:51:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Mon, 9 Sep 2019 17:51:35 +0100
Date: Mon, 9 Sep 2019 18:51:21 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 1/1] mm/pgtable/debug: Add test validating architecture
 page table helpers
In-Reply-To: <3d5de35f-8192-1c75-50a9-03e66e3b8e5c@arm.com>
References: <1567497706-8649-1-git-send-email-anshuman.khandual@arm.com>
        <1567497706-8649-2-git-send-email-anshuman.khandual@arm.com>
        <20190904221618.1b624a98@thinkpad>
        <20e3044d-2af5-b27b-7653-cec53bdec941@arm.com>
        <20190905190629.523bdb87@thinkpad>
        <3c609e33-afbb-ffaf-481a-6d225a06d1d0@arm.com>
        <20190906210346.5ecbff01@thinkpad>
        <3d5de35f-8192-1c75-50a9-03e66e3b8e5c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190909185121.6271e9be@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 11:56:50 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

[..]
> > 
> > Hmm, I simply used this on my system to make pud_clear_tests() work, not
> > sure if it works on all archs:
> > 
> > pud_val(*pudp) |= RANDOM_NZVALUE;  
> 
> Which compiles on arm64 but then fails on x86 because of the way pmd_val()
> has been defined there. on arm64 and s390 (with many others) pmd_val() is
> a macro which still got the variable that can be used as lvalue but that is
> not true for some other platforms like x86.
> 
> arch/arm64/include/asm/pgtable-types.h:	#define pmd_val(x)	((x).pmd)
> arch/s390/include/asm/page.h:		#define pmd_val(x)	((x).pmd)
> arch/x86/include/asm/pgtable.h:		#define pmd_val(x)       native_pmd_val(x)
> 
> static inline pmdval_t native_pmd_val(pmd_t pmd)
> {
>         return pmd.pmd;
> }
> 
> Unless I am mistaken, the return value from this function can not be used as
> lvalue for future assignments.
> 
> mm/arch_pgtable_test.c: In function ‘pud_clear_tests’:
> mm/arch_pgtable_test.c:156:17: error: lvalue required as left operand of assignment
>   pud_val(*pudp) |= RANDOM_ORVALUE;
>                  ^~
> AFAICS pxx_val() were never intended to be used as lvalue and using it that way
> might just happen to work on all those platforms which define them as macros.
> They meant to just provide values for an entry as being determined by the platform.
> 
> In principle pxx_val() on an entry was not supposed to be modified directly from
> generic code without going through (again) platform helpers for any specific state
> change (write, old, dirty, special, huge etc). The current use case is a deviation
> for that.
> 
> I originally went with memset() just to load up the entries with non-zero value so
> that we know pxx_clear() are really doing the clearing. The same is being followed
> for all pxx_same() checks.
> 
> Another way for fixing the problem would be to mark them with known attributes
> like write/young/huge etc instead which for sure will create non-zero entries.
> We can do that for pxx_clear() and pxx_same() tests and drop RANDOM_NZVALUE
> completely. Does that sound good ?

Umm, not really. Those mkwrite/young/huge etc. helpers do only exist for
page table levels where we can also have large mappings, at least on s390.
Also, we do (on s390) again check for certain sanity before actually setting
the bits.
Good news is that at least for the pxx_same() checks the memset() is no
problem, because pxx_same() does not do any checks other than the same check.

For the pxx_clear_tests(), maybe it could be an option to put them behind the
pxx_populate_tests(), and rely on them having properly populated (non-clear)
values after that?

[...]
> > 
> > Actually, using get_unmapped_area() as suggested by Kirill could also
> > solve this issue. We do create a new mm with 3-level page tables on s390,
> > and the dynamic upgrade to 4 or 5 levels is then triggered exactly by
> > arch_get_unmapped_area(), depending on the addr. But I currently don't
> > see how / where arch_get_unmapped_area() is set up for such a dummy mm
> > created by mm_alloc().  
> 
> Normally they are set during program loading but we can set it up explicitly
> for the test mm_struct if we need to but there are some other challenges.
> 
> load_[aout|elf|flat|..]_binary()
> 	setup_new_exec()
> 		arch_pick_mmap_layout().
> 
> I did some initial experiments around get_unmapped_area(). Seems bit tricky
> to get it working on a pure 'test' mm_struct. It expects a real user context
> in the form of current->mm.

Yes, that's where I stopped because it looked rather complicated :-)
Not sure why Kirill suggested it initially, but if using get_unmapped_area()
would only be necessary to get properly initialized page table levels
on s390, you could also defer this to a later add-on patch.

Regards,
Gerald
