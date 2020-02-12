Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729029AbgBLR4G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Feb 2020 12:56:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CHnYWk153601
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 12:56:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3pqh2urr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 12 Feb 2020 12:56:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 12 Feb 2020 17:56:01 -0000
Date: Wed, 12 Feb 2020 18:55:48 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page
 table helpers
In-Reply-To: <b169ff9d-7b87-91f4-b3d0-e97f86680d0c@arm.com>
References: <1580174873-18117-1-git-send-email-anshuman.khandual@arm.com>
        <20200210153716.GB9283@E121110.arm.com>
        <b169ff9d-7b87-91f4-b3d0-e97f86680d0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200212185548.3274ec2e@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Christophe Leroy <christophe.leroy@c-s.fr>, Sri Krishna chowdary <schowdary@nvidia.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Wed, 12 Feb 2020 15:12:54 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> >> +/*
> >> + * On s390 platform, the lower 12 bits are used to identify given page table
> >> + * entry type and for other arch specific requirements. But these bits might
> >> + * affect the ability to clear entries with pxx_clear(). So while loading up
> >> + * the entries skip all lower 12 bits in order to accommodate s390 platform.
> >> + * It does not have affect any other platform.
> >> + */
> >> +#define RANDOM_ORVALUE	(0xfffffffffffff000UL)  
> > 
> > I'd suggest you generate this mask with something like
> > GENMASK(BITS_PER_LONG, PAGE_SHIFT).  
> 
> IIRC the lower 12 bits constrains on s390 platform might not be really related
> to it's PAGE_SHIFT which can be a variable, but instead just a constant number.
> But can definitely use GENMASK or it's variants here.
> 
> https://lkml.org/lkml/2019/9/5/862

PAGE_SHIFT would be fine, it is 12 on s390. However, in order to be
more precise, we do not really need all 12 bits, only the last 4 bits.
So, something like this would work:

#define RANDOM_ORVALUE GENMASK(BITS_PER_LONG - 1, 4)

The text in the comment could then also be changed from 12 to 4, and
be a bit more specific on the fact that the impact on pxx_clear()
results from the dynamic page table folding logic on s390:

/*
 * On s390 platform, the lower 4 bits are used to identify given page table
 * entry type. But these bits might affect the ability to clear entries with
 * pxx_clear() because of how dynamic page table folding works on s390. So
 * while loading up the entries do not change the lower 4 bits.
 * It does not have affect any other platform.
 */
