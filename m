From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path event
 handling
Date: Tue, 16 Jan 2018 16:57:13 +0100
Message-ID: <a4f39e6e-c031-0861-ff6b-e29747ba9489@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
 <f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
 <20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>



On 01/15/2018 09:59 AM, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-01-12 19:10:20 +0100]:
> 
>>
>>
>> On 01/11/2018 04:04 AM, Dong Jia Shi wrote:
>>> What are still missing, thus need to be offered in the next version are:
>>> - I/O termination and FSM state handling if currently we have I/O on the status
>>>   switched path.
>>> - Vary on/off event is not sensible to a guest.
>>
>> I don't see a doc update. We do have documentation (in
>> Documentation/s390/vfio-ccw.txt) in which the uapi interface with the
>> regions and their purpose/usage  is at least kind of explained. You are
>> changing this interface without updating the doc.
>>
>> I would like to see documentation on this because I'm under the
>> impression either the design is pretty convoluted or I did not
>> get it at all.
> Ah, I missed the documentation part. Thanks for pointing out. I will add
> it in the next cycle.
> 

I would have preferred having a doc update in this cycle. E.g. as
an answer to the cover letter.

As previously pointed out I don't really understand your design.
I wanted to avoid summarizing the design myself (that is my understanding
of it), to then question the design.

To give you a feeling of what I mean here some bullet points:
* Channel paths are css level resources (simplified).
* When a channel path malfunctions a CRW is generated and a machine
check channel report pending is generated. Same goes for
channel paths popping up (on HW level). Should not these get
propagated?
* Kind of instead of the CRW you introduce a per device interrupt
for channel path events on the qemu/kvm boundary. AFAIU for a chp
event you do an STSCH for each (affected?) subchannel and generate
an irq. Right? Why is this a good idea.
* SCHIB.PMCW provides path information relevant for a given device.
This information is retrieved using store subchannel. Is your series
sufficient for making store subchannel work properly (correct and
reasonably up to date)? Regarding PMCW it's supposed to get updated
when io functions are preformed by the css, AFAIR. Is that right?
If yes what are the implications? Are the manipulations you do
on some PMCW fields architecturally correct?
* The one thing I would very much appreciate as an user of vfio,
and should in my understanding be the user story of this series
(and the qemu counterpart of course) is the following. If my device
(that is IO operation) failed because no path could be found on
which the device is accessible, I would like to be able to identify
that. Preferably the same way I would do for an LPAR guest. Is this
series accomplishing that? 
* Why not just do proper STSCH for vfio-ccw?
* Shouldn't we virtualize CHPIDs? What if we have a clash? Lets
say my dasd is only accessible via chp  0.00 in the host. Currently
we have a problem there, or (as the only path would end up being
ignored)? Note: this is another unpleasant effect of not having
MCSSE in the guest. The original design was to have a separate
css for vfio, and then we would not have this kind of a problem.
(Virtualization of chps would still be good for migration.)

Regards,
Halil
