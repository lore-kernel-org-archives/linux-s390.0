From: David Hildenbrand <david@redhat.com>
Date: Fri, 07 Dec 2018 16:12:35 +0000
Subject: Re: [kvm-unit-tests PATCH v2 3/6] s390x: Switch to z/Arch if needed
Message-Id: <269ca0d7-8fd1-936e-bcf0-e0d85330fd63@redhat.com>
In-Reply-To: <20181205153918.29480-4-frankja@linux.ibm.com>
References: <20181205153918.29480-4-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05.12.18 16:39, Janosch Frank wrote:
> LPAR and z/VM start in esam mode depending on the hardware, so we need
> to switch to z/Arch and set 64 bit addressing.
> 
> Under Qemu/KVM we already start out with both when being run with the
> Qemu --kernel argument or we lack 64 bit when booting from disk
> because of the initial psw specifying 31 bit for z/VM and lpar
> compatibility.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index d382497..7886f35 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -20,9 +20,17 @@
>   *
>   * For KVM and TCG kernel boot we are in 64 bit z/Arch mode.
>   * When booting from disk the initial short psw is in 31 bit mode.
> + * When running under LPAR or z/VM, we might start in 31 bit and esam mode.
>   */
>  	.globl start
>  start:
> +	/* Switch to z/Architecture mode and 64-bit */
> +	slr     %r0, %r0		# Set cpuid to zero
> +	lhi     %r1, 2			# mode 2 = esame
> +	sigp    %r1, %r0, 0x12		# sigp set arch
> +	bras	%r13,0f			# Jump over zero area
> +	.fill	16,4,0x0		# Zero area for lmh
> +0:	lmh	%r0,%r15,0(%r13)	# Clear high-order half of gprs
>  	sam64				# Set addressing mode to 64 bit
>  	/* setup stack */
>  	larl	%r15, stackptr
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
