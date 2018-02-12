From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
Date: Mon, 12 Feb 2018 08:27:27 +0100
Message-ID: <20180212072727.saupl35jvwex6hbe@gmail.com>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org, X86 ML <x86@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, virtualization@lists.linux-foundation.org, John Johansen <john.johansen@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-s390.vger.kernel.org>


* Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
> reason. It looks like it's only a convenience, so remove kmemleak.h
> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
> that don't already #include it.
> Also remove <linux/kmemleak.h> from source files that do not use it.
> 
> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
> would be good to run it through the 0day bot for other $ARCHes.
> I have neither the horsepower nor the storage space for the other
> $ARCHes.
> 
> [slab.h is the second most used header file after module.h; kernel.h
> is right there with slab.h. There could be some minor error in the
> counting due to some #includes having comments after them and I
> didn't combine all of those.]
> 
> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
> header files).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Nice find:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

I agree that it needs to go through 0-day to find any hidden dependencies we might 
have grown due to this.

Thanks,

	Ingo
