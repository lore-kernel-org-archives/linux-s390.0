From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/3] s390: qeth patches for net-next
Date: Wed, 19 Aug 2015 10:20:51 +0200
Message-ID: <1439972454-64347-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

here are some s390 related qeth patches for net-next

shortlog:

Eugene Crosser (1):
  qeth: remove extraneous length from %pM format

Vaishali Thakkar (1):
  qeth: Convert use of __constant_htons to htons

Lakhvich Dmitriy (1):
  qeth: no write permission for readonly sysattr

Thanks,
       Ursula
