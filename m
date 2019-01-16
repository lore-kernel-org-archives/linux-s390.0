Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-4-mathieu.poirier@linaro.org>
 <b688e813-a3a3-011a-a0b1-0eeeffe8816d@arm.com>
In-Reply-To: <b688e813-a3a3-011a-a0b1-0eeeffe8816d@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 16 Jan 2019 16:57:32 -0700
Message-ID: <CANLsYkwgn0aEbAAyTvL8f=M4Y9=04Dsxs-VqaEh64Hc8UKY-pw@mail.gmail.com>
Subject: Re: [PATCH 3/7] coresight: Use event attributes for sink selection
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

On Wed, 16 Jan 2019 at 03:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mathieu,
>
> On 15/01/2019 23:07, Mathieu Poirier wrote:
> > This patch uses the information conveyed by perf_event::attr::config2
> > to select a sink to use for the session.  That way a sink can easily be
> > selected to be used by more than one source, something that isn't currently
> > possible with the sysfs implementation.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++------
> >   drivers/hwtracing/coresight/coresight-priv.h  |  1 +
> >   drivers/hwtracing/coresight/coresight.c       | 39 +++++++++++++++++++
> >   3 files changed, 44 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index 292bd409a68c..685d16001d0b 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -201,18 +201,10 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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
> > +     /* First get the selected sink from user space. */
> > +     sink = coresight_get_sink_by_id(event->attr.config2);
>
> Please could we also expose this information under "format", so that the
> userspace knows where to fill in the sink id ? The other advantage is, we
> could always change the size of the sink_id with the above, if we decide
> to do something different with the sinks.

Humm...  From my point of view we don't want user space to do anything
with the sink ID other than read it.  In what  scenario do envison
user space filling the sink ID?

>
> And also, I think this should be :
>
>         if (event->attr.config2) {
>                 sink = coresight_get_sink_by_id(event->attr.config2)
>                 if (!sink)
>                         return -ENODEV;
>         } else {
>                 sink = coresight_get_enabled_sink(true);
>         }
> So that we don't fallback to an enabled sink when a sink id is explicitly
> specified ?

The code in user space refuses to go forward if an invalid sink has
been specified but enforcing the same in kernel space is a good idea.
I'll heed your advice.

>
> > +     if (!sink)
> > +             sink = coresight_get_enabled_sink(true);
> >       if (!sink || !sink_ops(sink)->alloc_buffer)
> >               goto err;
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > index 579f34943bf1..071bb98d358f 100644
> > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > @@ -147,6 +147,7 @@ void coresight_disable_path(struct list_head *path);
> >   int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
> >   struct coresight_device *coresight_get_sink(struct list_head *path);
> >   struct coresight_device *coresight_get_enabled_sink(bool reset);
> > +struct coresight_device *coresight_get_sink_by_id(u64 id);
> >   struct list_head *coresight_build_path(struct coresight_device *csdev,
> >                                      struct coresight_device *sink);
> >   void coresight_release_path(struct list_head *path);
> > diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> > index 526f122a38ee..7e2ce0beb2a0 100644
> > --- a/drivers/hwtracing/coresight/coresight.c
> > +++ b/drivers/hwtracing/coresight/coresight.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/err.h>
> >   #include <linux/export.h>
> >   #include <linux/slab.h>
> > +#include <linux/stringhash.h>
> >   #include <linux/mutex.h>
> >   #include <linux/clk.h>
> >   #include <linux/coresight.h>
> > @@ -541,6 +542,44 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
> >       return dev ? to_coresight_device(dev) : NULL;
> >   }
> >
> > +static int coresight_sink_by_id(struct device *dev, void *data)
> > +{
> > +     struct coresight_device *csdev = to_coresight_device(dev);
> > +     unsigned long hash;
> > +
> > +     if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> > +          csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
> > +             /*
> > +              * See function etm_perf_sink_name_show() to know where this
> > +              * comes from.
> > +              */
> > +             hash = hashlen_hash(hashlen_string(NULL, dev_name(dev)));
> > +
> > +             if (hash == (*(unsigned long *)data))
> > +                     return 1;
>
> nit: is it worth storing the sink_id of a sink in the csdev ? May be if we add
> attribute field to the csdev (as mentioned in the previous patch), we could
> simply use it here to compare.

That depends on what we end up doing in the previous patch (see my
comment).  Since we are not even close to modularize coresight drivers
(unless you're already spending your weekends working on that,
something I doubt very much :o) ) I don't think we need to go this
way.  Again, let me know if you really want me to change this.

Thank you for your time,
Mathieu

>
> Rest looks fine to me.
>
> Cheers
> Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
