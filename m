Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:24041 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRXg5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Mar 2020 19:36:57 -0400
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
 <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1c8b16c7-248e-b75f-96c6-eabc953c5066@intel.com>
Date: Wed, 18 Mar 2020 16:36:56 -0700
MIME-Version: 1.0
In-Reply-To: <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Andrew Morton <akpm@linux-foundation.org>

On 3/18/20 3:52 PM, Mike Kravetz wrote:
> Sounds good.  I'll incorporate those changes into a v2, unless someone
> else with has a different opinion.
> 
> BTW, this patch should not really change the way the code works today.
> It is mostly a movement of code.  Unless I am missing something, the
> existing code will always allow setup of PMD_SIZE hugetlb pages.

Hah, I totally skipped over the old code in the diff.

It looks like we'll disable hugetblfs *entirely* if PSE isn't supported.
 I think this is actually wrong, but nobody ever noticed.  I think you'd
have to be running as a guest under a hypervisor that's lying about PSE
not being supported *and* care about 1GB pages.  Nobody does that.
