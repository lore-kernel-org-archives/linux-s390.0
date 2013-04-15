Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1366005207.1878.43.camel@joe-AO722>
Subject: Re: arch/s390/lib/uaccess_pt.c: Missing breaks: ?
From: Joe Perches <joe@perches.com>
Date: Sun, 14 Apr 2013 22:53:27 -0700
In-Reply-To: <20130415054814.GA4207@osiris>
References: <1365919574.1878.13.camel@joe-AO722>
	 <20130415054814.GA4207@osiris>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2013-04-15 at 07:48 +0200, Heiko Carstens wrote:
> On Sat, Apr 13, 2013 at 11:06:14PM -0700, Joe Perches wrote:
> > Commit ea81531d ("s390/uaccess: fix page table walk")
> > added this code.  It looks like it should have break;
> > for each case.
> no, the fallthrough is on purpose for each case statement.

Hi again.  It might be useful to add /* fallthrough */
or some other comment showing it's intentional.
