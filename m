Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A01DE2DC;
	Thu, 26 Jun 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936844; cv=none; b=GhwZaooK4TRUjw9wqiP+eyV8OXoMzjH1/u73gEgMfjBjOOFR713/Sk51miYYaitdAfdtdr7xpfsYOcdp2+exjfWAWkMswBHmyFRIc8aLmGD1EajMOJTHEkuVjQu9ifAwd84DLmuoWnapt8FvwAjB4L9B3/qj47VDSOL5mFifm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936844; c=relaxed/simple;
	bh=C4f7VtU2IxWUn/+6CtPz+hcR/TxIpvkTdAdow77mhkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsF4wNNwOQGUwacVgxHLQQp7h1K/+1JYCjckRW50m6ornAh2O7621y0tgIbkV9wNob4zD/N9epX5eSZt/K48R1/TG1OohxGu/JU6I1LnazCiiRDu/PweEzC2VzOw+ZZx+fuphXBJD5rfz6/tpOdl9jVLLWYIizFR1yIb739M3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bSbB02K49z9vGJ;
	Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDQegORpF3hS; Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bSbB017ZFz9vGH;
	Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B36F8B7B7;
	Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1FFBuvr_5nqx; Thu, 26 Jun 2025 12:52:39 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F3C38B7A7;
	Thu, 26 Jun 2025 12:52:37 +0200 (CEST)
Message-ID: <3b6ff3a9-6b88-4a28-a0fd-31f31ae3e84b@csgroup.eu>
Date: Thu, 26 Jun 2025 12:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] kasan/powerpc: call kasan_init_generic in kasan_init
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org,
 tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 kevin.brodsky@arm.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250625095224.118679-1-snovitoll@gmail.com>
 <20250625095224.118679-10-snovitoll@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250625095224.118679-10-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/06/2025 à 11:52, Sabyrzhan Tasbolatov a écrit :
> Call kasan_init_generic() which enables the static flag
> to mark generic KASAN initialized, otherwise it's an inline stub.
> Also prints the banner from the single place.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
> Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>   arch/powerpc/include/asm/kasan.h       | 14 --------------
>   arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
>   2 files changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index b5bbb94c51f..23a06fbec72 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -52,20 +52,6 @@
>   
>   #endif
>   
> -#ifdef CONFIG_KASAN

The above #ifdef must remain, at the moment I get:

   CC      arch/powerpc/kernel/asm-offsets.s
In file included from ./arch/powerpc/include/asm/nohash/32/pgtable.h:65,
                  from ./arch/powerpc/include/asm/nohash/pgtable.h:13,
                  from ./arch/powerpc/include/asm/pgtable.h:20,
                  from ./include/linux/pgtable.h:6,
                  from ./arch/powerpc/include/asm/kup.h:43,
                  from ./arch/powerpc/include/asm/uaccess.h:8,
                  from ./include/linux/uaccess.h:12,
                  from ./include/linux/sched/task.h:13,
                  from ./include/linux/sched/signal.h:9,
                  from ./include/linux/rcuwait.h:6,
                  from ./include/linux/percpu-rwsem.h:7,
                  from ./include/linux/fs.h:34,
                  from ./include/linux/compat.h:17,
                  from arch/powerpc/kernel/asm-offsets.c:12:
./arch/powerpc/include/asm/kasan.h:70:2: error: #endif without #if
  #endif
   ^~~~~
In file included from ./include/linux/kasan.h:21,
                  from ./include/linux/slab.h:260,
                  from ./include/linux/fs.h:46,
                  from ./include/linux/compat.h:17,
                  from arch/powerpc/kernel/asm-offsets.c:12:
./arch/powerpc/include/asm/kasan.h:70:2: error: #endif without #if
  #endif
   ^~~~~
make[2]: *** [scripts/Makefile.build:182: 
arch/powerpc/kernel/asm-offsets.s] Error 1


> -#ifdef CONFIG_PPC_BOOK3S_64
> -DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
> -static __always_inline bool kasan_arch_is_ready(void)
> -{
> -	if (static_branch_likely(&powerpc_kasan_enabled_key))
> -		return true;
> -	return false;
> -}
> -
> -#define kasan_arch_is_ready kasan_arch_is_ready
> -#endif
> -
>   void kasan_early_init(void);
>   void kasan_mmu_init(void);
>   void kasan_init(void);
> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
> index 7d959544c07..dcafa641804 100644
> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> @@ -19,8 +19,6 @@
>   #include <linux/memblock.h>
>   #include <asm/pgalloc.h>
>   
> -DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
>   static void __init kasan_init_phys_region(void *start, void *end)
>   {
>   	unsigned long k_start, k_end, k_cur;
> @@ -92,11 +90,9 @@ void __init kasan_init(void)
>   	 */
>   	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>   
> -	static_branch_inc(&powerpc_kasan_enabled_key);
> -
>   	/* Enable error messages */
>   	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>   }
>   
>   void __init kasan_early_init(void) { }

