Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Subject: [BUG] Regression introduced with "block: split bios to max possible
 length"
Message-ID: <56A0F1CA.4010303@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 15:57:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: keith.busch@intel.com, axboe@fb.com, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

unfortunately commit e36f62042880 "block: split bios to maxpossible length"
breaks the DASD driver on s390.  We expect the block requests to be multiple
of 4k in size. With the patch applied I see the requests split up in 
multiple
of 512 byte and therefore the requests get rejected and lots of I/Os fail.

Could you please fix or revert the patch?

We have following values set for the block queue:

hw_sector_size         4096
logical_block_size     4096
minimum_io_size        4096
physical_block_size    4096
max_hw_sectors_kb       760
max_sectors_kb          760
max_segment_size       4096
max_segments          65535

Regards,
Stefan
