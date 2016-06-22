From: Lakhvich Dmitriy <Ldmitriy@ru.ibm.com>
Date: Wed, 22 Jun 2016 16:07:26 +0000
Subject: [PATCH] qeth:  autodetect layer2/3 of z/VM VSWITCH
Message-Id: <1466611647-4065-1-git-send-email-Ldmitriy@ru.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Lakhvich Dmitriy <LDmitriy@ru.ibm.com>

Current version of qeth driver has a problem with 
layer setting for virtual z/VM nics(VSWITCH or GUEST LAN). 
Such nics are supports  just one layer. Setting unsupported layer produce
errors so linux user must know which layer the virtual nic supports.
This patch fix the problem, now qeth driver can detect z/VM nic's
supported layer, also to avoid errors layer changing for
z/VM virtual nics now is forbidden.

Lakhvich Dmitriy (1):
  qeth: autodetect layer2/3 of z/VM VSWITCH/GUESTLAN

 drivers/s390/net/qeth_core_main.c | 104 +++++++++++++++++++++++++++++++++++---
 drivers/s390/net/qeth_core_sys.c  |   6 +++
 2 files changed, 102 insertions(+), 8 deletions(-)

-- 
2.5.0
