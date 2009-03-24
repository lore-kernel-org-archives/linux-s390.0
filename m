From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 0/9] s390: lcs / ctcm / claw / netiucv patches for 2.6.29
Date: Tue, 24 Mar 2009 13:29:04 +0100
Message-ID: <20090324122904.744942000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are a couple of drivers/s390/net-patches for 2.6.29 :

1/9: lcs:     exploit <linux/kthread.h>          - Klaus-Dieter Wacker
2/9: lcs:     hard_start_xmit return codes       - Klaus-Dieter Wacker
3/9: netiucv: hard_start_xmit return codes       - Ursula Braun
4/9: claw:    hard_start_xmit return codes       - Ursula Braun
5/9: ctcm:    hard_start_xmit return codes       - Ursula Braun
6/9: ctcm:    avoid wraparound in length of incoming data - Roel Kluin
7/9: ctcm:    minor findings from code analysis tool      - Joel Fowler
8/9: claw:    convert printk messages to kmsg api    - Andy Richter
9/9: claw:    minor findings from code analysis tool - Andy Richter

Thanks and regards,
Ursula
