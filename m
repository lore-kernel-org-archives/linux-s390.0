Return-Path: <linux-kernel-owner+w=401wt.eu-S967935AbXJSWAy@vger.kernel.org>
Message-Id: <20071019215538.395133000@linux.vnet.ibm.com>
Date: Fri, 19 Oct 2007 23:55:38 +0200
From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/1] remove header_ops bug in qeth driver
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: jgarzik@pobox.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: mschwid2@linux.vnet.ibm.com, apw@shadowen.org, linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com, kaber@trash.net
List-ID: <linux-s390.vger.kernel.org>

-- 
Remove qeth driver bug introduced by this commit:

commit 3b04ddde02cf1b6f14f2697da5c20eca5715017f
Author: Stephen Hemminger <shemminger@linux-foundation.org>
Date:   Tue Oct 9 01:40:57 2007 -0700

    [NET]: Move hardware header operations out of netdevice.
