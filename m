From: frank.blaschka@de.ibm.com
Subject: [patch 00/11] s390: qeth patches for 2.6.36
Date: Tue, 22 Jun 2010 10:57:01 +0200
Message-ID: <20100622085701.772508000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

this patch set contains qeth + 1 smsgiucv patches for 2.6.36 (net-next).

shortlog:
Ursula Braun (3)
smsgiucv: guarantee single iucv connect in thaw
qeth: specify correct function level for OSN devices
qeth: handle missing z/VM authorization of OSX

Carsten Otte (7)
qeth: Rework qeth_dbf_longtext
qeth: Add new s390 debug feature for each qeth card
qeth: Fold qeth_trace debug area
qeth: Fold qeth_sense debug area
qeth: Fold qeth_misc debug area
qeth: Fold qeth_qerr debug area
qeth: fix use after free for qeth's debug area

Frank Blaschka (1)
qeth: fix page breaks in hw headers

Thanks,
        Frank
