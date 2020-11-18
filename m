Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:54276 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRKxr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:53:47 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/6] s390/ctcm: Remove gfp_type() usage.
Date: Wed, 18 Nov 2020 11:53:11 +0100
Message-Id: <20201118105317.605671-1-bigeasy@linutronix.de>
MIME-Version: 1.0
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
There are still two in_irq() users left in ctcm which I'm currently
struggling with.

Sebastian
