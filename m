Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgIVAYk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Sep 2020 20:24:40 -0400
References: <CAK8P3a2Mi+1yttyGk4k7HxRVrMtmFqJewouVhynqUL0PJycmog@mail.gmail.com>
 <D0791499-1190-4C3F-A984-0A313ECA81C7@amacapital.net>
 <563138b5-7073-74bc-f0c5-b2bad6277e87@gmail.com>
 <486c92d0-0f2e-bd61-1ab8-302524af5e08@gmail.com>
 <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <d5c6736a-2cb4-4e22-78da-a667bda5c05a@gmail.com>
Date: Tue, 22 Sep 2020 03:22:06 +0300
MIME-Version: 1.0
In-Reply-To: <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>



On 22/09/2020 02:51, Andy Lutomirski wrote:
> On Mon, Sep 21, 2020 at 9:15 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 21/09/2020 19:10, Pavel Begunkov wrote:
>>> On 20/09/2020 01:22, Andy Lutomirski wrote:
>>>>
>>>>> On Sep 19, 2020, at 2:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>
>>>>> ﻿On Sat, Sep 19, 2020 at 6:21 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>>> On Fri, Sep 18, 2020 at 8:16 AM Christoph Hellwig <hch@lst.de> wrote:
>>>>>>> On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
>>>>>>>> Said that, why not provide a variant that would take an explicit
>>>>>>>> "is it compat" argument and use it there?  And have the normal
>>>>>>>> one pass in_compat_syscall() to that...
>>>>>>>
>>>>>>> That would help to not introduce a regression with this series yes.
>>>>>>> But it wouldn't fix existing bugs when io_uring is used to access
>>>>>>> read or write methods that use in_compat_syscall().  One example that
>>>>>>> I recently ran into is drivers/scsi/sg.c.
>>>>>
>>>>> Ah, so reading /dev/input/event* would suffer from the same issue,
>>>>> and that one would in fact be broken by your patch in the hypothetical
>>>>> case that someone tried to use io_uring to read /dev/input/event on x32...
>>>>>
>>>>> For reference, I checked the socket timestamp handling that has a
>>>>> number of corner cases with time32/time64 formats in compat mode,
>>>>> but none of those appear to be affected by the problem.
>>>>>
>>>>>> Aside from the potentially nasty use of per-task variables, one thing
>>>>>> I don't like about PF_FORCE_COMPAT is that it's one-way.  If we're
>>>>>> going to have a generic mechanism for this, shouldn't we allow a full
>>>>>> override of the syscall arch instead of just allowing forcing compat
>>>>>> so that a compat syscall can do a non-compat operation?
>>>>>
>>>>> The only reason it's needed here is that the caller is in a kernel
>>>>> thread rather than a system call. Are there any possible scenarios
>>>>> where one would actually need the opposite?
>>>>>
>>>>
>>>> I can certainly imagine needing to force x32 mode from a kernel thread.
>>>>
>>>> As for the other direction: what exactly are the desired bitness/arch semantics of io_uring?  Is the operation bitness chosen by the io_uring creation or by the io_uring_enter() bitness?
>>>
>>> It's rather the second one. Even though AFAIR it wasn't discussed
>>> specifically, that how it works now (_partially_).
>>
>> Double checked -- I'm wrong, that's the former one. Most of it is based
>> on a flag that was set an creation.
>>
> 
> Could we get away with making io_uring_enter() return -EINVAL (or
> maybe -ENOTTY?) if you try to do it with bitness that doesn't match
> the io_uring?  And disable SQPOLL in compat mode?

Something like below. If PF_FORCE_COMPAT or any other solution
doesn't lend by the time, I'll take a look whether other io_uring's
syscalls need similar checks, etc.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0458f02d4ca8..aab20785fa9a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8671,6 +8671,10 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 	if (ctx->flags & IORING_SETUP_R_DISABLED)
 		goto out;
 
+	ret = -EINVAl;
+	if (ctx->compat != in_compat_syscall())
+		goto out;
+
 	/*
 	 * For SQ polling, the thread will do all submissions and completions.
 	 * Just return the requested submit count, and wake the thread if
@@ -9006,6 +9010,10 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p,
 	if (ret)
 		goto err;
 
+	ret = -EINVAL;
+	if (ctx->compat)
+		goto err;
+
 	/* Only gets the ring fd, doesn't install it in the file table */
 	fd = io_uring_get_fd(ctx, &file);
 	if (fd < 0) {
-- 
Pavel Begunkov
