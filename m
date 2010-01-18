From: Sachin Sant <sachinp@in.ibm.com>
Subject: [-next Jan 18] Boot failure on s390 with DEVTMPFS=y
Date: Mon, 18 Jan 2010 19:51:47 +0530
Message-ID: <4B546E7B.2080900@in.ibm.com>
References: <20100118195743.b45f119e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100118195743.b45f119e.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Today next (next-20100118) failed to boot on a s390 box
with the following Oops :

Brought up 4 CPUs
Unable to handle kernel pointer dereference at virtual kernel address 0000000000543000
Oops: 0004 #1 SMP
Modules linked in:
CPU: 0 Not tainted 2.6.33-rc4-autotest-next-20100118-5-default #1
Process swapper (pid: 1, task: 00000000fd792038, ksp: 00000000fd797a30)
Krnl PSW : 0704200180000000 00000000001eb0b8 (shmem_parse_options+0xc0/0x328)
          R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:0 CC:2 PM:0 EA:3
Krnl GPRS: 000000000054388a 000000000000003d 0000000000543836 000000000000003d
          0000000000000000 0000000000483f28 0000000000536112 00000000fd797d00
          00000000fd4ba100 0000000000000100 0000000000483978 0000000000543832
          0000000000000000 0000000000465958 00000000001eb0b0 00000000fd797c58
Krnl Code: 00000000001eb0aa: c0e5000994f1       brasl   %r14,31da8c
          00000000001eb0b0: b9020022           ltgr    %r2,%r2
          00000000001eb0b4: a784010b           brc     8,1eb2ca
         >00000000001eb0b8: 92002000           mvi     0(%r2),0
          00000000001eb0bc: a7080000           lhi     %r0,0
          00000000001eb0c0: 41902001           la      %r9,1(%r2)
          00000000001eb0c4: b9040016           lgr     %r1,%r6
          00000000001eb0c8: b904002b           lgr     %r2,%r11
Call Trace:
(<00000000fd797c50> 0xfd797c50)
<00000000001eb5da> shmem_fill_super+0x13a/0x25c
<0000000000228cfa> get_sb_single+0xbe/0xdc
<000000000034ffc0> dev_get_sb+0x2c/0x38
<000000000066c602> devtmpfs_init+0x46/0xc0
<000000000066c53e> driver_init+0x22/0x60
<000000000064d40a> kernel_init+0x24e/0x3d0
<000000000010a7ea> kernel_thread_starter+0x6/0xc
<000000000010a7e4> kernel_thread_starter+0x0/0xc

Previous next builds worked fine on the same box. The only difference
between configs of the two builds was CONFIG_DEVTMPFS. This option was
enabled while compiling 20100118. 

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
