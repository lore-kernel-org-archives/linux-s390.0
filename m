From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH-tip v4 02/10] locking/rwsem: Stop active read lock
 ASAP
Date: Sat, 15 Oct 2016 22:57:31 -0700
Message-ID: <20161016055731.GA21379@infradead.org>
References: <1471554672-38662-1-git-send-email-Waiman.Long@hpe.com>
 <1471554672-38662-3-git-send-email-Waiman.Long@hpe.com>
 <20161006181718.GA14967@linux-80c1.suse>
 <20161006214751.GU27872@dastard>
 <20161009151748.GA29102@infradead.org>
 <20161010060745.GA27872@dastard>
 <20161010093434.GA18024@infradead.org>
 <20161011210640.GB27872@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161011210640.GB27872@dastard>
Sender: linux-alpha-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Waiman Long <Waiman.Long@hpe.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Jason Low <jason.low2@hp.com>, Jonathan Corbet <corbet@lwn.net>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:06:40AM +1100, Dave Chinner wrote:
> Um, I seem to have completely missed that change - when did that
> happen and why?
> 
> Oh, it was part of the misguided "enable DAX on block devices"
> changes -

o, that commit just switched it to use ->f_mapping:

-       return (filp->f_flags & O_DIRECT) || IS_DAX(file_inode(filp));
+       return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);

The original version of it goes all the way back to introducing the
current-day DAX code in d475c6346 ("dax,ext2: replace XIP read and write
with DAX I/O");

> Hence I'd suggest that DAX check in io_is_direct() should be removed
> ASAP; the filesystems don't need it as they check the inode DAX
> state directly, and the code it "fixed" is no longer in the tree.

As long as ext4 still uses the overloaded direct_IO we need the
checks for DAX in the filemap.c generic read/write code.  It seems
like that's only two spots anyway, but I'd feel much safer once ext4
is switched over to the iomap version of the dax code.
