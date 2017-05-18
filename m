Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170518084136.GA5331@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-3-hch@lst.de>
 <CAK8P3a106wR4h_muGGF7S7uh5UrH-OcJObMfVgk22P9brP5Bjg@mail.gmail.com>
 <20170518082448.GB3812@lst.de> <20170518084136.GA5331@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 May 2017 10:57:31 +0200
Message-ID: <CAK8P3a2ddbr=ck+G+80vGkVQ+L3snWkT1bbj2+1T6UJhm+_mrQ@mail.gmail.com>
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

On Thu, May 18, 2017 at 10:41 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, May 18, 2017 at 10:24:48AM +0200, Christoph Hellwig wrote:
>> > b) give the union a name (breaks any reference to timer_list->func in C code):
>> >
>> >  +       union {
>> >  +               void            (*func)(struct timer_list *timer);
>> >  +               void            (*function)(unsigned long);
>> >  +       } u;
>>
>> I'll look into that, as it seems a lot safer, and places outside
>> the timer code shouldn't really touch it (although I bet they do,
>> so more fixes for this series..)
>
> Meh.  All the old init_timer users set function directly, so
> I guess we need to use the other approach.

How expensive would it be to add another field to timer_list and
just have both pointers?

      Arnd
