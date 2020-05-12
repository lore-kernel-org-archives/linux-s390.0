Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgELRkG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 May 2020 13:40:06 -0400
Date: Tue, 12 May 2020 19:39:56 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: s390x: kdump kernel can not boot if I load kernel and initrd
 images via the kexec_file_load syscall.
Message-ID: <20200512193956.15ae3f23@laptop2-ibm.local>
In-Reply-To: <79241fab-3299-1ba3-1c2b-a29eb4e0af7c@redhat.com>
References: <4d7ff4bb-f09e-7aec-964f-f5cc2412e5b7@redhat.com>
        <20200511111558.2d3e3db3@laptop2-ibm.local>
        <20200511170146.28eaafed@laptop2-ibm.local>
        <19903f1e-b3ae-730e-8a02-ed30fb47e9ba@redhat.com>
        <559a3c8f-9da9-a64d-aa78-434365c4b271@redhat.com>
        <79241fab-3299-1ba3-1c2b-a29eb4e0af7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: lijiang <lijiang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Baoquan He <bhe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Lianbo,

stupid me obviously never tested the kdump+initrd combination...

The patch below fixed the problem for me. Could please give it a try, too.

Thanks
Philipp

---

From 3f77088c9139582261d2e3ee6476324fc1ded401 Mon Sep 17 00:00:00 2001
From: Philipp Rudo <prudo@linux.ibm.com>
Date: Tue, 12 May 2020 19:25:14 +0200
Subject: [PATCH] s390/kexec_file: fix initrd location for kdump kernel

initrd_start must not point at the location the initrd is loaded into
the crashkernel memory but at the location it will be after the
crashkernel memory is swapped with the memory at 0.

