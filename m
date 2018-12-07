From: David Hildenbrand <david@redhat.com>
Date: Fri, 07 Dec 2018 16:12:00 +0000
Subject: Re: [kvm-unit-tests PATCH v2 4/6] s390x: Add BSS clearing for non ELF boot
Message-Id: <ed423ad6-a2ea-f608-8abf-891e79997e38@redhat.com>
In-Reply-To: <20181205153918.29480-5-frankja@linux.ibm.com>
References: <20181205153918.29480-5-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05.12.18 16:39, Janosch Frank wrote:
> When doing an IPL normal the memory will not be zeroed and hence the
> BSS section can have any value. We need to clear it by ourselves.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 23 ++++++++++++++++++++++-
>  s390x/flat.lds   |  2 ++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 7886f35..0246e18 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -37,6 +37,24 @@ start:
>  	/* setup initial PSW mask + control registers*/
>  	larl	%r1, initial_psw
>  	lpswe	0(%r1)
> +init_clear_bss:
> +	larl 	%r2, __bss_start
> +	larl 	%r3, __bss_end
> +	slgr 	%r3, %r2		# Get sizeof bss
> +	ltgr 	%r3,%r3			# bss empty?> +	jz 	init_psw_cont		# Yes, jump to init_psw_cont

do we actually need these two instructions? If we should ever not have a
bss, things are already pretty shaky :D

(we could even enforce a BSS size > 0 in flat.lds)

> +	aghi 	%r3,-1
> +	srlg 	%r4,%r3,8		# Calc number of 256 byte chunks
> +	ltgr 	%r4,%r4
> +	lgr 	%r1,%r2
> +	jz	remainder		# If none, clear remaining bytes
> +loop:
> +	xc	0(256,%r1), 0(%r1)	# Clear 256 byte chunks via xor
> +	la	%r1, 256(%r1)
> +	brctg 	%r4, loop
> +remainder:
> +	larl	%r2, memsetxc
> +	ex 	%r3, 0(%r2)
>  init_psw_cont:
>  	/* setup pgm interrupt handler */
>  	larl	%r1, pgm_int_psw
> @@ -69,6 +87,9 @@ init_psw_cont:
>  	/* call exit() */
>  	j exit
>  
> +memsetxc:
> +	xc 0(1,%r1),0(%r1)
> +
>  	.macro SAVE_REGS
>  	/* save grs 0-15 */
>  	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
> @@ -157,7 +178,7 @@ svc_int:
>  
>  	.align	8
>  initial_psw:
> -	.quad	0x0000000180000000, init_psw_cont
> +	.quad	0x0000000180000000, init_clear_bss
>  pgm_int_psw:
>  	.quad	0x0000000180000000, pgm_int
>  ext_int_psw:
> diff --git a/s390x/flat.lds b/s390x/flat.lds
> index 7cfd9f9..fb229ce 100644
> --- a/s390x/flat.lds
> +++ b/s390x/flat.lds
> @@ -35,7 +35,9 @@ SECTIONS
>  	. = ALIGN(16);
>  	.rodata : { *(.rodata) *(.rodata.*) }
>  	. = ALIGN(16);
> +	__bss_start = .;
>  	.bss : { *(.bss) }
> +	__bss_end = .;
>  	. = ALIGN(64K);
>  	edata = .;
>  	. += 64K;
> 


-- 

Thanks,

David / dhildenb
