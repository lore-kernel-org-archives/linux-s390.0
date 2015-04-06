Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Apr 2015 07:49:51 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/6] block: loop: don't hold lo_ctl_mutex in lo_open
Message-ID: <20150406144951.GB2703@infradead.org>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428218688-4092-3-git-send-email-ming.lei@canonical.com>
 <CACVXFVMFxAdG3BNtO82uhv8RTYErk5c9ts4+QVpbne+4WHnVqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVMFxAdG3BNtO82uhv8RTYErk5c9ts4+QVpbne+4WHnVqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 06, 2015 at 12:28:22AM +0800, Ming Lei wrote:
> Another simpler way is to make lo_refcnt as atomic_t and remove
> lo_ctrl_mutext in lo_open(), and freeze request queue during clearing
> fd, and better to freeze queue during setting fd too, so will update in
> v1 with this way.

Using an atomic_t sounds good to me.
