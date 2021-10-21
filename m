Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9CEC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 21 Oct 2021 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E3061373
	for <linux-s390@archiver.kernel.org>; Thu, 21 Oct 2021 16:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhJUQ1j (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:27:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33066 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhJUQ1j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Oct 2021 12:27:39 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:49386)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdasZ-005agR-VI; Thu, 21 Oct 2021 10:25:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55044 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdasW-004580-Ld; Thu, 21 Oct 2021 10:25:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-2-ebiederm@xmission.com>
        <202110210858.41719190D2@keescook>
Date:   Thu, 21 Oct 2021 11:25:08 -0500
In-Reply-To: <202110210858.41719190D2@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:02:04 -0700")
Message-ID: <87cznycpln.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdasW-004580-Ld;;;mid=<87cznycpln.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+8ac5GaciGlAstn3lEEUZ+dUI+mMUpD0U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 02/20] exit: Remove calls of do_exit after noreturn versions of die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:43:48PM -0500, Eric W. Biederman wrote:
>> On nds32, openrisc, s390, sh, and xtensa the function die never
>> returns.  Mark die __noreturn so that no one expects die to return.
>> Remove the do_exit calls after die as they will never be reached.
>
> Maybe note that the "bust_spinlocks" calls are also redundant, since
> they're in die(). I note that is a "mismatch" between the do_kill()
> in die() (SIGSEGV) and after die() (SIGKILL). This patch makes no
> behavioral change (the first caller would "win"), but I thought I'd note
> it in case some architecture would prefer a different signal.

If someone has some strong preferences in the matter of which signal a
wait on a processes that has oopsed should return please let me know.

My next step in cleaning up the uses of do_exit looks like it is going
to be getting all of the architectures to use the same signal for oopses
(aka die), and then introducing a helper (called something like
"make_task_dead" or "oops_task_exit" ) that will replace do_exit on the
oops path and not take a signal number at all.

That helper I can then remove the ptrace break point from and possibly
some of the coredump logic as well.  Ultimately it will be something
we can optimize for the case when we know there is a kernel bug and we
just want the task to exit so the rest of the system can limp along
as best as it can.

Eric
