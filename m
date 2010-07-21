From: David Miller <davem@davemloft.net>
Date: Wed, 21 Jul 2010 01:45:48 +0000
Subject: Re: [PATCH] math-emu: correct test for downshifting fraction in
Message-Id: <20100720.184548.250802682.davem@davemloft.net>
References: <19524.51858.992299.119315@pilspetsen.it.uu.se>
In-Reply-To: <19524.51858.992299.119315@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: mikpe@it.uu.se
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 19 Jul 2010 23:58:42 +0200

> The kernel's math-emu code contains a macro _FP_FROM_INT() which is
> used to convert an integer to a raw normalized floating-point value.
> It does this basically in three steps:
 ...
> The fix is simple: the exponent comparison used to determine if the
> fraction should be downshifted must be "<=" not "<".
> 
> I'm sending a kernel module to test this as a reply to this message.
> There are also SPARC user-space test cases in the GCC bug entry.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied and I'll make sure this gets into -stable too.

Thanks!
