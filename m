From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: mmotm 2010-02-10 - BUG at fs/dcache.c:677!
Date: Fri, 12 Feb 2010 05:07:03 +0000
Message-ID: <20100212050703.GT30031@ZenIV.linux.org.uk>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
 <8576.1265942657@localhost>
 <20100211191427.6ff9aec6.akpm@linux-foundation.org>
 <4B74DE40.5030401@ce.jp.nec.com>
 <20100212050104.GS30031@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100212050104.GS30031@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 12, 2010 at 05:01:04AM +0000, Al Viro wrote:

> > So the bug seems introduced between next-20100205 and next-20100208.
> > 
> > Isn't this change missing the equivalent of "dput(old)"?
> 
> Argh...  Nice catch, and yes, it is.

Fixed, pushed to hera, should propagate to git.kernel.org shortly.
