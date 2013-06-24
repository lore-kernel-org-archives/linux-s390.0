From: frank.blaschka@de.ibm.com
Subject: [patch 0/5] s390: network patches for net-next
Date: Mon, 24 Jun 2013 13:21:47 +0200
Message-ID: <20130624112147.347247916@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some s390 related patches for net-next

shortlog:

Andy Shevchenko (1)
netiucv: remove unused macro

Stefan Raspl (2)
qeth: Increase default MTU for OSA devices
qeth: Fix crash on initial MTU size change

Ursula Braun (1)
qeth: change default standard blkt settings for OSA

Sebastian Ott (1)
qeth: use default napi weight

Thanks,
        Frank
