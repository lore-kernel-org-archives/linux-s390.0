From: frank.blaschka@de.ibm.com
Subject: [patch 0/2] s390: network bug fixes for net
Date: Tue, 16 Oct 2012 07:21:16 +0200
Message-ID: <20121016052116.210859505@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some bug fixes for net.

shortlog:

Hendrik Brueckner (1)
smsgiucv: reestablish IUCV path after resume

Stefan Raspl (1)
qeth: fix deadlock between recovery and bonding driver

Thanks,
        Frank
