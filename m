Return-Path: <linux-kernel-owner+w=401wt.eu-S1030636AbXDJWcx@vger.kernel.org>
Date: Tue, 10 Apr 2007 15:32:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH (revised)] device_schedule_callback needs a module
 reference
Message-Id: <20070410153208.ad523206.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704101141110.3614-100000@iolanthe.rowland.org>
References: <20070410151337.03a6596a@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0704101141110.3614-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Satyam Sharma <satyam.sharma@gmail.com>, Neil Brown <neilb@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 10 Apr 2007 12:46:11 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Tue, 10 Apr 2007, Cornelia Huck wrote:
> 
> > Whoops:
> > 
> > In file included from include/linux/interrupt.h:15,
> >                  from include/asm/hardirq.h:18,
> >                  from include/linux/hardirq.h:7,
> >                  from include/asm-generic/local.h:5,
> >                  from include/asm/local.h:1,
> >                  from include/linux/module.h:19,
> >                  from arch/s390/kernel/time.c:16:
> > include/linux/device.h: In function 'device_schedule_callback':
> > include/linux/device.h:374: error: 'THIS_MODULE' undeclared (first use in this function)
> > include/linux/device.h:374: error: (Each undeclared identifier is reported only once
> > include/linux/device.h:374: error: for each function it appears in.)
> > 
> > Maybe better move the implementation of device_schedule_callback() to
> > drivers/base/core.c? (Though I'm not sure why
> > include/asm-s390/hardirq.h includes linux/interrupt.h, and e.g.
> > include/asm-i386/hardirq.h doesn't.)
> 
> I don't think moving device_schedule_callback() is the answer.  For one 
> thing, the implementation _has_ to be compiled in the calling module so 
> that THIS_MODULE will have the correct value.  If it were compiled in 
> drivers/base/core.c then it wouldn't refer to the caller's module.
> 
> The real problem is bad nesting of #includes.  Maybe changing 
> include/asm-s390/hardirq.h not to include linux/interrupt.h will be 
> feasible.
> 
> Or perhaps it would be better to move the definition of THIS_MODULE in
> linux/module.h up before all the #include lines, since it seems reasonable
> that a file indirectly included by module.h might need to use THIS_MODULE.
> 

<holds nose>


--- a/include/linux/device.h~device_schedule_callback-needs-a-module-reference-fix
+++ a/include/linux/device.h
@@ -369,11 +369,9 @@ extern void device_remove_bin_file(struc
 extern int device_schedule_callback_owner(struct device *dev,
 		void (*func)(struct device *), struct module *owner);
 
-static inline int device_schedule_callback(struct device *dev,
-		void (*func)(struct device *))
-{
-	return device_schedule_callback_owner(dev, func, THIS_MODULE);
-}
+/* This is a macro to avoid include problems with THIS_MODULE */
+#define device_schedule_callback(dev, func)			\
+	device_schedule_callback_owner(dev, func, THIS_MODULE)
 
 /* device resource management */
 typedef void (*dr_release_t)(struct device *dev, void *res);
_
