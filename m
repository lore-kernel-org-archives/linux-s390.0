Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 21 May 2015 14:27:39 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH trivial] s390/mm: s/specifiation/specification/, s/an
 specification/a specification/
Message-ID: <20150521122739.GC4079@osiris>
References: <1432209647-20668-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432209647-20668-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Jiri Kosina <trivial@kernel.org>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 21, 2015 at 02:00:47PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/s390/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index fc642399b489d896..9a04717f5d0cf40f 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1565,9 +1565,9 @@ static inline int has_transparent_hugepage(void)
>  /*
>   * 64 bit swap entry format:
>   * A page-table entry has some bits we have to treat in a special way.
> - * Bits 52 and bit 55 have to be zero, otherwise an specification
> + * Bits 52 and bit 55 have to be zero, otherwise a specification
>   * exception will occur instead of a page translation exception. The
> - * specifiation exception has the bad habit not to store necessary
> + * specification exception has the bad habit not to store necessary

Applied, thanks.
