Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Apr 2015 10:23:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.1 merge window #2
Message-ID: <20150420102355.6250e2c7@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

The big thing in this second merge for s390 is the new eBPF JIT
from Michael which replaces the old 32-bit backend.
The remaining commits are bug fixes.

The merge has a small conflict which is easy to resolve:

diff --cc arch/s390/pci/pci_debug.c
index c22d440,3fc9b4d..4129b0a
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@@ -45,9 -58,11 +58,12 @@@ static int pci_perf_show(struct seq_fil
  
  	if (!zdev)
  		return 0;
+ 
+ 	mutex_lock(&zdev->lock);
  	if (!zdev->fmb) {
+ 		mutex_unlock(&zdev->lock);
 -		return seq_printf(m, "FMB statistics disabled\n");
 +		seq_puts(m, "FMB statistics disabled\n");
 +		return 0;
  	}
  
  	/* header */

Shortlog:

Joe Perches (1):
      s390: Use bool function return values of true/false not 1/0

Michael Holzheu (2):
      s390/bpf: Add s390x eBPF JIT compiler backend
      s390/mm: Fix memory hotplug for unaligned standby memory

Sebastian Ott (2):
      s390/pci: extract software counters from fmb
      s390/pci: add locking for fmb access

Stefan Haberland (3):
      s390/dasd: fix inability to set a DASD device offline
      s390/dasd: fix unresumed device after suspend/resume
      s390/dasd: Fix unresumed device after suspend/resume having no paths

 arch/s390/Kconfig                   |    2 +-
 arch/s390/include/asm/dma-mapping.h |    2 +-
 arch/s390/include/asm/pci.h         |   10 +-
 arch/s390/net/bpf_jit.S             |  197 ++--
 arch/s390/net/bpf_jit.h             |   58 ++
 arch/s390/net/bpf_jit_comp.c        | 1780 +++++++++++++++++++++--------------
 arch/s390/pci/pci.c                 |    6 +
 arch/s390/pci/pci_debug.c           |   36 +-
 arch/s390/pci/pci_dma.c             |    8 +-
 drivers/s390/block/dasd.c           |   42 +-
 drivers/s390/block/dasd_eckd.c      |    3 +-
 drivers/s390/char/sclp_cmd.c        |   48 +-
 12 files changed, 1350 insertions(+), 842 deletions(-)
 create mode 100644 arch/s390/net/bpf_jit.h
