Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110819141857.052232873@linux.vnet.ibm.com>
Date: Fri, 19 Aug 2011 16:18:57 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 0/2] kdump: Common code changes for s390 kdump support
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: vgoyal@redhat.com, ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Andrew,

I had a long discussion with Vivek Goyal on the s390 kdump support (thanks
Vivek for all the time!). As a result of this, here are two common code
patches that are required for the s390 port. Could you please integrate them
upstream in the next merge window? The s390 specific part will be integrated
by our s390 maintainer Martin Schwidefsky.

I will be on vacation for the next two weeks. Therefore if you have comments
or questions, please contact also Martin Schwidefsky and Heiko Carstens.

Thanks

   Michael
