Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEF7Y (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Aug 2020 01:59:24 -0400
Date: Wed, 5 Aug 2020 08:59:09 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/17] x86/setup: simplify initrd relocation and
 reservation
Message-ID: <20200805055909.GD8243@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
 <20200802163601.8189-14-rppt@kernel.org>
 <20200805042024.GT10792@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805042024.GT10792@MiWiFi-R3L-srv>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Emil Renner Berthing <kernel@esmil.dk>, Ingo Molnar <mingo@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org

On Wed, Aug 05, 2020 at 12:20:24PM +0800, Baoquan He wrote:
> On 08/02/20 at 07:35pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Currently, initrd image is reserved very early during setup and then it
> > might be relocated and re-reserved after the initial physical memory
> > mapping is created. The "late" reservation of memblock verifies that mapped
> > memory size exceeds the size of initrd, the checks whether the relocation
>                                           ~ then?

Right, thanks!

> > required and, if yes, relocates inirtd to a new memory allocated from
> > memblock and frees the old location.
