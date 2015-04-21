Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5535B3D8.40508@kernel.dk>
Date: Mon, 20 Apr 2015 20:20:08 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] block: reread partitions changes and fix for loop
References: <1428751813-25199-1-git-send-email-ming.lei@canonical.com>	<20150413092252.GA14423@infradead.org> <CACVXFVP=n6MtKNvT3jdnwBQMKBeWFmXKzU8y84qTocqxinb0ZA@mail.gmail.com>
In-Reply-To: <CACVXFVP=n6MtKNvT3jdnwBQMKBeWFmXKzU8y84qTocqxinb0ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>, Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 04/20/2015 08:15 PM, Ming Lei wrote:
> On Mon, Apr 13, 2015 at 5:22 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> The series looks fine to me:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Jens, could you share us if you are OK with this patchset?

Looks good to me, I'll queue it up.

-- 
Jens Axboe
