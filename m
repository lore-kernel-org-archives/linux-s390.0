Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgIJKD5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Sep 2020 06:03:57 -0400
MIME-Version: 1.0
References: <20200910091340.8654-1-david@redhat.com> <20200910091340.8654-5-david@redhat.com>
In-Reply-To: <20200910091340.8654-5-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 10 Sep 2020 12:03:45 +0200
Message-ID: <CAM9Jb+j=8-Fpyg2fizM_3FenF649y2AKA8rsWaQzwCgX8Da7+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify
 merging of System RAM resources
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>

Looks good to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
