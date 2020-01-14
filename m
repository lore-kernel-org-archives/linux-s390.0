Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:44045 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANQUf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Jan 2020 11:20:35 -0500
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RESEND v4] reboot: support offline CPUs before reboot
In-Reply-To: <20200114110620.164861-1-hsinyi@chromium.org>
References: <20200114110620.164861-1-hsinyi@chromium.org>
Date: Tue, 14 Jan 2020 17:19:59 +0100
Message-ID: <87o8v6au34.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jkosina@suse.cz>, Pavankumar Kondeti <pkondeti@codeaurora.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Guenter Roeck <groeck@chromium.org>, Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-pm@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Resend v4:
> * Cc more people and mailing lists. Also fix a few nits from v4.

Please don't name it resend if you actually changed the patch. Resend
wants to be an unmodified patch and the only reasons to do that are:

 - add more people to CC

 - Resend it because it got ignored or dropped (do that only after a
   couple of weeks)

If you changed the patch, then it wants a new version number.

Thanks,

        tglx
