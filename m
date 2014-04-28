From: frank.blaschka@de.ibm.com
Subject: [patch 0/7] s390: network patches for net-next
Date: Mon, 28 Apr 2014 10:05:04 +0200
Message-ID: <20140428080504.925649066@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are some s390 related patches for net-next

shortlog:

Stefan Raspl (3)
qeth: Fix default queue setting in priority queueing
qeth: Extend priority queueing to IPv6
qeth: Add new priority queueing options

Duan Jiong (2)
lcs: replace PTR_RET with PTR_ERR_OR_ZERO
qeth: replace PTR_RET with PTR_ERR_OR_ZERO

Frank Blaschka (2)
claw: replace PTR_RET with PTR_ERR_OR_ZERO
ctc: replace PTR_RET with PTR_ERR_OR_ZERO

Thanks,
        Frank
