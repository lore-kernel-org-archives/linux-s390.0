From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v6 00/99] XArray version 6
Date: Thu, 18 Jan 2018 09:02:11 -0800
Message-ID: <20180118170211.GB23800@bombadil.infradead.org>
References: <20180117202203.19756-1-willy@infradead.org>
 <20180118160749.GP13726@twin.jikos.cz>
 <20180118164843.GA23800@bombadil.infradead.org>
 <20180118165612.GS13726@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20180118165612.GS13726@twin.jikos.cz>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/intel-gfx/>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
To: dsterba@suse.cz, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, iommu@lists.linux-foundation.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org, linux-sh@vger.kernel.org, David Howells <dhowells@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 18, 2018 at 05:56:12PM +0100, David Sterba wrote:
> On Thu, Jan 18, 2018 at 08:48:43AM -0800, Matthew Wilcox wrote:
> > Thank you!  I shall attempt to debug.  Was this with a btrfs root
> > filesystem?  I'm most suspicious of those patches right now, since they've
> > received next to no testing.  I'm going to put together a smaller patchset
> > which just does the page cache conversion and nothing else in the hope
> > that we can get that merged this year.
> 
> No, the root is ext3 and there was no btrfs filesytem mounted at the
> time.

Found it; I was missing a prerequisite patch.  New (smaller) patch series
coming soon.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
