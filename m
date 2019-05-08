Return-Path: <SRS0=OmxZ=TI=kvack.org=owner-linux-mm@kernel.org>
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-9-david@redhat.com>
In-Reply-To: <20190507183804.5512-9-david@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 May 2019 17:30:15 -0700
Message-ID: <CAPcyv4hzpuApmKHhC6mHnE-RmiZ8Aspiv5wfd+Fs4QmaDsCJVw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] mm/memory_hotplug: Remove "zone" parameter from sparse_remove_one_section
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: David Hildenbrand <david@redhat.com>
Cc: Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 7, 2019 at 11:39 AM David Hildenbrand <david@redhat.com> wrote:
>
> Unused, and memory unplug path should never care about zones. This is
> the job of memory offlining. ZONE_DEVICE might require special care -
> the caller of arch_remove_memory() should handle this.

The ZONE_DEVICE usage does not require special care so you can drop
that comment. The only place it's used in the subsection patches is to
lookup the node-id, but it turns out that the resulting node-id is
then never used.

With the ZONE_DEVICE mention dropped out of changelog you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
