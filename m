Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Thu, 29 Nov 2018 16:09:15 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
Message-ID: <20181129230915.GA8881@xps15>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129074936.GE12347@kroah.com>
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, acme@kernel.org, ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com, namhyung@kernel.org, tglx@linutronix.de, suzuki.poulosi@arm.com, jolsa@redhat.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Greg,

On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > This patch uses the PMU driver configuration held in event::hw::drv_config
> > to select a sink for each event that is created (the old sysFS way of
> > working is kept around for backward compatibility).
> 
> It is "sysfs", no InterCaps please, I've never called it that in the
> past.
> 
> And just use sysfs, if that does not work properly, then fix that, don't
> create yet-another-way-to-configure-this-thing to just confuse people.

Thanks for the review, you've provided usefull comments.

Regarding the "char *" argument for the ioctl, I followed an example that
currently exist but I can proceed differently.  

My goal with this patchset was specifically to fix what is wrong with sysfs and
completely take it out of the equation.  The only reason to keep the kernel 
interface alive was to prevent braking older user space perf tools currently
using it.  

I chose to use an ioctl() because it is flexible and well suited for the dynamic
nature of perf events.  It is also currently used to set various event specific 
configuration so doing the same adds to the established pattern and avoids
creating a new way of doing things, something the perf crew would have been
quick to point out.

Was my approach wrong?

Regards,
Mathieu

> 
> thanks,
> 
> greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
