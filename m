From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 0/4] s390: ctcm / lcs / claw fixes for 2.6.27
Date: Thu, 21 Aug 2008 17:10:21 +0200
Message-ID: <20080821151021.069615000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Hi Jeff,

Here are some drivers/s390/net fixes for 2.6.27:

- removal of claw memory leak
- make use of ml_priv field of struct net_device in claw driver
- make use of ml_priv field of struct net_device in ctcm driver
- recovery fix for lcs driver

Thanks, Ursula Braun
