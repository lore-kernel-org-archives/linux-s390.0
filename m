From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Tue, 26 Feb 2013 12:54:00 +0100
Message-ID: <512CA258.7070101@de.ibm.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
	<20130226111812.GA11111@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130226111812.GA11111@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On 26/02/13 12:18, Michael S. Tsirkin wrote:
> On Tue, Feb 26, 2013 at 01:04:21PM +0200, Michael S. Tsirkin wrote:
>> On Mon, Feb 25, 2013 at 04:27:45PM +0100, Cornelia Huck wrote:
>>> Here's the latest version of my patch series enabling ioeventfds
>>> on s390, again against kvm-next.
>>>
>>> Patches 1 and 2 (cleaning up initialization and exporting the virtio-ccw
>>> api) would make sense even independent of the ioeventfd enhancements.
>>>
>>> Patches 3-5 are concerned with adding a new type of ioeventfds for
>>> virtio-ccw notifications on s390. The naming is now hopefully clearer.
>>> We won't add ioeventfd support for the legacy s390-virtio transport.
>>>
>>> Please consider applying.
>>
>> I just had a thought: this makes us lookup the device on the bus
>> for each notification. It would be better to simply get the
>> device index from guest instead.
>>
>> We could validate that it matches the correct device,
>> if not - fallback to the current linear scan.
>>
>> We could return the index to guest for the next call.
>>
>> I know this needs guest changes but it's still not too late to
>> fix this for 3.9 guests so that we won't need to worry
>> about compatibility going forward.
>>
>> Hmm?
> 
> And just to clarify, here's what I mean (BTW, why doesn't
> this code use the interfaces from kvm_para.h?)
> I think it's a good idea to merge this before 3.9 so we don't
> need to worry about legacy going forward.
> 
> Completely untested, just to give you the idea.

Thinking more about it: Isnt the index on the kvm bus just an implementation
detail? In other words, what happens if we want to re-arrange the kvm io bus 
to a tree like structure. Then the index becomes pretty much useless. Do we 
really want to put such an internal thing into an interface?

CHristian