Fixes: ee337f5469fd ("s390/kexec_file: Add crash support to image loader")
Reported-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
---
 arch/s390/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8415ae7d2a23..f9e4baa64b67 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -151,7 +151,7 @@ static int kexec_file_add_initrd(struct kimage *image,
 		buf.mem += crashk_res.start;
 	buf.memsz = buf.bufsz;
 
-	data->parm->initrd_start = buf.mem;
+	data->parm->initrd_start = data->memsz;
 	data->parm->initrd_size = buf.memsz;
 	data->memsz += buf.memsz;
 
-- 
2.17.1


On Tue, 12 May 2020 18:03:56 +0800
lijiang <lijiang@redhat.com> wrote:

> There may be more people who would like to care about this issue. So I added
> them to cc list.
> 
> Thanks.
> Lianbo
> 
> 在 2020年05月12日 17:47, lijiang 写道:
> > Also added Dave Young to the cc list. Thanks.
> > 
> > 在 2020年05月12日 10:52, lijiang 写道:  
> >> 在 2020年05月11日 23:01, Philipp Rudo 写道:  
> >>> Hi Lianbo,
> >>>  
> >> Thank you for this reply, Philipp.
> >>  
> >>> one more question. Does the same problem occur withe the kexec_load syscall,
> >>> i.e. option '-c' instead of '-s'?
> >>>  
> >> No, kdump kernel can boot with the kexec_load syscal option '-c'.
> >>
> >> Currently, I only found kdump kernel can not boot with the kexec_file_load syscall(option '-s').
> >>  
> >>> Thanks
> >>> Philipp
> >>>
> >>> On Mon, 11 May 2020 11:15:58 +0200
> >>> Philipp Rudo <prudo@linux.ibm.com> wrote:
> >>>  
> >>>> Hi Lianbo,
> >>>>
> >>>> I believe that your crashkernel memory is simply too small. Pretty much at the
> >>>> beginning of the kernel log you have
> >>>>  
> >>>>> [    0.070468] setup: The initial RAM disk does not fit into the memory  
> >>>>
> >>>> Although I must say 256M should be enough for most purposes...
> >>>>
> >>>> Could you please retry with a bigger crashkernel memory?
> >>>>  
> >>
> >> I increased the size of crash memory to 512M(crashkernel=512M), kdump kernel still can
> >> not boot, there is a same issue.
> >>
> >> I added some debug information in the arch/s390/kernel/setup.c, and got the following logs:
> >>
> >> [    0.070885] Linux version 5.7.0-rc5+ (root@ibm-z-124.rhts.eng.bos.redhat.com)
> >>  (gcc version 8.3.1 20191121 (Red Hat 8.3.1-5) (GCC), GNU ld version 2.30-73.el8
> >> ) #3 SMP Mon May 11 10:28:57 EDT 2020                                           
> >> [    0.070888] setup: Linux is running as a z/VM guest operating system in 64-bi
> >> t mode                                                                          
> >> [    0.071125] lijiang-debug initrd_start:4aeeb000 size:17180900    <----------------------                
> >> [    0.071128] setup: The maximum memory size is 2048MB                         
> >> [    0.071130] cma: Reserved 4 MiB at 0x000000001fc00000                        
> >> [    0.071131] setup: The initial RAM disk does not fit into the memory         
> >> [    0.071132] lijiang-debug: check_initrd 810 start:4aeeb000, size:17180900  <----------------------      
> >> [    0.099765] cpu: 2 configured CPUs, 0 standby CPUs  
> >>
> >> The size of initrd is 17M, the 512M memory should be enough. I could suspect that kdump
> >> kernel doesn't find an appropriate memory block, thereby this causes the failure.
> >>
> >> The compressed initrd is really decompressed in the unpack_to_rootfs().
> >>
> >> I have a s390 machine with 2cpus and 2G memory, which is too slow. :-)
> >>
> >>
> >> Thanks.
> >> Lianbo
> >>
> >>  
> >>>> Thanks
> >>>> Philipp
> >>>>
> >>>>
> >>>> On Fri, 8 May 2020 18:45:56 +0800
> >>>> lijiang <lijiang@redhat.com> wrote:
> >>>>  
> >>>>> Hi, Philipp Rudo
> >>>>>
> >>>>> Sorry to disturb you. I ran into a problem on s390 machine, can you help to have a look?
> >>>>>
> >>>>> Kdump kernel can not boot on s390x machines if I load the kernel and initrd images with the kexec_file_load() syscall as below:
> >>>>>
> >>>>> #kexec -s -p /boot//boot/vmlinuz-5.7.0-rc4+ --initrd=/boot/initramfs-5.7.0-rc4+kdump.img --command-line="rd.dasd=0.0.0120 rd.dasd=0.0.0121 rd.dasd=0.0.0122 rd.dasd=0.0.0123 rd.znet=qeth,0.0.8000,0.0.8001,0.0.8002,layer2=1,portname=z-126,portno=0 $tuned_params BOOT_IMAGE=0 nr_cpus=1 cgroup_disable=memory numa=off udev.children-max=2 panic=10 rootflags=nofail transparent_hugepage=never novmcoredd nokaslr"
> >>>>>
> >>>>> But the kexec reboot can work well if I use the kexec_file_load() syscall as follow:
> >>>>>
> >>>>> #kexec -s -l  /boot//boot/vmlinuz-5.7.0-rc4+ --initrd=/boot/initramfs-5.7.0-rc4+kdump.img --command-line="root=/dev/mapper/rhel_ibm--z--126-root crashkernel=256M rd.dasd=0.0.0120 rd.dasd=0.0.0121 rd.dasd=0.0.0122 rd.dasd=0.0.0123 rd.lvm.lv=rhel_ibm-z-126/root rd.lvm.lv=rhel_ibm-z-126/swap rd.znet=qeth,0.0.8000,0.0.8001,0.0.8002,layer2=1,portname=z-126,portno=0 $tuned_params BOOT_IMAGE=0"
> >>>>>
> >>>>> I added the debug information in the populate_rootfs() (init/initramfs.c), and I found that the address of initrd_start is null, and also
> >>>>> checked the process of kexec file load, I didn't see any errors. It's strange. Any suggestions will be appreciated.
> >>>>>  
> >>>>> BTW: I put the kernel log at the end.
> >>>>>
> >>>>> Thanks.
> >>>>> Lianbo
> >>>>>
> >>>>>
> >>>>> kdump kernel log:
> >>>>>
> >>>>> 01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
> >>>>>  CPU 01.                                                                        
> >>>>> 01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
> >>>>>  CPU 00.                                                                        
> >>>>> [    0.070339] Linux version 5.7.0-rc4+ (root@ibm-z-126.rhts.eng.bos.redhat.com)
> >>>>>  (gcc version 8.3.1 20191121 (Red Hat 8.3.1-5) (GCC), GNU ld version 2.30-73.el8
> >>>>> ) #2 SMP Thu May 7 22:29:25 EDT 2020                                            
> >>>>> [    0.070344] setup: Linux is running as a z/VM guest operating system in 64-bi
> >>>>> t mode                                                                          
> >>>>> [    0.070464] setup: The maximum memory size is 2048MB                         
> >>>>> [    0.070468] cma: Reserved 4 MiB at 0x000000000fc00000                        
> >>>>> [    0.070468] setup: The initial RAM disk does not fit into the memory         
> >>>>> [    0.112609] cpu: 2 configured CPUs, 0 standby CPUs                           
> >>>>> [    0.112731] Write protected kernel read-only data: 10116k                    
> >>>>>
> >>>>> [    0.112747] Zone ranges:                                                     
> >>>>> [    0.112748]   DMA      [mem 0x0000000000000000-0x000000007fffffff]           
> >>>>> [    0.112750]   Normal   empty                                                 
> >>>>> [    0.112751] Movable zone start for each node                                 
> >>>>> [    0.112752] Early memory node ranges                                         
> >>>>> [    0.112753]   node   0: [mem 0x0000000000000000-0x000000000fffffff]          
> >>>>> [    0.112772] Initmem setup node 0 [mem 0x0000000000000000-0x000000000fffffff] 
> >>>>> [    0.115953] percpu: Embedded 33 pages/cpu s96256 r8192 d30720 u135168        
> >>>>> [    0.115976] Built 1 zonelists, mobility grouping on.  Total pages: 64512     
> >>>>> [    0.115977] Policy zone: DMA                                                 
> >>>>> [    0.115979] Kernel command line: rd.dasd=0.0.0120 rd.dasd=0.0.0121 rd.dasd=0.
> >>>>> 0.0122 rd.dasd=0.0.0123 rd.znet=qeth,0.0.8000,0.0.8001,0.0.8002,layer2=1,portnam
> >>>>> e=z-126,portno=0 $tuned_params BOOT_IMAGE=0 nr_cpus=1 cgroup_disable=memory numa
> >>>>> =off udev.children-max=2 panic=10 rootflags=nofail transparent_hugepage=never no
> >>>>> vmcoredd nokaslr                                                                
> >>>>> [    0.117247] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes, l
> >>>>> inear)                                                                          
> >>>>> [    0.117271] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes, li
> >>>>> near)                                                                           
> >>>>> [    0.117297] mem auto-init: stack:off, heap alloc:off, heap free:off          
> >>>>> [    0.121169] Memory: 237484K/262144K available (7652K kernel code, 1384K rwdat
> >>>>> a, 2464K rodata, 3324K init, 816K bss, 20564K reserved, 4096K cma-reserved)     
> >>>>> [    0.121220] random: get_random_u64 called from cache_random_seq_create+0x6a/0
> >>>>> x160 with crng_init=0                                                           
> >>>>> [    0.121310] SLUB: HWalign=256, Order=0-3, MinObjects=0, CPUs=1, Nodes=1      
> >>>>> [    0.121321] ftrace: allocating 25822 entries in 101 pages                    
> >>>>> [    0.137295] ftrace: allocated 101 pages with 4 groups                        
> >>>>> [    0.137389] rcu: Hierarchical RCU implementation.                            
> >>>>> [    0.137390] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=1.  
> >>>>> [    0.137392] rcu: RCU calculated value of scheduler-enlistment delay is 10 jif
> >>>>> fies.                                                                           
> >>>>> [    0.137393] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1     
> >>>>> [    0.140929] NR_IRQS: 3, nr_irqs: 3, preallocated irqs: 3                     
> >>>>> [    0.140977] clocksource: tod: mask: 0xffffffffffffffff max_cycles: 0x3b0a9be8
> >>>>> 03b0a9, max_idle_ns: 1805497147909793 ns                                        
> >>>>> [    0.141001] Console: colour dummy device 80x25                               
> >>>>> [    0.142713] random: fast init done                                           
> >>>>> [    0.144414] printk: console [ttyS0] enabled                                  
> >>>>> [    0.144563] pid_max: default: 32768 minimum: 301                             
> >>>>> [    0.144598] LSM: Security Framework initializing                             
> >>>>> [    0.144614] Yama: becoming mindful.                                          
> >>>>> [    0.144621] SELinux:  Initializing.                                          
> >>>>> [    0.144655] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear
> >>>>> )                                                                               
> >>>>> [    0.144657] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, l
> >>>>> inear)                                                                          
> >>>>> [    0.144877] Disabling memory control group subsystem                         
> >>>>> [    0.145087] rcu: Hierarchical SRCU implementation.                           
> >>>>> [    0.145249] smp: Bringing up secondary CPUs ...                              
> >>>>> [    0.145251] smp: Brought up 1 node, 1 CPU                                    
> >>>>> [    0.145365] devtmpfs: initialized                                            
> >>>>> [    0.145529] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, ma
> >>>>> x_idle_ns: 19112604462750000 ns                                                 
> >>>>> [    0.145532] futex hash table entries: 256 (order: 4, 65536 bytes, linear)    
> >>>>> [    0.145776] NET: Registered protocol family 16                               
> >>>>> [    0.145835] audit: initializing netlink subsys (disabled)                    
> >>>>> [    0.145934] Spectre V2 mitigation: execute trampolines                       
> >>>>> [    0.146759] audit: type=2000 audit(1588911734.995:1): state=initialized audit
> >>>>> _enabled=0 res=1                                                                
> >>>>> [    0.146830] HugeTLB registered 1.00 MiB page size, pre-allocated 0 pages     
> >>>>> [    0.190956] cryptd: max_cpu_qlen set to 1000                                 
> >>>>> [    0.194413] iommu: Default domain type: Translated                           
> >>>>> [    0.194510] SCSI subsystem initialized                                       
> >>>>> [    0.194516] pps_core: LinuxPPS API ver. 1 registered                         
> >>>>> [    0.194518] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giome
> >>>>> tti <giometti@linux.it>                                                         
> >>>>> [    0.194520] PTP clock support registered                                     
> >>>>> [    0.199801] NetLabel: Initializing                                           
> >>>>> [    0.199803] NetLabel:  domain hash size = 128                                
> >>>>> [    0.199804] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO                 
> >>>>> [    0.199818] NetLabel:  unlabeled traffic allowed by default                  
> >>>>> [    0.219300] VFS: Disk quotas dquot_6.6.0                                     
> >>>>> [    0.219322] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)   
> >>>>> [    0.219350] os_info: entry 0: not available (addr=0x0 size=0)                
> >>>>> [    0.219352] os_info: entry 1: copied (addr=0x67a37000 size=200)              
> >>>>> [    0.219353] os_info: crashkernel: addr=0x6fc00000 size=268435456             
> >>>>> [    0.220405] NET: Registered protocol family 2                                
> >>>>> [    0.220552] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 4096 
> >>>>> bytes, linear)                                                                  
> >>>>> [    0.220557] TCP established hash table entries: 2048 (order: 2, 16384 bytes, 
> >>>>> linear)                                                                         
> >>>>> [    0.220570] TCP bind hash table entries: 2048 (order: 3, 32768 bytes, linear 
> >>>>> [    0.220587] TCP: Hash tables configured (established 2048 bind 2048)         
> >>>>> [    0.220607] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)       
> >>>>> [    0.220614] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)  
> >>>>> [    0.220649] NET: Registered protocol family 1                                
> >>>>> [    0.220657] NET: Registered protocol family 44                               
> >>>>> [    0.220695] jlb-debug: populate_rootfs 661 initrd:0                          
> >>>>> [    0.220697] jlb-debug: populate_rootfs 663                                   
> >>>>> [    0.221396] alg: No test for crc32be (crc32be-vx)                            
> >>>>> [    0.221802] Initialise system trusted keyrings                               
> >>>>> [    0.221809] Key type blacklist registered                                    
> >>>>> [    0.221826] workingset: timestamp_bits=45 max_order=16 bucket_order=0        
> >>>>> [    0.223690] integrity: Platform Keyring initialized                          
> >>>>> [    0.227865] NET: Registered protocol family 38                               
> >>>>> [    0.227869] Key type asymmetric registered                                   
> >>>>> [    0.227870] Asymmetric key parser 'x509' registered                          
> >>>>> [    0.227877] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 2
> >>>>> 49)                                                                             
> >>>>> [    0.227894] io scheduler mq-deadline registered                              
> >>>>> [    0.227896] io scheduler kyber registered                                    
> >>>>> [    0.227924] io scheduler bfq registered                                      
> >>>>> [    0.227972] atomic64_test: passed                                            
> >>>>> [    0.228308] rdac: device handler registered                                  
> >>>>> [    0.228326] hp_sw: device handler registered                                 
> >>>>> [    0.228327] emc: device handler registered                                   
> >>>>> [    0.228343] alua: device handler registered                                  
> >>>>> [    0.228385] cio: Channel measurement facility initialized using format extend
> >>>>> ed (mode autodetected)                                                          
> >>>>> [    0.228596] drop_monitor: Initializing network drop monitor service          
> >>>>> [    0.228659] Initializing XFRM netlink socket                                 
> >>>>> [    0.228760] NET: Registered protocol family 10                               
> >>>>> [    0.229046] Segment Routing with IPv6                                        
> >>>>> [    0.229063] NET: Registered protocol family 17                               
> >>>>> [    0.229085] mpls_gso: MPLS GSO support                                       
> >>>>> [    0.229136] registered taskstats version 1                                   
> >>>>> [    0.229145] Loading compiled-in X.509 certificates                           
> >>>>> [    0.272961] Loaded X.509 cert 'Build time autogenerated kernel key: 6de832de3
> >>>>> 5ed366a6c3c2d0e99b0d84ae243cb28'                                                
> >>>>> [    0.273793] Key type big_key registered                                      
> >>>>> [    0.273802] ima: No TPM chip found, activating TPM-bypass!                   
> >>>>> [    0.273805] ima: Allocated hash algorithm: sha1                              
> >>>>> [    0.273813] ima: No architecture policies found                              
> >>>>> [    0.273933] md: Waiting for all devices to be available before autodetect    
> >>>>> [    0.273934] md: If you don't use raid, use raid=noautodetect                 
> >>>>> [    0.274074] md: Autodetecting RAID arrays.                                   
> >>>>> [    0.274075] md: autorun ...                                                  
> >>>>> [    0.274076] md: ... autorun DONE.                                            
> >>>>> [    0.274092] List of all partitions:                                          
> >>>>> [    0.274093] No filesystem could mount root, tried:                           
> >>>>> [    0.274094]                                                                  
> >>>>> [    0.274096] Kernel panic - not syncing: VFS: Unable to mount root fs on unkno
> >>>>> wn-block(1,0)                                                                   
> >>>>> [    0.274098] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc4+ #2          
> >>>>> [    0.274099] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                     
> >>>>> [    0.274100] Call Trace:                                                      
> >>>>> [    0.274109]  [<0000000000114302>] show_stack+0x8a/0xd0                       
> >>>>> [    0.274113]  [<000000000057a1d2>] dump_stack+0x8a/0xb8                       
> >>>>> [    0.274116]  [<0000000000147828>] panic+0x110/0x308                          
> >>>>> [    0.274121]  [<0000000000c3d616>] mount_block_root+0x35e/0x360               
> >>>>> [    0.274122]  [<0000000000c3d824>] prepare_namespace+0x174/0x1b0              
> >>>>> [    0.274124]  [<0000000000c3d054>] kernel_init_freeable+0x2bc/0x2d0           
> >>>>> [    0.274130]  [<000000000086b5ea>] kernel_init+0x22/0x150                     
> >>>>> [    0.274133]  [<00000000008759b0>] ret_from_fork+0x2c/0x30                    
> >>>>> 00: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 0010F444
> >>>>> 00:                                                               
> >>>>>  
> >>>  
> 
