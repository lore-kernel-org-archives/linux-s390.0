From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Thu, 29 Oct 2015 15:50:38 -0700
Message-ID: <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com> <5631629B.2050505@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5631629B.2050505@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 28, 2015 at 5:04 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Am 29.10.2015 um 07:22 schrieb Andy Lutomirski:
>> On Tue, Oct 27, 2015 at 3:48 PM, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>> This is an RFC to check if I am on the right track.  There
>>> are some attempts to unify the dma ops (Christoph) as well
>>> as some attempts to make virtio use the dma API (Andy).
>>>
>>> At todays discussion at the kernel summit, we concluded that
>>> we want to use the same code on all platforms, whereever
>>> possible, so having a dummy dma_op might be the easiest
>>> solution to keep virtio-ccw as similar as possible to
>>> virtio-pci. Andy Lutomirski will rework his patchset to
>>> unconditionally use the dma ops.  We will also need a
>>> compatibility quirk for powerpc to bypass the iommu mappings
>>> on older QEMU version (which translates to all versions as
>>> of today) and per device, e.g.  via device tree.  Ben
>>> Herrenschmidt will look into that.
>>
>> The combination of these patches plus my series don't link for me
>> unless I enable PCI.  Would s390 need to select HAS_DMA from VIRTIO or
>> something similar?
>
> Well, actually this is a potential improvement for series. I could just
> make the noop dma ops default for _all_ devices unless it has a per
> device dma_ops (e.g. s390 pci) and the unconditionally set HAS_DMA.
>>
>> Also, is it possible to use QEMU to emulate an s390x?  Even just:
>>
>> qemu-system-s390x -M s390-ccw-virtio
>
> Yes, we have no interactive bios and if no boot device is there is bios
> will load a disabled wait, which will exit qemu.
>
> Make sure to compile your kernel for z900  (processor type) as qemu does not
> handle all things of newer processors.
> You can then do
> qemu-system-s390x -nographic -m 256 -kernel vmlinux -initrd <something>
>

Progress!  After getting that sort-of-working, I figured out what was
wrong with my earlier command, and I got that working, too.  Now I
get:

qemu-system-s390x -fsdev
local,id=virtfs1,path=/,security_model=none,readonly -device
virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
-nodefaults -device sclpconsole,chardev=console -parallel none -net
none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
-serial chardev:console -mon chardev=console -vga none -display none
-kernel arch/s390/boot/bzImage -append
'init=/home/luto/devel/virtme/virtme/guest/virtme-init
psmouse.proto=exps "virtme_stty_con=rows 24 cols 150 iutf8"
TERM=xterm-256color rootfstype=9p
rootflags=ro,version=9p2000.L,trans=virtio,access=any
raid=noautodetect debug'
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.3.0-rc7-00403-ga2b5cd810259-dirty
(luto@amaluto.corp.amacapital.net) (gcc version 5.1.1 20150618 (Red
Hat Cross 5.1.1-3) (GCC) ) #328 SMP Thu Oct 29 15:46:05 PDT 2015
setup: Linux is running under KVM in 64-bit mode
setup: Max memory size: 128MB
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000007fffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
On node 0 totalpages: 32768
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 32768 pages, LIFO batch:7
PERCPU: Embedded 466 pages/cpu @0000000007605000 s1868032 r8192 d32512 u1908736
pcpu-alloc: s1868032 r8192 d32512 u1908736 alloc=466*4096
pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
Kernel command line:
init=/home/luto/devel/virtme/virtme/guest/virtme-init
psmouse.proto=exps "virtme_stty_con=rows 24 cols 150 iutf8"
TERM=xterm-256color rootfstype=9p
rootflags=ro,version=9p2000.L,trans=virtio,access=any
raid=noautodetect debug
PID hash table entries: 512 (order: 0, 4096 bytes)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Memory: 92552K/131072K available (8229K kernel code, 798K rwdata,
3856K rodata, 2384K init, 14382K bss, 38520K reserved, 0K
cma-reserved)
Write protected kernel read-only data: 0x100000 - 0xccdfff
SLUB: HWalign=256, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Running RCU self tests
Hierarchical RCU implementation.
    RCU debugfs-based tracing is enabled.
    RCU lockdep checking is enabled.
    Build-time adjustment of leaf fanout to 64.
    RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=2
NR_IRQS:3
clocksource: tod: mask: 0xffffffffffffffff max_cycles:
0x3b0a9be803b0a9, max_idle_ns: 1805497147909793 ns
console [ttyS1] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 8671 kB
 per task-struct memory footprint: 2688 bytes
Calibrating delay loop (skipped)... 13370.00 BogoMIPS preset
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
Initializing cgroup subsys io
Initializing cgroup subsys memory
ftrace: allocating 20968 entries in 82 pages
cpu: 1 configured CPUs, 0 standby CPUs
Brought up 1 CPUs
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
xor: measuring software checksum speed
   8regs     :   158.800 MB/sec
   8regs_prefetch:   158.000 MB/sec
QEMU: Terminated
[luto@amaluto linux-devel]$
/home/luto/apps/qemu/s390x-softmmu/qemu-system-s390x -fsdev
local,id=virtfs1,path=/,security_model=none,readonly -device
virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
-nodefaults -device sclpconsole,chardev=console -parallel none -net
none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
-serial chardev:console -mon chardev=console -vga none -display none
-kernel arch/s390/boot/bzImage -append debug
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.3.0-rc7-00403-ga2b5cd810259-dirty
(luto@amaluto.corp.amacapital.net) (gcc version 5.1.1 20150618 (Red
Hat Cross 5.1.1-3) (GCC) ) #328 SMP Thu Oct 29 15:46:05 PDT 2015
setup: Linux is running under KVM in 64-bit mode
setup: Max memory size: 128MB
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000007fffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
On node 0 totalpages: 32768
  DMA zone: 512 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 32768 pages, LIFO batch:7
