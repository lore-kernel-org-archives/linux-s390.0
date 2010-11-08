From: frank.blaschka@de.ibm.com
Subject: [patch 0/2] s390: qeth bug fixes for 2.6.37 next rc
Date: Mon, 08 Nov 2010 14:03:47 +0100
Message-ID: <20101108130347.973708765@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some qeth bug fixes for 2.6.37 next rc (net-2.6)

shortlog:

Ursula Braun (1)
qeth: remove dev_queue_xmit invocation

Frank Blaschka (1)
qeth: fix race condition during device startup

Thanks,
        Frank
