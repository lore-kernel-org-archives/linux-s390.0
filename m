From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V2 net-next 0/3] TCP experimental option for SMC rendezvous
Date: Wed, 18 Oct 2017 16:29:57 +0200
Message-ID: <20171018143000.23884-1-ubraun@linux.vnet.ibm.com>
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

Changelog:

V2:
* switch to current jump labels API
* remove static key checking in smc_set_capability()
  (comment from Eric Dumazet)
* use inet_request_sock parameter for smc_set_option_cond()
* smc_listen_work(): replace local variable lgr_lock_taken by new labels
                     and separate this change into a prerequisite first
                     patch

Ursula Braun (3):
  smc: fix mutex unlocks during link group creation 
  tcp: TCP experimental option for SMC
  smc: add SMC rendezvous protocol

 include/linux/tcp.h      |  9 +++++--
 include/net/inet_sock.h  |  3 ++-
 include/net/tcp.h        |  8 ++++++
 net/ipv4/tcp.c           |  6 +++++
 net/ipv4/tcp_input.c     | 34 +++++++++++++++++++++++++
 net/ipv4/tcp_minisocks.c | 19 ++++++++++++++
 net/ipv4/tcp_output.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++---
 net/smc/af_smc.c         | 42 ++++++++++++++++++++++--------
 8 files changed, 170 insertions(+), 17 deletions(-)

-- 
2.13.5
