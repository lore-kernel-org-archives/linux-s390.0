Return-Path: <linux-kernel-owner+w=401wt.eu-S1761500AbXFQXZD@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] use __asm__ and __volatile__ in i386/arm/s390 byteorder.h
Date: Mon, 18 Jun 2007 01:24:24 +0200
References: <200706171833.29046.vapier@gentoo.org> <1182120674.22999.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1182120674.22999.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706180124.25574.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mike Frysinger <vapier@gentoo.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Monday 18 June 2007, Arjan van de Ven wrote:
> 
> On Sun, 2007-06-17 at 18:33 -0400, Mike Frysinger wrote:
> > This changes asm() to __asm__() and volatile to __volatile__ so that these
> > headers can be used with gcc's -std=c99.
> 
> hmm but the kernel doesn't use -std=c99...

The byteorder headers are exported to user space through
include/asm-generic/Kbuild.asm, and they are used by a number
of other exported headers, so they should work with any
gcc flags that a user might want to use.

	Arnd <><
