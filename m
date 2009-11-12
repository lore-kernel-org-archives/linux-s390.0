From: frank.blaschka@de.ibm.com
Subject: [patch 0/5] s390: qeth patches for 2.6.33
Date: Thu, 12 Nov 2009 11:11:40 +0100
Message-ID: <20091112101140.882313000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here is a set of qeth patches for 2.6.33 (net-next).

shortlog:
Einar Lueck (1)
qeth: Exploit Connection Isolation

Ursula Braun (2)
qeth: remaining EDDP cleanup
qeth: Recognize return codes of ccw_device_set_online

Frank Blaschka (2)
qeth: rework TSO functions
qeth: allow dynamic change of rx checksumming

Thanks,
        Frank
