From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Date: Fri, 20 Feb 2015 02:52:57 +0000
Subject: Re: [PATCH RFC] Update kernel math-emu code from current glibc soft-fp
Message-Id: <20150220.115257.256613837.kkojima@rr.iij4u.or.jp>
References: <alpine.DEB.2.10.1502061719210.27832@digraph.polyomino.org.uk>
 <20150219.132122.204795202277130266.davem@davemloft.net>
 <alpine.DEB.2.10.1502191835490.22905@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.10.1502191835490.22905@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: joseph@codesourcery.com
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Joseph Myers <joseph@codesourcery.com> wrote:
> Please try this patch on top of the previous one.  The way abort is 
> redefined in the kernel code doesn't work for one place using it in an 
> expression; this patch changes a comma expression to a statement 
> expression.  This didn't appear in my powerpc testing because the powerpc 
> emulation never uses FP_FROM_INT; I'm not sure how Kaz's sh testing 
> avoided the problem appearing there.

My bad.  It turned out that I've configured the kernel wrongly and
CONFIG_SH_FPU_EMU isn't enabled.  With the proper configuration,
the build got the similar error with sparc64 during compiling
arch/sh/math.c and your patch for op-common.h fixes it.

Regards,
	kaz
