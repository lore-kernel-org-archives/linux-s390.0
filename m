Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Problems with phys_to_pfn_t in linux-next and s390
Message-ID: <567B8929.1060207@roeck-us.net>
Date: Wed, 23 Dec 2015 21:56:57 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

s390:defconfig:

ERROR: "phys_to_pfn_t" [drivers/s390/block/dcssblk.ko] undefined!

s390 does not set CONFIG_HAS_IOMEM, which is required for phys_to_pfn_t to exist.

Introduced with commit e014f77c4b ("mm-dax-pmem-introduce-pfn_t-v3") and
possibly earlier.

Guenter
