Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F13CAE95
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320292; cv=none; b=NS85FGapPOhaHPMXLKul5Z099b7uwa+DBikOQwLjJ2o6RybSTwqedpQPK5aTppx2iFBLDj0btNJGUkqP7Wx2p/oGdfBI+CVVoFANt8vmR2FiLsOfhAVzfrNyCZy+QtsFmQQYLKZKvVH4LNVs5g0v6doj9E8oPdlNBiNEU58Ddzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320292; c=relaxed/simple;
	bh=8/q15zH28mDu1hXhICrVjtbcwOJfbz3pGVvvXZMiZds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrqiqGdlKD/yG8qV3iLxGkea32Nxe0a0Et5CQ8jlAaFPRkCv6D2M98D4l6nwbzT5ZX5TJtVbd4j4AYgT+85Hzy6FWHkebiZxsaXJ5KBBLoUW2f3BAww419uFJiBySj8Dg4Qjj06FtZItVhsVUtPJPVNrd8mYAhF2rANrZe/iHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWykK1jJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWykK1jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1941F00A3C
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 23:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320290;
	bh=+XojcX+cBNMxauV3CDSL9gXTCmD6yueQSzdQP2DbJ+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mWykK1jJ4M1Y0t1X4E200qRw3WucF2APHRoJg6V2GzmeM8J67Rp7qms4fjy8aUiHA
	 mi1CuV2NNRyTBUdpu0DS2U/poDmgZ5bUjCz346Jr17eSUS8rtWYmnrs/XoIM22VPWQ
	 LBHwLD3FNTiRXdNQOult0hvNiZsGwPEZhaedB+3xG8zfW32UeI7mBuYTfColqen05V
	 5sbz39iZci3r6cYK5iGqKWGDFjvFsuK10PTf28l+a/KETrjrsBrCy45dNKOIyb0Slz
	 20jr5Z56iThLCKE9GsJ45F+Q48gvBMnA1kMM5K+tZdcIVXJNiZmHGh/kc3z+Cso4vh
	 v6IxapDe1cKTw==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5165195c8b0so62097141cf.0
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 16:38:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8i/c1oFB96aep15i+/pa8gwe69NKuo9Vrn8ALw2NYLfaqquFeNpvUcqg8BQ6INbSsLrZuzUDlkzDJx@vger.kernel.org
X-Gm-Message-State: AOJu0YzBChL4wzOs9LATVRdew3TSmm6s05W/LalgBCy1xbqNloXU/4By
	F39o6blWVtfXe29jM7ybNQDdofdPx6DyD1OSVm4MkaykfFx1b1xvTeWdKNfrG90DZh0897XAHKf
	qV3p5TVWvkAqZ64oUEaSjQXDUBTVZ+FI=
X-Received: by 2002:a05:622a:17c7:b0:50d:b0f9:1a66 with SMTP id
 d75a77b69052e-516c55ce180mr9639641cf.42.1779320290158; Wed, 20 May 2026
 16:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
In-Reply-To: <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 21 May 2026 07:37:58 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
X-Gm-Features: AVHnY4LEan2jPUL-UnPeql1qwutuRGUCiZMo1ZXEi3On484A8O-Avt_P3lSUuSE
Message-ID: <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:35=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/20/26 23:15, Matthew Wilcox wrote:
> > On Thu, May 21, 2026 at 05:14:20AM +0800, Barry Song wrote:
> >> My understanding is that we should not blame applications here. This i=
s 2026:
> >> there are basically only two kinds of applications =E2=80=94 single-th=
readed and
> >> multi-threaded =E2=80=94 and single-threaded applications are nearly e=
xtinct.
> >
> > all of the applications i run are either single threaded or don't fork.
> > what multithreaded applications call fork?
>
> Traditionally the problem was random libraries using fork+execve to launc=
h other
> programs ... instead of using alternatives like posix_spwan (some use cas=
es
> require more work done before execve and cannot yet switch to that). I'd =
hope
> that that is less of a problem on Android.
>
> I assume Android zygote might be multi threaded? Maybe sshd as well? Syst=
emd?
> But I'd be surprised if there are really performance implications.

I am trying to answer the question above:

1. zygote, multi-threaded on my phone using Android13.
/ # ls /proc/`pidof zygote64`/task/
1359  22728  22729  22730  22731  22732

/proc/1359/task # cat 22728/comm
Jit thread pool
/proc/1359/task # cat 22730/comm
ReferenceQueueD
/proc/1359/task # cat 22731/comm
FinalizerDaemon
/proc/1359/task # cat 22732/comm
FinalizerWatchd
/proc/1359/task # cat 1359/comm
main

