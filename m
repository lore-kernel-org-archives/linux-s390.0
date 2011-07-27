Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20110727125504.491183728@linux.vnet.ibm.com>
Date: Wed, 27 Jul 2011 14:55:04 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 00/10] kdump: Patch series for s390 support (version 2)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: vgoyal@redhat.com
Cc: ebiederm@xmission.com, mahesh@linux.vnet.ibm.com, hbabu@us.ibm.com, oomichi@mxs.nes.nec.co.jp, horms@verge.net.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Vivek,

To make progress and for getting at least the "standard" kdump port upstream
soon, I send you now the updated patch series that contain the s390 kdump port
without stand-alone dump support. The support for stand-alone dump tools
can be added later.

Main changes compared to version 1:
1. We use purgatory code
2. We use pre-allocated ELF core header
3. Registers are saved in old kernel
4. Removed meminfo

The following patches are most interesting for you:
[1-4] Common code changes
[9]   S390 kdump kernel backend
[10]  S390 kdump kexec-tools backend

Patches 5-8 are s390 specific preparation patches for the kdump port.

I hope we will make progress.
Thanks!

Michael
