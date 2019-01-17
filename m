Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
 <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a9f6be39-6914-4f32-0212-da016757dd72@arm.com>
Date: Thu, 17 Jan 2019 11:55:24 +0000
MIME-Version: 1.0
In-Reply-To: <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, acme@kernel.org, ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, will.deacon@arm.com, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

Hi Mathieu,

On 16/01/2019 23:43, Mathieu Poirier wrote:
> Good evening Suzuki,
> 
> On Wed, 16 Jan 2019 at 03:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 15/01/2019 23:07, Mathieu Poirier wrote:
>>> Add a "sinks" directory entry so that users can see all the sinks
>>> available in the system in a single place.  Individual sink are added
>>> as they are registered with the coresight bus.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

...

>>> +static ssize_t etm_perf_sink_name_show(struct device *dev,
>>> +                                    struct device_attribute *dattr,
>>> +                                    char *buf)
>>> +{
>>> +     /* See function coresight_sink_by_id() to know where this is used */
>>> +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
>>> +
>>> +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
>>> +}
>>> +
>>> +int etm_perf_symlink_sink(struct coresight_device *csdev)
>>> +{
>>> +     struct device *pmu_dev = etm_pmu.dev;
>>> +     struct device *pdev = csdev->dev.parent;
>>> +     struct device_attribute *dev_attr;
>>> +
>>> +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
>>> +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
>>> +             return -EINVAL;
>>> +
>>> +     if (!etm_perf_up)
>>> +             return -EPROBE_DEFER;
>>> +
>>> +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
>>> +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
>>> +     dev_attr->attr.mode = 0444;
>>> +     dev_attr->show = etm_perf_sink_name_show;
>>
>> I would have  added the attribute to the csdev (say, sink_attr),
>> and add that to the group, so that it is easier to remove the
>> attribute when the sink device is removed from the system (when
>> we get there). It would be good to have something in place to remove the
>> attribute.
> 
> My hope was to avoid introducing a new field in the already bloated
> coresight_device structure, and on top of things a component specific
> field.  I think it would be worth it if we'd envision making the

I agree. May be we could add a union for the fields specific to the "Type" of
the device.

> coresight drivers removable in a not so distant future.  But doing
> something like that is quite tricky (as Kim quickly found out) and
> skirts the bottom of the list of priorities, if on it at all.

> 
> I'll change it if you're really keen on it but it would be code that
> is never used.

Yes, I understand. But we would want to get there sometime in the future,
in order to allow using the Coresight out of the box on Enterprise systems.
So it would be good to prepare towards that as we go.


Also, it makes the failure handling easier.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
