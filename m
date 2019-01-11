From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Jan 2019 09:02:56 +0000
Subject: Re: [kvm-unit-tests PATCH v5 03/11] s390x: Make tests bootable from disk
Message-Id: <39a186ed-e7f3-e33b-9cef-38ddc11ea424@redhat.com>
In-Reply-To: <20190110154151.24233-4-frankja@linux.ibm.com>
References: <20190110154151.24233-4-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-10 16:41, Janosch Frank wrote:
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
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  s390x/cstart64.S |  8 +++++++-
>  s390x/flat.lds   | 13 ++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index dc7ddd6..385915e 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -14,7 +14,13 @@
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
>  	/* setup stack */
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

In case you respin: I think we could/should remove the "-Ttext=0x10000"
from the s390x/Makefile now.

 Thomas
