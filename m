Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819EC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 24 Nov 2021 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbhKXVx1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Nov 2021 16:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244474AbhKXVx0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Nov 2021 16:53:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D88DB61039;
        Wed, 24 Nov 2021 21:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637790616;
        bh=sjkChDiLxaG1fCpG89gy7bcfc/T7jMB1IUewwOWd69o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cm5wrgedyvLIRTjQ7KraWZ3OMr97ltyORBVps747E/UnLHJ470AEpQxKoEQe06P28
         Wp/Zi2Y5PVjF6pTNJtWW+FoUlZMUhzCZaaSBDzdlg0AocxbvHjlbj6A/px2FBq3EK7
         wAH7Ry0VJzAfA2TylGwac+4060fnhbNDAX3AqVeY=
Date:   Wed, 24 Nov 2021 13:50:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>
Subject: Re: [PATCH v3] mm: Defer kmemleak object creation of module_alloc()
Message-Id: <20211124135014.665649a0bcb872367b248cef@linux-foundation.org>
In-Reply-To: <20211124142034.192078-1-wangkefeng.wang@huawei.com>
References: <20211124142034.192078-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 24 Nov 2021 22:20:34 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Yongqiang reports a kmemleak panic when module insmod/rmmod
> with KASAN enabled(without KASAN_VMALLOC) on x86[1].
> 
> When the module area allocates memory, it's kmemleak_object
> is created successfully, but the KASAN shadow memory of module
> allocation is not ready, so when kmemleak scan the module's
> pointer, it will panic due to no shadow memory with KASAN check.
> 
> module_alloc
>   __vmalloc_node_range
>     kmemleak_vmalloc
> 				kmemleak_scan
> 				  update_checksum
>   kasan_module_alloc
>     kmemleak_ignore
> 
> Note, there is no problem if KASAN_VMALLOC enabled, the modules
> area entire shadow memory is preallocated. Thus, the bug only
> exits on ARCH which supports dynamic allocation of module area
> per module load, for now, only x86/arm64/s390 are involved.
> 
> Add a VM_DEFER_KMEMLEAK flags, defer vmalloc'ed object register
> of kmemleak in module_alloc() to fix this issue.
> 

I guess this is worth backporting into -stable kernels?  If so, what
would be a suitable Fixes: target?  I suspect it goes back to the
initial KASAN merge date?
