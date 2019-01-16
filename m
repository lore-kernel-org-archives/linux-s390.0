Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <20190116153948.GC871@kroah.com>
 <CANLsYkzfbJae6Nk7cHhnR09ZPSATa3g8sceGC=O3DfXYC2ruQQ@mail.gmail.com>
 <20190116163314.GB5446@kroah.com>
 <CANLsYkw_=_OC-95HRMxTZfpAe4UzAuidPJcZmL_T-LbkOwWCkQ@mail.gmail.com>
 <20190116171259.GB10164@kroah.com>
In-Reply-To: <20190116171259.GB10164@kroah.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 10:30:16 -0700
Message-ID: <CANLsYkyFJx9gSfkMNmxT=bdas=sKFpZ0Cad42gm6nHoyq8FfnA@mail.gmail.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org, "Suzuki K. Poulose" <suzuki.poulose@arm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 Jan 2019 at 10:13, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 16, 2019 at 09:38:09AM -0700, Mathieu Poirier wrote:
> > On Wed, 16 Jan 2019 at 09:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 16, 2019 at 09:14:33AM -0700, Mathieu Poirier wrote:
> > > > On Wed, 16 Jan 2019 at 08:39, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> > > > > > Add a "sinks" directory entry so that users can see all the sinks
> > > > > > available in the system in a single place.  Individual sink are added
> > > > > > as they are registered with the coresight bus.
> > > > > >
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
> > > > > >  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
> > > > > >  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
> > > > > >  3 files changed, 61 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > index f21eb28b6782..292bd409a68c 100644
> > > > > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > > > > @@ -14,6 +14,7 @@
> > > > > >  #include <linux/perf_event.h>
> > > > > >  #include <linux/percpu-defs.h>
> > > > > >  #include <linux/slab.h>
> > > > > > +#include <linux/stringhash.h>
> > > > > >  #include <linux/types.h>
> > > > > >  #include <linux/workqueue.h>
> > > > > >
> > > > > > @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
> > > > > >       .attrs  = etm_config_formats_attr,
> > > > > >  };
> > > > > >
> > > > > > +static struct attribute *etm_config_sinks_attr[] = {
> > > > > > +     NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group etm_pmu_sinks_group = {
> > > > > > +     .name   = "sinks",
> > > > > > +     .attrs  = etm_config_sinks_attr,
> > > > > > +};
> > > > > > +
> > > > > >  static const struct attribute_group *etm_pmu_attr_groups[] = {
> > > > > >       &etm_pmu_format_group,
> > > > > > +     &etm_pmu_sinks_group,
> > > > > >       NULL,
> > > > > >  };
> > > > > >
> > > > > > @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > +static ssize_t etm_perf_sink_name_show(struct device *dev,
> > > > > > +                                    struct device_attribute *dattr,
> > > > > > +                                    char *buf)
> > > > > > +{
> > > > > > +     /* See function coresight_sink_by_id() to know where this is used */
> > > > > > +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> > > > > > +
> > > > > > +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> > > > > > +}
> > > > > > +
> > > > > > +int etm_perf_symlink_sink(struct coresight_device *csdev)
> > > > > > +{
> > > > > > +     struct device *pmu_dev = etm_pmu.dev;
> > > > > > +     struct device *pdev = csdev->dev.parent;
> > > > > > +     struct device_attribute *dev_attr;
> > > > > > +
> > > > > > +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> > > > > > +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     if (!etm_perf_up)
> > > > > > +             return -EPROBE_DEFER;
> > > > > > +
> > > > > > +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> > > > > > +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> > > > > > +     dev_attr->attr.mode = 0444;
> > > > > > +     dev_attr->show = etm_perf_sink_name_show;
> > > > > > +
> > > > > > +     return sysfs_add_file_to_group(&pmu_dev->kobj,
> > > > > > +                                    &dev_attr->attr, "sinks");
> > > > >
> > > > > What is so odd about this call that you needed me to review this?
> > > >
> > > > As far as I can tell nobody is feeding a dynamic struct attribute to
> > > > the function and I wasn't sure if it was because they were told not to
> > > > or simply because it wasn't needed, hence asking for a second opinion.
> > >
> > > Ah.  Well, again, this is a good question to answer:
> > >
> > > > > And what happens if this call fails, do you leak memory?
> >
> > That's something I will fix in the next revision.
> >
> > >
> > > And also, what happens when you unload the device, who frees the
> > > attribute's memory?
> >
> > If configured, coresight devices aren't removable.
>
> But is the driver able to be unloaded?  Unbound from the device manually
> through sysfs?  There's lots of ways devices are "removed" that don't
> involved physical removal :)

All drivers are built-in and thus preventing them from being unloaded.
They also have their ".suppress_bin_attrs" field set to take care of
unbinding through sysfs.

>
> thanks,
>
> greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
