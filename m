Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgDXCfa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 22:35:30 -0400
Date: Thu, 23 Apr 2020 22:35:21 -0400
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
Message-ID: <20200424023521.GA22117@redhat.com>
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <20200422164037.7edd21ea@thinkpad>
 <20200422172126.743908f5@thinkpad>
 <20200422194605.n77t2wtx5fomxpyd@treble>
 <20200423141834.234ed0bc@thinkpad>
 <alpine.LSU.2.21.2004231513250.6520@pobox.suse.cz>
 <20200423141228.sjvnxwdqlzoyqdwg@treble>
 <20200423181030.b5mircvgc7zmqacr@treble>
 <20200423232657.7minzcsysnhp474w@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423232657.7minzcsysnhp474w@treble>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>

On Thu, Apr 23, 2020 at 06:26:57PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 23, 2020 at 01:10:30PM -0500, Josh Poimboeuf wrote:
> > Mystery solved:
> > 
> >   $ CROSS_COMPILE=s390x-linux-gnu- scripts/faddr2line vmlinux apply_rela+0x16a/0x520
> >   apply_rela+0x16a/0x520:
> >   apply_rela at arch/s390/kernel/module.c:336
> > 
> > which corresponds to the following code in apply_rela():
> > 
> > 
> > 	case R_390_PLTOFF64:	/* 16 bit offset from GOT to PLT. */
> > 		if (info->plt_initialized == 0) {
> > 			unsigned int *ip;
> > 			ip = me->core_layout.base + me->arch.plt_offset +
> > 				info->plt_offset;
> > 			ip[0] = 0x0d10e310;	/* basr 1,0  */
> > 			ip[1] = 0x100a0004;	/* lg	1,10(1) */
> > 
> > 
> > Notice how it's writing directly to text... oops.
> 
> Here's a fix, using write() for the PLT and the GOT.
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

Would it be too paranoid to declare:

  			const unsigned int *ip = me->core_layout.base + 
						 me->arch.plt_offset +
  						 info->plt_offset;

That would trip an assignment to read-only error if someone were tempted
to write directly through the pointer in the future.  Ditto for Elf_Addr
*gotent pointer in the R_390_GOTPLTENT case.

-- Joe
