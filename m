From: David Hildenbrand <david@redhat.com>
Date: Mon, 04 Feb 2019 10:57:45 +0000
Subject: Re: [kvm-unit-tests PATCH] s390x: Only look at relevant skey bits
Message-Id: <14a40cfb-e15a-08ec-f172-b54ee26fb02b@redhat.com>
In-Reply-To: <20190204105045.11286-1-frankja@linux.ibm.com>
References: <20190204105045.11286-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 04.02.19 11:50, Janosch Frank wrote:
> Reference and change indication should not be consulted when checking
> for ACC and FP values of storage keys.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> Automated testing with the debug kernel seems to result in the
> referenced bit being 1 when the key is read after setting it. This
> makes the tests trip, as I compare the wrong bits (referenced and
> changed are allowed to change in-between).
> 
> ---
>  lib/s390x/asm/mem.h |  5 +++++
>  s390x/pfmf.c        |  6 +++++-
>  s390x/skey.c        | 10 ++++++----
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/s390x/asm/mem.h b/lib/s390x/asm/mem.h
> index 909e6d4..75bd778 100644
> --- a/lib/s390x/asm/mem.h
> +++ b/lib/s390x/asm/mem.h
> @@ -10,6 +10,11 @@
>  #ifndef _ASM_S390_MEM_H
>  #define _ASM_S390_MEM_H
>  
> +#define SKEY_ACC	0xf0
> +#define SKEY_FP		0x08
> +#define SKEY_RF		0x04
> +#define SKEY_CH		0x02
> +
>  union skey {
>  	struct {
>  		uint8_t acc : 4;
> diff --git a/s390x/pfmf.c b/s390x/pfmf.c
> index 5e61267..4cc6bd1 100644
> --- a/s390x/pfmf.c
> +++ b/s390x/pfmf.c
> @@ -70,6 +70,7 @@ static void test_4k_key(void)
>  	r1.reg.key = 0x30;
>  	pfmf(r1.val, (unsigned long) pagebuf);
>  	skey.val = get_storage_key((unsigned long) pagebuf);
> +	skey.val &= SKEY_ACC | SKEY_FP;
>  	report("set 4k", skey.val == 0x30);
>  }
>  
> @@ -77,6 +78,7 @@ static void test_1m_key(void)
>  {
>  	int i;
>  	union r1 r1;
> +	union skey skey;
>  
>  	r1.val = 0;
>  	r1.reg.sk = 1;
> @@ -84,7 +86,9 @@ static void test_1m_key(void)
>  	r1.reg.key = 0x30;
>  	pfmf(r1.val, (unsigned long) pagebuf);
>  	for (i = 0; i < 256; i++) {
> -		if (get_storage_key((unsigned long) pagebuf + i * PAGE_SIZE) != 0x30) {
> +		skey.val = get_storage_key((unsigned long) pagebuf + i * PAGE_SIZE);
> +		skey.val &= SKEY_ACC | SKEY_FP;
> +		if (skey.val != 0x30) {
>  			report("set 1M", false);
>  			return;
>  		}
> diff --git a/s390x/skey.c b/s390x/skey.c
> index 1949533..bb230d0 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -35,9 +35,10 @@ static void test_set_mb(void)
>  	while (addr < end)
>  		addr = set_storage_key_mb(addr, skey.val);
>  
> -	ret1.val = get_storage_key(end - PAGE_SIZE);
> -	ret2.val = get_storage_key(end - PAGE_SIZE * 2);
> -	report("multi block", ret1.val == ret2.val && ret1.val == skey.val);
> +	ret1.val = get_storage_key(end - PAGE_SIZE) & (SKEY_ACC | SKEY_FP);
> +	ret2.val = get_storage_key(end - PAGE_SIZE * 2) & (SKEY_ACC | SKEY_FP);
> +	report("multi block",
> +	       ret1.val == ret2.val && ret1.val == skey.val);
>  }
>  
>  static void test_chg(void)
> @@ -60,7 +61,8 @@ static void test_set(void)
>  	ret.val = get_storage_key(page0);
>  	set_storage_key(page0, skey.val, 0);
>  	ret.val = get_storage_key(page0);
> -	report("set key test", skey.val == ret.val);
> +	report("set key test",
> +	       skey.str.acc == ret.str.acc && skey.str.fp == ret.str.fp);
>  }
>  
>  static void test_priv(void)
> 

Care to add a comment somewhere (one instance) why this is done?

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
