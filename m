From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 0/8] iucv / af_iucv patches for net-next-2.6.30-rc1
Date: Wed, 22 Apr 2009 11:26:19 +0200
Message-ID: <20090422092619.451973000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

thanks for applying our critical af_iucv bug fixes to net-2.6.
Here is now the series of iucv / af_iucv patches for the current
development cycle.
The patches are based on top of the current net-next-2.6 kernel
(2.6.30-rc1).

Hendrik Brueckner (7)
    af_iucv: sync sk shutdown flag if iucv path is quiesced
    af_iucv: add sockopt() to enable/disable use of IPRM_DATA msgs
    af_iucv: Support data in IUCV msg parameter lists (IPRMDATA)
    af_iucv: Modify iucv msg target class using control msghdr
    af_iucv: Provide new socket type SOCK_SEQPACKET
    af_iucv: cleanup and refactor recvmsg() EFAULT handling
    af_iucv: New socket option for setting IUCV MSGLIMITs

Ursula Braun (1):
    iucv: provide second per-cpu IUCV command parameter block

Kind regards,
Ursula Braun
