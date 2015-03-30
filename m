From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/1] af_iucv: fix AF_IUCV sendmsg() errno
Date: Mon, 30 Mar 2015 15:40:41 +0200
Message-ID: <1427722842-49894-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

here is a small patch for net fixing a bug in s390 net/iucv/af_iucv.c

shortlog:

Eugene Crosser (1):
  af_iucv: fix AF_IUCV sendmsg() errno

Thanks,
       Ursula
