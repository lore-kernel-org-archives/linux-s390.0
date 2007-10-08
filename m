From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/2] [AF_IUCV] fixes for net-2.6.24 - cleanup resend
Date: Mon, 08 Oct 2007 10:51:19 +0200
Message-ID: <20071008085119.805528000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: heicars2@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

-- 
Dave,

this is the resend of my patches from last week built against net-2.6.24.

> the following 2 patches are intended for 2.6.24 and contain:
> - removal of static declarations in af_iucv header file
> - postpone receival of inbound packets in af_iucv

Regards, Ursula
