Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 18 Nov 2009 19:41:56 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [-next Nov 17] s390 build
 break(arch/s390/kernel/compat_wrapper.S)
Message-ID: <20091118184156.GB3973@osiris.boeblingen.de.ibm.com>
References: <20091117195309.6cc3ead0.sfr@canb.auug.org.au>
 <4B0291BB.3090005@in.ibm.com>
 <20091117125201.GB5124@osiris.boeblingen.de.ibm.com>
 <1258465241.2876.29.camel@dhcp231-106.rdu.redhat.com>
 <20091117135525.GF5124@osiris.boeblingen.de.ibm.com>
 <1258471436.2876.34.camel@dhcp231-106.rdu.redhat.com>
 <20091118070418.GA4392@osiris.boeblingen.de.ibm.com>
 <1258560177.6446.19.camel@dhcp231-106.rdu.redhat.com>
 <20091118183400.0cd6b177@mschwide.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091118183400.0cd6b177@mschwide.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20091118184156.Mf3CK-SosHrvXCUJsVyvZszdcnLf1RLD5cEVYEjwW7A@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Eric Paris <eparis@redhat.com>, Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Nov 18, 2009 at 06:34:00PM +0100, Martin Schwidefsky wrote:
> used for parameter passing. 64 bit values are passed as registers pairs
> with the first register an even numbered register. The effect of that
> rule is that parameter registers may be skipped or that the whole 64 bit
> value is passed on the stack. Examples:

Erm, did I miss something? The 32 bit ABI doesn't say anything about
even/odd register pairs for 64 bit values. Also gcc doesn't generate
such code:

> fn(int a, long long b, int c)
> a is passed in %r2, b is passed in %r4/%r5, c is passed in %r6, %r3 is
> skipped.

extern void fn(int a, long long b, int c);

void bla(void)
{
	fn(0, 1, 2);
}

00000000 <bla>:
   0:   90 ef f0 38             stm     %r14,%r15,56(%r15)
   4:   a7 fa ff a0             ahi     %r15,-96
   8:   a7 28 00 00             lhi     %r2,0
   c:   a7 38 00 00             lhi     %r3,0
  10:   a7 48 00 01             lhi     %r4,1
  14:   a7 58 00 02             lhi     %r5,2
  18:   c0 e5 00 00 00 00       brasl   %r14,18 <bla+0x18>
  1e:   98 ef f0 98             lm      %r14,%r15,152(%r15)
  22:   07 fe                   br      %r14

Not that it really matters, since other archs enforce the rule anyway.
