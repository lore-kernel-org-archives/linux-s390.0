Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <555CA228.1020404@kernel.dk>
Date: Wed, 20 May 2015 09:03:04 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/7] block: reread partitions changes and fix for loop
References: <1430886389-26878-1-git-send-email-ming.lei@canonical.com>	<20150518161132.GA17390@infradead.org> <CACVXFVPkohpGo0ibJVfV=FbxnG1YRXw9p9cojN2BU0JudDby1A@mail.gmail.com>
In-Reply-To: <CACVXFVPkohpGo0ibJVfV=FbxnG1YRXw9p9cojN2BU0JudDby1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>, Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05/20/2015 03:17 AM, Ming Lei wrote:
> On Tue, May 19, 2015 at 12:11 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> This series looks good to me,
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Jens, last time you said you are OK with v2, and there is only one line
> change in v3, so would you mind merging v3 in block tree?

I'll merge it for 4.2, thanks.

-- 
Jens Axboe
