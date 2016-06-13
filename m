From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/3] s390: af_iucv patches
Date: Mon, 13 Jun 2016 18:46:13 +0200
Message-ID: <1465836376-24452-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are improvements for af_iucv relaxing the pressure to allocate
big contiguous kernel buffers.

Thanks, Ursula

Eugene Crosser (3):
  af_iucv: use paged SKBs for big outbound messages
  af_iucv: remove fragment_skb() to use paged SKBs
  af_iucv: use paged SKBs for big inbound messages

 net/iucv/af_iucv.c | 223 +++++++++++++++++++++++++++++------------------------
 1 file changed, 122 insertions(+), 101 deletions(-)

-- 
2.6.6
