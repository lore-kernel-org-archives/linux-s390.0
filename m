From: frank.blaschka@de.ibm.com
Subject: [patch 0/5] s390: network driver bug fixes for 3.2.0 next rc
Date: Tue, 15 Nov 2011 13:31:11 +0100
Message-ID: <20111115123111.128739986@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are a couple of s390 network driver bug fixes for 3.2.0 next rc

shortlog:

Ursula Braun (2)
qeth: return with -EPERM if sniffing is not enabled
netiucv: reinsert dev_alloc_name for device naming

Frank Blaschka (1)
qeth: l3 fix rcu splat in xmit

Christian Borntraeger (1)
qeth: remove WARN_ON leftover

Einar Lueck (1)
qeth: Reduce CPU consumption through less SIGA-r calls

Thanks,
        Frank
