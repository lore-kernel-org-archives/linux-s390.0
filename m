Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] s390: add const to bin_attribute structures
Date: Wed,  2 Aug 2017 21:37:21 +0530
Message-Id: <1501690043-7640-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: julia.lawall@lip6.fr, sebott@linux.vnet.ibm.com, oberpar@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Declare bin_attribute structures as const.

Bhumika Goyal (2):
  s390/sclp: add const to bin_attribute structure
  s390/cio: add const to bin_attribute structures

 drivers/s390/char/sclp_config.c | 2 +-
 drivers/s390/cio/chp.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
