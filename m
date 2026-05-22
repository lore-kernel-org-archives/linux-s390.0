Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E12D1914;
	Fri, 22 May 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465198; cv=none; b=utGne4Jh8DAvnKQ5jLdbmFmI/exNZJ5lnE71o15RmCBKxZLlFd3VML6A0cVborTbcJ/6GvZerArcekPZmJKzqjO/7MJ8pwuRcL6kV6nK65QGbzsGn95hvf/j8+zoUfOeJAUQAzZGliZjlXMExauCHmRoHRp3plhoIc+MAP/48cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465198; c=relaxed/simple;
	bh=p5TAlnWkYIZGxoMT5zKuHs5/PeRhx8E/A3LocCUhWQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWxcHjUY4+Je7Hcj+Ikpct+rC5ll6MTlXAZc0p5q9QFIiVjktIPlsw654S8nd+Oi5YTxFYKvDb0NB2PDJC0YzAdRG2o6W9F2nJ3HEcjuyx5Ue74uTvb6Ulh207fDnQMD1H6nUIHsPU1srR9k1vOXE9c8P3vamFJK9AxPtHIld3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN2DCukL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN2DCukL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EF31F000E9;
	Fri, 22 May 2026 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779465197;
	bh=nLi5o9aFHCLXZcuSgGlSphUfHtenwcEC6tB28xNcNAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZN2DCukLsOafoLobH44iXf1sfDoQYg61aOk7vmrcF8XJyYJ/xjht533EHF+60iCye
	 Cl0E/OaLHSx5X6HjZgBjdalWOrQPrKpQSTDjwYdQZ0egQFhfpgIV5vcKFFcHEOZ1Va
	 Asp4ZeMkcS2jQtv+tmwx9b+uEaV9jG7TkQbe0VaYRgyf9gGIrt9Mn+Ih7pqUx068BR
	 QwaIWrsQOMXxHfyB8uf+3n7zv0YsF8pRB4hF/0RHUGB7ieG+pl4/xykuALsEct1wEZ
	 pH2FkimPHzyfCHlOM9VZbyupr0HROUK05eZbjP+nIqTn83aZ6G4+ZfcP0D1iKlA/cM
	 rp95h5XVHiBNw==
Date: Fri, 22 May 2026 16:53:08 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, kunwu.chan@gmail.com, 
	liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahB6QyHgYq8ksj65@lucifer>
References: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org>
 <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>

