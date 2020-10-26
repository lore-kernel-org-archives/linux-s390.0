Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390998AbgJZJFo (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 05:05:44 -0400
Date: Mon, 26 Oct 2020 11:05:26 +0200
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
Message-ID: <20201026090526.GA1154158@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
List-ID: <linux-s390.vger.kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, "cl@linux.com" <cl@linux.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "will@kernel.org" <will@kernel.org>, "penberg@kernel.org" <penberg@kernel.org>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "kirill@shutemov.name" <kirill@shutemov.name>, "rientjes@google.com" <rientjes@google.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>, "paulus@samba.org" <paulus@samba.org>, "hca@linux.ibm.com" <hca@linux.ibm.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "luto@kernel.org" <luto@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>, "Brown, Len" <len.brown@intel.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>

On Mon, Oct 26, 2020 at 01:13:52AM +0000, Edgecombe, Rick P wrote:
> On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > Indeed, for architectures that define CONFIG_ARCH_HAS_SET_DIRECT_MAP
> > it is
> > possible that __kernel_map_pages() would fail, but since this
> > function is
> > void, the failure will go unnoticed.
> 
> Could you elaborate on how this could happen? Do you mean during
> runtime today or if something new was introduced?

A failure in__kernel_map_pages() may happen today. For instance, on x86
if the kernel is built with DEBUG_PAGEALLOC.

	__kernel_map_pages(page, 1, 0);

will need to split, say, 2M page and during the split an allocation of
page table could fail.

Currently, the only user of __kernel_map_pages() outside DEBUG_PAGEALLOC
is hibernation, but I think it would be safer to entirely prevent usage
of __kernel_map_pages() when DEBUG_PAGEALLOC=n.

-- 
Sincerely yours,
Mike.
