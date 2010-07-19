From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jul 2010 22:12:33 +0000
Subject: Re: [PATCH] math-emu: correct test for downshifting fraction in
Message-Id: <20100719.151233.215575238.davem@davemloft.net>
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
> 
> 1. Compute the exponent from the number of leading zero bits.
> 2. Downshift large fractions to put the MSB in the right position
>    for normalized fractions.
> 3. Upshift small fractions to put the MSB in the right position.
> 
> There is an boundary error in step 2, causing a fraction with its
> MSB exactly one bit above the normalized MSB position to not be
> downshifted.  This results in a non-normalized raw float, which when
> packed becomes a massively inaccurate representation for that input.
> 
> The impact of this depends on a number of arch-specific factors,
> but it is known to have broken emulation of FXTOD instructions
> on UltraSPARC III, which was originally reported as GCC bug 44631
> <http://gcc.gnu.org/bugzilla/show_bug.cgi?idD631>.
> 
> Any arch which uses math-emu to emulate conversions from integers to
> same-size floats may be affected.
> 
> The fix is simple: the exponent comparison used to determine if the
> fraction should be downshifted must be "<=" not "<".
> 
> I'm sending a kernel module to test this as a reply to this message.
> There are also SPARC user-space test cases in the GCC bug entry.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Thanks for fixing this Mikael:

Acked-by: David S. Miller <davem@davemloft.net>

Has anyone done an audit to compare the copy of math-emu in glibc, gcc,
and the linux kernel so that we don't have bugs living in some places
but not others?

These sources really need to be consolidated somehow.
