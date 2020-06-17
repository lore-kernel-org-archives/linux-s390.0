Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQDTU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jun 2020 23:19:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8DCC061573
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2020 20:19:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 205so791965qkg.3
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2020 20:19:19 -0700 (PDT)
Date: Tue, 16 Jun 2020 23:19:06 -0400
From: Qian Cai <cai@lca.pw>
Subject: Re: VM_BUG_ON_PAGE(page_to_pgoff(page) != offset) on s390
Message-ID: <20200617031906.GA5065@lca.pw>
References: <20200616013309.GB815@lca.pw>
 <20200616014859.GY8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616014859.GY8681@bombadil.infradead.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, darrick.wong@oracle.com, kirill@shutemov.name, peterx@redhat.com, yang.shi@linux.alibaba.com, hch@lst.de, linux-kernel@vger.kernel.org, songliubraving@fb.com

On Mon, Jun 15, 2020 at 06:48:59PM -0700, Matthew Wilcox wrote:
> On Mon, Jun 15, 2020 at 09:33:09PM -0400, Qian Cai wrote:
> > Ever since a few days ago, linux-next on s390 has started to crash
> > with compiling workloads or during boot below.
> > 
> > This .config if ever matters,
> > 
> > https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> 
> CONFIG_READ_ONLY_THP_FOR_FS=y
> 
> This looks like a duplicate of
> https://bugzilla.kernel.org/show_bug.cgi?id=206569
> 
> which Song has had no luck reproducing.
> 
> I would suggest simply disabling the Kconfig option for now.

Thanks for the information. Indeed, I can't reproduce it anymore after
setting READ_ONLY_THP_FOR_FS=n.

> 
> > Since our s390 guest has only 2 CPUs, it is probably going to take a
> > long time to bisect.
> > 
> > 01: [   60.589979] page:000003d0830bd540 refcount:257 mapcount:0 mapping:0000000
> > 01: 0ac9dec15 index:0x155 head:000003d0830bc000 order:8 compound_mapcount:0 comp
> > 01: ound_pincount:0
> > 01: [   60.590361] mapping->aops:xfs_address_space_operations [xfs] dentry name:
> > 01: "lvm"
> > 01: [   60.590369] flags: 0x2000000000000000()
> > 01: [   60.590380] raw: 2000000000000000 000003d0830bc001 000003d0830bd548 00000
> > 01: 00000000400
> > 01: [   60.590387] raw: 0000000000000000 0000000000000000 ffffffff00000000 00000
> > 01: 00000000000
> > 01: [   60.590394] head: 2000000000010015 000003d0830dd588 000000008fb34c20 0000
> > 01: 0000cc4f0568
> > 01: [   60.590401] head: 0000000000000100 0000000000000000 ffffffff00000101 0000
> > 01: 00008f78a000
> > 01: [   60.590407] page dumped because: VM_BUG_ON_PAGE(page_to_pgoff(page) != o
> > 01: fset)
> > 01: [   60.590428] ------------[ cut here ]------------
> > 01: [   60.590435] kernel BUG at mm/filemap.c:2516!
> > 01: [   60.590512] monitor event: 0040 ilc:2 [#1] SMP
> > 01: [   60.590518] Modules linked in: ip_tables x_tables xfs dm_mirror dm_region
> > 01: _hash dm_log dm_mod
> > 01: [   60.590531] CPU: 1 PID: 665 Comm: lvmconfig Not tainted 5.8.0-rc1-next-20
> > 01: 200615 #1
> > 01: [   60.590535] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> > 01: [   60.590539] Krnl PSW : 0704c00180000000 00000000bdf0bb46 (filemap_fault+0
> > 01: x191e/0x27c0)
> > 01: [   60.590550]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0
> > 01:  RI:0 EA:3
> > 01: [   60.590555] Krnl GPRS: 0000000000000001 0000037c002adef5 000003d0830bd578
> > 01:  0000030000000000
> > 01: [   60.591850]            0000030000000001 0000030000000000 000003e00156fdc8
> > 01:  000003e00156fdc0
> > 01: [   60.591854]            00000000c8f0b800 0000000000000155 000003d0830bd548
> > 01:  000003d0830bd540
> > 01: [   60.591859]            00000000bed41008 00000000bea6f900 00000000bdf0bb42
> > 01:  000003e00156f9d0
> > 01: [   60.591872] Krnl Code: 00000000bdf0bb36: c030005b1e45        larl    %r3,
> > 01: 00000000bea6f7c0
> > 01: [   60.591872]            00000000bdf0bb3c: c0e5000597ca        brasl   %r14
> > 01: ,00000000bdfbead0
> > 01: [   60.591872]           #00000000bdf0bb42: af000000            mc      0,0
> > 01: [   60.591872]           >00000000bdf0bb46: c020007d238d        larl    %r2,
> > 01: 00000000beeb0260
> > 01: [   60.591872]            00000000bdf0bb4c: c0e50028aebe        brasl   %r14
> > 01: ,00000000be4218c8
> > 01: [   60.591872]            00000000bdf0bb52: eb1a0003000c        srlg    %r1,
> > 01: %r10,3
> > 01: [   60.591872]            00000000bdf0bb58: a52d0300            llihl   %r2,
> > 01: 768
> > 01: [   60.591872]            00000000bdf0bb5c: b9080012            agr     %r1,
> > 01: %r2
> > 01: [   60.591901] Call Trace:
> > 01: [   60.591905]  [<00000000bdf0bb46>] filemap_fault+0x191e/0x27c0
> > 01: [   60.591910] ([<00000000bdf0bb42>] filemap_fault+0x191a/0x27c0)
> > 01: [   60.591967]  [<000003ff80240cfc>] xfs_filemap_fault+0x1ac/0x528 [xfs]
> > __xfs_filemap_fault at /home/linux-mm/linux/fs/xfs/xfs_file.c:1214
> > (inlined by) xfs_filemap_fault at /home/linux-mm/linux/fs/xfs/xfs_file.c:1228
> > 01: [   60.591973]  [<00000000bdfc8428>] __do_fault+0xc0/0x470
> > 01: [   60.591977]  [<00000000bdfd75f2>] handle_mm_fault+0x1782/0x29b8
> > 01: [   60.591983]  [<00000000bdb50c60>] do_dat_exception+0x200/0x9c8
> > do_exception at arch/s390/mm/fault.c:481
> > (inlined by) do_dat_exception at arch/s390/mm/fault.c:583
> > 01: [   60.591993]  [<00000000be9f4b76>] pgm_check_handler+0x1d6/0x234
> > 01: [   60.591997] INFO: lockdep is turned off.
> > 01: [   60.592000] Last Breaking-Event-Address:
> > 01: [   60.592004]  [<00000000bdfbeafc>] dump_page+0x2c/0x40
> > 01: [   60.606521] Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
> >  CPU 00.
> > 00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
> >  CPU 01.
> > 01: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 BDB32B58
