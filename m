Return-Path: <linux-kernel-owner+w=401wt.eu-S1754096AbXKSIyS@vger.kernel.org>
Subject: Re: [patch 1/6] sclp: sysfs interface for SCLP cpi
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <3ae72650711160708m1855eb18q3a986998cfd87a3f@mail.gmail.com>
References: <20071116142942.978412023@de.ibm.com>
	 <20071116143320.980985765@de.ibm.com>
	 <3ae72650711160708m1855eb18q3a986998cfd87a3f@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 19 Nov 2007 09:53:56 +0100
Message-Id: <1195462436.31281.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ernst <mernst@de.ibm.com>, Greg KH <greg@kroah.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2007-11-16 at 16:08 +0100, Kay Sievers wrote:
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

The "trainwreck" how Andrew has called it..
We have two git repositories with new code, both are against the
mainline git. After both repositories are merged we have push another
patch with the adaptions for the s390 code. The usual upstream fixing I
would say. Thanks for the hint.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
