From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/7] s390: ctc patches for 2.6.25
Date: Fri, 01 Feb 2008 15:51:28 +0100
Message-ID: <20080201145128.462823000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Jeff,

the following patches are intended for 2.6.25. Besides clean-ups
they replace the old ctc driver by a reworked ctcm driver.
This ctcm driver supports the channel-to-channel connections of the
old ctc driver plus an additional MPC protocol to provide SNA
connectivity.

Patch 1/7: clean-ups in ctc and netiucv
Patch 2/7: clean-ups in Kconfig
Patch 3/7: ctcm changes in Kconfig and Makefile
Patch 4/7: ctcm-patch part 1
Patch 5/7: ctcm-patch part 2
Patch 6/7: ctcm-patch part 3
Patch 7/7: removal of old ctc driver

Regards,    Ursula Braun
