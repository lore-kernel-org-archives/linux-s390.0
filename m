Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Aug 2011 15:03:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 0/2] kdump: Common code changes for s390 kdump support
Message-Id: <20110819150353.bf58c7e0.akpm@linux-foundation.org>
In-Reply-To: <20110819141857.052232873@linux.vnet.ibm.com>
References: <20110819141857.052232873@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: vgoyal@redhat.com, ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 19 Aug 2011 16:18:57 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> I had a long discussion with Vivek Goyal on the s390 kdump support (thanks
> Vivek for all the time!). As a result of this, here are two common code
> patches that are required for the s390 port. Could you please integrate them
> upstream in the next merge window? The s390 specific part will be integrated
> by our s390 maintainer Martin Schwidefsky.

The patches look OK to me.  I suggest that they be carried in Martin's
tree, alongside the s390 kdump support.  That will somewhat simplify
things during the merge window, and will greatly simplify getting the
entire feature into linux-next.

You can put my acked-by's on them if you like.

> I will be on vacation for the next two weeks. Therefore if you have comments
> or questions, please contact also Martin Schwidefsky and Heiko Carstens.

I'll put the patches into my tree (and hence linux-next) now, because I
need the typing practice ;) I'll drop them again if/when they turn up
in linux-next's s390 tree.
