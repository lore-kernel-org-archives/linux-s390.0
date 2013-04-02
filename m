From: frank.blaschka@de.ibm.com
Subject: [patch 0/2] s390: network bug fixes for net
Date: Tue, 02 Apr 2013 12:56:50 +0200
Message-ID: <20130402105650.056630101@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are 2 bug fixes for net.

shortlog:

Hendrik Brueckner (1)
af_iucv: recvmsg: use correct skb_pull() function

Stefan Raspl (1)
qeth: fix qeth_wait_for_threads() deadlock for OSN devices

Thanks,
        Frank
