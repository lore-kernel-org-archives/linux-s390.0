Return-Path: <linux-kernel-owner+w=401wt.eu-S1755459AbYGaMlT@vger.kernel.org>
Message-Id: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/6] latest bug fixes for s390.
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,
just a couple of additional bug fixes for 2.6.27-rc1. The only
one which is remotely interesting is the diag 0x260 removal.
The memory detection code stops using it anymore because there
are situations where the value you get from it just isn't usable.
I'll add them to git390 for the next please pull.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
