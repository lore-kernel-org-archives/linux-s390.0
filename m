Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgDTTpf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 15:45:35 -0400
Date: Mon, 20 Apr 2020 20:45:26 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/4] Clean up hugetlb boot command line processing
Message-ID: <20200420194525.GA28523@willie-the-truck>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <5E312000-05D8-4C5D-A7C0-DDDE1842CB0E@lca.pw>
 <4c36c6ce-3774-78fa-abc4-b7346bf24348@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c36c6ce-3774-78fa-abc4-b7346bf24348@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Qian Cai <cai@lca.pw>, Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Randy Dunlap <rdunlap@infradead.org>, Mina Almasry <almasrymina@google.com>, Peter Xu <peterx@redhat.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 20, 2020 at 11:20:23AM -0700, Mike Kravetz wrote:
> On 4/20/20 8:34 AM, Qian Cai wrote:
> > 
> > 
> >> On Apr 17, 2020, at 2:50 PM, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> Longpeng(Mike) reported a weird message from hugetlb command line processing
> >> and proposed a solution [1].  While the proposed patch does address the
> >> specific issue, there are other related issues in command line processing.
> >> As hugetlbfs evolved, updates to command line processing have been made to
> >> meet immediate needs and not necessarily in a coordinated manner.  The result
> >> is that some processing is done in arch specific code, some is done in arch
> >> independent code and coordination is problematic.  Semantics can vary between
> >> architectures.
> >>
> >> The patch series does the following:
> >> - Define arch specific arch_hugetlb_valid_size routine used to validate
> >>  passed huge page sizes.
> >> - Move hugepagesz= command line parsing out of arch specific code and into
> >>  an arch independent routine.
> >> - Clean up command line processing to follow desired semantics and
> >>  document those semantics.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20200305033014.1152-1-longpeng2@huawei.com
> >>
> >> Mike Kravetz (4):
> >>  hugetlbfs: add arch_hugetlb_valid_size
> >>  hugetlbfs: move hugepagesz= parsing to arch independent code
> >>  hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
> >>  hugetlbfs: clean up command line processing
> > 
> > Reverted this series fixed many undefined behaviors on arm64 with the config,
> > 
> > https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> > 
> > [   54.172683][    T1] UBSAN: shift-out-of-bounds in ./include/linux/hugetlb.h:555:34
> > [   54.180411][    T1] shift exponent 4294967285 is too large for 64-bit type 'unsigned long'
> > [   54.188885][    T1] CPU: 130 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc2-next-20200420 #1
> > [   54.197284][    T1] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> > [   54.207888][    T1] Call trace:
> > [   54.211100][    T1]  dump_backtrace+0x0/0x224
> > [   54.215565][    T1]  show_stack+0x20/0x2c
> > [   54.219651][    T1]  dump_stack+0xfc/0x184
> > [   54.223829][    T1]  __ubsan_handle_shift_out_of_bounds+0x304/0x344
> > [   54.230204][    T1]  hugetlb_add_hstate+0x3ec/0x414
> > huge_page_size at include/linux/hugetlb.h:555
> > (inlined by) hugetlb_add_hstate at mm/hugetlb.c:3301
> > [   54.235191][    T1]  hugetlbpage_init+0x14/0x30
> > [   54.239824][    T1]  do_one_initcall+0x6c/0x144
> > [   54.244446][    T1]  do_initcall_level+0x158/0x1c4
> > [   54.249336][    T1]  do_initcalls+0x68/0xb0
> > [   54.253597][    T1]  do_basic_setup+0x28/0x30
> > [   54.258049][    T1]  kernel_init_freeable+0x19c/0x228
> > [   54.263188][    T1]  kernel_init+0x14/0x208
> > [   54.267473][    T1]  ret_from_fork+0x10/0x18
> 
> While rearranging the code (patch 3 in series), I made the incorrect
> assumption that CONT_XXX_SIZE == (1UL << CONT_XXX_SHIFT).  However,
> this is not the case.  Does the following patch fix these issues?
> 
> From b75cb4a0852e208bee8c4eb347dc076fcaa88859 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 20 Apr 2020 10:41:18 -0700
> Subject: [PATCH] arm64/hugetlb: fix hugetlb initialization
> 
> When calling hugetlb_add_hstate() to initialize a new hugetlb size,
> be sure to use correct huge pages size order.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 9ca840527296..a02411a1f19a 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -453,11 +453,11 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  static int __init hugetlbpage_init(void)
>  {
>  #ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> +	hugetlb_add_hstate(ilog2(PUD_SIZE) - PAGE_SHIFT);
>  #endif
> -	hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT);
> -	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> -	hugetlb_add_hstate(CONT_PTE_SHIFT - PAGE_SHIFT);
> +	hugetlb_add_hstate(ilog2(CONT_PMD_SIZE) - PAGE_SHIFT);
> +	hugetlb_add_hstate(ilog2(PMD_SIZE) - PAGE_SHIFT);
> +	hugetlb_add_hstate(ilog2(CONT_PTE_SIZE) - PAGE_SHIFT);

Might be clearer to leave the non CONT_* definitions alone and instead
convert the CONT versions along the lines of:

	hugetlb_add_hstate(CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT);

(untested, but I think that's right...)

But that doesn't matter until Qian has confirmed that your patch fixes the
issue.

Will
