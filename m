From: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Thu, 24 Jan 2019 14:14:49 -0500
Message-ID: <f21fcc66-7874-295a-df3f-191c3a930c64@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190122193346.4e23e018@oc2783563651>
	<20190123112112.7822b237.cohuck@redhat.com>
	<42264dd9-86d7-8994-8c25-bc688067725d@linux.ibm.com>
	<20190124111934.72e7f0f1.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190124111934.72e7f0f1.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/24/2019 05:19 AM, Cornelia Huck wrote:
> On Thu, 24 Jan 2019 11:08:02 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 23/01/2019 11:21, Cornelia Huck wrote:
>>> On Tue, 22 Jan 2019 19:33:46 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> On Mon, 21 Jan 2019 12:03:51 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>   
>>>>> --- a/drivers/s390/cio/vfio_ccw_private.h
>>>>> +++ b/drivers/s390/cio/vfio_ccw_private.h
>>>>> @@ -28,6 +28,7 @@
>>>>>     * @mdev: pointer to the mediated device
>>>>>     * @nb: notifier for vfio events
>>>>>     * @io_region: MMIO region to input/output I/O arguments/results
>>>>> + * @io_mutex: protect against concurrent update of I/O structures
>>>>
>>>> We could be a bit more specific about what does this mutex guard.
>>>> Is it only io_region, or cp, irb and the new regions a well? ->state does
>>>> not seem to be covered, but should need some sort of synchronisation
>>>> too, or?
>>>
>>> I'm not sure. IIRC Pierre had some ideas about locking in the fsm?
>>>    
>>
>> Yes I postponed this work to not collide with your patch series.
>>
>> Do you think I should provide a new version of the FSM reworking series
>> based on the last comment I got?
>>
>> I would take into account that the asynchronous commands will come with
>> your patch series and only provide the framework changes.
> 
> This was more an answer to Halil's concerns around state
> synchronization. I would prefer to first get this series (or a
> variation) into decent shape, and then address state machine handling
> on top of that (when we know more about the transitions involved), just
> to avoid confusion.
> 
> Does that sound reasonable?
> 

It does to me.

<Sorry for my silence; we teach our daughter to share, and she shares 
whatever bug is passed around daycare.  I'm catching up on my "todo" 
emails now!>
