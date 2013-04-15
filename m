Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Apr 2013 07:58:23 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: arch/s390/lib/uaccess_pt.c: Missing breaks: ?
Message-ID: <20130415055822.GC4207@osiris>
References: <1365919574.1878.13.camel@joe-AO722>
 <20130415054814.GA4207@osiris>
 <1366005207.1878.43.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1366005207.1878.43.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Apr 14, 2013 at 10:53:27PM -0700, Joe Perches wrote:
> On Mon, 2013-04-15 at 07:48 +0200, Heiko Carstens wrote:
> > On Sat, Apr 13, 2013 at 11:06:14PM -0700, Joe Perches wrote:
> > > Commit ea81531d ("s390/uaccess: fix page table walk")
> > > added this code.  It looks like it should have break;
> > > for each case.
> > no, the fallthrough is on purpose for each case statement.
> 
> Hi again.  It might be useful to add /* fallthrough */
> or some other comment showing it's intentional.

I might add some comment above the function, since for everybody
*knowing* the architecture it's obvious ;) that these must be
fallthroughs.
How did you stuble across this?
