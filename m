From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
Date: Mon, 14 Jan 2013 08:33:48 -0700
Message-ID: <1358177628.14145.49.camel@misato.fc.hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
	 <1357861230-29549-2-git-send-email-toshi.kani@hp.com>
	 <5036592.TuXAnGzk4M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <5036592.TuXAnGzk4M@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, jiang.liu@huawei.com, wency@cn.fujitsu.com, guohanjun@huawei.com, yinghai@kernel.org, srivatsa.bhat@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2013-01-11 at 22:23 +0100, Rafael J. Wysocki wrote:
> On Thursday, January 10, 2013 04:40:19 PM Toshi Kani wrote:
> > Added include/linux/sys_hotplug.h, which defines the system device
> > hotplug framework interfaces used by the framework itself and
> > handlers.
> > 
> > The order values define the calling sequence of handlers.  For add
> > execute, the ordering is ACPI->MEM->CPU.  Memory is onlined before
> > CPU so that threads on new CPUs can start using their local memory.
> > The ordering of the delete execute is symmetric to the add execute.
> > 
> > struct shp_request defines a hot-plug request information.  The
> > device resource information is managed with a list so that a single
> > request may target to multiple devices.
> > 
 :
> > +
> > +struct shp_device {
> > +	struct list_head	list;
> > +	struct device		*device;
> > +	enum shp_class		class;
> > +	union shp_dev_info	info;
> > +};
> > +
> > +/*
> > + * Hot-plug request
> > + */
> > +struct shp_request {
> > +	/* common info */
> > +	enum shp_operation	operation;	/* operation */
> > +
> > +	/* hot-plug event info: only valid for hot-plug operations */
> > +	void			*handle;	/* FW handle */
> 
> What's the role of handle here?

On ACPI-based platforms, the handle keeps a notified ACPI handle when a
hot-plug request is made.  ACPI bus handlers, acpi_add_execute() /
acpi_del_execute(), then scans / trims ACPI devices from the handle.

Thanks,
-Toshi

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
