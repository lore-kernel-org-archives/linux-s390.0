From: Rob van der Heij <rvdheij@gmail.com>
Date: Thu, 06 May 2010 08:17:36 +0000
Subject: Re: deadline ALWAYS default for dasd devices(s390) ?
Message-Id: <z2x6227a1ef1005060117ld034b2e7vb31493640d0789be@mail.gmail.com>
In-Reply-To: <4BE27123.6070501@gmail.com>
References: <4BE27123.6070501@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 6, 2010 at 9:34 AM, Xose Vazquez Perez
<xose.vazquez@gmail.com> wrote:
> On 05/05/2010 09:52 AM, Stefan Weinhuber wrote:
>
> hi,
>
>> At the time this change was made we had the problem that the
>> default scheduler chosen by the distributions resulted in
>> bad performance for DASD devices.
>
> Have you done recently new cfq vs. deadline tests, in z/VM
> and LPAR ?
>
>> I agree that hard coding this choice into the driver is not pretty,
>> but it is pragmatic.
>
> It's awful. Easier and simpler from user space: /sys/block/dasdX/queue/scheduler
>
>> Some generic mechanism for setting driver specific
>> defaults would be nicer, but I doubt that many other drivers would
>> actually benefit from such an interface.
>
> see s390-tools-1.8.4/etc/udev/rules.d/60-readahead.rules
> That's the way to do it.

</lurk>
Hear, hear!

When it's hardcoded, the performance recommendations become a
self-fulfilling prophecy since it prevents simple souls like myself
from experimenting and show under what circumstances the alternative
is more effective. It would not be the first time. I  still recall the
critsit when some feature of the dasd driver did great in the lab and
failed miserably in real life.
I'm even willing to try wrap my brains around udev if I have to ;-)
<lurk>

Rob