PERCPU: Embedded 466 pages/cpu @0000000007605000 s1868032 r8192 d32512 u1908736
pcpu-alloc: s1868032 r8192 d32512 u1908736 alloc=466*4096
pcpu-alloc: [0] 0 [0] 1
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
Kernel command line: debug
PID hash table entries: 512 (order: 0, 4096 bytes)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Memory: 92552K/131072K available (8229K kernel code, 798K rwdata,
3856K rodata, 2384K init, 14382K bss, 38520K reserved, 0K
cma-reserved)
Write protected kernel read-only data: 0x100000 - 0xccdfff
SLUB: HWalign=256, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Running RCU self tests
Hierarchical RCU implementation.
    RCU debugfs-based tracing is enabled.
    RCU lockdep checking is enabled.
    Build-time adjustment of leaf fanout to 64.
    RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=2
NR_IRQS:3
clocksource: tod: mask: 0xffffffffffffffff max_cycles:
0x3b0a9be803b0a9, max_idle_ns: 1805497147909793 ns
console [ttyS1] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
 memory used by lock dependency info: 8671 kB
 per task-struct memory footprint: 2688 bytes
Calibrating delay loop (skipped)... 13370.00 BogoMIPS preset
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
Initializing cgroup subsys io
Initializing cgroup subsys memory
ftrace: allocating 20968 entries in 82 pages
cpu: 1 configured CPUs, 0 standby CPUs
Brought up 1 CPUs
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
xor: measuring software checksum speed
   8regs     :   159.200 MB/sec
   8regs_prefetch:   159.200 MB/sec
   32regs    :   696.800 MB/sec
   32regs_prefetch:   692.000 MB/sec
xor: using function: 32regs (696.800 MB/sec)
NET: Registered protocol family 16
raid6: int64x1  gen()   517 MB/s
raid6: int64x1  xor()   321 MB/s
raid6: int64x2  gen()   610 MB/s
raid6: int64x2  xor()   354 MB/s
raid6: int64x4  gen()   467 MB/s
raid6: int64x4  xor()   241 MB/s
raid6: int64x8  gen()   288 MB/s
raid6: int64x8  xor()   194 MB/s
raid6: using algorithm int64x2 gen() 610 MB/s
raid6: .... xor() 354 MB/s, rmw enabled
raid6: using intx1 recovery algorithm
SCSI subsystem initialized
cio: event: sch 0.0.0000, new
cio: Subchannel 0.0.0000 reports subchannel type 0000
cio: chsc: ssd failed for 0.0.0000 (rc=0004)
cio: Detected device 0000 on subchannel 0.0.0000 - PIM = 80, PAM = 80, POM = FF
cio: event: sch 0.0.0000, process=1, action=2
snsid: device 0.0.0000: rc=0 3832/09 0000/00
cio: cdev_todo: sched cdev=0.0.0000 todo=3
cio: cdev_todo: cdev=0.0.0000 todo=3
cio: chsc: ssd failed for 0.0.0000 (rc=0004)
cio: chsc: scm info failed (rc=0004)
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 4, 81920 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 3, 49152 bytes)
UDP-Lite hash table entries: 256 (order: 3, 49152 bytes)
NET: Registered protocol family 1
hypfs: The hardware system does not support hypfs
hypfs: Initialization of hypfs failed with rc=-61
futex hash table entries: 512 (order: 5, 131072 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1446158888.684:1): initialized
Kprobe smoke test: started
Kprobe smoke test: passed successfully
hugetlbfs: disabling because there are no supported hugepage sizes
fuse init (API version 7.23)
SGI XFS with ACLs, security attributes, realtime, no debug enabled
9p: Installing v9fs 9p2000 file system support
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
start plist test
end plist test
hvc_iucv: The z/VM IUCV HVC device driver cannot be used without z/VM
brd: module loaded
st: Version 20101219, fixed bufsize 32768, s/g segs 256
cio: Channel measurement facility initialized using format extended
(mode autodetected)
dasd: debug area created
Discipline DIAG cannot be used without z/VM
qeth: loading core functions
qeth: register layer 2 discipline
qeth: register layer 3 discipline
oprofile: using timer interrupt.
NET: Registered protocol family 10
vrfy: device 0.0.0000: rc=0 pgroup=0 mpath=0 vpm=80
virtio_ccw 0.0.0000: Failed to set online: -5

^^^ bad news!

sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
8021q: 802.1Q VLAN Support v1.8
9pnet: Installing 9P2000 support
registered taskstats version 1
Btrfs loaded
List of all partitions:
0100            4096 ram0  (driver?)
0101            4096 ram1  (driver?)
0102            4096 ram2  (driver?)
0103            4096 ram3  (driver?)
0104            4096 ram4  (driver?)
0105            4096 ram5  (driver?)
0106            4096 ram6  (driver?)
0107            4096 ram7  (driver?)
0108            4096 ram8  (driver?)
0109            4096 ram9  (driver?)
010a            4096 ram10  (driver?)
010b            4096 ram11  (driver?)
010c            4096 ram12  (driver?)
010d            4096 ram13  (driver?)
010e            4096 ram14  (driver?)
010f            4096 ram15  (driver?)
No filesystem could mount root, tried:  ext3 ext2 ext4 fuseblk xfs btrfs
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)

I see this with and without this patch series -- 4.3-rc7 by itself
fails like this.  Is there some further magic incantation I need?

I hacked up debug_sprintf_event to log to the console, hence the extra
messages above.

--Andy