On Thu, May 21, 2026 at 07:37:58AM +0800, Barry Song wrote:
> On Thu, May 21, 2026 at 5:35 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 5/20/26 23:15, Matthew Wilcox wrote:
> > > On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:
> > >> My understanding is that we should not blame applications here. This is 2026:
> > >> there are basically only two kinds of applications — single-threaded and
> > >> multi-threaded — and single-threaded applications are nearly extinct.
> > >
> > > all of the applications i run are either single threaded or don't fork.
> > > what multithreaded applications call fork?
> >
> > Traditionally the problem was random libraries using fork+execve to launch other
> > programs ... instead of using alternatives like posix_spwan (some use cases
> > require more work done before execve and cannot yet switch to that). I'd hope
> > that that is less of a problem on Android.
> >
> > I assume Android zygote might be multi threaded? Maybe sshd as well? Systemd?
> > But I'd be surprised if there are really performance implications.
>
> I am trying to answer the question above:
>
> 1. zygote, multi-threaded on my phone using Android13.
> / # ls /proc/`pidof zygote64`/task/
> 1359  22728  22729  22730  22731  22732
>
> /proc/1359/task # cat 22728/comm
> Jit thread pool
> /proc/1359/task # cat 22730/comm
> ReferenceQueueD
> /proc/1359/task # cat 22731/comm
> FinalizerDaemon
> /proc/1359/task # cat 22732/comm
> FinalizerWatchd
> /proc/1359/task # cat 1359/comm
> main
>
> But on another phone of mine running Android 16, zygote64 is
> single-threaded.
> Not sure if it is due to the Android team making some changes
> related to threads from Android 13 to Android 16.
>
> 2. sshd, multi-processes instead of multi-threads:
> $ ps aux | grep sshd
> root        1192  0.0  0.0  15444  9032 ?        Ss   09:42   0:00
> sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
> root        2465  0.0  0.0  17164 10760 ?        Ss   09:42   0:00
> sshd: barry [priv]
> barry       2632  0.0  0.0  17164  7852 ?        S    09:42   0:00
> sshd: barry@pts/0
> root        3305  2.5  0.0  17164 10772 ?        Ss   09:44   0:00
> sshd: barry [priv]
> barry       3406  0.0  0.0  17164  7940 ?        S    09:44   0:00
> sshd: barry@pts/1
>
> 3. systemd, also multi-processes
>
> $ ps ax | grep systemd
>     350 ?        S<s    0:00 /lib/systemd/systemd-journald
>     387 ?        Ss     0:00 /lib/systemd/systemd-udevd
>     666 ?        Ss     0:00 /lib/systemd/systemd-oomd
>     667 ?        Ss     0:00 /lib/systemd/systemd-resolved
>     728 ?        Ss     0:00 @dbus-daemon --system --address=systemd:
> --nofork --nopidfile --systemd-activation --syslog-only
>     751 ?        Ss     0:00 /lib/systemd/systemd-logind
>     753 ?        Ssl    0:00 /usr/sbin/thermald --systemd
> --dbus-enable --adaptive
>    1350 ?        Ss     0:00 /lib/systemd/systemd --user
>    1428 ?        Ss     0:00 /usr/bin/dbus-daemon --session
> --address=systemd: --nofork --nopidfile --systemd-activation
> --syslog-only
>    1900 ?        Ssl    0:00 /usr/libexec/gnome-session-binary
> --systemd-service --session=ubuntu
>    2141 ?        Ssl    0:00 /lib/systemd/systemd-timesyncd
>
> >
> > Not sure about webbroswers .... I think most of them switched to fork servers,
> > where I would assume fork servers would be single-threaded.
>
> On my phone, Chrome is multi-process, but its parent process
> chrome_zygote (10774) is single-threaded:
>
>  ps -A | grep chrome
> u0_i15        9883 10774 321066464 119452 do_epoll_wait     0 S
> com.android.chrome:sandboxed_process0:org.chromium.content.app.SandboxedProcessService0:15
> u0_a142      10164  1359 35110548 277640 do_epoll_wait      0 S
> com.android.chrome
> u0_a278      10724  1359 9779864 104988 do_epoll_wait       0 S
> com.google.android.apps.chromecast.app
> u0_a142      10774  1359 32803908 64076 do_sys_poll         0 S
> com.android.chrome_zygote
> u0_a142      11173  1359 34208592 142192 do_epoll_wait      0 S
> com.android.chrome:privileged_process0
>
> /proc/10774/task # ls
> 10774
>
> >
> > So, yeah, getting a clear understanding how this ends up being a problem on
> > Android would be great.
>
> I guess the real issue is that in the Android market, there
> are so many applications that are out of our control？
>
> Here are some trace examples from Nanzhe:
>
> iQIYI plugin
> vma reader thread:
> PbMisc-0, pid=27183, tgid=26444
>
> vma writer thread:
> i.video:plugin1, pid=27298, tgid=26444
> writer blocked: 440394938 ns (440 ms)
>
> reader stack:
> vma_start_read
> lock_vma_under_rcu
> do_page_fault
> do_translation_fault
> do_mem_abort
> el0_da
> el0t_64_sync_handler
> el0t_64_sync
>
> writer stack:
> __vma_start_write
> dup_mmap
> copy_mm
> copy_process
> kernel_clone
> __arm64_sys_clone
> invoke_syscall
> el0_svc_common
> do_el0_svc
> el0_svc
>
>
> Baidu Tieba
> vma reader thread:
> elastic_pms_pro, pid=7731, tgid=7575
>
> vma writer thread:
> com.baidu.tieba, pid=8005, tgid=7575
> writer blocked: 514975545 ns(515 ms)
>
> reader stack:
> vma_start_read
> lock_vma_under_rcu
> do_page_fault
> do_translation_fault
> do_mem_abort
> el0_da
> el0t_64_sync_handler
> el0t_64_sync
>
> writer stack:
> __vma_start_write
> dup_mmap
> copy_mm
> copy_process
> kernel_clone
> __arm64_sys_clone
> invoke_syscall
> el0_svc_common
> do_el0_svc
> el0_svc
>
> Thanks
> Barry

Again this is making me want to sit outside and sip on some lemonade and
ice :)

Yes - android processes are aggressively multi-threaded, sure of course.

The missing bit here is the forking - what, where, why, when?

And then you say zygote is sometimes multi-threaded but sometimes
single-threaded, which is adding a whole bunch of confusion on top of all
that.

I don't find these stack trace dumps all that useful (though thanks of
course for taking the time to gather them), I think we'd be better off with
specific data on forking, in some _concise_ _summarised_ form, ideally with
numbers.

There's such a thing as too much information :))

Anyway, again, please let's see a new _RFC_ with the approach proposed by
Suren, with some _succinct_ data demonstrating _exactly_ what the problem
is, so we can make some headway here.

And now I'm off for a cornetto! :)

Thanks, Lorenzo
