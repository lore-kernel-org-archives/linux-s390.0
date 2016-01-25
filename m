Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Jan 2016 14:38:20 -0500
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH/RFC] mm/debug_pagealloc: enable it by default
Message-ID: <20160125193820.GA22444@codemonkey.org.uk>
References: <1453463080-84320-1-git-send-email-borntraeger@de.ibm.com>
 <20160125064151.GA22557@js1304-P5Q-DELUXE>
 <56A5DB21.2090300@de.ibm.com>
 <20160125192210.GA20919@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160125192210.GA20919@codemonkey.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 25, 2016 at 02:22:10PM -0500, Dave Jones wrote:

 >  > A default mode would be ok for me as it makes things obvious. Will send
 >  > a patch.
 > 
 > The messaging around changing a default like this was really poor.
 > When we do behaviour changes like this, we typically rename the CONFIG option
 > to make it obvious that things aren't as they used to be.

Looking at this closer, shouldn't the original diff to make this runtime
have also changed the x86 implementation details in arch/x86/mm/pageattr.c ?
Even when we don't boot with the enable flag, we're doing the "split 2M page into 4Ks"
thing.  It looks like a s/debug_pagealloc/debug_pagealloc_enabled()/ might
do the right thing maybe ?

It's almost comedic that I walked into change c9e0d39126af thinking all this
stuff was working _because_ we were doing that page splitting.

	Dave
