Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35865 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbgIXO1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Sep 2020 10:27:35 -0400
Subject: Re: BUG: Bad page state in process dirtyc0w_child
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
 <20200916142806.GD7076@osiris> <20200922190350.7a0e0ca5@thinkpad>
 <20200923153938.5be5dd2c@thinkpad>
 <76fef5dfd8efdb4130e41d1811b2a78ce39c8b0d.camel@redhat.com>
From: Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4bf5597b-2466-29f3-e855-920d5632536f@linux.alibaba.com>
Date: Thu, 24 Sep 2020 22:25:13 +0800
MIME-Version: 1.0
In-Reply-To: <76fef5dfd8efdb4130e41d1811b2a78ce39c8b0d.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@redhat.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org



在 2020/9/24 上午10:06, Qian Cai 写道:
> On Wed, 2020-09-23 at 15:39 +0200, Gerald Schaefer wrote:
>> OK, I can now reproduce this, and unfortunately also with the gup_fast
>> fix, so it is something different. Bisecting is a bit hard, as it will
>> not always show immediately, sometimes takes up to an hour.
>>
>> Still, I think I found the culprit, merge commit b25d1dc9474e "Merge
>> branch 'simplify-do_wp_page'". Without those 4 patches, it works fine,
>> running over night.
>>
>> Not sure why this only shows on s390, should not be architecture-specific,
>> but we do often see subtle races earlier than others due to hypervisor
>> impact.
> 
> Apparently, someone can reproduce something similar on x86 as well:
> 
> https://lore.kernel.org/linux-mm/c41149a8-211e-390b-af1d-d5eee690fecb@linux.alibaba.com/
> 
> Probably, Alex could revert the bad commits and confirm it there.
> 
>>
>> The first commit 09854ba94c6a ("mm: do_wp_page() simplification") already

yes, after revert this commit, the BUG disappears.

Thanks
Alex

>> introduces this error. The dirtyc0w_child test seems to play with cow
>> and racing madvise(MADV_DONTNEED), but I have not yet fully understood
>> it and also not the changes from commit 09854ba94c6a. As Linus already
>> mentioned in the merge commit message, this is some bad timing for such
>> a change, so I don't want to delay this further with trying to understand
>> it better before reporting. Maybe Peter or Linus can spot some obvious
>> issue.
>>
>> One thing that seems strange to me is that the page flags from the
>> bad page state output are (uptodate|swapbacked), see below, or
>> (referenced|uptodate|dirty|swapbacked) in the original report. But IIUC,
>> that should not qualify for the "PAGE_FLAGS_CHECK_AT_FREE flag(s) set"
>> reason. So it seems that the flags have changed between check_free_page()
>> and __dump_page(), which would be very odd. Or maybe some issue with
>> compound pages, because __dump_page() looks at head->flags.
>>
>> [ 1863.237707] BUG: Bad page state in process dirtyc0w_child  pfn:58527d
>> [ 1863.237721] page:000000008866956b refcount:0 mapcount:0
>> mapping:0000000000000000 index:0x0 pfn:0x58527d
>> [ 1863.237727] flags: 0x3ffff00000080004(uptodate|swapbacked)
>> [ 1863.237734] raw: 3ffff00000080004 0000000000000100 0000000000000122
>> 0000000000000000
>> [ 1863.237738] raw: 0000000000000000 0000000000000000 ffffffff00000000
>> 0000000000000000
>> [ 1863.237742] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>> [ 1863.237745] Modules linked in:
>> [ 1863.237752] CPU: 16 PID: 9074 Comm: dirtyc0w_child Tainted:
>> G    B             5.9.0-rc6-00020-geff48ddeab78-dirty #104
>> [ 1863.237756] Hardware name: IBM 3906 M03 703 (LPAR)
>> [ 1863.237759] Call Trace:
>> [ 1863.237768]  [<0000000000115f28>] show_stack+0x100/0x158 
>> [ 1863.237775]  [<000000000096b41a>] dump_stack+0xa2/0xd8 
>> [ 1863.237781]  [<00000000003d497c>] bad_page+0xdc/0x140 
>> [ 1863.237785]  [<00000000003d5b62>] free_pcp_prepare+0x31a/0x360 
>> [ 1863.237789]  [<00000000003d906a>] free_unref_page+0x32/0xb8 
>> [ 1863.237794]  [<00000000003b05f4>] zap_p4d_range+0x64c/0xcf8 
>> [ 1863.237797]  [<00000000003b0e7a>] unmap_page_range+0x9a/0x110 
>> [ 1863.237801]  [<00000000003b0f84>] unmap_single_vma+0x94/0x100 
>> [ 1863.237805]  [<00000000003b14c2>] zap_page_range+0x14a/0x1f0 
>> [ 1863.237809]  [<00000000003e3a24>] do_madvise+0x75c/0x918 
>> [ 1863.237812]  [<00000000003e3c06>] __s390x_sys_madvise+0x26/0x38 
>> [ 1863.237817]  [<0000000000d280d4>] system_call+0xe0/0x2c0 
>> [ 1863.237820] INFO: lockdep is turned off.
>>
