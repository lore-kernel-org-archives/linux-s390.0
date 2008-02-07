From: Rick Troth <rmt@casita.net>
Subject: Re: [patch 3/4] ctcm: infrastructure for replaced ctc driver
Date: Thu, 7 Feb 2008 06:52:06 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0802070648020.547@force5.casita.net>
References: <20080206182723.103842000@linux.vnet.ibm.com>
 <20080206183023.042552000@linux.vnet.ibm.com> <20080207063534.GB27498@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080207063534.GB27498@infradead.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ursula Braun <braunu@de.ibm.com>, jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Peter Tiedemann <ptiedem@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 7 Feb 2008, Christoph Hellwig wrote:
 ...
> > +/*
> > + *	drivers/s390/net/ctcm_dbug.c
> > + *
> > + *	Copyright IBM Corp. 2001, 2007
> > + *	Authors:	Peter Tiedemann (ptiedem@de.ibm.com)
> > + *
> > + */
>
> Please don't mention filenames in the top of file comments.
> On the other hand a little description of what this file
> does would be quite useful.  (This comment applies to all
> files in this patch)

Better descriptions, yes.  Of course.
But are you saying to NOT name the file in its comments?
I am surprised.  If I am reading correctly, then I disagree.

Is the exclusion of the name of the source file from its comments
a stylistic decision the other kernel developers have agreed to?
Or is it tied to automation?  Or have I (hopefully) misunderstood?

-- R;   <><

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments
