Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190527111152.16324-1-david@redhat.com> <20190527111152.16324-2-david@redhat.com>
In-Reply-To: <20190527111152.16324-2-david@redhat.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 May 2019 13:53:50 -0400
Message-ID: <CA+CK2bBW4vH+J6bam1dOxjSwFwvoOEok0VNO0n_JjyHxpkGj+A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>, Arun KS <arunks@codeaurora.org>, Mathieu Malaterre <malat@debian.org>, Wei Yang <richardw.yang@linux.intel.com>

On Mon, May 27, 2019 at 7:12 AM David Hildenbrand <david@redhat.com> wrote:
>
> By converting start and size to page granularity, we actually ignore
> unaligned parts within a page instead of properly bailing out with an
> error.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
