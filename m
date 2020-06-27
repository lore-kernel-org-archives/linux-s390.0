Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF0H1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 27 Jun 2020 03:27:35 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: properly support exec with kernel pointers v3
Date: Sat, 27 Jun 2020 09:26:59 +0200
Message-Id: <20200627072704.2447163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

this series first cleans up the exec code and then adds proper
kernel_execveat and kernel_wait callers instead of relying on the fact
that the early init code and kernel threads implicitly run with
the address limit set to KERNEL_DS.

Note that the cleanup removes the compat execve(at) handlers entirely, as
we can handle the compat difference very nicely in a unified codebase.
x32 needs two hacky #defines for that for now, although those can go
away if the x32 syscall rework from Brian gets merged.

I think this is ready to get picked up.  What would the best tree be?
Most important a git tree would be good, as I have other work building
on top of it.


Changes since v2:
 - drop the kernel_wait addition, as this interacts with a series
   from Luis and should be merged together with that one

Changes since v1:
 - remove a pointless ifdef from get_user_arg_ptr
 - remove the need for a compat syscall handler for x32


Diffstat:
 arch/arm64/include/asm/unistd32.h                  |    4 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    4 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    4 
 arch/parisc/kernel/syscalls/syscall.tbl            |    4 
 arch/powerpc/kernel/syscalls/syscall.tbl           |    4 
 arch/s390/kernel/syscalls/syscall.tbl              |    4 
 arch/sparc/kernel/syscalls.S                       |    4 
 arch/x86/entry/syscall_x32.c                       |    7 
 arch/x86/entry/syscalls/syscall_32.tbl             |    4 
 arch/x86/entry/syscalls/syscall_64.tbl             |    4 
 fs/exec.c                                          |  248 ++++++++-------------
 include/linux/binfmts.h                            |   10 
 include/linux/compat.h                             |    7 
 include/uapi/asm-generic/unistd.h                  |    4 
 init/main.c                                        |    5 
 kernel/umh.c                                       |   14 -
 tools/include/uapi/asm-generic/unistd.h            |    4 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    4 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    4 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    4 
 20 files changed, 149 insertions(+), 198 deletions(-)
