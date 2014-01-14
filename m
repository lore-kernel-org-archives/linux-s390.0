From: frank.blaschka@de.ibm.com
Subject: [patch 0/3] s390: network patches for net-next
Date: Tue, 14 Jan 2014 15:54:10 +0100
Message-ID: <20140114145410.453840919@de.ibm.com>
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

Eugene Crosser (3)
qeth: bridgeport support - basic control

390/qdio: bridgeport support - CHSC part
  Since this patch touches CIO and qdio it will come in again with
  the s390 tree from Martin Schwidefsky.

qeth: bridgeport support - address notifications

Thanks,
        Frank
