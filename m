From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/2] s390: af_iucv patches
Date: Fri,  7 Oct 2016 15:51:46 +0200
Message-ID: <cover.1475846599.git.ursula.braun@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are 2 patches for the s390-only af_iucv socket family code.

Thanks, Ursula

Ursula Braun (2):
  Subject: [PATCH] af_iucv: enable control sends in case of
    SEND_SHUTDOWN
  Subject: [PATCH] af_iucv: drop skbs rejected by filter

 net/iucv/af_iucv.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

-- 
2.8.4
