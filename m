From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 11:30:20 +0000
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Add prefixes for dxc afp emulator test
Message-Id: <af0dbae2-4d35-20ae-32a2-9ef4982b9047@redhat.com>
In-Reply-To: <20190228083539.146516-4-frankja@linux.ibm.com>
References: <20190228083539.146516-4-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 28/02/2019 09.35, Janosch Frank wrote:
> Without it we have two reports that look the same, but don't have the
> same control register state for the test.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/emulator.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/emulator.c b/s390x/emulator.c
> index f49c414..bce7b79 100644
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
> @@ -273,12 +274,13 @@ static void test_dxc(void)
>  
>  	report("dxc in LC", lc->dxc_vxc == 0xff);
>  	report("dxc in FPC", get_fpc_dxc() == 0xff);
> -
> +	report_prefix_pop();
>  
>  	/* DXC (0xff) is to be stored in LC only on a trap (CRT) without AFP */
>  	lc->dxc_vxc = 0x12345678;
>  	set_fpc_dxc(0);
>  
> +	report_prefix_push("no-afp");
>  	expect_pgm_int();
>  	/* temporarily disable AFP */
>  	afp_disable();
> @@ -289,6 +291,7 @@ static void test_dxc(void)
>  
>  	report("dxc in LC", lc->dxc_vxc == 0xff);
>  	report("dxc not in FPC", get_fpc_dxc() == 0);
> +	report_prefix_pop();
>  }
>  
>  static struct {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
