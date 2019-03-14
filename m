Return-Path: <SRS0=dG1z=RR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
In-Reply-To: <20190307132015.26970-5-alex@ghiti.fr>
References: <20190307132015.26970-1-alex@ghiti.fr>
 <20190307132015.26970-5-alex@ghiti.fr>
Date: Thu, 14 Mar 2019 13:53:21 +1100
Message-ID: <87va0m9nfi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S .
 Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter
 Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

[ Cc += Aneesh ]

Alexandre Ghiti <alex@ghiti.fr> writes:
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 5b0177733994..d04a0bcc2f1c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -32,13 +32,6 @@ static inline int hstate_get_psize(struct hstate *hstate)
>  	}
>  }
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static inline bool gigantic_page_supported(void)
> -{
> -	return true;
> -}
> -#endif

This is going to clash with:

  https://patchwork.ozlabs.org/patch/1047003/

Which does:

@@ -35,6 +35,13 @@  static inline int hstate_get_psize(struct hstate *hstate)
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static inline bool gigantic_page_supported(void)
 {
+	/*
+	 * We used gigantic page reservation with hypervisor assist in some case.
+	 * We cannot use runtime allocation of gigantic pages in those platforms
+	 * This is hash translation mode LPARs.
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
+		return false;
 	return true;
 }
 #endif


Not sure how to resolve it.

cheers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
