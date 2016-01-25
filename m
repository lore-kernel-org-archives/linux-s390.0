Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Jan 2016 14:22:10 -0500
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH/RFC] mm/debug_pagealloc: enable it by default
Message-ID: <20160125192210.GA20919@codemonkey.org.uk>
References: <1453463080-84320-1-git-send-email-borntraeger@de.ibm.com>
 <20160125064151.GA22557@js1304-P5Q-DELUXE>
 <56A5DB21.2090300@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A5DB21.2090300@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 25, 2016 at 09:21:53AM +0100, Christian Borntraeger wrote:

 > >> Let's go back to the original default and reverse the command
 > >> line parameter to allow disabling the feature.
 > > 
 > > Default disable is requested by Andrew and I agreed that.
 > > 
 > > https://lkml.org/lkml/2014/11/27/3
 > 
 > Well, Andrew's assumption was "I suspect the number of "old users" is one"
 > and this is wrong. I can at least claim, that most of the s390 test were 
 > conducted with CONFIG_DEBUG_PAGEALLOC enabled (at least regularly) - and 
 > about a year ago this was changed to "no longer useful". I have posted 2
 > real bugs that I triggered pretty quickly after I enabled things on the 
 > command line.

Nearly all the fuzz-test runs I've done over the last few years have had this
enabled most the time.  I was wondering why things got faster last year.

 > > I think that default disable is good thing because we can use
 > > the kernel compiled with CONFIG_DEBUG_PAGEALLOC even for production.
 > > Unless boot param is provided, it's runtime cost is nearly zero.
 > > This could help to debug in some situations and make this debugging
 > > feature more useful. But, yes, old users can be surprised
 > > by this change. How about changing Kconfig to ask user for default mode?
 > 
 > A default mode would be ok for me as it makes things obvious. Will send
 > a patch.

The messaging around changing a default like this was really poor.
When we do behaviour changes like this, we typically rename the CONFIG option
to make it obvious that things aren't as they used to be.

ho-hum.

	Dave
