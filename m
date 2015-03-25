From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/2] powerpc/mm: Tracking vDSO remap
Date: Wed, 25 Mar 2015 19:33:16 +0100
Message-ID: <20150325183316.GA9090@gmail.com>
References: <20150325121118.GA2542@gmail.com>
 <cover.1427289960.git.ldufour@linux.vnet.ibm.com>
 <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6ce07f8e1e0d654371aee70bd8eac310456d0df.1427289960.git.ldufour@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org, cov@codeaurora.org, criu@openvz.org
List-ID: <linux-s390.vger.kernel.org>


* Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> +static inline void arch_unmap(struct mm_struct *mm,
> +			struct vm_area_struct *vma,
> +			unsigned long start, unsigned long end)
> +{
> +	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
> +		mm->context.vdso_base = 0;
> +}

So AFAICS PowerPC can have multi-page vDSOs, right?

So what happens if I munmap() the middle or end of the vDSO? The above 
condition only seems to cover unmaps that affect the first page. I 
think 'affects any page' ought to be the right condition? (But I know 
nothing about PowerPC so I might be wrong.)


> +#define __HAVE_ARCH_REMAP
> +static inline void arch_remap(struct mm_struct *mm,
> +			      unsigned long old_start, unsigned long old_end,
> +			      unsigned long new_start, unsigned long new_end)
> +{
> +	/*
> +	 * mremap() doesn't allow moving multiple vmas so we can limit the
> +	 * check to old_start == vdso_base.
> +	 */
> +	if (old_start == mm->context.vdso_base)
> +		mm->context.vdso_base = new_start;
> +}

mremap() doesn't allow moving multiple vmas, but it allows the 
movement of multi-page vmas and it also allows partial mremap()s, 
where it will split up a vma.

In particular, what happens if an mremap() is done with 
old_start == vdso_base, but a shorter end than the end of the vDSO? 
(i.e. a partial mremap() with fewer pages than the vDSO size)

Thanks,

	Ingo
