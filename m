Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:33804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKSN51 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:27 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/6] s390/ctcm: Remove gfp_type() usage.
Date: Thu, 19 Nov 2020 14:57:12 +0100
Message-Id: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

Folks,

in the discussion about preempt count consistency across kernel
configurations:
  https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/

Linus clearly requested that code in drivers and libraries which changes
behaviour based on execution context should either be split up so that
e.g. task context invocations and BH invocations have different interfaces
or if that's not possible the context information has to be provided by the
caller which knows in which context it is executing.

This series is removing the gfp_type() usage which uses in_interrupt().
Overall it appears to be a nice cleanup according to the diffstat.

v1=E2=80=A6v2:
	- Use the pointer from skb_put()/push() instead having it on
	  stack.
	- Collect acks for patch 4-6.

Sebastian
