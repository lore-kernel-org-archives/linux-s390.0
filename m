Return-Path: <owner-linux-mm@kvack.org>
Date: Thu, 28 Jul 2016 09:41:42 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [BUG -next] "random: make /dev/urandom scalable for silly
 userspace programs" causes crash
Message-ID: <20160728134142.GA12516@thunk.org>
References: <20160727071400.GA3912@osiris>
 <20160728034601.GC20032@thunk.org>
 <20160728055548.GA3942@osiris>
 <20160728072408.GB3942@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160728072408.GB3942@osiris>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-next@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 28, 2016 at 09:24:08AM +0200, Heiko Carstens wrote:
> 
> Oh, I just realized that Linus pulled your changes. Actually I was hoping
> we could get this fixed before the broken code would be merged.
> Could you please make sure the bug fix gets included as soon as possible?

Yes, I'll send the pull request to ASAP.

					- Ted

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
