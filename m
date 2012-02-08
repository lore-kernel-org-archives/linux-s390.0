From: frank.blaschka@de.ibm.com
Subject: [patch 0/6] s390: network driver features and fixes for net-next
Date: Wed, 08 Feb 2012 11:19:44 +0100
Message-ID: <20120208101944.272235343@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some s390 network driver features and fixes for net-next

shortlog:

Ursula Braun (5)
af_iucv: remove IUCV-pathes completely
af_iucv: block writing if msg limit is exceeded
af_iucv: change net_device handling for HS transport
af_iucv: allow retrieval of maximum message size
qeth: add wake_up on write channel

Frank Blaschka (1)
qeth: add query OSA address table support

Thanks,
        Frank
