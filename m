Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 7 Jan 2012 20:01:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 3.3
Message-ID: <20120107200122.5a78669d@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Carsten Otte (1):
      [S390] disable MACHINE_IS_VM check for pfault

Christian Borntraeger (1):
      [S390] kvm: fix sleeping function ... at mm/page_alloc.c:2260

Heiko Carsten (1):
      [S390] sysctl: get rid of dead declaration

Heiko Carstens (9):
      [S390] irq: fix accounting of external call/emergency signal
      [S390] topology: get rid of ifdefs
      [S390] qdio: fix qdio_allocate_aob() declaration
      [S390] topology: cleanup z10 topology handling
      [S390] topology: increase poll frequency if change is anticipated
      [S390] Remove Kerntypes leftovers
      [S390] ipc: call generic sys_ipc demultiplexer
      [S390] Enable exception traces by default
      [S390] disassembler: mark exception causing instructions

Holger Dengler (2):
      [S390] zcrypt: Rework length parameter checking.
      [S390] zcrypt: Fix error return codes.

Jan Glauber (1):
      [S390] make arch/s390 subdirectories depend on config option

Martin Schwidefsky (6):
      [S390] add support for physical memory > 4TB
      [S390] kvm: move cmf host id constant out of lowcore
      [S390] entry[64].S improvements
      [S390] cleanup trap handling
      [S390] outstanding interrupts vs. smp_send_stop
      [S390] return address of compat signals

Michael Holzheu (6):
      [S390] Check for NULL termination in command line setup
      [S390] Rework create_mem_hole() function
      [S390] Remove useless newline in reserve_kdump_bootmem()
      [S390] kernel: Fix smp_switch_to_ipl_cpu() stack frame setup
      [S390] Add VMCOREINFO_SYMBOL(high_memory) to vmcoreinfo
      [S390] Add s390x description to Documentation/kdump/kdump.txt

Stefan Haberland (2):
      [S390] dasd: add sanity check to detect path connection error
      [S390] dasd: fix fixpoint divide exception in define_extent

Stefan Weinhuber (1):
      [S390] dasd: fix expiration handling for recovery requests

Steffen Maier (1):
      [S390] qdio: fix kernel panic for zfcp 31-bit

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
