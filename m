From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: mmotm 2010-02-10 - BUG at fs/dcache.c:677!
Date: Fri, 12 Feb 2010 05:01:04 +0000
Message-ID: <20100212050104.GS30031@ZenIV.linux.org.uk>
References: <201002110043.o1B0hKxW008835@imap1.linux-foundation.org>
 <8576.1265942657@localhost>
 <20100211191427.6ff9aec6.akpm@linux-foundation.org>
 <4B74DE40.5030401@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B74DE40.5030401@ce.jp.nec.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 12, 2010 at 01:51:12PM +0900, Jun'ichi Nomura wrote:
> (02/12/10 12:14), Andrew Morton wrote:
> > On Thu, 11 Feb 2010 21:44:17 -0500 Valdis.Kletnieks@vt.edu wrote:
> > 
> >> On Wed, 10 Feb 2010 16:17:41 PST, akpm@linux-foundation.org said:
> >>> The mm-of-the-moment snapshot 2010-02-10-16-17 has been uploaded to
> >>>
> >>>    http://userweb.kernel.org/~akpm/mmotm/
> >>
> >> Hit this at shutdown. ext4 filesystems.  Brought it up to single-user
> >> mode, then 'shutdown -h now'.
> >>
> >> [   58.311786] ------------[ cut here ]------------
> >> [   58.312261] kernel BUG at fs/dcache.c:677!
> ...
> 
> > Yeah, Sachin reported that against linux-next too (I think - need to
> > check the exact line numbers):
> > http://permalink.gmane.org/gmane.linux.file-systems/38148
> > 
> > It seems to have been met with shrugs thus far.
> 
> According to the Sachin's report:
> > While running hackbench against today's next-20100208 (9056d31..)
> > on a s390 box, came across following BUG.
> ...
> > Did not observe this with next-20100205. Also there doesn't seem to be
> > any patches applied to this code after the last release. So not
> > sure what could have caused this. Corresponding code is :
> 
> So the bug seems introduced between next-20100205 and next-20100208.
> 
> Isn't this change missing the equivalent of "dput(old)"?

Argh...  Nice catch, and yes, it is.
