Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 27 Apr 2018 19:36:19 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [RFC PATCH 0/9] Enable THP migration for all possible
 architectures
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180427193619.435eb53a@thinkpad>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Zi Yan <zi.yan@sent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Zi Yan <zi.yan@cs.rutgers.edu>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steve Capper <steve.capper@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Apr 2018 10:27:55 -0400
Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> Hi all,
> 
> THP migration is only enabled on x86_64 with a special
> ARCH_ENABLE_THP_MIGRATION macro. This patchset enables THP migration for
> all architectures that uses transparent hugepage, so that special macro can
> be dropped. Instead, THP migration is enabled/disabled via
> /sys/kernel/mm/transparent_hugepage/enable_thp_migration.
> 
> I grepped for TRANSPARENT_HUGEPAGE in arch folder and got 9 architectures that
> are supporting transparent hugepage. I mechanically add __pmd_to_swp_entry() and
> __swp_entry_to_pmd() based on existing __pte_to_swp_entry() and
> __swp_entry_to_pte() for all these architectures, except tile which is going to
> be dropped.

This will not work on s390, the pmd layout is very different from the pte
layout. Using __swp_entry/type/offset() on a pmd will go horribly wrong.
I currently don't see a chance to make this work for us, so please make/keep
this configurable, and do not configure it for s390.

Regards,
Gerald
