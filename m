Return-Path: <linux-kernel-owner+w=401wt.eu-S1762323AbXEULAt@vger.kernel.org>
Message-Id: <20070521105118.955425052@de.ibm.com>
Date: Mon, 21 May 2007 12:51:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/5] s390 patches for 2.6.22-rc2
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

5 patches for s390. Important are the two patches that wire up the
system calls utimesat, signald, timerfd and eventfd.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
