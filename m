From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/5] s390: network patches for net-next
Date: Fri, 16 Jan 2015 14:05:44 +0100
Message-ID: <1421413549-56937-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Hi Dave,

here are some s390 related patches for net-next

shortlog:

Aya Mahfouz (1)
ctcm,netiucv: migrate variables to handle y2038 problem

Markus Elfring (1)
s390/net: Delete useless checks before function calls

Eugene Crosser (2)
qeth: use qeth_card_hw_is_reachable() everywhere
qeth: sysfs: replace strcmp() with sysfs_streq()

Thomas-Mich Richter (1)
qeth: Remove unneeded structure member

Thanks,
        Ursula
