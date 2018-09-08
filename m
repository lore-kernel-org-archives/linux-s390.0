Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 0/2] s390: Use ARRAY_SIZE instead of reimplementing its function
Date: Sat, 8 Sep 2018 18:26:26 +0800
Message-ID: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jwi@linux.ibm.com, ubraun@linux.ibm.com, jdelvare@suse.de
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I find the issue with the help of Coccinelle.

zhong jiang (2):
  s390: vmlogrdr: Use ARRAY_SIZE instead of reimplementing its function
  s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its
    function

 drivers/s390/char/vmlogrdr.c     | 2 +-
 drivers/s390/net/qeth_core_mpc.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
1.7.12.4
