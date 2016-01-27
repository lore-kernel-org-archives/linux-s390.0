From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] mm: provide debug_pagealloc_enabled() without
 CONFIG_DEBUG_PAGEALLOC
Date: Wed, 27 Jan 2016 10:15:35 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601271015220.3886@nanos>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com> <1453884618-33852-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1453884618-33852-2-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Jan 2016, Christian Borntraeger wrote:

> We can provide debug_pagealloc_enabled() also if CONFIG_DEBUG_PAGEALLOC
> is not set. It will return false in that case.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
