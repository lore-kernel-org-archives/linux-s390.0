Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Apr 2015 10:00:28 -0400
From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 2/7] block: loop: don't hold lo_ctl_mutex in lo_open
Message-ID: <20150408140028.GI14217@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428474226-27386-1-git-send-email-jarod@redhat.com>
 <1428474226-27386-3-git-send-email-jarod@redhat.com>
 <CACVXFVPtaG4EDjAJ5G=Qz29fE4Zfp==W0izdCK06ZnJm17jO8Q@mail.gmail.com>
 <20150408134034.GH14217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150408134034.GH14217@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 08, 2015 at 09:40:34AM -0400, Jarod Wilson wrote:
> On Wed, Apr 08, 2015 at 02:50:59PM +0800, Ming Lei wrote:
> > Hi Jarod,
> > 
> > On Wed, Apr 8, 2015 at 2:23 PM, Jarod Wilson <jarod@redhat.com> wrote:
> > > From: Ming Lei <ming.lei@canonical.com>
> > >
> > > The lo_ctl_mutex is held for running all ioctl handlers, and
> > > in some ioctl handlers, ioctl_by_bdev(BLKRRPART) is called for
> > > rereading partitions, which requires bd_mutex.
> > >
> > > So it is easy to cause failure because trylock(bd_mutex) may
> > > fail inside blkdev_reread_part(), and follows the lock context:
> > >
> > > blkid or other application:
> > >         ->open()
> > >                 ->mutex_lock(bd_mutex)
> > >                 ->lo_open()
> > >                         ->mutex_lock(lo_ctl_mutex)
> > >
> > > losetup(set fd ioctl):
> > >         ->mutex_lock(lo_ctl_mutex)
> > >         ->ioctl_by_bdev(BLKRRPART)
> > >                 ->trylock(bd_mutex)
> > >
> > > This patch trys to eliminate the ABBA lock dependency by removing
> > > lo_ctl_mutext in lo_open() with the following approach:
> > >
> > > 1) introduce lo_open_mutex to protect lo_refcnt and avoid acquiring
> > > lo_ctl_mutex in lo_open():
> > 
> > It is a bit quick since I said the lo_open_mutex can be removed,
> > and Christoph agreed that too.
> > 
> > So looks we still need to post another version, :-)
> 
> Ah. I missed that bit. Just trying to keep up momentum.

Are you working on that atomic_t version then, or should I dive into it?

-- 
Jarod Wilson
jarod@redhat.com
