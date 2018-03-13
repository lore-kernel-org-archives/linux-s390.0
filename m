Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 0/1] net/iucv: fix 2018-03-13
Date: Tue, 13 Mar 2018 16:50:05 +0100
Message-Id: <20180313155006.88162-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

please apply one patch for af_iucv, that fixes an error path during
initialization.

Thanks,
Julian


Arvind Yadav (1):
  net/iucv: Free memory obtained by kzalloc

 net/iucv/af_iucv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.13.5
