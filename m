Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng Ye <yehs2007@zoho.com>
Subject: [PATCH 0/5] Do not request a pointer kaddr when not required
Date: Tue, 24 Jul 2018 16:45:05 +0800
Message-Id: <20180724084510.6104-1-yehs2007@zoho.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within fs/dax and dax/super don't need to get kaddr from
direct_access. Assigning NULL to kaddr to ->direct_access() is more
straightforward and simple than offering a useless local pointer.

So all direct_access() need to check the validity of second rank pointer
kaddr for NULL assignment. If kaddr equals to NULL, it doesn't need to
calculate its value.

* This series are supplement to [PATCH v2 00/14]mm: Asynchronous +
  multithreaded memmap init for ZONE_DEVICE. [1]

[1]: https://lkml.org/lkml/2018/7/16/828

Huaisheng Ye (5):
  libnvdimm, pmem: Allow a NULL-kaddr to ->direct_access()
  tools/testing/nvdimm: Allow a NULL-kaddr to ->direct_access()
  s390, dcssblk: Allow a NULL-kaddr to ->direct_access()
  filesystem-dax: Do not request a pointer kaddr when not required
  dax/super: Do not request a pointer kaddr when not required

 drivers/dax/super.c             | 3 +--
 drivers/nvdimm/pmem.c           | 4 +++-
 drivers/s390/block/dcssblk.c    | 3 ++-
 fs/dax.c                        | 3 +--
 tools/testing/nvdimm/pmem-dax.c | 6 ++++--
 5 files changed, 11 insertions(+), 8 deletions(-)

-- 
1.8.3.1
