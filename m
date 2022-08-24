Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B48C48BE4
	for <linux-s390@archiver.kernel.org>; Wed, 24 Aug 2022 12:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiHXM5P (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 Aug 2022 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiHXM5O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Aug 2022 08:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410AD94EF2
        for <linux-s390@vger.kernel.org>; Wed, 24 Aug 2022 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661345832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M67uFP+s7kbmtZeai05eepZumcmXz+PrYdRQN892qiE=;
        b=X2Tlr4w8EgTqmzCPTsUPurxTmtPfDvoHCMGa10Qt+SOw0aif09VA0IpYq2tc4zdnRQzO26
        WNDCY/pbSyKArso+z1Dd3skP4mat7+uvOam5P+XSz15ZPOibOvSLhAURB7Iy3hVetoKBUk
        ELV0VhSVNVW/mfsua6lSzT5LRmvrXEI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-N0Nq3H16OaaeDSimfL8leg-1; Wed, 24 Aug 2022 08:57:11 -0400
X-MC-Unique: N0Nq3H16OaaeDSimfL8leg-1
Received: by mail-qk1-f199.google.com with SMTP id bl16-20020a05620a1a9000b006bc3aa1908dso4955589qkb.15
        for <linux-s390@vger.kernel.org>; Wed, 24 Aug 2022 05:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=M67uFP+s7kbmtZeai05eepZumcmXz+PrYdRQN892qiE=;
        b=b98UYPJ5j5zS2Cp0G1Zc6HNq6q2RloVOWOBbzoucUbe6YMIwFyaZmFsLOeRzQk/VO0
         yuXGELiePUcGoSmqQovXRj0kmpYv0pive4qAaSfSLKSEgJB55S79bMRvWt2H6FXEjkQh
         3wjuZgWdtTW5FaSRYIaTTup1xzYwTV+jQHc1yFVYMb9sV/j2u2Ut92IIo063deUW7m2w
         FRqlORRtsotvipwxUpuU0sQUunlksgvljFDqJEL9/4g4XF8scOz544qW5oVsvHHrw8WF
         C4ITtYFBIaE+r+VMxqZhEyfZwFXzw7WXlRif3NyB7k/g9kZF2Kv+oHjNcy3sBYA8znoX
         L83g==
X-Gm-Message-State: ACgBeo0q420SsLKAlazu+qZkv4jywHwYIAwUlbNVE7ZM1kUPvGwuk/tx
        IFPg+VbQJrbfd6pM5rp2oC2tj4QwbP1648hl0a0gdwhnMCus79pnsWnuPOioBJAiNMowosJub6q
        u0mTqvmnEKlaNS4mQNhHz2g==
X-Received: by 2002:ac8:5d49:0:b0:343:5690:9bba with SMTP id g9-20020ac85d49000000b0034356909bbamr23777595qtx.163.1661345830962;
        Wed, 24 Aug 2022 05:57:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5EaGf/noPh9Wc489jAdcPbd7XQ0qFRtCDwgkYBfuXaMDX4Go3YACdxb43ZMWBnvqVgmPRijQ==
X-Received: by 2002:ac8:5d49:0:b0:343:5690:9bba with SMTP id g9-20020ac85d49000000b0034356909bbamr23777575qtx.163.1661345830693;
        Wed, 24 Aug 2022 05:57:10 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a0c4e00b006bb568016easm15020938qki.116.2022.08.24.05.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:57:10 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:57:07 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC] s390: kernel BUG at include/linux/mm.h:1529!
Message-ID: <YwYgI7wqx6O0g3WK@bfoster>
References: <YwYThOGeyIv4b8IB@bfoster>
 <f5a81962-cd95-a47b-5710-900b7932bf56@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a81962-cd95-a47b-5710-900b7932bf56@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Aug 24, 2022 at 02:07:16PM +0200, David Hildenbrand wrote:
