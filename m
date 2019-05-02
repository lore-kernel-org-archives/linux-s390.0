Return-Path: <SRS0=aDnU=TC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Thu, 2 May 2019 17:10:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190502143110.GC17577@kroah.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190502122128.GA2670@kroah.com>
 <20190502161758.26972bb2@mschwideX1>
 <20190502143110.GC17577@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190502171055.132f023c@mschwideX1>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2 May 2019 16:31:10 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, May 02, 2019 at 04:17:58PM +0200, Martin Schwidefsky wrote:
> > On Thu, 2 May 2019 14:21:28 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Mon, Apr 15, 2019 at 09:17:10AM -0700, Linus Torvalds wrote:  
> > > > On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:    
> > > > >
> > > > > Can we please have the page refcount overflow fixes out on the list
> > > > > for review, even if it is after the fact?    
> > > > 
> > > > They were actually on a list for review long before the fact, but it
> > > > was the security mailing list. The issue actually got discussed back
> > > > in January along with early versions of the patches, but then we
> > > > dropped the ball because it just wasn't on anybody's radar and it got
> > > > resurrected late March. Willy wrote a rather bigger patch-series, and
> > > > review of that is what then resulted in those commits. So they may
> > > > look recent, but that's just because the original patches got
> > > > seriously edited down and rewritten.
> > > > 
> > > > That said, powerpc and s390 should at least look at maybe adding a
> > > > check for the page ref in their gup paths too. Powerpc has the special
> > > > gup_hugepte() case, and s390 has its own version of gup entirely. I
> > > > was actually hoping the s390 guys would look at using the generic gup
> > > > code.
> > > > 
> > > > I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> > > > largely irrelevant, partly since even theoretically this whole issue
> > > > needs a _lot_ of memory.
> > > > 
> > > > Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
> > > > (page ref overflow)"). You may or may not really care.    
> > > 
> > > I've now queued these patches up for the next round of stable releases,
> > > as some people seem to care about these.
> > > 
> > > I didn't see any follow-on patches for s390 or ppc64 hit the tree for
> > > these changes, am I just missing them and should also queue up a few
> > > more to handle this issue on those platforms?  
> > 
> > I fixed that with a different approach. The following two patches are
> > queued for the next merge window:
> > 
> > d1874a0c2805 "s390/mm: make the pxd_offset functions more robust"
> > 1a42010cdc26 "s390/mm: convert to the generic get_user_pages_fast code"
> > 
> > With these two s390 now uses the generic gup code in mm/gup.c  
> 
> Nice!  Do you want me to queue those up for the stable backports once
> they hit a public -rc release?

Yes please!

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
