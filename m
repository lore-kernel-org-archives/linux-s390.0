Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-il1-f196.google.com ([209.85.166.196]:35945 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgAPJ0K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 04:26:10 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so17562192iln.3
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 01:26:09 -0800 (PST)
MIME-Version: 1.0
References: <20200115063410.131692-1-hsinyi@chromium.org> <20200115114112.GA3663@bogus>
In-Reply-To: <20200115114112.GA3663@bogus>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 16 Jan 2020 17:25:43 +0800
Message-ID: <CAJMQK-ip7C71=K+CViEKcc3ed4GPY_Uknm5uNgLJTzZb2aQOcA@mail.gmail.com>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jkosina@suse.cz>, Pavankumar Kondeti <pkondeti@codeaurora.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Guenter Roeck <groeck@chromium.org>, Stephen Boyd <swboyd@chromium.org>, lkml <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, Linux PM <linux-pm@vger.kernel.org>

On Wed, Jan 15, 2020 at 7:41 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 15, 2020 at 02:34:10PM +0800, Hsin-Yi Wang wrote:
> > Currently system reboots uses architecture specific codes (smp_send_stop)
> > to offline non reboot CPUs. Most architecture's implementation is looping
> > through all non reboot online CPUs and call ipi function to each of them. Some
> > architecture like arm64, arm, and x86... would set offline masks to cpu without
> > really offline them. This causes some race condition and kernel warning comes
> > out sometimes when system reboots.
> >
> > This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> > migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> > checking online cpus would be an empty loop. If architecture don't enable this
> > config, or some cpus somehow fails to offline, it would fallback to ipi
> > function.
> >
>
> What's the timing impact on systems with large number of CPUs(say 256 or
> more) ? I remember we added some change to reduce the wait times for
> offlining CPUs in system suspend path on arm64, still not negligible.
>

This is not the final solution, but I would still provided some data
points here:

Tested on my arm64 with 4 cpu: 2 a53 and 2 a72.
Offlining 3 cpu takes about 60~65 ms
Offlining 2 cpu(a53+a72 or a72+a72) takes about 42~47 ms
Offlining 1 cpu(a53 or a72) takes about 23~25 ms.

It would take longer time for systems with large number of CPUs.
