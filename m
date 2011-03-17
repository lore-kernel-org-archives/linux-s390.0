From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Mar 2011 06:50:04 +0000
Subject: Re: [PATCH 00/02] virtio: Virtio platform driver
Message-Id: <AANLkTimwt4hvaU0E=7tJx=zUUJKk5dgZDw4tXphj4Ype@mail.gmail.com>
References: <20110310070541.27327.52089.sendpatchset@t400s>
	<87d3lriv7e.fsf@rustcorp.com.au>
	<AANLkTi=zjGubKx0vV+hqEYiVFVNTAEoGwxEfL4oprxk8@mail.gmail.com>
	<20110316154047.GB21758@ovro.caltech.edu>
In-Reply-To: <20110316154047.GB21758@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 17, 2011 at 12:40 AM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> On Wed, Mar 16, 2011 at 02:17:15PM +0900, Magnus Damm wrote:
>> On Wed, Mar 16, 2011 at 12:46 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> > On Thu, 10 Mar 2011 16:05:41 +0900, Magnus Damm <magnus.damm@gmail.com> wrote:
>> >> virtio: Virtio platform driver
>> >>
>> >> [PATCH 01/02] virtio: Break out lguest virtio code to virtio_lguest.c
>> >> [PATCH 02/02] virtio: Add virtio platform driver
>> >
>> > I have no problem with these patches, but it's just churn until we see
>> > your actual drivers.
>>
>> Well, actually this platform driver is used together with already
>> existing drivers, so there are no new virtio drivers to wait for.
>>
>> The drivers that have been tested are so far:
>>
>> CONFIG_VIRTIO_CONSOLE=y
>> CONFIG_VIRTIO_NET=y
>>
>> At this point there are four different pieces of code working together
>>
>> 1) Virtio platform driver patches (for guest)
>> 2) SH4AL-DSP guest kernel patch
>> 3) ARM UIO driver patches (for host)
>> 4) User space backing code for ARM based on lguest.c
>>
>> These patches in this mail thread are 1), and I decided to brush up
>> that portion and submit upstream because it's the part that is easiest
>> to break out. I intend to post the rest bit by bit over time, but if
>> someone is interested then I can post everything at once too.
>>
>
> I'm very interested in the full series of patches. I want to do
> something similar to talk between two Linux kernels (x86 and PowerPC)
> connected by a PCI bus.

For a full source release, have a look at SH Core Linux 20110317:
http://www.spinics.net/lists/linux-sh/msg07188.html

The SH kernel patch shows how to make use of the virtio platform driver.

Cheers,

/ magnus
