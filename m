Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Nov 2017 07:37:47 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 updates for v4.15
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20171113063747.GA3714@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Linus,

since Martin is on vacation you get the s390 pull request for the v4.15
merge window this time from me.

Please pull from the 'for-linus' branch of

    git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Besides a lot of cleanups and bug fixes these are the most important changes:

- A new regset for runtime instrumentation registers

- Hardware accelerated AES-GCM support for the aes_s390 module

- Support for the new CEX6S crypto cards

- Support for FORTIFY_SOURCE

- Addition of missing z13 and new z14 instructions to the in-kernel
  disassembler

- Generate opcode tables for the in-kernel disassembler out of a simple text
  file instead of having to manually maintain those tables

- Fast memset16, memset32 and memset64 implementations

- Removal of named saved segment support

- Hardware counter support for z14

- Queued spinlocks and queued rwlocks implementations for s390

- Use the stack_depth tracking feature for s390 BPF JIT

- A new s390_sthyi system call which emulates the sthyi (store hypervisor
  information) instruction

- Removal of the old KVM virtio transport

- An s390 specific CPU alternatives implementation which is used in the new
  spinlock code

You will see two trivial merge conflicts caused by the "SPDX GPL-2.0 license"
commit and the removal of s390 specific header files:

arch/s390/include/asm/rwsem.h
arch/s390/include/uapi/asm/kvm_virtio.h

The resolution is to simply remove those files.

Thanks,
Heiko

Alice Frosi (2):
      s390/runtime_instrumentation: clean up struct runtime_instr_cb
      s390/ptrace: add runtime instrumention register get/set

Arnd Bergmann (1):
      s390/dasd: avoid calling do_gettimeofday()

Christian Borntraeger (2):
      s390/pci: do not require AIS facility
      s390/virtio: remove unused header file kvm_virtio.h

Cornelia Huck (1):
      MAINTAINERS: add virtio-ccw.h to virtio/s390 section

Dong Jia Shi (2):
      vfio: ccw: bypass bad idaw address when fetching IDAL ccws
      vfio: ccw: validate the count field of a ccw before pinning

Elena Reshetova (1):
      vmur: convert urdev.ref_count from atomic_t to refcount_t

Harald Freudenberger (7):
      s390/zcrypt: Explicitly check input data length.
      s390/crypto: add s390 platform specific aes gcm support.
      s390/zcrypt: CEX6S exploitation
      s390/zcrypt: Enable special header file flag for AU CPRP
      s390/zcrypt: Introduce QACT support for AP bus devices.
      s390/archrandom: Reconsider s390 arch random implementation
      s390/zcrypt: Rework struct ap_qact_ap_info.

Heiko Carstens (31):
      s390: convert release_thread() into a static inline function
      s390/runtime instrumention: fix possible memory corruption
      s390/runtime instrumentation: simplify task exit handling
      s390/guarded storage: fix possible memory corruption
      s390/ptrace: fix guarded storage regset handling
      s390/guarded storage: simplify task exit handling
      s390: get rid of exit_thread()
      s390: add support for FORTIFY_SOURCE
      s390/cpumf: remove superfluous nr_cpumask_bits check
      s390/virtio: simplify Makefile
      s390/disassembler: add missing end marker for e7 table
      s390/disassembler: fix LRDFU format
      s390/disassembler: remove double instructions
      s390/disassembler: add sthyi instruction
      s390/disassembler: add missing z13 instructions
      s390/disassembler: add new z14 instructions
      s390: use generic rwsem implementation
      s390: implement memset16, memset32 & memset64
      s390/mm: use memset64 instead of clear_table
      s390: optimize memset implementation
      s390: cleanup string ops prototypes
      s390/kprobes: remove KPROBE_SWAP_INST state
      s390/debug: adjust coding style
      s390: remove named saved segment support
      s390/disassembler: remove insn_to_mnemonic()
      s390/disassembler: generate opcode tables from text file
      s390: avoid undefined behaviour
      s390: simplify transactional execution elf hwcap handling
      Merge tag 'vfio-ccw-20171109' of git://git.kernel.org/.../kvms390/vfio-ccw into features
      s390: fix transactional execution control register handling
      s390/noexec: execute kexec datamover without DAT

