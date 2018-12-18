Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
In-Reply-To: <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 18 Dec 2018 10:34:47 -0700
Message-ID: <CANLsYkyvq-K1M7jZ=rOEcGBySTktV_c7D4S2jBV_nS3cj8a8wg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, suzuki.poulosi@arm.com, Jiri Olsa <jolsa@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Good day Suzuki,

On Tue, 18 Dec 2018 at 07:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 17/12/2018 17:21, Mathieu Poirier wrote:
> > This patch uses the PMU driver configuration held in event::hw::drv_config
> > to select a sink for each event that is created (the old sysFS way of
> > working is kept around for backward compatibility).
> >
> > By proceeding in this way a sink can be used by multiple sessions
> > without having to play games with entries in sysFS.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c | 74 ++++++++++++++++++++----
> >   1 file changed, 62 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index f21eb28b6782..a7e1fdef07f2 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -4,6 +4,7 @@
> >    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
> >    */
> >
> > +#include <linux/amba/bus.h>
> >   #include <linux/coresight.h>
> >   #include <linux/coresight-pmu.h>
> >   #include <linux/cpumask.h>
> > @@ -11,6 +12,7 @@
> >   #include <linux/list.h>
> >   #include <linux/mm.h>
> >   #include <linux/init.h>
> > +#include <linux/ioport.h>
> >   #include <linux/perf_event.h>
> >   #include <linux/percpu-defs.h>
> >   #include <linux/slab.h>
> > @@ -177,6 +179,26 @@ static void etm_free_aux(void *data)
> >       schedule_work(&event_data->work);
> >   }
> >
> > +static struct coresight_device *etm_drv_config_sync(struct perf_event *event)
>
> minor nit: The name doesn't quite imply what we do here. Did you mean
> s/sync/sink ?
>

I chose "sync" with "synchronisation" in mind.  I tried to keep things
generic since we could potentially use the same interface to convey
complex PMU configuration.  Arguably we could go with "sink" for now
and change it to "sync" in the future - I'm not strongly opinionated
on that part.

> > +{
> > +     struct coresight_device *sink = NULL;
> > +     struct pmu_drv_config *drv_config = perf_event_get_drv_config(event);
> > +
> > +     /*
> > +      * Make sure we don't race with perf_drv_config_replace() in
> > +      * kernel/events/core.c.
> > +      */
> > +     raw_spin_lock(&drv_config->lock);
> > +
> > +     /* Copy what we got from user space if applicable. */
> > +     if (drv_config->config)
> > +             sink = drv_config->config;
> > +
> > +     raw_spin_unlock(&drv_config->lock);
> > +
> > +     return sink;
> > +}
> > +
> >   static void *etm_setup_aux(struct perf_event *event, void **pages,
> >                          int nr_pages, bool overwrite)
> >   {
> > @@ -190,18 +212,11 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >               return NULL;
> >       INIT_WORK(&event_data->work, free_event_data);
> >
> > -     /*
> > -      * In theory nothing prevent tracers in a trace session from being
> > -      * associated with different sinks, nor having a sink per tracer.  But
> > -      * until we have HW with this kind of topology we need to assume tracers
> > -      * in a trace session are using the same sink.  Therefore go through
> > -      * the coresight bus and pick the first enabled sink.
> > -      *
> > -      * When operated from sysFS users are responsible to enable the sink
> > -      * while from perf, the perf tools will do it based on the choice made
> > -      * on the cmd line.  As such the "enable_sink" flag in sysFS is reset.
> > -      */
> > -     sink = coresight_get_enabled_sink(true);
> > +     /* First get the sink config from user space. */
> > +     sink = etm_drv_config_sync(event);
> > +     if (!sink)
> > +             sink = coresight_get_enabled_sink(true);
> > +
> >       if (!sink || !sink_ops(sink)->alloc_buffer)
> >               goto err;
> >
> > @@ -454,6 +469,40 @@ static void etm_addr_filters_sync(struct perf_event *event)
> >       filters->nr_filters = i;
> >   }
> >
> > +static int etm_drv_config_find_sink(struct device *dev, void *data)
> > +{
> > +     struct amba_device *adev = to_amba_device(dev->parent);
> > +     struct resource *res = &adev->res;
> > +     u64 value = *((u64 *)data);
> > +
> > +     /*
> > +      * The HW mapping of a component is unique.  If the value we've been
> > +      * given matches the component's start address, then we must have found
> > +      * the device we are looking for.
> > +      */
>
> To be frank, I don't quite like the idea of passing the base address of the
> component as the key to locate a device, (even though that is unique and readily
> available). I would rather prefer a programmable way to map the keys to the
> "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> address is not obvious from the name). Also if we decide to use a platform
> agnostic naming scheme, it becomes even more complex.

This mechanism doesn't rely on the naming scheme - it exploits the
"resource" interface exported for each amba device [1].  As such
whether the component is discovered using ACPI or DT, we end up on the
same amba bus and using the same interface.

[1]. https://elixir.bootlin.com/linux/latest/source/drivers/amba/bus.c#L128

>
> We could assign a static "id/key" exported either via the device sysfs dir or
> the "pmu" dir. I prefer the latter.

Not sure what you mean by "pmu" directory - would you mind expanding
on that?  Using sysfs would be quite easy but I am reluctant to create
a new id/key mechanism and introduce another entry when we have the
component address that is unique and already available in the amba
directory structure.

Thanks for taking a look,
Mathieu

>
> Thoughts ?
>
> And whatever we decide to choose, needs to be clearly documented under the
> Documentation/perf/cs_etm.txt.
>
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
