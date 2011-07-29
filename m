Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110729123944.562622201@linux.vnet.ibm.com>
Date: Fri, 29 Jul 2011 14:39:44 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 0/3] kdump: Add external kdump entry point for s390 stand-alone dump tools
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Vivek,

I finished the patches that add the stand-alone dump tools support on
top of the recently sent v2 patch series. The following three patches
implement the program check idea that we have discussed recently:

[1] kdump: Add new machine_kexec_finish() architecture callback
[2] s390: Add external kdump entry point for s390 stand-alone dump tools
[3] kexec-tools: Emit program check on s390 for checksum failure

Thanks!

Michael
