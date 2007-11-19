Return-Path: <linux-kernel-owner+w=401wt.eu-S1753022AbXKSHaf@vger.kernel.org>
Date: Mon, 19 Nov 2007 08:29:45 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [patch 1/6] sclp: sysfs interface for SCLP cpi
Message-ID: <20071119082945.1e741eb0@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <3ae72650711160708m1855eb18q3a986998cfd87a3f@mail.gmail.com>
References: <20071116142942.978412023@de.ibm.com>
	<20071116143320.980985765@de.ibm.com>
	<3ae72650711160708m1855eb18q3a986998cfd87a3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ernst <mernst@de.ibm.com>, Greg KH <greg@kroah.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 16 Nov 2007 16:08:21 +0100,
"Kay Sievers" <kay.sievers@vrfy.org> wrote:

> On Nov 16, 2007 3:29 PM, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> > +
> > +static decl_subsys(cpi, NULL, NULL);
> > +
> 
> decl_subsys() and all other static kset cruft called "subsys" will be
> gone with 2.6.25.
> The patch series doing this is in -mm, and this patch will need
> (trivial) adaption to the
> new interfaces.

Andrew has this one in his lineup:

http://www.eu.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc2/2.6.24-rc2-mm1/broken-out/adapt-sclp_cpi_sysc-to-the-kobject-kset-changes.patch
