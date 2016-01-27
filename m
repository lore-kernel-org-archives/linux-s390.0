From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Date: Wed, 27 Jan 2016 14:18:29 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1601271418190.23510@chino.kir.corp.google.com>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com> <1453889401-43496-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1453889401-43496-4-git-send-email-borntraeger@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 1MB/2GB pages as well as to print
> the current setting in dump_stack.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
