From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/1] s390: ctc patch for 2.6.24
Date: Thu, 29 Nov 2007 17:36:26 +0100
Message-ID: <20071129163626.573067000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
The following patch is intended for 2.6.24 and repairs the
ctc driver by introducing alloc_netdev().
