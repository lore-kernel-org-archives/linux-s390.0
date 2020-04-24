Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbgDXHUm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 03:20:42 -0400
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <20200422164037.7edd21ea@thinkpad> <20200422172126.743908f5@thinkpad>
 <20200422194605.n77t2wtx5fomxpyd@treble> <20200423141834.234ed0bc@thinkpad>
 <alpine.LSU.2.21.2004231513250.6520@pobox.suse.cz>
 <20200423141228.sjvnxwdqlzoyqdwg@treble>
 <20200423181030.b5mircvgc7zmqacr@treble>
 <20200423232657.7minzcsysnhp474w@treble>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <eb464a0b-922b-1dbd-81e6-1161a5157acb@de.ibm.com>
Date: Fri, 24 Apr 2020 09:20:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200423232657.7minzcsysnhp474w@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>, Joe Lawrence <joe.lawrence@redhat.com>


On 24.04.20 01:26, Josh Poimboeuf wrote:
> On Thu, Apr 23, 2020 at 01:10:30PM -0500, Josh Poimboeuf wrote:
>> On Thu, Apr 23, 2020 at 09:12:28AM -0500, Josh Poimboeuf wrote:
>>>>> this is strange. While I would have expected an exception similar to
>>>>> this, it really should have happened on the "sturg" instruction which
>>>>> does the DAT-off store in s390_kernel_write(), and certainly not with
>>>>> an ID of 0004 (protection). However, in your case, it happens on a
>>>>> normal store instruction, with 0004 indicating a protection exception.
>>>>>
>>>>> This is more like what I would expect e.g. in the case where you do
>>>>> _not_ use the s390_kernel_write() function for RO module text patching,
>>>>> but rather normal memory access. So I am pretty sure that this is not
>>>>> related to the s390_kernel_write(), but some other issue, maybe some
>>>>> place left where you still use normal memory access?
>>>>
>>>> The call trace above also suggests that it is not a late relocation, no? 
>>>> The path is from KLP module init function through klp_enable_patch. It should 
>>>> mean that the to-be-patched object is loaded (it must be a module thanks 
>>>> to a check klp_init_object_loaded(), vmlinux relocations were processed 
>>>> earlier in apply_relocations()).
>>>>
>>>> However, the KLP module state here must be COMING, so s390_kernel_write() 
>>>> should be used. What are we missing?
>>>
>>> I'm also scratching my head.  It _should_ be using s390_kernel_write()
>>> based on the module state, but I don't see that on the stack trace.
>>>
>>> This trace (and Gerald's comment) seem to imply it's using
>>> __builtin_memcpy(), which might expected for UNFORMED state.
>>>
>>> Weird...
>>
>> Mystery solved:
>>
>>   $ CROSS_COMPILE=s390x-linux-gnu- scripts/faddr2line vmlinux apply_rela+0x16a/0x520
>>   apply_rela+0x16a/0x520:
>>   apply_rela at arch/s390/kernel/module.c:336
>>
>> which corresponds to the following code in apply_rela():
>>
>>
>> 	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
>> 		if (info->plt_initialized == 0) {
>> 			unsigned int *ip;
>> 			ip = me->core_layout.base + me->arch.plt_offset +
>> 				info->plt_offset;
>> 			ip[0] = 0x0d10e310;	/* basr 1,0  */
>> 			ip[1] = 0x100a0004;	/* lg	1,10(1) */
>>
>>
>> Notice how it's writing directly to text... oops.
> 
> Here's a fix, using write() for the PLT and the GOT.

Are you going to provide a proper patch?

> 
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index 2798329ebb74..fe446f42818f 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -297,7 +297,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
>  
>  			gotent = me->core_layout.base + me->arch.got_offset +
>  				info->got_offset;
> -			*gotent = val;
> +			write(gotent, &val, sizeof(*gotent));
>  			info->got_initialized = 1;
>  		}
>  		val = info->got_offset + rela->r_addend;
> @@ -330,25 +330,29 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base, Elf_Sym *symtab,
>  	case R_390_PLTOFF32:	/* 32 bit offset from GOT to PLT. */
>  	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
>  		if (info->plt_initialized == 0) {
> -			unsigned int *ip;
> +			unsigned int *ip, insn[5];
> +
>  			ip = me->core_layout.base + me->arch.plt_offset +
>  				info->plt_offset;
> -			ip[0] = 0x0d10e310;	/* basr 1,0  */
> -			ip[1] = 0x100a0004;	/* lg	1,10(1) */
> +
> +			insn[0] = 0x0d10e310;	/* basr 1,0  */
> +			insn[1] = 0x100a0004;	/* lg	1,10(1) */
>  			if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable) {
>  				unsigned int *ij;
>  				ij = me->core_layout.base +
>  					me->arch.plt_offset +
>  					me->arch.plt_size - PLT_ENTRY_SIZE;
> -				ip[2] = 0xa7f40000 +	/* j __jump_r1 */
> +				insn[2] = 0xa7f40000 +	/* j __jump_r1 */
>  					(unsigned int)(u16)
>  					(((unsigned long) ij - 8 -
>  					  (unsigned long) ip) / 2);
>  			} else {
> -				ip[2] = 0x07f10000;	/* br %r1 */
> +				insn[2] = 0x07f10000;	/* br %r1 */
>  			}
> -			ip[3] = (unsigned int) (val >> 32);
> -			ip[4] = (unsigned int) val;
> +			insn[3] = (unsigned int) (val >> 32);
> +			insn[4] = (unsigned int) val;
> +
> +			write(ip, insn, sizeof(insn));
>  			info->plt_initialized = 1;
>  		}
>  		if (r_type == R_390_PLTOFF16 ||
> 
