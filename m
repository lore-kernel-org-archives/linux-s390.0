Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] s390/qeth: fixes 2020-02-20
Date: Thu, 20 Feb 2020 15:54:53 +0100
Message-Id: <20200220145456.11571-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave,

please apply the following patch series for qeth to netdev's net tree.

This corrects three minor issues:
1) return a more fitting errno when VNICC cmds are not supported,
2) remove a bogus WARN in the NAPI code, and
3) be _very_ pedantic about the RX copybreak.

Thanks,
Julian

Alexandra Winter (1):
  s390/qeth: vnicc Fix EOPNOTSUPP precedence

Julian Wiedmann (2):
  s390/qeth: don't warn for napi with 0 budget
  s390/qeth: fix off-by-one in RX copybreak check

 drivers/s390/net/qeth_core_main.c |  3 +--
 drivers/s390/net/qeth_l2_main.c   | 29 +++++++++++++----------------
 2 files changed, 14 insertions(+), 18 deletions(-)

-- 
2.17.1
