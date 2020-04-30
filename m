Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:31780 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgD3QE0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:26 -0400
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org>
 <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <c905918d-54f6-0f17-ca5b-cd3371ada788@intel.com>
Date: Thu, 30 Apr 2020 09:04:23 -0700
MIME-Version: 1.0
In-Reply-To: <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

On 4/30/20 8:52 AM, David Hildenbrand wrote:
>> Justifying behavior by documentation that does not consider memory
>> hotplug is bad thinking.
> Are you maybe confusing this patch series with the arm64 approach? This
> is not about ordinary hotplugged DIMMs.
> 
> I'd love to get Dan's, Dave's and Michal's opinion.

The impact on kexec from the DAX "kmem" driver's use of hotplug was
inadvertent and unfortunate.

The problem statement and solution seem pretty sane to me.
