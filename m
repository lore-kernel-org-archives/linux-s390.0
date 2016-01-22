Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
References: <56A0F1CA.4010303@linux.vnet.ibm.com> <56A14EE4.1020008@fb.com>
 <20160121225127.GA30993@localhost.localdomain>
 <CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
 <20160122032135.GA9244@localhost.localdomain>
 <CA+55aFwGRQb_2SUTj8A9MzTC4WCVC37p64t5obUfTvLNyctjKA@mail.gmail.com>
 <20160122145559.GA21984@localhost.localdomain>
From: Jens Axboe <axboe@fb.com>
Message-ID: <56A263A7.6070406@fb.com>
Date: Fri, 22 Jan 2016 10:15:19 -0700
MIME-Version: 1.0
In-Reply-To: <20160122145559.GA21984@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Keith Busch <keith.busch@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/22/2016 07:56 AM, Keith Busch wrote:
> On Thu, Jan 21, 2016 at 08:15:37PM -0800, Linus Torvalds wrote:
>> For the case of nvme, for example, I think the max sector number is so
>> high that you'll never hit that anyway, and you'll only ever hit the
>> chunk limit. No?
>
> The device's max transfer and chunk size are not very large, both fixed
> at 128KB. We can lose ~70% of potential throughput when IO isn't aligned,
> and end users reported this when the block layer stopped splitting on
> alignment for the NVMe drive.
>
> So it's a big deal for this h/w, but now I feel awkward defending a
> device specific feature for the generic block layer.

Honestly, the splitting code is what is a piece of crap, we never should 
have gone down that route. Hopefully we can get rid of it soon. In the 
mean time, this does need to work. It's an odd hw construct (basically 
two devices bolted together), but it's not really an esoteric thing to 
support.

> Anyway, the patch was developed with incorrect assumptions. I'd still
> like to try again after reconciling the queue limit constraints, but
> I defer to Jens for the near term.

Instead of scrambling for -rc1, I'd suggest we just revert again and 
ensure what we merge for -rc2 is clean and passes the test cases.

-- 
Jens Axboe
