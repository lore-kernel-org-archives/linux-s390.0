Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0127CC61DA4
	for <linux-s390@archiver.kernel.org>; Mon,  6 Mar 2023 00:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCFAzi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Mar 2023 19:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCFAzh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Mar 2023 19:55:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFC12BC6
        for <linux-s390@vger.kernel.org>; Sun,  5 Mar 2023 16:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xdnm8ipicXWf+GKr9NY9HfBCE8Zt8YOqdX2C6njkQeo=; b=eT3aBohJJHtV77Xkx6DpkZ5Wrd
        eiTJfTjh4uTckBnH/q+eRCVrJ9DhpdMrh7Ky5WM6CNHUjNMjrYCQjtrvOJ5hSWK+BpfzvnNb3tHGs
        NRCZAVKsVGxddiUrIT/zdALhmE1N6q/0vCJroRN8Go3yi8YnjVWLUFKaE0JYTpuwMBoBnBLJlxJD9
        CHkzxuPy4oMYYQSInVHXlx4d2as9nCjx3ed4e5xrDmDC2wO+MZUTmsiS2yyl6tvQkKRgtgDbvh6dt
        x6HeMmf5YqyxugqS4yE/J3PqYHfI4ocDDGwn+AhO4rmOepdkpIul8xzqPND1LKEJ4ISEJ0eLQTmgZ
        Ngcf2B4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pYz8X-00ECyL-21;
        Mon, 06 Mar 2023 00:55:33 +0000
Date:   Mon, 6 Mar 2023 00:55:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-s390@vger.kernel.org
Cc:     linux-s390@vger.kernel.org
Subject: [PATCH] s390: trim ancient junk from copy_thread()
Message-ID: <ZAU6BYFisE8evmYf@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Setting and ->psw.addr in childregs of kernel thread is a rudiment of
the old kernel_thread()/kernel_execve() implementation.  Mainline hadn't
been using them since 2012.

And clarify the assigments to frame->sf.gprs - the array stores grp6..gpr15
values to be set by __switch_to(), so frame->sf.gprs[5] actually affects
grp11, etc.  Better spell that as frame->sf.gprs[11 - 6]...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 67df64ef4839..87ca3a727604 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -136,12 +136,12 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	p->thread.last_break = 1;
 
 	frame->sf.back_chain = 0;
-	frame->sf.gprs[5] = (unsigned long)frame + sizeof(struct stack_frame);
-	frame->sf.gprs[6] = (unsigned long)p;
+	frame->sf.gprs[11 - 6] = (unsigned long)&frame->childregs;
+	frame->sf.gprs[12 - 6] = (unsigned long)p;
 	/* new return point is ret_from_fork */
-	frame->sf.gprs[8] = (unsigned long)ret_from_fork;
+	frame->sf.gprs[14 - 6] = (unsigned long)ret_from_fork;
 	/* fake return stack for resume(), don't go back to schedule */
-	frame->sf.gprs[9] = (unsigned long)frame;
+	frame->sf.gprs[15 - 6] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
 	if (unlikely(args->fn)) {
@@ -149,8 +149,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO |
 					    PSW_MASK_EXT | PSW_MASK_MCHECK;
-		frame->childregs.psw.addr =
-				(unsigned long)__ret_from_fork;
 		frame->childregs.gprs[9] = (unsigned long)args->fn;
 		frame->childregs.gprs[10] = (unsigned long)args->fn_arg;
 		frame->childregs.orig_gpr2 = -1;
