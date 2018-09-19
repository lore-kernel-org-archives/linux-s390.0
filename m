From: Thomas Huth <thuth@redhat.com>
Date: Wed, 19 Sep 2018 12:09:22 +0000
Subject: Re: [kvm-unit-tests PATCH] s390x: Add prefixes to pgm interrupt checks
Message-Id: <33414dc8-3e85-6b2b-cd90-b74546d76a86@redhat.com>
In-Reply-To: <20180919094856.191590-1-frankja@linux.ibm.com>
References: <20180919094856.191590-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 2018-09-19 11:48, Janosch Frank wrote:
> We need the information about which of the checks failed if there are
> more than one and the prefixes provide that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cmm.c    |  4 ++++
>  s390x/diag10.c | 23 +++++++++++++++++++++++
>  s390x/gs.c     |  8 ++++++++
>  s390x/iep.c    |  2 ++
>  s390x/pfmf.c   |  2 ++
>  s390x/skey.c   |  7 +++++++
>  6 files changed, 46 insertions(+)
> 
> diff --git a/s390x/cmm.c b/s390x/cmm.c
> index 42dfda2..fe4d9df 100644
> --- a/s390x/cmm.c
> +++ b/s390x/cmm.c
> @@ -29,17 +29,21 @@ static unsigned long essa(uint8_t state, unsigned long paddr)
>  
>  static void test_params(void)
>  {
> +	report_prefix_push("invalid ORC 8");
>  	expect_pgm_int();
>  	essa(8, (unsigned long)pagebuf);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
>  }
>  
>  static void test_priv(void)
>  {
> +	report_prefix_push("privileged");
>  	expect_pgm_int();
>  	enter_pstate();
>  	essa(0, (unsigned long)pagebuf);
>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
>  }
>  
>  /* Unfortunately the availability is not indicated by stfl bits, but
> diff --git a/s390x/diag10.c b/s390x/diag10.c
> index 806ebc6..7ee8945 100644
> --- a/s390x/diag10.c
> +++ b/s390x/diag10.c
> @@ -32,43 +32,66 @@ static inline void diag10(unsigned long start, unsigned long end)
>  /* Try freeing the prefix */
>  static void test_prefix(void)
>  {
> +	report_prefix_push("lowcore freeing");
> +
> +	report_prefix_push("0x0000/0x0000");
>  	expect_pgm_int();
>  	diag10(0, 0);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
>  
> +
> +	report_prefix_push("0x1000/0x1000");
>  	expect_pgm_int();
>  	diag10(0x1000, 0x1000);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
>  
> +	report_prefix_push("0x0000/0x1000");
>  	expect_pgm_int();
>  	diag10(0, 0x1000);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
>  }
>  
>  static void test_params(void)
>  {
> +	report_prefix_push("start/end");
> +
>  	/* end < start */
> +	report_prefix_push("end < start");
>  	expect_pgm_int();
>  	diag10(page1, page0);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
>  
>  	/* Unaligned start */
> +	report_prefix_push("unaligned start");
>  	expect_pgm_int();
>  	diag10((unsigned long) pagebuf + 42, page1);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
>  
>  	/* Unaligned end */
> +	report_prefix_push("unaligned end");
>  	expect_pgm_int();
>  	diag10(page0, (unsigned long) pagebuf + PAGE_SIZE + 42);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
>  }
>  
>  static void test_priv(void)
>  {
> +	report_prefix_push("privileged");
>  	expect_pgm_int();
>  	enter_pstate();
>  	diag10(page0, page0);
>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
>  }
>  
>  int main(void)
> diff --git a/s390x/gs.c b/s390x/gs.c
> index bddc2b4..26f22e8 100644
> --- a/s390x/gs.c
> +++ b/s390x/gs.c
> @@ -128,12 +128,20 @@ static void test_load(void)
>  /* Test gs instructions without enablement resulting in an exception */
>  static void test_special(void)
>  {
> +	report_prefix_push("disabled gs");
> +	report_prefix_push("load gs");
>  	expect_pgm_int();
>  	load_gs_cb(&gs_cb);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +
> +	report_prefix_push("store gs");
>  	expect_pgm_int();
>  	store_gs_cb(&gs_cb);
>  	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
>  }
>  
>  static void init(void)
> diff --git a/s390x/iep.c b/s390x/iep.c
> index 8c1ea8f..9f98b09 100644
> --- a/s390x/iep.c
> +++ b/s390x/iep.c
> @@ -38,7 +38,9 @@ static void test_iep(void)
>  	expect_pgm_int();
>  	/* Jump into protected page */
>  	fn();
> +	report_prefix_push("iep protection");
>  	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	report_prefix_pop();
>  	unprotect_page(iepbuf, PAGE_ENTRY_IEP);
>  	ctl_clear_bit(0, 20);

Don't you want to put the report_prefix_push before the expect_pgm_int
here, too, as you do it in the other spots?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
