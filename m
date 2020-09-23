Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: let import_iovec deal with compat_iovecs as well v3
Date: Wed, 23 Sep 2020 08:05:38 +0200
Message-Id: <20200923060547.16903-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Hi Al,

this series changes import_iovec to transparently deal with comat iovec
structures, and then cleanups up a lot of code dupliation.

Changes since v2:
 - revert the switch of the access process vm sysclls to iov_iter
 - refactor the import_iovec internals differently
 - switch aio to use __import_iovec

Changes since v1:
 - improve a commit message
 - drop a pointless unlikely
 - drop the PF_FORCE_COMPAT flag
 - add a few more cleanups (including two from David Laight)

Diffstat:
 arch/arm64/include/asm/unistd32.h                  |   10 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   10 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   10 
 arch/parisc/kernel/syscalls/syscall.tbl            |   10 
 arch/powerpc/kernel/syscalls/syscall.tbl           |   10 
 arch/s390/kernel/syscalls/syscall.tbl              |   10 
 arch/sparc/kernel/syscalls/syscall.tbl             |   10 
 arch/x86/entry/syscall_x32.c                       |    5 
 arch/x86/entry/syscalls/syscall_32.tbl             |   10 
 arch/x86/entry/syscalls/syscall_64.tbl             |   10 
 block/scsi_ioctl.c                                 |   12 
 drivers/scsi/sg.c                                  |    9 
 fs/aio.c                                           |   38 --
 fs/io_uring.c                                      |   20 -
 fs/read_write.c                                    |  362 +--------------------
 fs/splice.c                                        |   57 ---
 include/linux/compat.h                             |   24 -
 include/linux/fs.h                                 |   11 
 include/linux/uio.h                                |   10 
 include/uapi/asm-generic/unistd.h                  |   12 
 lib/iov_iter.c                                     |  161 +++++++--
 mm/process_vm_access.c                             |   85 ----
 net/compat.c                                       |    4 
 security/keys/compat.c                             |   37 --
 security/keys/internal.h                           |    5 
 security/keys/keyctl.c                             |    2 
 tools/include/uapi/asm-generic/unistd.h            |   12 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   10 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   10 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   10 
 30 files changed, 280 insertions(+), 706 deletions(-)
