From: frank.blaschka@de.ibm.com
Subject: [patch 0/2] s390: network bug fixes for net [v2]
Date: Mon, 08 Apr 2013 10:19:25 +0200
Message-ID: <20130408081925.995757091@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are the fixes for net again, including
feedback from Eric (Thx!)

shortlog:

Ursula Braun (1)
af_iucv: fix recvmsg by replacing skb_pull() function

Stefan Raspl (1)
qeth: fix qeth_wait_for_threads() deadlock for OSN devices

Thanks,
        Frank