But on another phone of mine running Android 16, zygote64 is
single-threaded.
Not sure if it is due to the Android team making some changes
related to threads from Android 13 to Android 16.

2. sshd, multi-processes instead of multi-threads:
$ ps aux | grep sshd
root        1192  0.0  0.0  15444  9032 ?        Ss   09:42   0:00
sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root        2465  0.0  0.0  17164 10760 ?        Ss   09:42   0:00
sshd: barry [priv]
barry       2632  0.0  0.0  17164  7852 ?        S    09:42   0:00
sshd: barry@pts/0
root        3305  2.5  0.0  17164 10772 ?        Ss   09:44   0:00
sshd: barry [priv]
barry       3406  0.0  0.0  17164  7940 ?        S    09:44   0:00
sshd: barry@pts/1

3. systemd, also multi-processes

$ ps ax | grep systemd
    350 ?        S<s    0:00 /lib/systemd/systemd-journald
    387 ?        Ss     0:00 /lib/systemd/systemd-udevd
    666 ?        Ss     0:00 /lib/systemd/systemd-oomd
    667 ?        Ss     0:00 /lib/systemd/systemd-resolved
    728 ?        Ss     0:00 @dbus-daemon --system --address=3Dsystemd:
--nofork --nopidfile --systemd-activation --syslog-only
    751 ?        Ss     0:00 /lib/systemd/systemd-logind
    753 ?        Ssl    0:00 /usr/sbin/thermald --systemd
--dbus-enable --adaptive
   1350 ?        Ss     0:00 /lib/systemd/systemd --user
   1428 ?        Ss     0:00 /usr/bin/dbus-daemon --session
--address=3Dsystemd: --nofork --nopidfile --systemd-activation
--syslog-only
   1900 ?        Ssl    0:00 /usr/libexec/gnome-session-binary
--systemd-service --session=3Dubuntu
   2141 ?        Ssl    0:00 /lib/systemd/systemd-timesyncd

>
> Not sure about webbroswers .... I think most of them switched to fork ser=
vers,
> where I would assume fork servers would be single-threaded.

On my phone, Chrome is multi-process, but its parent process
chrome_zygote (10774) is single-threaded:

 ps -A | grep chrome
u0_i15        9883 10774 321066464 119452 do_epoll_wait     0 S
com.android.chrome:sandboxed_process0:org.chromium.content.app.SandboxedPro=
cessService0:15
u0_a142      10164  1359 35110548 277640 do_epoll_wait      0 S
com.android.chrome
u0_a278      10724  1359 9779864 104988 do_epoll_wait       0 S
com.google.android.apps.chromecast.app
u0_a142      10774  1359 32803908 64076 do_sys_poll         0 S
com.android.chrome_zygote
u0_a142      11173  1359 34208592 142192 do_epoll_wait      0 S
com.android.chrome:privileged_process0

/proc/10774/task # ls
10774

>
> So, yeah, getting a clear understanding how this ends up being a problem =
on
> Android would be great.

I guess the real issue is that in the Android market, there
are so many applications that are out of our control=EF=BC=9F

Here are some trace examples from Nanzhe:

iQIYI plugin
vma reader thread:
PbMisc-0, pid=3D27183, tgid=3D26444

vma writer thread:
i.video:plugin1, pid=3D27298, tgid=3D26444
writer blocked: 440394938 ns (440 ms)

reader stack:
vma_start_read
lock_vma_under_rcu
do_page_fault
do_translation_fault
do_mem_abort
el0_da
el0t_64_sync_handler
el0t_64_sync

writer stack:
__vma_start_write
dup_mmap
copy_mm
copy_process
kernel_clone
__arm64_sys_clone
invoke_syscall
el0_svc_common
do_el0_svc
el0_svc


Baidu Tieba
vma reader thread:
elastic_pms_pro, pid=3D7731, tgid=3D7575

vma writer thread:
com.baidu.tieba, pid=3D8005, tgid=3D7575
writer blocked: 514975545 ns(515 ms)

reader stack:
vma_start_read
lock_vma_under_rcu
do_page_fault
do_translation_fault
do_mem_abort
el0_da
el0t_64_sync_handler
el0t_64_sync

writer stack:
__vma_start_write
dup_mmap
copy_mm
copy_process
kernel_clone
__arm64_sys_clone
invoke_syscall
el0_svc_common
do_el0_svc
el0_svc

Thanks
Barry
