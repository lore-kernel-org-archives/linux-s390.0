From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/1] af_iucv: Validate socket address length in iucv_sock_bind()
Date: Tue, 19 Jan 2016 10:41:32 +0100
Message-ID: <1453196493-57590-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: ubraunu@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

this patch fixes a problem reported by Dmitry Vyukov in december. It is built
and intended for the next-tree.

Thanks, Ursula

Ursula Braun (1):
  af_iucv: Validate socket address length in iucv_sock_bind()

 net/iucv/af_iucv.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.3.9
