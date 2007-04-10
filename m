Return-Path: <linux-kernel-owner+w=401wt.eu-S1030489AbXDJNLW@vger.kernel.org>
Date: Tue, 10 Apr 2007 15:13:37 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH (revised)] device_schedule_callback needs a module
 reference
Message-ID: <20070410151337.03a6596a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0704091104490.3561-100000@iolanthe.rowland.org>
References: <a781481a0704090752u27140ee8vc93bd344c5005549@mail.gmail.com>
	<Pine.LNX.4.44L0.0704091104490.3561-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Satyam Sharma <satyam.sharma@gmail.com>, Neil Brown <neilb@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 9 Apr 2007 11:07:22 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> This revised patch (as896b) fixes an oversight in the design of
> device_schedule_callback().  It is necessary to acquire a reference to
> the module owning the callback routine, to prevent the module from
> being unloaded before the callback can run.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

<snip>

> Index: usb-2.6/include/linux/device.h
> ===================================================================
> --- usb-2.6.orig/include/linux/device.h
> +++ usb-2.6/include/linux/device.h
> @@ -369,8 +369,14 @@ extern int __must_check device_create_bi
>  					       struct bin_attribute *attr);
>  extern void device_remove_bin_file(struct device *dev,
>  				   struct bin_attribute *attr);
> -extern int device_schedule_callback(struct device *dev,
> -		void (*func)(struct device *));
> +extern int device_schedule_callback_owner(struct device *dev,
> +		void (*func)(struct device *), struct module *owner);
> +
> +static inline int device_schedule_callback(struct device *dev,
> +		void (*func)(struct device *))
> +{
> +	return device_schedule_callback_owner(dev, func, THIS_MODULE);
> +}
> 
>  /* device resource management */
>  typedef void (*dr_release_t)(struct device *dev, void *res);

Whoops:

In file included from include/linux/interrupt.h:15,
                 from include/asm/hardirq.h:18,
                 from include/linux/hardirq.h:7,
                 from include/asm-generic/local.h:5,
                 from include/asm/local.h:1,
                 from include/linux/module.h:19,
                 from arch/s390/kernel/time.c:16:
include/linux/device.h: In function 'device_schedule_callback':
include/linux/device.h:374: error: 'THIS_MODULE' undeclared (first use in this function)
include/linux/device.h:374: error: (Each undeclared identifier is reported only once
include/linux/device.h:374: error: for each function it appears in.)

Maybe better move the implementation of device_schedule_callback() to
drivers/base/core.c? (Though I'm not sure why
include/asm-s390/hardirq.h includes linux/interrupt.h, and e.g.
include/asm-i386/hardirq.h doesn't.)
