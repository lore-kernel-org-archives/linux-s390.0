From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/2] qeth patches for 2.6.23
Date: Thu, 12 Jul 2007 12:51:33 +0200
Message-ID: <20070712105133.165267000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--
second attempt to send qeth patches: 
This time with corrected sender address - sorry for the confusion.
 
two qeth patches for 2.6.23:
- scatter-gather patch improves handling of large incoming packets
- barrier patch is required due to a recent removal of 'volatile'
  from atomic_t in include/asm-s390/atomic.h
