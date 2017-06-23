From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/2] af_iucv updates
Date: Fri, 23 Jun 2017 19:32:26 +0200
Message-ID: <20170623173228.70128-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,
please apply two af_iucv patches for net-next.

Thanks,
Julian


Hans Wippel (1):
  net/iucv: improve endianness handling

Mateusz Jurczyk (1):
  af_iucv: Move sockaddr length checks to before accessing sa_family in
    bind and connect handlers

 net/iucv/af_iucv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.11.2
