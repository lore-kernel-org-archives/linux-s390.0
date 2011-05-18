From: frank.blaschka@de.ibm.com
Subject: [patch 0/1] s390: one more qeth patch for net-next
Date: Wed, 18 May 2011 15:28:34 +0200
Message-ID: <20110518132834.728225299@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Hi Dave,

thanks to the help and patience of Michal Miroslaw here is a
patch to finalize the qeth hw_features rework.

shortlog:
Frank Blaschka (1)
qeth: use ndo_set_features callback for initial setup and recovery

Thanks,
        Frank
