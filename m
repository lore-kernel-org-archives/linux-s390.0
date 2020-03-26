Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29133 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZXK7 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Mar 2020 19:10:59 -0400
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
 <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
 <1c8b16c7-248e-b75f-96c6-eabc953c5066@intel.com>
 <530e6e11-ad1a-55bc-e61e-9da6eb7fea21@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <ae80063f-cef8-3141-3c6b-9130def5396a@intel.com>
Date: Thu, 26 Mar 2020 16:10:56 -0700
MIME-Version: 1.0
In-Reply-To: <530e6e11-ad1a-55bc-e61e-9da6eb7fea21@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, "Shutemov, Kirill" <kirill.shutemov@intel.com>

On 3/26/20 2:56 PM, Mike Kravetz wrote:
> Perhaps it would be best to check hugepages_supported() when parsing
> hugetlb command line options.  If not enabled, throw an error.  This
> will be much easier to do after moving all command line parsing to
> arch independent code.

Yeah, that sounds sane.

> Is that a sufficient way to address this concern?  I think it is a good
> change in any case.

(Thanks to Kirill for pointing this out.)

So, it turns out the x86 huge page enumeration is totally buggered.
X86_FEATURE_PSE is actually meaningless on 64-bit (and 32-bit PAE).  All
CPUs architecturally support 2MB pages regardless of X86_FEATURE_PSE and
the state of CR4.PSE.

So, on x86_64 at least, hugepages_supported() should *always* return 1.

1GB page support can continue to be dependent on X86_FEATURE_GBPAGES.
