From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/3] net/iucv: fixes 2018-09-05
Date: Wed,  5 Sep 2018 16:55:09 +0200
Message-ID: <20180905145512.30165-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply three straight-forward fixes for iucv. One that prevents
leaking the skb on malformed inbound packets, one to fix the error
handling on transmit error, and one to get rid of a compile warning.

Thanks,
Julian


Julian Wiedmann (3):
  net/af_iucv: drop inbound packets with invalid flags
  net/af_iucv: fix skb handling on HiperTransport xmit error
  net/iucv: declare iucv_path_table_empty() as static

 net/iucv/af_iucv.c | 38 +++++++++++++++++++++++++-------------
 net/iucv/iucv.c    |  2 +-
 2 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.16.4
