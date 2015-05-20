Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150518161132.GA17390@infradead.org>
References: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>
	<20150518161132.GA17390@infradead.org>
Date: Wed, 20 May 2015 17:17:50 +0800
Message-ID: <CACVXFVPkohpGo0ibJVfV=FbxnG1YRXw9p9cojN2BU0JudDby1A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] block: reread partitions changes and fix for loop
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 19, 2015 at 12:11 AM, Christoph Hellwig <hch@infradead.org> wrote:
> This series looks good to me,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, last time you said you are OK with v2, and there is only one line
change in v3, so would you mind merging v3 in block tree?

Thanks,
Ming
