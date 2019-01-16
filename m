Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
In-Reply-To: <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 16:43:51 -0700
Message-ID: <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Good evening Suzuki,

On Wed, 16 Jan 2019 at 03:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 15/01/2019 23:07, Mathieu Poirier wrote:
> > Add a "sinks" directory entry so that users can see all the sinks
> > available in the system in a single place.  Individual sink are added
> > as they are registered with the coresight bus.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> >   .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> >   drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> >   3 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..292bd409a68c 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/perf_event.h>
> >   #include <linux/percpu-defs.h>
> >   #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >   #include <linux/types.h>
> >   #include <linux/workqueue.h>
> >
> > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> >       .attrs  = etm_config_formats_attr,
> >   };
> >
> > +static struct attribute *etm_config_sinks_attr[] = {
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group etm_pmu_sinks_group = {
> > +     .name   = "sinks",
> > +     .attrs  = etm_config_sinks_attr,
> > +};
> > +
> >   static const struct attribute_group *etm_pmu_attr_groups[] = {
> >       &etm_pmu_format_group,
> > +     &etm_pmu_sinks_group,
> >       NULL,
> >   };
> >
> > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> >       return 0;
> >   }
> >
> > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > +                                    struct device_attribute *dattr,
> > +                                    char *buf)
> > +{
> > +     /* See function coresight_sink_by_id() to know where this is used */
> > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > +}
> > +
> > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > +{
> > +     struct device *pmu_dev = etm_pmu.dev;
> > +     struct device *pdev = csdev->dev.parent;
> > +     struct device_attribute *dev_attr;
> > +
> > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > +             return -EINVAL;
> > +
> > +     if (!etm_perf_up)
> > +             return -EPROBE_DEFER;
> > +
> > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > +     dev_attr->attr.mode = 0444;
> > +     dev_attr->show = etm_perf_sink_name_show;
>
> I would have  added the attribute to the csdev (say, sink_attr),
> and add that to the group, so that it is easier to remove the
> attribute when the sink device is removed from the system (when
> we get there). It would be good to have something in place to remove the
> attribute.

My hope was to avoid introducing a new field in the already bloated
coresight_device structure, and on top of things a component specific
field.  I think it would be worth it if we'd envision making the
coresight drivers removable in a not so distant future.  But doing
something like that is quite tricky (as Kim quickly found out) and
skirts the bottom of the list of priorities, if on it at all.

I'll change it if you're really keen on it but it would be code that
is never used.

Mathieu

>
> Otherwise, the overall approach looks fine to me.
>
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
