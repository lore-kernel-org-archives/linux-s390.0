From: frank.blaschka@de.ibm.com
Subject: [patch 0/5] s390: qeth/ctcm patches for 2.6.31
Date: Wed, 20 May 2009 09:38:36 +0200
Message-ID: <20090520073836.897878000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some qeth and ctcm patches for 2.6.31 (net-next).

shortlog:
Klaus-Dieter Wacker (1)
qeth: Clear SBALF15 in any case for output buffers.

Ursula Braun (4)
qeth: avoid crash after detach of replugged device
ctcm: avoid crash in ctcm_remove_device
qeth: support z/VM VSWITCH Port Isolation
qeth: omit upstream checksumming for HiperSockets

Thanks,
        Frank
