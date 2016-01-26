From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH/RFC 1/3] mm: provide debug_pagealloc_enabled() without
 CONFIG_DEBUG_PAGEALLOC
Date: Tue, 26 Jan 2016 15:23:26 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1601261521560.25141@chino.kir.corp.google.com>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com> <1453799905-10941-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1453799905-10941-2-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Jan 2016, Christian Borntraeger wrote:

> We can provide debug_pagealloc_enabled() also if CONFIG_DEBUG_PAGEALLOC
> is not set. It will return false in that case.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7783073..fbc5354 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2148,6 +2148,10 @@ kernel_map_pages(struct page *page, int numpages, int enable)
>  extern bool kernel_page_present(struct page *page);
>  #endif /* CONFIG_HIBERNATION */
>  #else
> +static inline bool debug_pagealloc_enabled(void)
> +{
> +	return false;
> +}
>  static inline void
>  kernel_map_pages(struct page *page, int numpages, int enable) {}
>  #ifdef CONFIG_HIBERNATION

Since the patchset needs to be refreshed based on Heiko and Thomas's 
comments, please add some /* CONFIG_DEBUG_PAGEALLOC */ annotation to the 
#else and #endif lines so this block is easier to read.  After that, feel 
free to add

	Acked-by: David Rientjes <rientjes@google.com>
