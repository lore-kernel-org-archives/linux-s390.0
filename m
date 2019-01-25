Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
Date: Fri, 25 Jan 2019 16:28:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 7/9] arm64: kdump: No need to mark crashkernel pages
 manually PG_reserved
Message-ID: <20190125162830.GK25901@arrakis.emea.arm.com>
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-8-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190114125903.24845-8-david@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: David Hildenbrand <david@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, CHANDAN VN <chandan.vn@samsung.com>, Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>, Stefan Agner <stefan@agner.ch>, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Laura Abbott <labbott@redhat.com>, Kristina Martsenko <kristina.martsenko@arm.com>, linux-m68k@lists.linux-m68k.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>, James Morse <james.morse@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Greg Hackmann <ghackmann@android.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 14, 2019 at 01:59:01PM +0100, David Hildenbrand wrote:
> The crashkernel is reserved via memblock_reserve(). memblock_free_all()
> will call free_low_memory_core_early(), which will go over all reserved
> memblocks, marking the pages as PG_reserved.
> 
> So manually marking pages as PG_reserved is not necessary, they are
> already in the desired state (otherwise they would have been handed over
> to the buddy as free pages and bad things would happen).
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Greg Hackmann <ghackmann@android.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: CHANDAN VN <chandan.vn@samsung.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
