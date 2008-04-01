From: frank.blaschka@de.ibm.com
Subject: [patch 0/8] s390: qeth bug fixes for 2.6.26
Date: Tue, 01 Apr 2008 10:26:52 +0200
Message-ID: <20080401082652.754871000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Jeff,

a couple of bug fixes for the new qeth. The patches apply to
..git/davem/net-2.6.26.git. The shortlog:

Ursula Braun (5)
qeth: improve ip_list administration after deregister failures
qeth: allow qdio queue element addresses > 2GB
qeth: set lan_online flag after a received STARTLAN
qeth: CCL-sequence numbers required for protocol ETH_P_802_2 only
qeth: keep ip-address after LAN_OFFLINE failure

Frank Blaschka (2)
qeth: layer 3 do not allow to change mac address
qeth: core code should alloc headroom for LLC protocol

Peter Tiedemann (1)
qeth: improving debug message handling

        Frank

-- 
