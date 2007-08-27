From: Ursula Braun <braunu@de.ibm.com>
Date: Mon, 27 Aug 2007 17:27:31 +0000
Subject: [patch 0/7] qeth patches for 2.6.23-rc3
Message-Id: <20070827172731.370533000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
qeth patches for 2.6.23-rc3:
- do not allow interruption of "ungroup"
- scatter gather mode: enforce rate limit
- don't return void function return values
- add tx checkumming for TSO/EDDP mode
- invoke qeth_clear_output_buffer only for allocated qdio queues.
- add specific message for exclusively used OSA-adapters
- drop ARP packets on HiperSockets

Regards,   Ursula Braun