> On 24.08.22 14:03, Brian Foster wrote:
> > Hi all,
> > 
> > When running a fuzzer workload to test an unrelated patch[1], I've been
> > reproducing the VM_BUG_ON() splat below[2] on s390x. I've narrowed the
> > problem down to a deterministic reproducer. The code for that is also
> > appended below[3].
> > 
> > The splat occurs because during fork() we end up down in
> > copy_present_pte() -> page_try_dup_anon_rmap() ->
> > page_needs_cow_for_dma() for a !is_cow mapping, so copy_page_range()
> > didn't acquire the ->write_protect_seq seqlock as expected. After
> > digging into this a bit, I _think_ this boils down to a bug in the s390
> > arch fault code dealing with a write fault to a !VM_WRITE mapping..
> > 
> > The sequence of events implemented by the reproducer that leads to this:
> > 
> > 1. Create a shmem segment and attach it SHM_RDONLY. This causes
> > do_mmap() to set up a !VM_WRITE mapping, but also clear
> > (VM_MAYWRITE|VM_SHARED) on the mapping because the backing shmem file is
> > read-only.
> > 
> > 2. Take a write fault on the mapping in kernel mode (via getrlimit() in
> > this case). The write fault ultimately causes getrlimit() to fail with a
> > bad access error, but not before the generic fault code creates an
> > anon_vma mapping for the page.
> > 
> > This occurs because first do_dat_exception() calls handle_mm_fault()
> > with FAULT_FLAG_WRITE via the following logic:
> > 
> > 	access = VM_ACCESS_FLAGS;
> > 	...
> > 	if (access == VM_WRITE || is_write)
> > 		flags |= FAULT_FLAG_WRITE;
> > 	...
> > 	if (unlikely(!(vma->vm_flags & access)))
> > 		goto out_up;
> > 	...
> > 	fault = handle_mm_fault(...);
> > 
> > So the FAULT_FLAG_WRITE fault proceeds because is_write is true and
> > ->vm_flags has read or exec permission (but not VM_WRITE). This
> > eventually gets down into do_cow_fault() -> finish_fault() ->
> > do_set_pte(), the latter of which calls page_add_new_anon_rmap() because
> > this is a write fault to a !shared mapping.
> > 
> > Note this is immediately followed by a do_protection_exception() that
> > uses access = VM_WRITE and thus fails the above check and returns with
> > VM_FAULT_BADACCESS. So I think this ultimately DTRT wrt to failing the
> > syscall to userspace, but the do_dat_exception() handling sets up an
> > unexpected situation for fork()..
> > 
> > 3. fork() -> dup_mm() comes across this mapping with ->anon_vma set (so
> > vma_needs_copy() returns true), but is_cow_mapping() returns false
> > because VM_MAYWRITE is cleared. From there we fall down into the page
> > table copying path described by the BUG splat.
> > 
> > This problem doesn't occur on x86 seemingly because we don't call into
> > handle_mm_fault() for a write fault to a !VM_WRITE mapping, which is
> > specifically checked in access_error(). Therefore, something like the
> > patch below[4] seems to prevent the problem on s390. However, the access
> > checking logic looks wonky enough to me that I wonder whether it
> > warrants a closer look from s390 experts. For example, does this code
> > need to care about any flags/context beyond write or read faults vs.
> > write or !write mappings? I don't have enough context to reason about
> > it. Could somebody more familiar with these two s390 exception variants
> > chime in?
> > 
> > Finally, note that so far I've only really tested the patch against the
> > reproducer. I'm happy to try and form it into a proper patch and test
> > further after some feedback... thanks.
> > 
> > Brian
> > 
> > [1] https://lore.kernel.org/linux-s390/20220816155407.537372-1-bfoster@redhat.com
> > [2] BUG splat:
> > 
> > kernel BUG at include/linux/mm.h:1529!
> > monitor event: 0040 ilc:2 [#1] SMP 
> > Modules linked in: rfkill sunrpc ghash_s390 prng xts aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 vfio_ccw sha512_s390 mdev vfio_iommu_type1 vfio xfs libcrc32c virtio_blk virtio_net net_failover failover dm_mirror dm_region_hash dm_log dm_mod pkey zcrypt
> > CPU: 1 PID: 1401 Comm: shmem-fork-test Not tainted 6.0.0-rc2+ #20
> > Hardware name: IBM 8561 LT1 400 (KVM/Linux)
> > Krnl PSW : 0704c00180000000 0000000014928240 (copy_pte_range+0xa40/0xe58)
> >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> > Krnl GPRS: 000003ff85b80000 000000000000000c 0000000000000000 000003ff85b80000
> >            0000000091c5f31f 0000000087d70640 000000008160e800 00000372024717c0
> >            000003ff85b80000 0000000000000000 00000000831c9c00 0000000091c5f31f
> >            00000000823ada00 0000000087d70640 00000000149279c2 0000038000773880
> > Krnl Code: 0000000014928232: c0e5fffff48f	brasl	%r14,0000000014926b50
> >            0000000014928238: a7f4fd43		brc	15,0000000014927cbe
> >           #000000001492823c: af000000		mc	0,0
> >           >0000000014928240: b904005b		lgr	%r5,%r11
> >            0000000014928244: a7f4ffde		brc	15,0000000014928200
> >            0000000014928248: e310f0e80004	lg	%r1,232(%r15)
> >            000000001492824e: a7f4ff17		brc	15,000000001492807c
> >            0000000014928252: ec3800091c7c	cgij	%r3,28,8,0000000014928264
> > Call Trace:
> >  [<0000000014928240>] copy_pte_range+0xa40/0xe58 
> > ([<00000000149279c2>] copy_pte_range+0x1c2/0xe58)
> >  [<000000001492e258>] copy_page_range+0x510/0x770 
> >  [<00000000146f3896>] dup_mmap+0x47e/0x6c0 
> >  [<00000000146f3b52>] dup_mm+0x7a/0x278 
> >  [<00000000146f5a48>] copy_process+0x1298/0x1a48 
> >  [<00000000146f62fe>] kernel_clone+0x5e/0x3c0 
> >  [<00000000146f6742>] __do_sys_clone+0x5a/0x68 
> >  [<00000000146f67e0>] __s390x_sys_clone+0x40/0x50 
> >  [<0000000014f68dac>] __do_syscall+0x1d4/0x200 
> >  [<0000000014f78c22>] system_call+0x82/0xb0 
> > Last Breaking-Event-Address:
> >  [<0000000014927a46>] copy_pte_range+0x246/0xe58
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 
> > [3] minimal reproducer:
> > 
> > #include <unistd.h>
> > #include <sys/shm.h>
> > #include <sys/resource.h>
> > 
> > int main()
> > {
> > 	int id;
> > 	void *p;
> > 
> > 	id = shmget(IPC_PRIVATE, 4096, IPC_CREAT);
> > 	p = shmat(id, NULL, SHM_RDONLY);
> > 	getrlimit(RLIMIT_AS, p);
> > 	fork();
> > 	return 0;
> > }
> > 
> > [4] RFC patch:
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index 13449941516c..c12722da1558 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -418,6 +418,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	fault = VM_FAULT_BADACCESS;
> >  	if (unlikely(!(vma->vm_flags & access)))
> >  		goto out_up;
> > +	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_WRITE))
> > +		goto out_up;
> >  
> >  	if (is_vm_hugetlb_page(vma))
> >  		address &= HPAGE_MASK;
> > 
> 
> Heh, we might have identified this independently just recently:
> 
> https://lore.kernel.org/all/20220816113359.33843f54@thinkpad/T/#u
> 
> Can you take a look if that proposed small change also fixes the issue?
> 

Yup, this looks like the same issue. The patch in that thread just
"upgrades" the access mode as opposed to adding the explicit flag check.
Either way seems reasonable to me. I just confirmed that change fixes
the problem with the above reproducer as well. Thanks!

Brian

> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

