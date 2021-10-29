Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA2C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DB560F93
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 19:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2Tg4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:36:56 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37482 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ2Tg4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Oct 2021 15:36:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:57118)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgXdx-007QLV-Jn; Fri, 29 Oct 2021 13:34:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:32942 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgXdw-00EJtM-9Y; Fri, 29 Oct 2021 13:34:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-11-ebiederm@xmission.com>
        <7c99f791-4a87-ae52-bee7-cb794b0741d2@de.ibm.com>
        <87y26dp2hj.fsf@disp2133>
Date:   Fri, 29 Oct 2021 14:32:36 -0500
In-Reply-To: <87y26dp2hj.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        28 Oct 2021 10:56:24 -0500")
Message-ID: <87v91fhbjf.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mgXdw-00EJtM-9Y;;;mid=<87v91fhbjf.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+IQGABJNds1K89FHzqTI6D9ZKRfirmdT4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 11/20] signal/s390: Use force_sigsegv in default_trap_handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Christian Borntraeger <borntraeger@de.ibm.com> writes:
>
>> Am 20.10.21 um 19:43 schrieb Eric W. Biederman:
>>> Reading the history it is unclear why default_trap_handler calls
>>> do_exit.  It is not even menthioned in the commit where the change
>>> happened.  My best guess is that because it is unknown why the
>>> exception happened it was desired to guarantee the process never
>>> returned to userspace.
>>>
>>> Using do_exit(SIGSEGV) has the problem that it will only terminate one
>>> thread of a process, leaving the process in an undefined state.
>>>
>>> Use force_sigsegv(SIGSEGV) instead which effectively has the same
>>> behavior except that is uses the ordinary signal mechanism and
>>> terminates all threads of a process and is generally well defined.
>>
>> Do I get that right, that programs can not block SIGSEGV from force_sigsegv
>> with a signal handler? Thats how I read the code. If this is true
>> then
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
> 99% true, and it is what force_sigsegv(SIGSEGV) intends to do.
>
> Andy Lutormorski pointed at a race where a thread can call sigaction
> and change the signal handler after force_sigsegv has run but before
> the process dequeues the SIGSEGV.

I now have a simple patch that closes the sigaction vs force_sig race,
that I am adding to this set of changes.  So now I can say programs can
not block force_sigsegv(SIGSEGV) with a signal handler or any other
method.

Eric

>>> Cc: Heiko Carstens <hca@linux.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: linux-s390@vger.kernel.org
>>> Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
>>> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>   arch/s390/kernel/traps.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
>>> index bcefc2173de4..51729ea2cf8e 100644
>>> --- a/arch/s390/kernel/traps.c
>>> +++ b/arch/s390/kernel/traps.c
>>> @@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
>>>   {
>>>   	if (user_mode(regs)) {
>>>   		report_user_fault(regs, SIGSEGV, 0);
>>> -		do_exit(SIGSEGV);
>>> +		force_sigsegv(SIGSEGV);
>>>   	} else
>>>   		die(regs, "Unknown program exception");
>>>   }
>>>
