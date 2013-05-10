Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 10 May 2013 13:40:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 next/akpm] aio: convert the ioctx list to radix tree
Message-Id: <20130510134015.ac8ad56305c539fa9bd8b5a7@linux-foundation.org>
In-Reply-To: <1366026055-28604-1-git-send-email-octavian.purdila@intel.com>
References: <1366026055-28604-1-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org, linux-s390@vger.kernel.org, koverstreet@google.com, bcrl@kvack.org, schwidefsky@de.ibm.com, kirill.shutemov@linux.intel.com, zab@redhat.com, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Apr 2013 14:40:55 +0300 Octavian Purdila <octavian.purdila@intel.com> wrote:

> When using a large number of threads performing AIO operations the
> IOCTX list may get a significant number of entries which will cause
> significant overhead. For example, when running this fio script:
> 
> rw=randrw; size=256k ;directory=/mnt/fio; ioengine=libaio; iodepth=1
> blocksize=1024; numjobs=512; thread; loops=100
> 
> on an EXT2 filesystem mounted on top of a ramdisk we can observe up to
> 30% CPU time spent by lookup_ioctx:
> 
>  32.51%  [guest.kernel]  [g] lookup_ioctx
>   9.19%  [guest.kernel]  [g] __lock_acquire.isra.28
>   4.40%  [guest.kernel]  [g] lock_release
>   4.19%  [guest.kernel]  [g] sched_clock_local
>   3.86%  [guest.kernel]  [g] local_clock
>   3.68%  [guest.kernel]  [g] native_sched_clock
>   3.08%  [guest.kernel]  [g] sched_clock_cpu
>   2.64%  [guest.kernel]  [g] lock_release_holdtime.part.11
>   2.60%  [guest.kernel]  [g] memcpy
>   2.33%  [guest.kernel]  [g] lock_acquired
>   2.25%  [guest.kernel]  [g] lock_acquire
>   1.84%  [guest.kernel]  [g] do_io_submit
> 
> This patchs converts the ioctx list to a radix tree.

The patch looks nice.  One thing we should pay attention to is the
memory consumption.  radix-trees can be far less space-efficient than
lists, and as the tree key comes from mmap() it can be pretty sparsely
distributed.

So could you please have a think about this, see if we can cook up some
worst-case numbers and decide if they are problematic?
