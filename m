From: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [-next Feb 8] kernel BUG at fs/dcache.c:676!
Date: Thu, 11 Feb 2010 10:43:02 +0530
Message-ID: <4B7391DE.1070200@in.ibm.com>
References: <4B7028BD.9070108@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <4B7028BD.9070108@in.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-s390@vger.kernel.org, linux-next@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

Sachin Sant wrote:
> While running hackbench against today's next-20100208 (9056d31..)
> on a s390 box, came across following BUG.
>
I can still recreate this issue against next-20100210.

kjournald starting.  Commit interval 5 seconds
EXT3-fs (dasdb1): using internal journal
EXT3-fs (dasdb1): mounted filesystem with writeback data mode
BUG: Dentry 00000000fbde0ec0{i=3D13c39,n=3Dbin} still in use (1) unmoun=
t of ext3 da
sdb1
------------ cut here ------------
kernel BUG at fs/dcache.c:676!
illegal operation: 0001 #1 SMP
Modules linked in: fuse loop zfcp qeth_l3 scsi_transport_fc ipv6 scsi_t=
gt vmur s
csi_mod ext3 jbd mbcache dasd_eckd_mod dasd_fba_mod dasd_mod qeth qdio =
ccwgroup
dm_mod
CPU: 1 Not tainted 2.6.33-rc7-autotest-next-20100210-5-default #1
Process umount (pid: 2125, task: 00000000fac04138, ksp: 00000000fb58bb8=
0)
Krnl PSW : 0704100180000000 000000000023ef1c (shrink_dcache_for_umount_=
subtree+0
x3a8/0x3d0)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:1 PM:0 EA:3
Krnl GPRS: 0000000000010000 0000000000686648 000000000000005c 00000000f=
ffffffe
           0000000000449fa2 0000000000000000 0000000000000001 000000000=
0000001
           00000000000000e0 000000000060ba00 00000000fbde0e60 000000000=
0623218
           00000000fac18e68 000000000046efc0 000000000023ef18 00000000f=
b58bcf8
Krnl Code: 000000000023ef0c: e3c0f0a80024       stg     %r12,168(%r15)
           000000000023ef12: c0e50010581f       brasl   %r14,449f50
           000000000023ef18: a7f40001           brc     15,23ef1a
          >000000000023ef1c: a7f40000           brc     15,23ef1c
           000000000023ef20: c0b0001f217c       larl    %r11,623218
           000000000023ef26: a7f4fe79           brc     15,23ec18
           000000000023ef2a: c020001e656b       larl    %r2,60ba00
           000000000023ef30: c0e5000722a8       brasl   %r14,323480
Call Trace:
( <000000000023ef18>=A8 shrink_dcache_for_umount_subtree+0x3a4/0x3d0)
  <000000000023efa6>=A8 shrink_dcache_for_umount+0x62/0x98
  <000000000022a1fc>=A8 generic_shutdown_super+0x3c/0x160
  <000000000022a356>=A8 kill_block_super+0x36/0x54
  <000000000022ad00>=A8 deactivate_super+0xa0/0xc8
  <0000000000247826>=A8 SyS_umount+0x72/0x404
  <0000000000118bae>=A8 sysc_noemu+0x10/0x16
  <0000020000149836>=A8 0x20000149836
Last Breaking-Event-Address:
  <000000000023ef18>=A8 shrink_dcache_for_umount_subtree+0x3a4/0x3d0


> kjournald starting.  Commit interval 5 seconds
> EXT3-fs (dasdb1): using internal journal
> EXT3-fs (dasdb1): mounted filesystem with writeback data mode
> BUG: Dentry 00000000fc937d40{i=3D13c39,n=3Dbin} still in use (1) =DDu=
nmount=20
> of ext3 da
> sdb1=A8
> ------------" cut here "------------
> kernel BUG at fs/dcache.c:676!
> illegal operation: 0001 "#1" SMP
> Modules linked in: fuse loop zfcp scsi_transport_fc qeth_l3 scsi_tgt=20
> ipv6 vmur s
> csi_mod ext3 jbd mbcache dasd_eckd_mod dasd_fba_mod dasd_mod qeth qdi=
o=20
> ccwgroup
> dm_mod
> CPU: 2 Not tainted 2.6.33-rc7-autotest-next-20100208-5-default #1
> Process umount (pid: 2120, task: 00000000fb3da538, ksp: 00000000fc6c7=
b80)
> Krnl PSW : 0704100180000000 000000000023ef54=20
> (shrink_dcache_for_umount_subtree+0
> x3a8/0x3d0)
>           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:1 PM:0 EA:3
> Krnl GPRS: 0000000000010000 0000000000686648 000000000000005c=20
> 00000000fffffffd
>           0000000000448a52 0000000000000000 0000000000000001=20
> 0000000000000001
>           00000000000000e0 000000000060ba00 00000000fc937ce0=20
> 0000000000623218
>           00000000fae10e68 000000000046ced8 000000000023ef50=20
> 00000000fc6c7cf8
> Krnl Code: 000000000023ef44: e3c0f0a80024       stg     %r12,168(%r15=
)
>           000000000023ef4a: c0e500104d5b       brasl   %r14,448a00
>           000000000023ef50: a7f40001           brc     15,23ef52
>          >000000000023ef54: a7f40000           brc     15,23ef54
>           000000000023ef58: c0b0001f2160       larl    %r11,623218
>           000000000023ef5e: a7f4fe79           brc     15,23ec50
>           000000000023ef62: c020001e654f       larl    %r2,60ba00
>           000000000023ef68: c0e50007229c       brasl   %r14,3234a0
> Call Trace:
> (<000000000023ef50> shrink_dcache_for_umount_subtree+0x3a4/0x3d0)
> <000000000023efde> shrink_dcache_for_umount+0x62/0x98
> <000000000022a234> generic_shutdown_super+0x3c/0x160
> <000000000022a38e> kill_block_super+0x36/0x54
> <000000000022ad38> deactivate_super+0xa0/0xc8
> <000000000024785e> SyS_umount+0x72/0x404
> <0000000000118c26> sysc_noemu+0x10/0x16
> <0000020000149836> 0x20000149836
> Last Breaking-Event-Address:
> "<000000000023ef50>" shrink_dcache_for_umount_subtree+0x3a4/0x3d0
>
> Did not observe this with next-20100205. Also there doesn't seem to b=
e
> any patches applied to this code after the last release. So not
> sure what could have caused this. Corresponding code is :
>
> 664                         if (atomic_read(&dentry->d_count) !=3D 0)=
 {
> 665                                 printk(KERN_ERR
> 666                                        "BUG: Dentry %p{i=3D%lx,n=3D=
%s}"
> 667                                        " still in use (%d)"
> 668                                        " [unmount of %s %s]\n",
> 669                                        dentry,
> 670                                        dentry->d_inode ?
> 671                                        dentry->d_inode->i_ino : 0=
UL,
> 672                                        dentry->d_name.name,
> 673                                        atomic_read(&dentry->d_cou=
nt),
> 674                                        dentry->d_sb->s_type->name=
,
> 675                                        dentry->d_sb->s_id);
> 676                                 BUG();
>           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 677                         }
>
> Let me know if i can provide any other information. Have attached
> the config.
>
> Thanks
> -Sachin
>
>

--=20

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
