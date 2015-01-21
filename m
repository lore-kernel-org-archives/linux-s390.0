From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/2] s390/qeth patches for net
Date: Wed, 21 Jan 2015 13:39:08 +0100
Message-ID: <1421843950-58220-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

here are two s390/qeth patches built for net.
One patch is quite large, but we would like to fix the locking warning
seen in recent kernels as soon as possible. But if you want me to submit
these patches for net-next, I will do.

shortlog:

Eugene Crosser (1)
qeth: clean up error handling

Thomas-Mich Richter (1)
qeth: Fix locking warning during qeth device setup

Thanks,
        Ursula
