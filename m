Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Aug 2011 13:15:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v3 2/8] kdump: Make kimage_load_crash_segment() weak
Message-ID: <20110818171541.GC15413@redhat.com>
References: <20110812134849.748973593@linux.vnet.ibm.com>
 <20110812134907.166585439@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110812134907.166585439@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Aug 12, 2011 at 03:48:51PM +0200, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> On s390 we do not create page tables at all for the crashkernel memory.
> This requires a s390 specific version for kimage_load_crash_segment().
> Therefore this patch declares this function as "__weak". The s390 version is
> very simple. It just copies the kexec segment to real memory without using
> page tables:
> 
> int kimage_load_crash_segment(struct kimage *image,
>                               struct kexec_segment *segment)
> {
>         return copy_from_user_real((void *) segment->mem, segment->buf,
>                                    segment->bufsz);
> }
> 
> There are two main advantages of not creating page tables for the
> crashkernel memory:
> 
> a) It saves memory. We have scenarios in mind, where crashkernel
>    memory can be very large and saving page table space is important.
> b) We protect the crashkernel memory from being overwritten.

Michael,

Thinking more about it. Can't we provide a arch specific version of
kmap() and kunmap() so that we create temporary mappings to copy
the pages and then these are torn off. That way you don't waste space
as well you don't have the risk of overwritting the loaded kernel.

Exporting the knowledge of generic kexec segments to arch code sounds
like little odd choice.

Thanks
Vivek
