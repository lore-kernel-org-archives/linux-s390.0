Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 24 Jul 2018 08:50:13 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH 0/5] Do not request a pointer kaddr when not required
Message-ID: <20180724145013.GA19466@linux.intel.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Huaisheng Ye <yehs2007@zoho.com>
Cc: linux-nvdimm@lists.01.org, dan.j.williams@intel.com, ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 24, 2018 at 04:45:05PM +0800, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Some functions within fs/dax and dax/super don't need to get kaddr from
> direct_access. Assigning NULL to kaddr to ->direct_access() is more
> straightforward and simple than offering a useless local pointer.
> 
> So all direct_access() need to check the validity of second rank pointer
> kaddr for NULL assignment. If kaddr equals to NULL, it doesn't need to
> calculate its value.
> 
> * This series are supplement to [PATCH v2 00/14]mm: Asynchronous +
>   multithreaded memmap init for ZONE_DEVICE. [1]
> 
> [1]: https://lkml.org/lkml/2018/7/16/828

This whole series looks good to me.  Just a few comments:

1) Does this series actually depend on the "Asynchronous multithreaded mmap
init for ZONE_DEVICE" series from Dan?  It seems totally independent to me?
I reviewed yours by applying to linux/master, which worked fine.  I ask
because Dan's series has been delayed to after v4.19, and if yours isn't
actually dependent it could possibly go in sooner.

2) I agree with Christian's comment that the changelogs could be improved
slightly.  Remember that the goal of the changelog isn't to describe *what*
the code is doing, but *why*.  We can read that the code now checks if 'kaddr'
is NULL, and if so we don't calculate it.  It's useful to say that callers may
have no need for 'kaddr', so this patch is prep for allowing them to pass in
NULL instead of having to pass in a pointer that they then just throw away.

3) I think you should make one more change to kill the unused 'dummy_addr'
variable in persistent_memory_claim().  That was the one last case of a dummy
'kaddr' type variable that I could find.
