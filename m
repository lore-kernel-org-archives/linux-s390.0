Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgKBRHh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 12:07:37 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D649BC0617A6
        for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2020 09:07:35 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m9so1985934iox.10
        for <linux-s390@vger.kernel.org>; Mon, 02 Nov 2020 09:07:35 -0800 (PST)
Subject: Re: [PATCH] s390: add support for TIF_NOTIFY_SIGNAL
References: <20201101173153.GC9375 () osiris>
 <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <54c02fa6-8c8a-667f-af99-e83a1f150586@kernel.dk>
Date: Mon, 2 Nov 2020 10:07:33 -0700
MIME-Version: 1.0
In-Reply-To: <362e3645e2c0891309c07e244a147f0c32f106da.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@redhat.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@linutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>

On 11/2/20 9:59 AM, Qian Cai wrote:
> On Sun, 2020-11-01 at 17:31 +0000, Heiko Carstens wrote:
>> On Thu, Oct 29, 2020 at 10:21:11AM -0600, Jens Axboe wrote:
>>> Wire up TIF_NOTIFY_SIGNAL handling for s390.
>>>
>>> Cc: linux-s390@vger.kernel.org
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Even though I did confirm that today's linux-next contains this additional patch
> from Heiko below, a z10 guest is still unable to boot. Reverting the whole
> series (reverting only "s390: add support for TIF_NOTIFY_SIGNAL" introduced
> compiling errors) fixed the problem, i.e., git revert --no-edit
> af0dd809f3d3..7b074c15374c [1]

That's odd, it should build fine without that patch. How did it fail for you?

Can you try and add this on top? Looks like I forgot the signal change for
s390, though that shouldn't really cause any issues.


diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 9e900a8977bd..a68c3796a1bf 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -472,7 +472,7 @@ void do_signal(struct pt_regs *regs)
 	current->thread.system_call =
 		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
 
-	if (get_signal(&ksig)) {
+	if (test_thread_flag(TIF_NOTIFY_SIGNAL) && get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
 		if (current->thread.system_call) {
 			regs->int_code = current->thread.system_call;

-- 
Jens Axboe
