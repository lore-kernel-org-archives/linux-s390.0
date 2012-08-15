From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] s390: Always use "long" for ssize_t to match size_t
Date: Wed, 15 Aug 2012 10:07:53 +0200
Message-ID: <20120815080752.GC3622@osiris.de.ibm.com>
References: <1344765694-7465-1-git-send-email-geert@linux-m68k.org>
 <1344765694-7465-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344765694-7465-2-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Aug 12, 2012 at 12:01:34PM +0200, Geert Uytterhoeven wrote:
> On s390x-linux-gcc, __SIZE_TYPE__ expands to "long unsigned int" for both
> 32-bit s390 and 64-bit s390x, as
> gcc-4.6.3-nolibc/s390x-linux/lib/gcc/s390x-linux/4.6.3/plugin/include/config/s390/linux.h
> has
> 
>     #define SIZE_TYPE (TARGET_64BIT ? "long unsigned int" : "long unsigned int")
> 
> To match this, __kernel_size_t is always set to "long unsigned int".
> 
> But while __kernel_ssize_t is "long" on 64-bit s390x, it is "int" on 32-bit
> s390, causing compiler warnings like:
> 
>     fs/quota/quota_tree.c:372:4: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'ssize_t' [-Wformat]
> 
> To fix this, __kernel_ssize_t should be "long", irrespective of word size.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied. Thanks Geert!
