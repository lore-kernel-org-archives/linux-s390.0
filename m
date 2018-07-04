Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng Ye <yehs2007@zoho.com>
Subject: [PATCH v2 0/4] Assigning NULL to gfn of dax_direct_access if useless
Date: Thu,  5 Jul 2018 00:38:19 +0800
Message-Id: <20180704163823.9980-1-yehs2007@zoho.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc: ross.zwisler@linux.intel.com, willy@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk, martin.petersen@oracle.com, axboe@kernel.dk, gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, colyli@suse.de, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-ID: <linux-s390.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Changes since v1 [1]:
* Collect Jan's reviewed-by.
* According to Dan's suggestion, update the unit test infrastructure
  tools/testing/nvdimm/pmem-dax.c for checking the validity of gfn.

[1]: https://lkml.org/lkml/2018/7/4/81

---

Some functions within fs/dax don't need to get gfn from direct_access.
Assigning NULL to gfn of dax_direct_access is more intuitive and simple
than offering a useless local variable.

So all direct_access need to check the validity of pointer pfn for NULL
assignment. If pfn equals to NULL, it doesn't need to calculate its value.

---

Huaisheng Ye (4):
  nvdimm/pmem: check the validity of the pointer pfn
  nvdimm/pmem-dax: check the validity of the pointer pfn
  s390/block/dcssblk: check the validity of the pointer pfn
  fs/dax: Assign NULL to gfn of dax_direct_access if useless

 drivers/nvdimm/pmem.c           | 3 ++-
 drivers/s390/block/dcssblk.c    | 3 ++-
 fs/dax.c                        | 9 +++------
 tools/testing/nvdimm/pmem-dax.c | 6 ++++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
1.8.3.1
