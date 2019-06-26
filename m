Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/2] net/smc: fixes 2019-06-26
Date: Wed, 26 Jun 2019 17:47:48 +0200
Message-Id: <20190626154750.46127-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com, zhp@smail.nju.edu.cn, yuehaibing@huawei.com

Dave,

here are 2 small smc fixes for the net tree.

Thanks, Ursula

Huaping Zhou (1):
  net/smc: hold conns_lock before calling smc_lgr_register_conn()

YueHaibing (1):
  net/smc: Fix error path in smc_init

 net/smc/af_smc.c   | 5 ++++-
 net/smc/smc_core.c | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.17.1
