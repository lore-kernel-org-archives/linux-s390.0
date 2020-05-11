Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:36664 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgEKSyk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 May 2020 14:54:40 -0400
Subject: Re: [PATCH V3 2/3] mm/hugetlb: Define a generic fallback for
 is_hugepage_only_range()
References: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
 <1588907271-11920-3-git-send-email-anshuman.khandual@arm.com>
 <9fc622e1-45ff-b79f-ebe0-35614837456c@oracle.com>
 <c21ab871-da06-baf6-ba31-80b13402b8c9@arm.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ab931b52-1f1b-1ff3-47ee-377de3ed1a98@oracle.com>
Date: Mon, 11 May 2020 11:52:34 -0700
MIME-Version: 1.0
In-Reply-To: <c21ab871-da06-baf6-ba31-80b13402b8c9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 5/10/20 8:14 PM, Anshuman Khandual wrote:
> On 05/09/2020 03:52 AM, Mike Kravetz wrote:
>> On 5/7/20 8:07 PM, Anshuman Khandual wrote:
>>
>> Did you try building without CONFIG_HUGETLB_PAGE defined?  I'm guessing
> 
> Yes I did for multiple platforms (s390, arm64, ia64, x86, powerpc etc).
> 
>> that you need a stub for is_hugepage_only_range().  Or, perhaps add this
>> to asm-generic/hugetlb.h?
>>
> There is already a stub (include/linux/hugetlb.h) when !CONFIG_HUGETLB_PAGE.
> 

Thanks!  I missed that stub in the existing code.  I like the removal of
redundant code.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
