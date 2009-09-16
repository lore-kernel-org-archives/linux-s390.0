From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 0/7] s390: iucv / af_iucv fixes for 2.6.31+
Date: Wed, 16 Sep 2009 16:37:21 +0200
Message-ID: <20090916143721.863799000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here are bugfixes for iucv and af_iucv for the next possible 2.6.31 follow-on.
They apply to linux-2.6 and net-2.6.

Summary:

Ursula Braun (1)
iucv: suspend/resume error msg for left over pathes

Hendrik Brueckner (6)
iucv: fix iucv_buffer_cpumask check when calling IUCV functions
iucv: use correct output register in iucv_query_maxconn()
af_iucv: fix race in __iucv_sock_wait()
af_iucv: handle non-accepted sockets after resuming from suspend
af_iucv: do not call iucv_sock_kill() twice
af_iucv: fix race when queueing skbs on the backlog queue

Thanks,
        Ursula
