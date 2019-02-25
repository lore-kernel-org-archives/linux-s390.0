From: Thomas Huth <thuth@redhat.com>
Date: Mon, 25 Feb 2019 12:42:44 +0000
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Add prefix for dxc afp emulator test
Message-Id: <b8402382-b3a8-131e-764d-b3fcefab6749@redhat.com>
In-Reply-To: <20190219084913.198737-4-frankja@linux.ibm.com>
References: <20190219084913.198737-4-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 19/02/2019 09.49, Janosch Frank wrote:
> Without it we have two reports that look the same, but don't have the
> same control register state for the test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/emulator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/emulator.c b/s390x/emulator.c
> index f49c414..4c26b80 100644
> --- a/s390x/emulator.c
> +++ b/s390x/emulator.c
> @@ -266,6 +266,7 @@ static void test_dxc(void)
>  	lc->dxc_vxc = 0x12345678;
>  	set_fpc_dxc(0);
>  
> +	report_prefix_push("afp");
>  	expect_pgm_int();
>  	asm volatile("	.insn	rrf,0xb9600000,%0,%0,8,0\n"
>  		     : : "r"(0) : "memory");
> @@ -273,7 +274,7 @@ static void test_dxc(void)
>  
>  	report("dxc in LC", lc->dxc_vxc == 0xff);
>  	report("dxc in FPC", get_fpc_dxc() == 0xff);
> -
> +	report_prefix_pop();
>  
>  	/* DXC (0xff) is to be stored in LC only on a trap (CRT) without AFP */
>  	lc->dxc_vxc = 0x12345678;

Maybe add a prefix a la "no-afp" for the second test, too?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
