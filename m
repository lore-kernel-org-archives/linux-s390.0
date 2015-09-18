Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Sep 2015 13:17:50 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] s390/crash_dump: Use for_each_mem_range
Message-ID: <20150918111750.GA3986@osiris>
References: <1442343264-10583-1-git-send-email-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442343264-10583-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 16, 2015 at 12:54:24AM +0600, Alexander Kuleshov wrote:
> The <linux/memblock.h> already provides for_each_mem_range() macro that
> iterates through memblock areas from type_a and not included in type_b.
> We can remove custom for_each_dump_mem_range() macro and use the
> for_each_mem_range() instead.
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  arch/s390/kernel/crash_dump.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Applied, thanks.
