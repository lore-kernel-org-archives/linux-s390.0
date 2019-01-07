From: David Hildenbrand <david@redhat.com>
Date: Mon, 07 Jan 2019 11:37:48 +0000
Subject: Re: [kvm-unit-tests PATCH v4 03/13] s390x: Make tests bootable from disk
Message-Id: <dd040aa2-d4ec-1bf5-3c39-7d96cc3cdb6e@redhat.com>
In-Reply-To: <20190103100806.9039-4-frankja@linux.ibm.com>
References: <20190103100806.9039-4-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03.01.19 11:07, Janosch Frank wrote:
> Currently tests are run with the --kernel option of Qemu, which will
> load the ELF file and jump to the start address. When booting from
> disk, we need to specify a start address. This is done by setting the
> initial short PSW at 0x0.
> 
> .text was moved to 0x11000 because the bootloader can write from
> 0x10480 until 0x11000 if it has a lot to write. 0x10480 to 0x10600 was
> not enough safe space.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  s390x/cstart64.S |  9 ++++++++-
>  s390x/flat.lds   | 13 ++++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index dc7ddd6..d382497 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -14,9 +14,16 @@
>  
>  .section .init
>  
> -/* entry point - for KVM + TCG we directly start in 64 bit mode */
> +/*
> + * Short init between 0x10000 and 0x10480 and then jump to 0x11000.
> + * 0x10480 - 0x11000 are written to by bootloader.
> + *
> + * For KVM and TCG kernel boot we are in 64 bit z/Arch mode.
> + * When booting from disk the initial short psw is in 31 bit mode.
> + */
>  	.globl start
>  start:
> +	sam64				# Set addressing mode to 64 bit
>  	/* setup stack */
>  	larl	%r15, stackptr
>  	/* setup initial PSW mask + control registers*/
> diff --git a/s390x/flat.lds b/s390x/flat.lds
> index b6e2172..977af7c 100644
> --- a/s390x/flat.lds
> +++ b/s390x/flat.lds
> @@ -1,10 +1,21 @@
>  SECTIONS
>  {
> +	/*
> +	 * Initial short psw for disk boot, with 31 bit addressing for
> +	 * non z/Arch environment compatibility and the instruction
> +	 * address 0x10000 (cstart64.S .init).
> +	 */
> +	.lowcore : {
> +		. = 0;
> +		 LONG(0x00080000)
> +		 LONG(0x80010000)
> +	}
> +	. = 0x10000;
>  	.text : {
>  		*(.init)
>  		. = 0x480;
>  		ipl_args = .;
> -		. = 0x600;
> +		.  = 0x1000;
>  		*(.text)
>  		*(.text.*)
>  	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
