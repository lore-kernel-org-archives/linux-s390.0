From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/2] powerpc/mm: Tracking vDSO remap
Date: Fri, 27 Mar 2015 12:02:13 +0100
Message-ID: <551538B5.2030507@linux.vnet.ibm.com>
References: <20150326141730.GA23060@gmail.com> <cover.1427390952.git.ldufour@linux.vnet.ibm.com> <7fdae652993cf88bdd633d65e5a8f81c7ad8a1e3.1427390952.git.ldufour@linux.vnet.ibm.com> <20150326185550.GA25547@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20150326185550.GA25547@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org, cov@codeaurora.org, criu@openvz.org
List-ID: <linux-s390.vger.kernel.org>

On 26/03/2015 19:55, Ingo Molnar wrote:
> 
> * Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>> +{
>> +	unsigned long vdso_end, vdso_start;
>> +
>> +	if (!mm->context.vdso_base)
>> +		return;
>> +	vdso_start = mm->context.vdso_base;
>> +
>> +#ifdef CONFIG_PPC64
>> +	/* Calling is_32bit_task() implies that we are dealing with the
>> +	 * current process memory. If there is a call path where mm is not
>> +	 * owned by the current task, then we'll have need to store the
>> +	 * vDSO size in the mm->context.
>> +	 */
>> +	BUG_ON(current->mm != mm);
>> +	if (is_32bit_task())
>> +		vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
>> +	else
>> +		vdso_end = vdso_start + (vdso64_pages << PAGE_SHIFT);
>> +#else
>> +	vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
>> +#endif
>> +	vdso_end += (1<<PAGE_SHIFT); /* data page */
>> +
>> +	/* Check if the vDSO is in the range of the remapped area */
>> +	if ((vdso_start <= old_start && old_start < vdso_end) ||
>> +	    (vdso_start < old_end && old_end <= vdso_end)  ||
>> +	    (old_start <= vdso_start && vdso_start < old_end)) {
>> +		/* Update vdso_base if the vDSO is entirely moved. */
>> +		if (old_start == vdso_start && old_end == vdso_end &&
>> +		    (old_end - old_start) == (new_end - new_start))
>> +			mm->context.vdso_base = new_start;
>> +		else
>> +			mm->context.vdso_base = 0;
>> +	}
>> +}
> 
> Oh my, that really looks awfully complex, as you predicted, and right 
> in every mremap() call.

I do agree, that's awfully complex ;)

> I'm fine with your original, imperfect, KISS approach. Sorry about 
> this detour ...
>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

No problem, so let's stay on the v3 version of the patch.
Thanks for Reviewed-by statement which, I guess, applied to the v3 too.
Should I resend the v3 ?

Thanks,
Laurent.
