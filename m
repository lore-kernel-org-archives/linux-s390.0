From: frank.blaschka@de.ibm.com
Subject: [patch 0/6] [resend] s390: network patches for net-next
Date: Wed, 02 Feb 2011 17:04:30 +0100
Message-ID: <20110202160430.554090958@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

I have removed the NET_SKB_PAD patch from the patch set.
We will define it in an arch specific header. The new
version of the patch will come via the s390 tree. Thx!

shortlog:
Ursula Braun (3)
qeth: show new mac-address if its setting fails
qeth: allow HiperSockets framesize change in suspend
qeth: allow OSA CHPARM change in suspend state

Frank Blaschka (1)
qeth: add more strict MTU checking

Stefan Weil (2)
s390: Fix wrong size in memcmp (netiucv)
s390: Fix possibly wrong size in strncmp (smsgiucv)

Thanks,
        Frank
