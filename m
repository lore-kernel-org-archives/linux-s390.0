Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbgIMByT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Sep 2020 21:54:19 -0400
Message-ID: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
Subject: BUG: Bad page state in process dirtyc0w_child
From: Qian Cai <cai@redhat.com>
Date: Sat, 12 Sep 2020 21:54:12 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Occasionally, running this LTP test will trigger an error below on
s390:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w.c
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c

this .config:
https://gitlab.com/cailca/linux-mm/-/blob/master/s390.config

[ 6970.253173] LTP: starting dirtyc0w
[ 6971.599102] BUG: Bad page state in process dirtyc0w_child  pfn:8865d
[ 6971.599867] page:000000001a8328d7 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8865d
[ 6971.599876] flags: 0x400000000008000e(referenced|uptodate|dirty|swapbacked)
[ 6971.599886] raw: 400000000008000e 0000000000000100 0000000000000122 0000000000000000
[ 6971.599893] raw: 0000000000000000 0000000000000000 ffffffff00000000 0000000000000000
[ 6971.599900] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[ 6971.599906] Modules linked in: loop kvm ip_tables x_tables dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
[ 6971.599952] CPU: 1 PID: 65238 Comm: dirtyc0w_child Tainted: G           O      5.9.0-rc4-next-20200909 #1
[ 6971.599959] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
[ 6971.599964] Call Trace:
[ 6971.599979]  [<0000000073aec038>] show_stack+0x158/0x1f0 
[ 6971.599986]  [<0000000073af724a>] dump_stack+0x1f2/0x238 
[ 6971.599994]  [<0000000072ed086a>] bad_page+0x1ba/0x1c0 
[ 6971.600000]  [<0000000072ed20c4>] free_pcp_prepare+0x4fc/0x658 
[ 6971.600006]  [<0000000072ed96a6>] free_unref_page+0xae/0x158 
[ 6971.600013]  [<0000000072e8286a>] unmap_page_range+0xb62/0x1df8 
[ 6971.600019]  [<0000000072e83bbc>] unmap_single_vma+0xbc/0x1c8 
[ 6971.600025]  [<0000000072e8418e>] zap_page_range+0x176/0x230 
[ 6971.600033]  [<0000000072eece8e>] do_madvise+0xfde/0x1270 
[ 6971.600039]  [<0000000072eed50a>] __s390x_sys_madvise+0x72/0x98 
[ 6971.600047]  [<0000000073b1cce4>] system_call+0xdc/0x278 
[ 6971.600053] 2 locks held by dirtyc0w_child/65238:
[ 6971.600058]  #0: 000000013442fa18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x17a/0x1270
[ 6971.600432]  #1: 00000001343f9060 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: unmap_page_range+0x640/0x1df8
[ 6971.600487] Disabling lock debugging due to kernel taint

Once it happens, running it again will trigger in on another PFN.

[39717.085115] BUG: Bad page state in process dirtyc0w_child  pfn:af065 

Any thoughts?
