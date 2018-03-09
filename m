Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 00/12] s390/qeth: updates 2018-03-09
Date: Fri,  9 Mar 2018 18:12:51 +0100
Message-Id: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here is the current pile of qeth patches for net-next. Just the usual
small updates and clean ups. Please apply.

Thanks,
Julian


Julian Wiedmann (12):
  s390/qeth: use __ipa_cmd() for casting an IPA cmd buffer
  s390/qeth: remove outdated portname debug msg
  s390/qeth: support SG for more device types
  s390/qeth: advertise IFF_UNICAST_FLT
  s390/qeth: pass correct length to header_ops->create()
  s390/qeth: allocate skb from NAPI cache
  s390/qeth: reduce RX skb setup
  s390/qeth: reset NAPI context during queue init
  s390/qeth: restructure IP notification handlers
  s390/qeth: simplify card look-up on IP notification
  s390/qeth: extract helpers for managing special IPs
  s390/qeth: shrink qeth_ipaddr struct

 drivers/s390/net/qeth_core.h      |   8 -
 drivers/s390/net/qeth_core_main.c |  40 ++--
 drivers/s390/net/qeth_l2_main.c   |  34 ++--
 drivers/s390/net/qeth_l3.h        |  34 ++--
 drivers/s390/net/qeth_l3_main.c   | 419 ++++++++++++--------------------------
 drivers/s390/net/qeth_l3_sys.c    |  51 ++---
 6 files changed, 198 insertions(+), 388 deletions(-)

-- 
2.13.5
