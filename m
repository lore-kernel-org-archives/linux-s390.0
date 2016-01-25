From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 0/5] all: s390: make compat wrappers the generic solution
Date: Mon, 25 Jan 2016 19:57:22 +0300
Message-ID: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, Yury Norov <ynorov@caviumnetworks.com>, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

The problem that makes us use wrappers is that some compat
architectures allows user code to access top halves of registers.
This is not a problem for syscalls that are already handled by compat
code, or for that who has types of the same size in kernel and
userspace. In case of s390 and lp64/ilp32 the problem is in pointer
types, long, unsigned long. 

S390 folks already have the solution for it. In this patchset,
it is turned to be general, as arm64/ilp32 needs it too.

This patchset is created as the part of the work of enabling arm64
with ILP32 user mode. See details here:
http://thread.gmane.org/gmane.linux.kernel/2126946

Build-tested on s390.

Yury Norov (5):
  all: s390: move wrapper infrastructure to generic headers
  all: declare new wrappers
  all: s390: redefine wrappers in generic code
  all: non-obvious wrappers
  introduce COMPAT_WRAPPER option and enable it for S390

 arch/Kconfig                      |   4 +
 arch/s390/Kconfig                 |   1 +
 arch/s390/include/asm/compat.h    |  17 ++-
 arch/s390/kernel/Makefile         |   2 +-
 arch/s390/kernel/compat_wrapper.c | 179 ------------------------
 arch/s390/kernel/entry.h          |   2 +
 arch/s390/pci/pci_mmio.c          |   5 +-
 drivers/char/random.c             |   3 +-
 fs/aio.c                          |   4 +-
 fs/buffer.c                       |   3 +-
 fs/dcache.c                       |   3 +-
 fs/eventpoll.c                    |   4 +-
 fs/exec.c                         |   2 +-
 fs/fhandle.c                      |   3 +-
 fs/filesystems.c                  |   3 +-
 fs/namei.c                        |  29 ++--
 fs/namespace.c                    |   7 +-
 fs/notify/inotify/inotify_user.c  |   3 +-
 fs/open.c                         |  20 +--
 fs/pipe.c                         |   5 +-
 fs/quota/quota.c                  |   3 +-
 fs/read_write.c                   |   2 +-
 fs/readdir.c                      |   6 +
 fs/select.c                       |   3 +-
 fs/splice.c                       |   4 +-
 fs/stat.c                         |   5 +-
 fs/xattr.c                        |  25 ++--
 include/linux/compat.h            | 280 ++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h          |  57 +-------
 include/linux/syscalls_structs.h  |  60 ++++++++
 include/uapi/asm-generic/unistd.h | 224 +++++++++++++++---------------
 ipc/mqueue.c                      |   3 +-
 kernel/acct.c                     |   3 +-
 kernel/bpf/syscall.c              |   3 +-
 kernel/capability.c               |   5 +-
 kernel/events/core.c              |   2 +-
 kernel/fork.c                     |  12 +-
 kernel/groups.c                   |   5 +-
 kernel/kcmp.c                     |   3 +-
 kernel/module.c                   |   7 +-
 kernel/printk/printk.c            |   3 +-
 kernel/reboot.c                   |   3 +-
 kernel/sched/core.c               |  11 +-
 kernel/seccomp.c                  |   2 +-
 kernel/signal.c                   |   6 +-
 kernel/sys.c                      |  16 +--
 kernel/sys_ni.c                   | 104 +++++++-------
 mm/madvise.c                      |   3 +-
 mm/mincore.c                      |   3 +-
 mm/mlock.c                        |   7 +-
 mm/mmap.c                         |   7 +-
 mm/mprotect.c                     |   3 +-
 mm/mremap.c                       |   3 +-
 mm/msync.c                        |   3 +-
 mm/nommu.c                        |   7 +-
 mm/shmem.c                        |   3 +-
 mm/swapfile.c                     |   5 +-
 net/socket.c                      |  14 +-
 security/keys/keyctl.c            |   5 +-
 59 files changed, 699 insertions(+), 520 deletions(-)
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 create mode 100644 include/linux/syscalls_structs.h

-- 
2.5.0