Hendrik Brueckner (1):
      s390/cpum_cf: add hardware counter support for IBM z14

Himanshu Jha (1):
      s390/sclp: Use setup_timer and mod_timer

Jason J. Herne (1):
      s390: vfio-ccw: Do not attempt to free no-op, test and tic cda.

Jean Delvare (1):
      s390/char: fix cdev_add usage

Johannes Thumshirn (1):
      samples/kprobes: Add s390 case in kprobe example module

Julian Wiedmann (1):
      s390/ccwgroup: tie a ccwgroup driver to its ccw driver

Luc Van Oostenryck (1):
      s390: pass endianness info to sparse

Martin Schwidefsky (14):
      s390/topology: add detection of dedicated vs shared CPUs
      s390/spinlock: use the cpu number +1 as spinlock value
      s390/spinlock: introduce spinlock wait queueing
      s390/rwlock: introduce rwlock wait queueing
      Merge branch 'sthyi' into features
      s390: update defconfig
      Merge tag 'vfio-ccw-20171016' of git://git.kernel.org/.../kvms390/vfio-ccw into features
      s390/vdso: move boot_vdso_data to vdso.c
      s390/nmi: use smp_emergency_stop instead of smp_send_stop
      s390/ctl_reg: use decoding unions in update_cr_regs
      s390/ctl_reg: move control register definitions to ctl_reg.h
      s390/nmi: allocation of the extended save area
      s390/nmi: do register validation as early as possible
      s390/decompressor: remove informational messages

Michael Holzheu (1):
      s390/bpf: take advantage of stack_depth tracking

Patrick Steuer (1):
      s390/crypto: add inline assembly for KMA instruction to cpacf.h

Philipp Rudo (1):
      s390/kexec: Fix checksum validation return code for kdump

QingFeng Hao (3):
      s390/sthyi: reorganize sthyi implementation
      s390/sthyi: add cache to store hypervisor info
      s390/sthyi: add s390_sthyi system call

Sebastian Ott (12):
      s390/cmf: set_schib_wait add timeout
      s390/cmf: simplify set_schib_wait
      s390/cmf: simplify cmb_copy_wait
      s390/cmf: simplify copy_block
      s390/cmf: read from hw buffer
      s390/cmf: avg_utilization
      s390/cmf: use tod_to_ns()
      s390/debug: improve debug_event
      s390/debug: only write data once
      s390/dasd: remove unused debug macros
      s390/qdio: use atomic_cmpxchg
      s390/qdio: sanitize put_indicator

Thomas Huth (1):
      s390/virtio: remove the old KVM virtio transport

Vasily Gorbik (3):
      s390: introduce CPU alternatives
      s390/spinlock: use cpu alternatives to enable niai instruction
      s390/nmi: avoid using long-displacement facility

