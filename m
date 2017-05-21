Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170521070017.GA13082@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
 <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
 <20170518082448.GB3812@lst.de> <20170518084136.GA5331@lst.de>
 <CAK8P3a2ddbr=ck+G+80vGkVQ+L3snWkT1bbj2+1T6UJhm+_mrQ@mail.gmail.com>
 <20170521070017.GA13082@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 21 May 2017 14:29:21 +0200
Message-ID: <CAK8P3a004SX_cAc1hcbx4wdRMEhmzp=w1wasiRy3UvexskQ5dA@mail.gmail.com>
Subject: Re: [PATCH 2/9] timers: provide a "modern" variant of timers
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 21, 2017 at 9:00 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, May 18, 2017 at 10:57:31AM +0200, Arnd Bergmann wrote:
>> How expensive would it be to add another field to timer_list and
>> just have both pointers?
>
> That would add 4/8 bytes to every structure containing a timer,
> so I'd rather avoid it if possible.

I didn't expect too many timers to be in allocated structures at the same
time on most systems, but I haven't researched this at all.

We should probably update the comment about the cacheline alignment
though: when most users embed the timer_list in some other structure,
it's not valid at all, and forcing timer_list to be cacheline aligned would
waste way more space than an extra field.

>  But one option might be to inflict this onto users of outdated compilers
> and use the union for modern ones.

Good idea, this sounds better than the alternatives at least. The
remaining users of those old compilers certainly don't care that much
about micro-optimizing the kernel anyway.

       Arnd
