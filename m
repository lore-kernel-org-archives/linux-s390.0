Return-Path: <linux-kernel-owner+w=401wt.eu-S1755772AbZFDQTO@vger.kernel.org>
Message-Id: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/38] power management / hibernate support for s390
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
this patch set implements hibernation support for s390. All s390
specific buses grow pm callbacks and all the s390 device drivers
are modified to make use of the callbacks. This allows to do

echo disk > /sys/power/state

to save the state of the running linux image to swap. A normal
ipl (alias boot) of the same kernel will detect the stored image
on swap and resume the save image. Works for guests under z/VM
and for LPARs.

The patches are meant to be applied on top of the s390 tree found
at
	git://git390.marist.edu/pub/scm/linux-2.6.git features

Have fun..
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
