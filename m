Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Wed, 27 Feb 2019 18:40:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v3 18/34] s390: mm: Add p?d_large() definitions
In-Reply-To: <20190227170608.27963-19-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-19-steven.price@arm.com>
MIME-Version: 1.0
Message-Id: <20190227184012.2e251154@mschwideX1>
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
To: Steven Price <steven.price@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Feb 2019 17:05:52 +0000
Steven Price <steven.price@arm.com> wrote:

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For s390, we don't support large pages, so add a stub returning 0.

Well s390 does support 1MB and 2GB large pages, pmd_large() and pud_large()
are non-empty. We do not support 4TB or 8PB large pages though, which
makes the patch itself correct. Just the wording is slightly off.
 
> CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/s390/include/asm/pgtable.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 063732414dfb..9617f1fb69b4 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -605,6 +605,11 @@ static inline int pgd_present(pgd_t pgd)
>  	return (pgd_val(pgd) & _REGION_ENTRY_ORIGIN) != 0UL;
>  }
> 
> +static inline int pgd_large(pgd_t pgd)
> +{
> +	return 0;
> +}
> +
>  static inline int pgd_none(pgd_t pgd)
>  {
>  	if (pgd_folded(pgd))
> @@ -645,6 +650,11 @@ static inline int p4d_present(p4d_t p4d)
>  	return (p4d_val(p4d) & _REGION_ENTRY_ORIGIN) != 0UL;
>  }
> 
> +static inline int p4d_large(p4d_t p4d)
> +{
> +	return 0;
> +}
> +
>  static inline int p4d_none(p4d_t p4d)
>  {
>  	if (p4d_folded(p4d))


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
