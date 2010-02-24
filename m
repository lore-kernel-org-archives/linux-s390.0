Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084430.193562869@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/32] s390 patch queue for 2.6.34
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Greetings,
we are closing in on 2.6.33 so it is time for the usual s390 patch
bomb. 32 patches are waiting on the features branch of git390 right
now, mostly boring stuff. Two patches are intersting though:
the spinlock improvement that checks for the virtual cpu running
status of the lock holder and the kernel image compression (yes, we
finally have kernel image compression after only 10 years..)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
