Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jan 2016 14:56:00 +0000
From: Keith Busch <keith.busch@intel.com>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
Message-ID: <20160122145559.GA21984@localhost.localdomain>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
 <56A14EE4.1020008@fb.com>
 <20160121225127.GA30993@localhost.localdomain>
 <CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
 <20160122032135.GA9244@localhost.localdomain>
 <CA+55aFwGRQb_2SUTj8A9MzTC4WCVC37p64t5obUfTvLNyctjKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwGRQb_2SUTj8A9MzTC4WCVC37p64t5obUfTvLNyctjKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@fb.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 21, 2016 at 08:15:37PM -0800, Linus Torvalds wrote:
> For the case of nvme, for example, I think the max sector number is so
> high that you'll never hit that anyway, and you'll only ever hit the
> chunk limit. No?

The device's max transfer and chunk size are not very large, both fixed
at 128KB. We can lose ~70% of potential throughput when IO isn't aligned,
and end users reported this when the block layer stopped splitting on
alignment for the NVMe drive.

So it's a big deal for this h/w, but now I feel awkward defending a
device specific feature for the generic block layer.

Anyway, the patch was developed with incorrect assumptions. I'd still
like to try again after reconciling the queue limit constraints, but
I defer to Jens for the near term.

Thanks!
