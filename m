Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35340 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgD2QmA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Apr 2020 12:42:00 -0400
Date: Wed, 29 Apr 2020 16:41:55 +0000
From: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v1 1/3] mm/memory_hotplug: Prepare passing flags to
 add_memory() and friends
Message-ID: <20200429164154.ctflq4ouwrwwe4wq@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200429160803.109056-1-david@redhat.com>
 <20200429160803.109056-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429160803.109056-2-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Pingfan Liu <kernelfans@gmail.com>, Leonardo Bras <leobras.c@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Eric Biederman <ebiederm@xmission.com>

On Wed, Apr 29, 2020 at 06:08:01PM +0200, David Hildenbrand wrote:
> We soon want to pass flags - prepare for that.
> 
> This patch is based on a similar patch by Oscar Salvador:
> 
> https://lkml.kernel.org/r/20190625075227.15193-3-osalvador@suse.de
> 
[...]
> ---
>  drivers/hv/hv_balloon.c                         |  2 +-

> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..0194bed1a573 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  
>  		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT));
> +				(HA_CHUNK << PAGE_SHIFT), 0);
>  
>  		if (ret) {
>  			pr_err("hot_add memory failed error is %d\n", ret);

Acked-by: Wei Liu <wei.liu@kernel.org>
