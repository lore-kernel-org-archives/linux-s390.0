Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38078 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWAk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 17:00:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id q19so7252411qvs.5
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 14:00:38 -0800 (PST)
Date: Mon, 18 Nov 2019 17:00:36 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: PSI: use-after-free in collect_percpu_times()
Message-ID: <20191118220036.GA382712@cmpxchg.org>
References: <1574113159.5937.148.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574113159.5937.148.camel@lca.pw>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>
Cc: Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Qian,

On Mon, Nov 18, 2019 at 04:39:19PM -0500, Qian Cai wrote:
> Since a few days ago, s390 starts to crash on linux-next while reading some
> sysfs. It is not always reproducible but seems pretty reproducible after running
> the whole MM test suite here,
> https://github.com/cailca/linux-mm/blob/master/test.sh
> 
> the config:
> https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config
> 
> The stack trace on s390 is not particular helpful as both gdb and faddr2line are
> unable to point out which line causes the issue.
> 
> # ./scripts/faddr2line vmlinux collect_percpu_times+0x2d6/0x798
> bad symbol size: base: 0x00000000002076f8 end: 0x00000000002076f8
> 
> (gdb) list *(collect_percpu_times+0x2d6)
> 0x2079ce is in collect_percpu_times (./include/linux/compiler.h:199).
> 194	})
> 195	
> 196	static __always_inline
> 197	void __read_once_size(const volatile void *p, void *res, int size)
> 198	{
> 199		__READ_ONCE_SIZE;
> 200	}
> 201	
> 202	#ifdef CONFIG_KASAN
> 203	/*
> 
> Could it be some race conditions in PSI?

psi doesn't do much lifetime management in itself: the psi_group is
embedded in the cgroup and the per-cpu data is freed right before the
cgroup itself is freed. An open file descriptor on the pressure files
will pin the cgroup and prevent it from being deleted.

As it's reproducible, would you be able to bisect this problem?
