From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/2] TCP experimental option for SMC rendezvous
Date: Mon, 16 Oct 2017 17:42:00 +0200
Message-ID: <20171016154202.72635-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

SMC-capability is to be negotiated with a TCP experimental option.
As requested during code review of our previous approach using
netfilter hooks, here's a new version. It touches tcp-code in the
first patch and exploits the new tcp flag in the smc-code.

Kind regards, Ursula

Ursula Braun (2):
  tcp: TCP experimental option for SMC
  smc: add SMC rendezvous protocol

 include/linux/tcp.h      |  9 ++++--
 include/net/inet_sock.h  |  3 +-
 include/net/tcp.h        |  8 ++++++
 net/ipv4/tcp.c           |  6 ++++
 net/ipv4/tcp_input.c     | 45 ++++++++++++++++++++++++++++++
 net/ipv4/tcp_minisocks.c | 20 ++++++++++++++
 net/ipv4/tcp_output.c    | 71 ++++++++++++++++++++++++++++++++++++++++++++++--
 net/smc/af_smc.c         | 21 +++++++++++++-
 8 files changed, 176 insertions(+), 7 deletions(-)

-- 
2.13.5
