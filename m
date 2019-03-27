Return-Path: <SRS0=MWzg=R6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
References: <20190327063626.18421-1-alex@ghiti.fr>
 <20190327063626.18421-5-alex@ghiti.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 27 Mar 2019 12:31:10 +0530
MIME-Version: 1.0
In-Reply-To: <20190327063626.18421-5-alex@ghiti.fr>
Content-Language: en-US
Message-Id: <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>, mpe@ellerman.id.au, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index ec2a55a553c7..7013284f0f1b 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -36,8 +36,8 @@ static inline int hstate_get_psize(struct hstate *hstate)
>   	}
>   }
>   
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static inline bool gigantic_page_supported(void)
> +#define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
> +static inline bool gigantic_page_runtime_supported(void)
>   {
>   	/*
>   	 * We used gigantic page reservation with hypervisor assist in some case.
> @@ -49,7 +49,6 @@ static inline bool gigantic_page_supported(void)
>   
>   	return true;
>   }
> -#endif
>   
>   /* hugepd entry valid bit */
>   #define HUGEPD_VAL_BITS		(0x8000000000000000UL)

Is that correct when CONTIG_ALLOC is not enabled? I guess we want

gigantic_page_runtime_supported to return false when CONTIG_ALLOC is not 
enabled on all architectures and on POWER when it is enabled we want it 
to be conditional as it is now.

-aneesh


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
