Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
In-Reply-To: <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
Date: Tue, 18 Dec 2018 17:21:47 +0200
Message-ID: <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
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
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, acme@kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, will.deacon@arm.com, adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>> +	/*
>> +	 * The HW mapping of a component is unique.  If the value we've been
>> +	 * given matches the component's start address, then we must have found
>> +	 * the device we are looking for.
>> +	 */
>
> To be frank, I don't quite like the idea of passing the base address of the
> component as the key to locate a device, (even though that is unique and readily
> available). I would rather prefer a programmable way to map the keys to the
> "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> address is not obvious from the name). Also if we decide to use a platform
> agnostic naming scheme, it becomes even more complex.
>
> We could assign a static "id/key" exported either via the device sysfs dir or
> the "pmu" dir. I prefer the latter.
>
> Thoughts ?

So, my understanding is that we have a bunch of trace sources and a
bunch of trace sinks to choose from when we set up the perf event. The
current model basically treats trace sources as PMUs and relies on the
sink configuration process to be done via sysfs, which is not ideal as
an API.

The first thing that comes to mind is: can then the sinks be made their
own PMUs, so the above can be done via the existing SET_OUTPUT ioctl?

Regards,
--
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
