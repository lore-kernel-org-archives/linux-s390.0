Return-Path: <linux-kernel-owner+w=401wt.eu-S1754981AbYHCIyV@vger.kernel.org>
Subject: [GIT PULL] asm-s390 move.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Sun, 03 Aug 2008 10:54:02 +0200
Message-Id: <1217753642.29252.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull (again) from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

Your last pull has been a little bit too early, I comitted the asm header
file move shortly after. I want to get over with it, it makes no sense
to postpone it. The kernel compiles with defconfig, allmodconfig and
allyesconfig.

Martin Schwidefsky (1):
      [S390] move include/asm-s390 to arch/s390/include/asm

 {include/asm-s390 => arch/s390/include/asm}/Kbuild |    0 
 {include/asm-s390 => arch/s390/include/asm}/airq.h |    0 
 .../asm-s390 => arch/s390/include/asm}/appldata.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/atomic.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/auxvec.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/bitops.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/bug.h  |    0 
 {include/asm-s390 => arch/s390/include/asm}/bugs.h |    0 
 .../asm-s390 => arch/s390/include/asm}/byteorder.h |    0 
 .../asm-s390 => arch/s390/include/asm}/cache.h     |    0 
 .../s390/include/asm}/cacheflush.h                 |    0 
 .../asm-s390 => arch/s390/include/asm}/ccwdev.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/ccwgroup.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/checksum.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/chpid.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/chsc.h |    0 
 {include/asm-s390 => arch/s390/include/asm}/cio.h  |    0 
 {include/asm-s390 => arch/s390/include/asm}/cmb.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/compat.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/cpcmd.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/cpu.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/cputime.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/current.h   |    0 
 {include/asm-s390 => arch/s390/include/asm}/dasd.h |    0 
 .../asm-s390 => arch/s390/include/asm}/debug.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/delay.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/device.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/diag.h |    0 
 .../asm-s390 => arch/s390/include/asm}/div64.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/dma.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/ebcdic.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/elf.h  |    0 
 .../s390/include/asm}/emergency-restart.h          |    0 
 .../asm-s390 => arch/s390/include/asm}/errno.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/etr.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/extmem.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/fb.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/fcntl.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/fcx.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/futex.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/hardirq.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/hugetlb.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/idals.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/io.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/ioctl.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/ioctls.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/ipcbuf.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/ipl.h  |    0 
 {include/asm-s390 => arch/s390/include/asm}/irq.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/irq_regs.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/irqflags.h  |    0 
 {include/asm-s390 => arch/s390/include/asm}/isc.h  |    0 
 {include/asm-s390 => arch/s390/include/asm}/itcw.h |    0 
 .../asm-s390 => arch/s390/include/asm}/kdebug.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/kexec.h     |    0 
 .../s390/include/asm}/kmap_types.h                 |    0 
 .../asm-s390 => arch/s390/include/asm}/kprobes.h   |    0 
 {include/asm-s390 => arch/s390/include/asm}/kvm.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/kvm_host.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/kvm_para.h  |    0 
 .../s390/include/asm}/kvm_virtio.h                 |    0 
 .../asm-s390 => arch/s390/include/asm}/linkage.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/local.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/lowcore.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/mathemu.h   |    0 
 {include/asm-s390 => arch/s390/include/asm}/mman.h |    0 
 {include/asm-s390 => arch/s390/include/asm}/mmu.h  |    0 
 .../s390/include/asm}/mmu_context.h                |    0 
 .../asm-s390 => arch/s390/include/asm}/module.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/monwriter.h |    0 
 .../asm-s390 => arch/s390/include/asm}/msgbuf.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/mutex.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/page.h |    0 
 .../asm-s390 => arch/s390/include/asm}/param.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/pci.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/percpu.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/pgalloc.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/pgtable.h   |    0 
 {include/asm-s390 => arch/s390/include/asm}/poll.h |    0 
 .../s390/include/asm}/posix_types.h                |    0 
 .../asm-s390 => arch/s390/include/asm}/processor.h |    0 
 .../asm-s390 => arch/s390/include/asm}/ptrace.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/qdio.h |    0 
 {include/asm-s390 => arch/s390/include/asm}/qeth.h |    0 
 .../asm-s390 => arch/s390/include/asm}/reset.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/resource.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/rwsem.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/s390_ext.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/s390_rdev.h |    0 
 .../s390/include/asm}/scatterlist.h                |    0 
 .../asm-s390 => arch/s390/include/asm}/schid.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/sclp.h |    0 
 .../asm-s390 => arch/s390/include/asm}/sections.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/segment.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/sembuf.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/setup.h     |    0 
 .../s390/include/asm}/sfp-machine.h                |    0 
 .../asm-s390 => arch/s390/include/asm}/sfp-util.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/shmbuf.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/shmparam.h  |    0 
 .../s390/include/asm}/sigcontext.h                 |    0 
 .../asm-s390 => arch/s390/include/asm}/siginfo.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/signal.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/sigp.h |    0 
 {include/asm-s390 => arch/s390/include/asm}/smp.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/socket.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/sockios.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/sparsemem.h |    0 
 .../asm-s390 => arch/s390/include/asm}/spinlock.h  |    0 
 .../s390/include/asm}/spinlock_types.h             |    0 
 {include/asm-s390 => arch/s390/include/asm}/stat.h |    0 
 .../asm-s390 => arch/s390/include/asm}/statfs.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/string.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/suspend.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/sysinfo.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/system.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/tape390.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/termbits.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/termios.h   |    0 
 .../s390/include/asm}/thread_info.h                |    0 
 .../asm-s390 => arch/s390/include/asm}/timer.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/timex.h     |    0 
 {include/asm-s390 => arch/s390/include/asm}/tlb.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/tlbflush.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/todclk.h    |    0 
 .../asm-s390 => arch/s390/include/asm}/topology.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/types.h     |    0 
 .../asm-s390 => arch/s390/include/asm}/uaccess.h   |    0 
 .../asm-s390 => arch/s390/include/asm}/ucontext.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/unaligned.h |    0 
 .../asm-s390 => arch/s390/include/asm}/unistd.h    |    0 
 {include/asm-s390 => arch/s390/include/asm}/user.h |    0 
 {include/asm-s390 => arch/s390/include/asm}/vtoc.h |    0 
 {include/asm-s390 => arch/s390/include/asm}/xor.h  |    0 
 .../asm-s390 => arch/s390/include/asm}/zcrypt.h    |    0 
 135 files changed, 0 insertions(+), 0 deletions(-)
 rename {include/asm-s390 => arch/s390/include/asm}/Kbuild (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/airq.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/appldata.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/atomic.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/auxvec.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/bitops.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/bug.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/bugs.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/byteorder.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cache.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cacheflush.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ccwdev.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ccwgroup.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/checksum.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/chpid.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/chsc.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cio.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cmb.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/compat.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cpcmd.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cpu.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/cputime.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/current.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/dasd.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/debug.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/delay.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/device.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/diag.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/div64.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/dma.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ebcdic.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/elf.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/emergency-restart.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/errno.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/etr.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/extmem.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/fb.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/fcntl.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/fcx.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/futex.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/hardirq.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/hugetlb.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/idals.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/io.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ioctl.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ioctls.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ipcbuf.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ipl.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/irq.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/irq_regs.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/irqflags.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/isc.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/itcw.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kdebug.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kexec.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kmap_types.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kprobes.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kvm.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kvm_host.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kvm_para.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/kvm_virtio.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/linkage.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/local.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/lowcore.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/mathemu.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/mman.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/mmu.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/mmu_context.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/module.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/monwriter.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/msgbuf.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/mutex.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/page.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/param.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/pci.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/percpu.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/pgalloc.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/pgtable.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/poll.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/posix_types.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/processor.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ptrace.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/qdio.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/qeth.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/reset.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/resource.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/rwsem.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/s390_ext.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/s390_rdev.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/scatterlist.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/schid.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sclp.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sections.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/segment.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sembuf.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/setup.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sfp-machine.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sfp-util.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/shmbuf.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/shmparam.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sigcontext.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/siginfo.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/signal.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sigp.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/smp.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/socket.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sockios.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sparsemem.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/spinlock.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/spinlock_types.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/stat.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/statfs.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/string.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/suspend.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/sysinfo.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/system.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/tape390.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/termbits.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/termios.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/thread_info.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/timer.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/timex.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/tlb.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/tlbflush.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/todclk.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/topology.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/types.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/uaccess.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/ucontext.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/unaligned.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/unistd.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/user.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/vtoc.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/xor.h (100%)
 rename {include/asm-s390 => arch/s390/include/asm}/zcrypt.h (100%)
