Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
 <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
 <bb313a2d-b5fc-9329-5db6-4bf661d278bb@arm.com>
 <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b082bf81-2148-2b43-5b1a-0bdf4b1e62c0@arm.com>
Date: Wed, 9 Jan 2019 14:55:44 +0000
MIME-Version: 1.0
In-Reply-To: <CANLsYkx_-QHs=3syOXrazU_nA2x-QT9VjvzWubGjVGtz_01dAQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: mathieu.poirier@linaro.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, Suzuki.Poulose@arm.com, peterz@infradead.org, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, acme@kernel.org, ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, will.deacon@arm.com, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

Hi Mathieu,

On 07/01/2019 18:18, Mathieu Poirier wrote:
> On Wed, 19 Dec 2018 at 02:40, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 18/12/2018 17:34, Mathieu Poirier wrote:
>>> Good day Suzuki,
>>>
>>> On Tue, 18 Dec 2018 at 07:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

>>>> We could assign a static "id/key" exported either via the device sysfs dir or
>>>> the "pmu" dir. I prefer the latter.
>>>
>>> Not sure what you mean by "pmu" directory - would you mind expanding
>>> on that?  Using sysfs would be quite easy but I am reluctant to create
>>> a new id/key mechanism and introduce another entry when we have the
>>> component address that is unique and already available in the amba
>>> directory structure.
>>
>> We could add another directory under :
>>
>> /sys/bus/event_source/devices/<PMU>/
>>                                  \_ events/
>>                                  \_ format/
>> say :
>>                  \_ drv_config/
>>                  Or
>>                  \_ sinks/
>>
>> and list the sinks, eg:
>> # cd $sysfs_pmu_dir/sinks
>> # cat <name_of_the_sink>
>> ID_of_the_sink
> 
> There is merit to this idea.  Thinking along those lines simply using
> "sinks" is probably a better approach since we don't yet know how PMU
> configuration will unfold.  I'm also wondering if we have to
> explicitly list the ID of the sink.  The ID itself should be fetch
> from the device specific entries in sysfs like the "resource" property
> of sinks that show up on the AMBA bus.  Sinks that don't show up on
> the AMBA bus will likely have a "reg" property of something similar
> and that is where the ID should be taken from.

I would recommend this be done by the PMU driver and expose it, rather
than specifying what is expected. If we keep it simple like an integer,
which is then mapped to the sink-device, we could save some bits in the
config field for further use and a the complex set of rules for the ID.

> 
> Lastly it may be tricky to add a new directory structure to the PMU
> entry as it is generic for all PMUs in the system.  But that is up for
> investigation and I will look into doing something like that.

I don't think this is particularly problematic. The PMU driver can provide
a list of attribute_groups which should eventually appear in the device
directory under the "bus/event_source/devices/<PMU>/". And that provides
a central place for finding the SINK id for all the available sinks, rather
than scanning for a sink under all the buses (e.g, platform, amba) wherever
that might show up.

> 
>>
>> Btw, I am always inclined to using some bits off one of the "config" fields
>> ("config1" or "config2") for the sink configuration. But I understand that
>> you have explored that avenue and chose this approach as we have further
>> configurations required for complex ETM settings.
> 
> I've had a good conversation with myself over the holidays on that
> topic (hence the late-ish reply).  My original approach was to use the
> same ioctl() mechanism to do sink selection and complex PMU
> configuration.  But as Greg confirmed with his comment on the previous
> patch doing so requires to iron out how the latter will be done on ARM
> (and probably on Intel too), something that is a different deal
> altogether.
> 
> Taking a step back and forgetting about complex PMU configuration for
> a minute, the ID of a sink can easily be stuffed in one of the
> "config" fields of the perf_event_attr structure, something I alluded
> to in the patchset's cover letter.  That way we can move along with
> this feature and leave the discussion on complex PMU configuration for
> another day.

Cool ! I completely agree with this.

> 
> I'll do a respin with the above in mind.
> 
> A happy new year to you,

You too.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
