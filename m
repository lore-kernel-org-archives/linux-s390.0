Return-Path: <linux-kernel-owner+w=401wt.eu-S1760991AbXEJN4h@vger.kernel.org>
Message-Id: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/15] s390 patches for 2.6.22
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

A few fixes, some compiler warnings and the Kconfig cleanup.
s390 now uses the common drivers/Kconfig file instead of the
home-brewn drivers/s390/Kconfig. There are some more config
options for s390 now, not all of them make sense but as long
as the code compiles no harm is done.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
