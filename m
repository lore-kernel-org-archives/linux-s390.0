From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 20 Jul 2010 07:34:59 +0000
Subject: Re: [PATCH] math-emu: correct test for downshifting fraction in
Message-Id: <20100720093459.10f0ea90@mschwide.boeblingen.de.ibm.com>
References: <19524.51858.992299.119315@pilspetsen.it.uu.se>
	<19524.52658.716540.932975@pilspetsen.it.uu.se>
In-Reply-To: <19524.52658.716540.932975@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 20 Jul 2010 00:12:02 +0200
Mikael Pettersson <mikpe@it.uu.se> wrote:

> Unfortunately it seems difficult to write a generic module
> which uses math-emu:
> - <math-emu/soft-fp.h> includes <asm/sfp-machine.h>,
>   but only a handful of archs have it
> - <asm/sfp-machine.h> isn't always self-contained and may depend
>   on various $arch-specific declarations being present
> 
> The given test module works on sparc64 and ppc64, where it uses
> the kernel's sfp-machine.h, and on x86 where it uses a stub
> sfp-machine.h supplied by itself.  I tried to cross-compile it
> for alpha, but that failed due to its sfp-machine.h not being
> self-contained.  I didn't try sh or s390.

It would be challange to try this on s390. The math emulation code is
only used for really old 31 bit machines. Starting with the G5 the fpu
can do IEEE754, I would say the math emulation code is irrelevant for
s390 by now.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
