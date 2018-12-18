Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
 <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
In-Reply-To: <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 18 Dec 2018 11:20:51 -0700
Message-ID: <CANLsYkwiQ6q9KTu7oK8gWiu2Rq+iVbRJnXxr5abZ1RSKgs1GyQ@mail.gmail.com>
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
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-s390@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, heiko.carstens@de.ibm.com, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, schwidefsky@de.ibm.com, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, suzuki.poulosi@arm.com, Jiri Olsa <jolsa@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Alex,

On Tue, 18 Dec 2018 at 08:21, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
>
> >> +    /*
> >> +     * The HW mapping of a component is unique.  If the value we've been
> >> +     * given matches the component's start address, then we must have found
> >> +     * the device we are looking for.
> >> +     */
> >
> > To be frank, I don't quite like the idea of passing the base address of the
> > component as the key to locate a device, (even though that is unique and readily
> > available). I would rather prefer a programmable way to map the keys to the
> > "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> > address is not obvious from the name). Also if we decide to use a platform
> > agnostic naming scheme, it becomes even more complex.
> >
> > We could assign a static "id/key" exported either via the device sysfs dir or
> > the "pmu" dir. I prefer the latter.
> >
> > Thoughts ?
>
> So, my understanding is that we have a bunch of trace sources and a
> bunch of trace sinks to choose from when we set up the perf event. The
> current model basically treats trace sources as PMUs and relies on the
> sink configuration process to be done via sysfs, which is not ideal as
> an API.

That is correct.  Most of the grief comes from the fact that when
tracing CPU-wide session sinks are concurrently used by more than one
CPU.

>
> The first thing that comes to mind is: can then the sinks be made their
> own PMUs, so the above can be done via the existing SET_OUTPUT ioctl?

I had a serious look at the SET_OUTPUT function as part of the
research that pre-dated implementing CPU-wide support for coresight.
The core does not allow events assigned to different CPUs to use the
same mmap'ed area, which is perfectly understandable.

To me the problem of sharing a sink between CPUs is inherent to
coresight and should be fixed within that framework (see full work
here [1] if interested).  The implementation associates a sink with an
mmap'ed area, just like PT and coresight --per-thread.  Where things
differ is that for coresight CPU-wide the sink is kept in function for
as long as a CPU is using it, ignoring other request for updates or to
switch it off.  So the first CPU to use it turns the sink on and the
last turns it off after collecting trace data from it.

Thanks,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/log/?h=cpu-wide-coresight

>
> Regards,
> --
> Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
