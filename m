From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH/RFC 0/4] dma ops and virtio
Date: Mon, 2 Nov 2015 12:23:25 -0800
Message-ID: <CALCETrXURKZCwBYLvPof9KZyrfFA6moEyLCQgssmqQmM-OVniQ@mail.gmail.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <CALCETrVOsq4+z1HzQ2vthuHB91nt9FJ1a3jiAuOe5Fyb5vGXQA@mail.gmail.com>
 <5631629B.2050505@de.ibm.com> <CALCETrWcSKPUBvYQO4UuThtkUo6=c-HKJTpWKbYc5qgX6bth=Q@mail.gmail.com>
 <20151030092548.7abd51e1.cornelia.huck@de.ibm.com> <CALCETrWb5JAeRtsmPEuNNMY-oL1WyLMrr5sh=WL45K-Wq0gVeQ@mail.gmail.com>
 <20151102121658.11aa3375.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151102121658.11aa3375.cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <jroedel@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 2, 2015 at 3:16 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> On Fri, 30 Oct 2015 13:33:07 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> On Fri, Oct 30, 2015 at 1:25 AM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
>> > On Thu, 29 Oct 2015 15:50:38 -0700
>> > Andy Lutomirski <luto@amacapital.net> wrote:
>> >
>> >> Progress!  After getting that sort-of-working, I figured out what was
>> >> wrong with my earlier command, and I got that working, too.  Now I
>> >> get:
>> >>
>> >> qemu-system-s390x -fsdev
>> >> local,id=virtfs1,path=/,security_model=none,readonly -device
>> >> virtio-9p-ccw,fsdev=virtfs1,mount_tag=/dev/root -M s390-ccw-virtio
>> >> -nodefaults -device sclpconsole,chardev=console -parallel none -net
>> >> none -echr 1 -serial none -chardev stdio,id=console,signal=off,mux=on
>> >> -serial chardev:console -mon chardev=console -vga none -display none
>> >> -kernel arch/s390/boot/bzImage -append
>> >> 'init=/home/luto/devel/virtme/virtme/guest/virtme-init
>> >> psmouse.proto=exps "virtme_stty_con=rows 24 cols 150 iutf8"
>> >> TERM=xterm-256color rootfstype=9p
>> >> rootflags=ro,version=9p2000.L,trans=virtio,access=any
>> >> raid=noautodetect debug'
>> >
>> > The commandline looks sane AFAICS.
>> >
>> > (...)
>> >
>> >> vrfy: device 0.0.0000: rc=0 pgroup=0 mpath=0 vpm=80
>> >> virtio_ccw 0.0.0000: Failed to set online: -5
>> >>
>> >> ^^^ bad news!
>> >
>> > I'd like to see where in the onlining process this fails. Could you set
>> > up qemu tracing for css_* and virtio_ccw_* (instructions in
>> > qemu/docs/tracing.txt)?
>>
>> I have a file called events that contains:
>>
>> css_*
>> virtio_ccw_*
>>
>> pointing -trace events= at it results in a trace-<pid> file that's 549
>> bytes long and contains nothing.  Are wildcards not as well-supported
>> as the docs suggest?
>
> Just tried it, seemed to work for me as expected. And as your messages
> indicate, at least some of the css tracepoints are guaranteed to be
> hit. Odd.
>
> Can you try the following sophisticated printf debug patch?
>
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index c033612..6a87bd6 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -308,6 +308,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr)
>          sch->ccw_no_data_cnt++;
>      }
>
> +    fprintf(stderr, "CH DBG: %s: cmd_code=%x\n", __func__, ccw.cmd_code);
> +
>      /* Look at the command. */
>      switch (ccw.cmd_code) {
>      case CCW_CMD_NOOP:
> @@ -375,6 +377,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr)
>          }
>          break;
>      }
> +    fprintf(stderr, "CH DBG: %s: ret=%d\n", __func__, ret);
>      sch->last_cmd = ccw;
>      sch->last_cmd_valid = true;
>      if (ret == 0) {
>
>
>> > Which qemu version is this, btw.?
>> >
>>
>> git from yesterday.
>
> Hm. Might be worth trying the s390-ccw-virtio-2.4 machine instead.
>

No change.

With s390-ccw-virtio-2.4, I get:

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 4.3.0-rc7-00008-gff230d6ec6b2
(luto@amaluto.corp.amacapital.net) (gcc version 5.1.1 20150618 (Red
Hat Cross 5.1.1-3) (GCC) ) #344 SMP Fri Oct 30 13:16:13 PDT 2015
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
psmouse.proto=exps "virtme_stty_con=rows 45 cols 150 iutf8"
TERM=xterm-256color rootfstype=9p
rootflags=version=9p2000.L,trans=virtio,access=any raid=noautodetect
ro debug
PID hash table entries: 512 (order: 0, 4096 bytes)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Memory: 92520K/131072K available (8255K kernel code, 802K rwdata,
3860K rodata, 2384K init, 14382K bss, 38552K reserved, 0K
cma-reserved)
Write protected kernel read-only data: 0x100000 - 0xcd4fff
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
ftrace: allocating 21000 entries in 83 pages
cpu: 1 configured CPUs, 0 standby CPUs
Brought up 1 CPUs
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 19112604462750000 ns
xor: measuring software checksum speed
   8regs     :   152.800 MB/sec
   8regs_prefetch:   152.400 MB/sec
   32regs    :   695.200 MB/sec
   32regs_prefetch:   680.000 MB/sec
xor: using function: 32regs (695.200 MB/sec)
NET: Registered protocol family 16
raid6: int64x1  gen()   519 MB/s
raid6: int64x1  xor()   321 MB/s
raid6: int64x2  gen()   611 MB/s
raid6: int64x2  xor()   357 MB/s
raid6: int64x4  gen()   301 MB/s
raid6: int64x4  xor()   337 MB/s
raid6: int64x8  gen()   290 MB/s
raid6: int64x8  xor()   189 MB/s
raid6: using algorithm int64x2 gen() 611 MB/s
raid6: .... xor() 357 MB/s, rmw enabled
raid6: using intx1 recovery algorithm
SCSI subsystem initialized
CH DBG: css_interpret_ccw: cmd_code=e4
CH DBG: css_interpret_ccw: ret=0
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
audit: type=2000 audit(1446495676.052:1): initialized
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
Discipline DIAG cannot be used without z/VM
qeth: loading core functions
CH DBG: css_interpret_ccw: cmd_code=3
CH DBG: css_interpret_ccw: ret=0
CH DBG: css_interpret_ccw: cmd_code=83
CH DBG: css_interpret_ccw: ret=-38
qeth: register layer 2 discipline
qeth: register layer 3 discipline
oprofile: using timer interrupt.
NET: Registered protocol family 10
virtio_ccw 0.0.0000: Failed to set online: -5
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
8021q: 802.1Q VLAN Support v1.8
9pnet: Installing 9P2000 support
registered taskstats version 1
Btrfs loaded
9pnet_virtio: no channels available

The lack of much interesting output makes me think that maybe I
misconfigured something.

--Andy
