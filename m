From: Thomas Huth <thuth@redhat.com>
Date: Tue, 18 Dec 2018 10:17:48 +0000
Subject: Re: [kvm-unit-tests PATCH v3 05/13] s390x: Add BSS clearing for non ELF boot
Message-Id: <6fec14e5-e557-20c4-207d-d9f0bbe97343@redhat.com>
In-Reply-To: <e8bc39e5-a170-af47-3c4a-1186b7039bec@redhat.com>
References: <e8bc39e5-a170-af47-3c4a-1186b7039bec@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2018-12-18 10:26, Janosch Frank wrote:
> When doing an IPL normal the memory will not be zeroed and hence the
> BSS section can have any value. We need to clear it by ourselves.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 21 ++++++++++++++++++++-
>  s390x/flat.lds   |  2 ++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 7886f35..aba11f4 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -37,6 +37,22 @@ start:
>  	/* setup initial PSW mask + control registers*/
>  	larl	%r1, initial_psw
>  	lpswe	0(%r1)
> +init_clear_bss:
> +	larl 	%r2, __bss_start
> +	larl 	%r3, __bss_end
> +	slgr 	%r3, %r2		# Get sizeof bss
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

Looks similar to the kernel's memset function, so I think this is fine.

Reviewed-by: Thomas Huth <thuth@redhat.com>
