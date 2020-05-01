Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 1 May 2020 15:09:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
Message-Id: <20200501150947.367ca6b38a394f1ff678ed4b@linux-foundation.org>
In-Reply-To: <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
References: <20200414131348.444715-1-hch@lst.de>
        <20200414131348.444715-22-hch@lst.de>
        <20200414151344.zgt2pnq7cjq2bgv6@debian>
        <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
        <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: John Dorminy <jdorminy@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>, Christoph Hellwig <hch@lst.de>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, bpf@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>, Gao Xiang <xiang@kernel.org>

On Thu, 30 Apr 2020 22:38:10 -0400 John Dorminy <jdorminy@redhat.com> wrote:

> the change
> description refers to PROT_KERNEL, which is a symbol which does not
> appear to exist; perhaps PAGE_KERNEL was meant?

Yes, thanks, fixed.
