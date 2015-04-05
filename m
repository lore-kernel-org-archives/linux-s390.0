Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1428218688-4092-3-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
	<1428218688-4092-3-git-send-email-ming.lei@canonical.com>
Date: Mon, 6 Apr 2015 00:28:22 +0800
Message-ID: <CACVXFVMFxAdG3BNtO82uhv8RTYErk5c9ts4+QVpbne+4WHnVqA@mail.gmail.com>
Subject: Re: [PATCH 2/6] block: loop: don't hold lo_ctl_mutex in lo_open
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org, Ming Lei <ming.lei@canonical.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Apr 5, 2015 at 3:24 PM, Ming Lei <ming.lei@canonical.com> wrote:
> The lo_ctl_mutex is held for running all ioctl handlers, and
> in some ioctl handlers, ioctl_by_bdev(BLKRRPART) is called for
> rereading partitions, which requires bd_mutex.
>
> So it is easy to cause failure because trylock(bd_mutex) may
> fail inside blkdev_reread_part(), and follows the lock context:
>
> blkid or other application:
>         ->open()
>                 ->mutex_lock(bd_mutex)
>                 ->lo_open()
>                         ->mutex_lock(lo_ctl_mutex)
>
> losetup(set fd ioctl):
>         ->mutex_lock(lo_ctl_mutex)
>         ->ioctl_by_bdev(BLKRRPART)
>                 ->trylock(bd_mutex)
>
> This patch trys to eliminate the ABBA lock dependency by removing
> lo_ctl_mutext in lo_open() with the following approach:
>
> 1) introduce lo_open_mutex to protect lo_refcnt and avoid acquiring
> lo_ctl_mutex in lo_open():
>         - for open vs. add/del loop, no any problem because of loop_index_mutex
>         - lo_open_mutex is used for syncing open() and loop_clr_fd()
>         - both open() and release() have been serialized by bd_mutex already
>
> 2) don't hold lo_ctl_mutex for decreasing/checking lo_refcnt in
> lo_release(), then lo_ctl_mutex is only required for the last release.

Another simpler way is to make lo_refcnt as atomic_t and remove
lo_ctrl_mutext in lo_open(), and freeze request queue during clearing
fd, and better to freeze queue during setting fd too, so will update in
v1 with this way.

Thanks,
Ming Lei
