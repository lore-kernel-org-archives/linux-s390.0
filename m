Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbgIOHhW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Sep 2020 03:37:22 -0400
Subject: Re: [PATCH v2 2/7] kernel/resource: move and rename
 IORESOURCE_MEM_DRIVER_MANAGED
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-3-david@redhat.com>
 <20200915022023.GD2007@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b4eced44-00af-fcd2-be0d-d7abf8a2cc99@redhat.com>
Date: Tue, 15 Sep 2020 09:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200915022023.GD2007@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org

On 15.09.20 04:20, Wei Yang wrote:
> On Tue, Sep 08, 2020 at 10:10:07PM +0200, David Hildenbrand wrote:
>> IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
>> always set to 0 by hardware. This is far from beautiful (and confusing),
>> and the bit only applies to SYSRAM. So let's move it out of the
>> bus-specific (PnP) defined bits.
>>
>> We'll add another SYSRAM specific bit soon. If we ever need more bits for
>> other purposes, we can steal some from "desc", or reshuffle/regroup what we
>> have.
> 
> I think you make this definition because we use IORESOURCE_SYSRAM_RAM for
> hotpluged memory? So we make them all in IORESOURCE_SYSRAM_XXX family?

Yeah, to specify based on the extended MEM type SYSRAM. Because it
really only applies to that.

-- 
Thanks,

David / dhildenb
