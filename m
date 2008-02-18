From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/1] s390: claw - More use DIV_ROUND_UP
Date: Mon, 18 Feb 2008 14:41:54 +0100
Message-ID: <20080218134154.893427000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, julia@diku.dk
List-ID: <linux-s390.vger.kernel.org>

-- 
Jeff,

this patch is intended for 2.6.25.
It makes use of the DIV_ROUND_UP function as proposed by Julia Lawall.

Regards, Ursula Braun
