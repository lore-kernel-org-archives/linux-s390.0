From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Thu, 24 Jan 2019 14:16:21 -0500
Message-ID: <b1f0a5f6-51b0-0986-00dd-51bdd79a4779@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190121212018.4e377e59@oc2783563651>
	<20190122112926.4ff54f9f.cohuck@redhat.com>
	<20190122121737.49c3f900@oc2783563651>
	<20190122125322.4bb04921.cohuck@redhat.com>
	<20190122134612.40a7745e@oc2783563651>
	<20190122182617.23fab5e9.cohuck@redhat.com>
	<20190122200331.14ff2818@oc2783563651>
	<20190123113447.04354ae4.cohuck@redhat.com>
	<20190123140601.54b2c768@oc2783563651>
	<20190123143429.7a8da112.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190123143429.7a8da112.cohuck@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/23/2019 08:34 AM, Cornelia Huck wrote:
> On Wed, 23 Jan 2019 14:06:01 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On Wed, 23 Jan 2019 11:34:47 +0100
>> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> Yes, one can usually think of interfaces as contracts: both sides need
>> to keep their end for things to work as intended. Unfortunately the
>> vfio-ccw iterface is not a very well specified one, and that makes
>> reasoning about right order so much harder.
> 
> That's probably where our disconnect comes from.
> 
>>
>> I was under the impression that the right ordering is dictated by the
>> SCSW in userspace. E.g. if there is an FC bit set there userspace is not
>> ought to issue a SSCH request (write to the io_region). The kernel part
>> however may say 'userspace read the actual SCSW' by signaling
>> the io_trigger eventfd. Userspace is supposed to read the IRB from the
>> region and update it's SCSW.
>>
>> Now if userspace reads a broken SCSW from the IRB, because of a race
>> (due to poorly written kernel part -- userspace not at fault), it is
>> going to make wrong assumptions about currently legal and illegal
>> operations (ordering).
> 
> My understanding of the interface was that writing to the I/O region
> triggers a ssch (unless rejected with error) and that reading it just
> gets whatever the kernel wrote there the last time it updated its
> internal structures. The eventfd simply triggers to say "the region has
> been updated with an IRB", not to say "userspace, read this".
> 
>>
>> Previously I described a scenario where IRB can break without userspace
>> being at fault (race between unsolicited interrupt -- can happen at any
>> time -- and a legit io request). I was under the impression we agreed on
>> this.
> 
> There is a bug in there (clearing the cp for non-final interrupts), and
> it needs to be fixed. I'm not so sure if the unsolicited interrupt
> thing is a bug (beyond that the internal state machine is confused).
> 
>>
>> This in turn could lead to userspace violating the contract, as perceived
>> by the kernel side.
> 
> Which contract? ;)
> 
> Also, I'm not sure if we'd rather get a deferred cc 1?

As I'm encountering dcc=1 quite regularly lately, it's a nice error. 
But we don't have a good way of recovering from it, and so my test tends 
to go down in a heap quite quickly.  This patch set will probably help; 
I should really get it applied and try it out.

> 
>>
>>> At this point, I'm mostly confused... I'd prefer to simply fix things
>>> as they come up so that we can finally move forward with the halt/clear
>>> handling (and probably rework the state machine on top of that.)

+1 for fixing things as we go.  I hear the complaints about this code 
(and probably say them too), but remain convinced that a large rewrite 
is unnecessary.  Lots of opportunities for improvement, with lots of 
willing and motivated participants, means it can only get better!

>>>    
>>
>> I understand. I guess you will want to send a new version because of the
>> stuff that got lost in the rebase, or?
> 
> Yes, I'll send a new version; but I'll wait for more feedback for a bit.
> 

I'll try to provide some now.  Still digging through the emails marked 
"todo" :)

  - Eric
