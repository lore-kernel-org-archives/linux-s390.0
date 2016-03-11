Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 0/2] s390: Hotplug notifier transitions
Date: Fri, 11 Mar 2016 11:52:36 +0100
Message-Id: <1457693558-45970-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The following patches fix missing error handling of hotplug notifier
transitions.

Thanks,
Anna-Maria

---
 perf_cpum_cf.c |    1 +
 perf_cpum_sf.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