Vasyl Gomonovych (1):
      s390/pkey: fix kzalloc-simple.cocci warnings

 Documentation/admin-guide/kernel-parameters.txt |    3 +
 MAINTAINERS                                     |    1 +
 arch/s390/Kconfig                               |   43 +-
 arch/s390/Makefile                              |    3 +-
 arch/s390/boot/compressed/Makefile              |    2 +-
 arch/s390/boot/compressed/misc.c                |    2 -
 arch/s390/configs/default_defconfig             |   11 +-
 arch/s390/configs/gcov_defconfig                |    9 +-
 arch/s390/configs/performance_defconfig         |    9 +-
 arch/s390/crypto/aes_s390.c                     |  296 +++-
 arch/s390/defconfig                             |    3 -
 arch/s390/include/asm/Kbuild                    |    1 +
 arch/s390/include/asm/alternative.h             |  163 ++
 arch/s390/include/asm/archrandom.h              |   26 +-
 arch/s390/include/asm/atomic_ops.h              |   32 +-
 arch/s390/include/asm/ccwgroup.h                |    2 +
 arch/s390/include/asm/cpacf.h                   |   52 +-
 arch/s390/include/asm/ctl_reg.h                 |   32 +-
 arch/s390/include/asm/debug.h                   |  190 ++-
 arch/s390/include/asm/dis.h                     |   28 +-
 arch/s390/include/asm/ipl.h                     |    3 +-
 arch/s390/include/asm/kprobes.h                 |    2 -
 arch/s390/include/asm/kvm_host.h                |    1 -
 arch/s390/include/asm/lowcore.h                 |    5 +-
 arch/s390/include/asm/nmi.h                     |   19 +-
 arch/s390/include/asm/pci_debug.h               |    6 +-
 arch/s390/include/asm/pci_insn.h                |    2 +-
 arch/s390/include/asm/pgalloc.h                 |   18 +-
 arch/s390/include/asm/processor.h               |    8 +-
 arch/s390/include/asm/runtime_instr.h           |   86 +-
 arch/s390/include/asm/rwsem.h                   |  210 ---
 arch/s390/include/asm/sections.h                |    2 +-
 arch/s390/include/asm/setup.h                   |    3 -
 arch/s390/include/asm/smp.h                     |    5 +
 arch/s390/include/asm/spinlock.h                |  167 +-
 arch/s390/include/asm/spinlock_types.h          |    4 +-
 arch/s390/include/asm/string.h                  |   46 +-
 arch/s390/include/asm/switch_to.h               |    2 +-
 arch/s390/include/asm/sysinfo.h                 |    4 +-
 arch/s390/include/asm/topology.h                |    2 +
 arch/s390/include/asm/vdso.h                    |    1 +
 arch/s390/include/uapi/asm/kvm_virtio.h         |   64 -
 arch/s390/include/uapi/asm/sthyi.h              |    6 +
 arch/s390/include/uapi/asm/unistd.h             |    3 +-
 arch/s390/kernel/Makefile                       |    5 +-
 arch/s390/kernel/alternative.c                  |  110 ++
 arch/s390/kernel/asm-offsets.c                  |    5 +
 arch/s390/kernel/compat_wrapper.c               |    1 +
 arch/s390/kernel/debug.c                        |  916 +++++-----
 arch/s390/kernel/dis.c                          | 2039 ++++-------------------
 arch/s390/kernel/early.c                        |  145 +-
 arch/s390/kernel/entry.S                        |   60 +-
 arch/s390/kernel/entry.h                        |    1 +
 arch/s390/kernel/guarded_storage.c              |    7 +-
 arch/s390/kernel/ipl.c                          |   36 -
 arch/s390/kernel/kprobes.c                      |    7 -
 arch/s390/kernel/machine_kexec.c                |   22 +-
 arch/s390/kernel/module.c                       |   17 +
 arch/s390/kernel/nmi.c                          |  203 ++-
 arch/s390/kernel/perf_cpum_cf_events.c          |  278 ++-
 arch/s390/kernel/perf_cpum_sf.c                 |    6 +-
 arch/s390/kernel/process.c                      |   18 +-
 arch/s390/kernel/ptrace.c                       |  172 +-
 arch/s390/kernel/relocate_kernel.S              |    3 -
 arch/s390/kernel/runtime_instr.c                |   42 +-
 arch/s390/kernel/setup.c                        |   21 +-
 arch/s390/kernel/smp.c                          |   87 +-
 arch/s390/{kvm => kernel}/sthyi.c               |  172 +-
 arch/s390/kernel/suspend.c                      |    8 +-
 arch/s390/kernel/syscalls.S                     |    1 +
 arch/s390/kernel/topology.c                     |   43 +-
 arch/s390/kernel/vdso.c                         |   20 +-
 arch/s390/kernel/vmlinux.lds.S                  |   28 +-
 arch/s390/kvm/Makefile                          |    2 +-
 arch/s390/kvm/intercept.c                       |   56 +
 arch/s390/kvm/interrupt.c                       |    6 +-
 arch/s390/kvm/kvm-s390.c                        |    4 +-
 arch/s390/kvm/kvm-s390.h                        |    5 +-
 arch/s390/lib/mem.S                             |   64 +-
 arch/s390/lib/spinlock.c                        |  343 ++--
 arch/s390/lib/string.c                          |   28 +-
 arch/s390/mm/init.c                             |    4 +-
 arch/s390/mm/pgalloc.c                          |   14 +-
 arch/s390/mm/vmem.c                             |   16 +-
 arch/s390/net/bpf_jit.h                         |    7 +-
 arch/s390/net/bpf_jit_comp.c                    |   26 +-
 arch/s390/pci/pci.c                             |    5 +-
 arch/s390/pci/pci_insn.c                        |    6 +-
 arch/s390/tools/Makefile                        |   10 +
 arch/s390/tools/gen_opcode_table.c              |  336 ++++
 arch/s390/tools/opcodes.txt                     | 1183 +++++++++++++
 drivers/s390/block/dasd_eer.c                   |   16 +-
 drivers/s390/block/dasd_int.h                   |   16 -
 drivers/s390/block/scm_blk.h                    |    8 +-
 drivers/s390/char/sclp_con.c                    |    7 +-
 drivers/s390/char/sclp_tty.c                    |    7 +-
 drivers/s390/char/tape_class.c                  |    3 +-
 drivers/s390/char/vmlogrdr.c                    |    3 +-
 drivers/s390/char/vmur.c                        |   11 +-
 drivers/s390/char/vmur.h                        |    4 +-
 drivers/s390/cio/ccwgroup.c                     |    6 +
 drivers/s390/cio/chsc_sch.c                     |    6 +-
 drivers/s390/cio/cio_debug.h                    |    8 +-
 drivers/s390/cio/cmf.c                          |  278 ++-
 drivers/s390/cio/eadm_sch.c                     |    8 +-
 drivers/s390/cio/qdio_debug.h                   |   18 +-
 drivers/s390/cio/qdio_thinint.c                 |   10 +-
 drivers/s390/cio/vfio_ccw_cp.c                  |   24 +-
 drivers/s390/crypto/ap_asm.h                    |   43 +
 drivers/s390/crypto/ap_bus.c                    |   74 +-
 drivers/s390/crypto/ap_bus.h                    |    4 +-
 drivers/s390/crypto/ap_card.c                   |   12 +-
 drivers/s390/crypto/ap_queue.c                  |    4 +-
 drivers/s390/crypto/pkey_api.c                  |    3 +-
 drivers/s390/crypto/zcrypt_api.h                |    1 +
 drivers/s390/crypto/zcrypt_cex4.c               |   48 +-
 drivers/s390/crypto/zcrypt_msgtype50.c          |    6 +-
 drivers/s390/crypto/zcrypt_msgtype6.c           |    3 +-
 drivers/s390/net/ctcm_main.c                    |    1 +
 drivers/s390/net/lcs.c                          |    1 +
 drivers/s390/net/qeth_core_main.c               |    1 +
 drivers/s390/virtio/Makefile                    |    6 +-
 drivers/s390/virtio/kvm_virtio.c                |  515 ------
 include/uapi/linux/elf.h                        |    1 +
 samples/kprobes/kprobe_example.c                |    8 +
 125 files changed, 4751 insertions(+), 4578 deletions(-)
 create mode 100644 arch/s390/include/asm/alternative.h
 delete mode 100644 arch/s390/include/asm/rwsem.h
 delete mode 100644 arch/s390/include/uapi/asm/kvm_virtio.h
 create mode 100644 arch/s390/include/uapi/asm/sthyi.h
 create mode 100644 arch/s390/kernel/alternative.c
 rename arch/s390/{kvm => kernel}/sthyi.c (77%)
 create mode 100644 arch/s390/tools/gen_opcode_table.c
 create mode 100644 arch/s390/tools/opcodes.txt
 delete mode 100644 drivers/s390/virtio/kvm_virtio.c
