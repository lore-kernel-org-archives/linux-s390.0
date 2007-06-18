Return-Path: <linux-kernel-owner+w=401wt.eu-S1765428AbXFRSjm@vger.kernel.org>
Date: Mon, 18 Jun 2007 19:39:30 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch] use __asm__ and __volatile__ in i386/arm/s390 byteorder.h
Message-ID: <20070618183930.GA17479@infradead.org>
References: <200706171833.29046.vapier@gentoo.org> <20070618183450.GA17112@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070618183450.GA17112@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Mike Frysinger <vapier@gentoo.org>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 18, 2007 at 07:34:50PM +0100, Christoph Hellwig wrote:
> On Sun, Jun 17, 2007 at 06:33:28PM -0400, Mike Frysinger wrote:
> > This changes asm() to __asm__() and volatile to __volatile__ so that these
> > headers can be used with gcc's -std=c99.
> 
> We should not allow inline assemly in the exported part of userspace headers
> at all.  These headers must only include defintions for the kernel <-> user
> ABI, and should not include code at all.

this should have been a reply to the hdrcheck thread, but given the
cc list of this one is a superset of that I hope everyone can find it anyway.
