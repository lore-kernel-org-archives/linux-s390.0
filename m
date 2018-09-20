From: David Hildenbrand <david@redhat.com>
Date: Thu, 20 Sep 2018 14:06:03 +0000
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Add prefixes to pgm interrupt checks
Message-Id: <990b9217-a832-4f39-1c83-4a8e00aeac88@redhat.com>
In-Reply-To: <20180919131414.6192-1-frankja@linux.ibm.com>
References: <20180919131414.6192-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 19/09/2018 15:14, Janosch Frank wrote:
> We need the information about which of the checks failed if there are
> more than one and the prefixes provide that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> 
> Moved prefix_push to expect_pgm_int() in iep.c
> 
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
> index 8c1ea8f..7da78a3 100644
> --- a/s390x/iep.c
> +++ b/s390x/iep.c
> @@ -35,10 +35,12 @@ static void test_iep(void)
>  	*code = 0x07fe;
>  	fn = (void *)code;
>  
> +	report_prefix_push("iep protection");
>  	expect_pgm_int();
>  	/* Jump into protected page */
>  	fn();
>  	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	report_prefix_pop();
>  	unprotect_page(iepbuf, PAGE_ENTRY_IEP);
>  	ctl_clear_bit(0, 20);
>  }
> diff --git a/s390x/pfmf.c b/s390x/pfmf.c
> index 2268fd0..5e61267 100644
> --- a/s390x/pfmf.c
> +++ b/s390x/pfmf.c
> @@ -51,10 +51,12 @@ static inline unsigned long pfmf(unsigned long r1, unsigned long paddr)
>  
>  static void test_priv(void)
>  {
> +	report_prefix_push("privileged");
>  	expect_pgm_int();
>  	enter_pstate();
>  	pfmf(0, (unsigned long) pagebuf);
>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
>  }
>  
>  static void test_4k_key(void)
> diff --git a/s390x/skey.c b/s390x/skey.c
> index e4c2a43..1949533 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -68,18 +68,25 @@ static void test_priv(void)
>  	union skey skey;
>  
>  	memset(pagebuf, 0, PAGE_SIZE * 2);
> +	report_prefix_push("privileged");
> +	report_prefix_push("sske");
>  	expect_pgm_int();
>  	enter_pstate();
>  	set_storage_key(page0, 0x30, 0);
>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
>  
>  	skey.val = get_storage_key(page0);
>  	report("skey did not change on exception", skey.str.acc != 3);
>  
> +	report_prefix_push("iske");
>  	expect_pgm_int();
>  	enter_pstate();
>  	get_storage_key(page0);
>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
> +
> +	report_prefix_pop();
>  }
>  
>  int main(void)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
