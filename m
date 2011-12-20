From: frank.blaschka@de.ibm.com
Subject: [patch 00/10] s390: network driver features and fixes for net-next
Date: Tue, 20 Dec 2011 09:56:26 +0100
Message-ID: <20111220085626.924756639@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some s390 network driver features and fixes for net-next

shortlog:

Ursula Braun (8)
af_iucv: support ancillary data with HS transport
af_iucv: accelerate close for HS transport
af_iucv: release reference to HS device
af_iucv: remove unused timer infrastructure
af_iucv: get rid of state IUCV_SEVERED
qeth: suspicious rcu_dereference_check in recovery
qeth: forbid recovery during shutdown
netiucv: allow multiple interfaces to same peer

Frank Blaschka (1)
qeth: improve recovery during resource shortage

Einar Lueck (1)
qeth: recovery through asynchronous delivery

Thanks,
        Frank
