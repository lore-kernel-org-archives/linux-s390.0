Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B633603EF;
	Tue, 15 Sep 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458401; cv=none; b=BFDcQzxGK4e4I1ysXU7Ygnm4hxaG3nvC5Xh2bzhHZGw6vgFgowbAVtQU3shfKB0w1EGIsct13O9stJOjpvuBKziCrcOG25l+LAhLx5b88sI8U/hq8m+Z6L5ii9QNX4G4M8vwgVjFpMUGJDdjNsZyT5HXax0zF0ZReHQ2wpdY4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458401; c=relaxed/simple;
	bh=TGxiytZbwlmv2BP60EKFFTrI1970pAfKpcdYND/NbhU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ss4mmL7pK104vP9ztMmaWmMWoI8sFHMZwt46sl309JMcHlCucR9SfcV2jEbsPhGEh2Qp28ERVWVzBzW8NXF5WEfi3ItLdIu3ypC+jGcQf6f9BK/V5/2c5D631Js1p/12fYAd9QLr0OJAv1LNxfbLSsI4G8njjMWr/JTtV8oOq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gWJOwkn8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdEMAFAK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gWJOwkn8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdEMAFAK"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 44038EC062E;
	Tue, 15 Sep 2026 03:46:36 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 15 Sep 2026 03:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789458395;
	 x=1789544795; bh=J9TVHqMg6DzzuOSZ1h26Nn1hQ6ISaDnr9mEy//ELed0=; b=
	gWJOwkn8qVN0hj5f7WGvUZAhs3CZBeo3GtMSnu/ybA444ItsfZGyyR6+lz82aTX5
	EL7LNzJnDcPjzFwK7THKOIdKd+pVUpYX7LxF27ZbNQbvDamNN35AuOBsC6X6iWWC
	gMkW8RwX1lPflvdT5EZNkGaqcVLkBypc3ZpdJkP6I0hlpxBI5eDHQSNs3Ihflz9Z
	wfy+YCcLbTeW11trLS8vNBqg3sMcfvIdPtn4qbJzLODTh6jfPUY6L4WJ/xqWajfC
	8l1ukToruj4EtuzHVD/1s/GJ72cqNlWjljgzwiZeZPlvGw6BdC45WzYMl8uxChxm
	ILs5ft66VzolU0WB9BwLkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789458395; x=
	1789544795; bh=J9TVHqMg6DzzuOSZ1h26Nn1hQ6ISaDnr9mEy//ELed0=; b=q
	dEMAFAKJsWQ2+R7P4+Ed6WvD9pC356dz6S04fOLECMzm8F3kEeumGyrGIp9GdH7n
	rJAZrdpKqns8Sh0JpUZPL+7pZL7A88OOFpWfWmUBFH4cB/ST9byyoJ1fU0/7v3rk
	Cw5a6/yyFr44xw34IwXHNnDR6Ek7yGWQRcAGYSaNnktd1J993qmFQS56O2ETIj8+
	Fi8RqszY9Z+VOG+LjF6463mAlf4Al91GBm9J5INvRXbC4KWaEvQ6BtT7ONVMppEf
	ClnohD6ujLK7MKzAw41NP3nTQtUCgsrb/SAM8tZBZgLHczjucu127P6jZbts1dar
	670Hd9OULOrJVEuZN79Xw==
X-ME-Sender: <xms:1veoaq-s-zK2UArd3jLyOSO5wgaVrbeebs-nQ5DuVrX_z0-9H71hyQ>
    <xme:1veoaliUMKFoItbNkdFPzPq-h_rIyk8e6dnqDrRxPIacByiVZzEhzZipYdnRVMavs
    bYeTGnTMAU98JOQ1tFDypHz-PO5QqWM3P7qsj-YmmYJu9ofMetskFM>
X-ME-Proxy-Cause: dmFkZTFjBJTPSsEvy7MdPYY6zoz5hEujSdjlA0j1/ndTB6CM/iz4MVRXgkhD+6Up0/ryRu
    xEKhw7XJzajgoXQusJgmwVrHZmGtqCQvgETtVrkeGYuXdxEoqFrBwJbIKAeiBLsoCdS4by
    UTMePArx3+74ccqnNttcOua34hzVwQqbxzZEliOytewiy6U/yDTXlu01lwA1i4z02FxOeY
    cQMGEYrfctlDcOg/PWPqgycJxZY6uswSnNn9EWOz2NKeVkGVxOPeVjyHqG+aa3YRBLZK3+
    qDvmOvsQTDC4uQg9wePtcFpouKeI+yVVPp4ahrnz+mqeTgRbjRkbmT7F4A7l5Zg3mRtZem
    V1YTrkyQYtU/UrXQRE+v6Up2nhaqvUqzuxKIYY28PgJxjwr8y6dyBPzzJ8q3igIyZSzb8a
    yi/2ZGz1krnOkI63xE7YqxxTTZTzmzbynlxlCj6WWZOJKyzTNJ/5eL/sHFZ1/cVfS51at/
    gb1AdH/c/zYpgO4Vcice7yl/S7IAL2p29oJAbte/BKvAByatZfMVfT1Gq6V7IXwyrXZ8Ko
    VfyG6z/JW8cm3p2JBFul+1KZzSruB/ey6Nb71FEe7/u1j9S7r6SnUqmz38RuV0/LPP77cl
    eEgXy9ucq2nzC/+/yMwfyDCiv6sTZB0cQCjs5hveFN0OaIIdbgsZibgZq5mQ
X-ME-Proxy: <xmx:2feoauhm05MVTTJFNChLLZ1eEI5vzlR1J4HNxrorZrOq3zNpDqSXkg>
    <xmx:2feoavezASGoXoYquy_goSx0civPySVKcBZ1RDM6sU5tu2LUzLSjCQ>
    <xmx:2feoal36ABBh5m1iTrh0wreAOmUA8HFVmzS3bQvWmDTc_87EzWkVMw>
    <xmx:2feoajr3p3sPVKfBW7otUAqGoHu_zctcV3NxIEfgODa2TeI_vp-uwA>
    <xmx:2_eoahL73tD2rKVLVCoyvzx-4DgTHujZF_SW7UbuyouYn8oDxnXmPXfq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A85E332A0081; Tue, 15 Sep 2026 03:46:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA0MNwphKERR
Date: Tue, 15 Sep 2026 09:45:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <95b693c0-ca51-4355-99ba-2b37a1ab2169@app.fastmail.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
Subject: Re: [PATCH v6 00/13] syscalls: Add a shared table for all archs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026, at 01:19, Andr=C3=A9 Almeida wrote:
> While implementing a new syscall, we need to wire up it's number to th=
e arch
> table. Since syscall number 403, all architectures are on sync regardi=
ng the
> number (except alpha), which make things a lot easier but more repetit=
ive as
> well. Have a look at commit b36d4b6aa88 ("arch: hookup listns() system=
 call"),
> with 15 lines of mostly:
>
>   +470    common  listns                          sys_listns
>
> There's already a "common" table shared with a bunch of archs at
> `scripts/syscall.tbl`, but due to historical reasons some archs will n=
ever be
> able to move to this table and share all the numbers.
>
> The generic table starts from 403 (clock_gettime64), the first common =
syscall.
>
> I've compile tested for arm32, arm64, s390, mips, sparc and alpha by c=
omparing
> the syscalls_*.h and unistd_*.h files generated before and after this =
patchset.
> For most of cases the files are identical, for the few cases that they=
 are not,
> there's a note in the commit explaining why they are equivalent.

I've tried merging these for the asm-generic tree now, and would like to
send them for 7.4.

Unfortunately, the build bot flagged problems on mips, see the patch bel=
ow
for my workarounds=3D, but I think we have to improve that still and did=
n't
just fold it into your patch.

As you took out the dependencies on the syscall_*.tbl files, the
output does not get rebuilt if changes are made to the table, and I
have not come up with a good solution for mips. My hack just adds both
input files to all outputs, which works but is not technically correct.

The rt_sigtimedwait and ustat entries had a typo that caused a link
error, but I did not check if there were any additional mistakes that
caused incorrect output data without causing a link failure.

       Arnd

diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/sysca=
lls/Makefile
index aaa5443ea906..51b9939ecff0 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -40,10 +40,10 @@ src_n32 :=3D $(src)/syscall_n.tbl
 src_n64 :=3D $(src)/syscall_n.tbl
 src_o32 :=3D $(src)/syscall_o32.tbl
=20
-$(kapi)/unistd_nr_%.h: $(systbl_common) $(sysnr) FORCE
+$(kapi)/unistd_nr_%.h: $(src_o32) $(src_n64) $(systbl_common) $(sysnr) =
FORCE
        $(call if_changed,sysnr)
=20
-$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) FORCE
+$(kapi)/syscall_table_%.h: $(src_o32) $(src_n64) $(systbl) $(systbl_com=
mon) FORCE
        $(call if_changed,systbl)
=20
 uapisyshdr-y           +=3D unistd_n32.h                 \
diff --git a/arch/mips/kernel/syscalls/syscall_n.tbl b/arch/mips/kernel/=
syscalls/syscall_n.tbl
index e3d278f715b7..84c35c1f0c3e 100644
--- a/arch/mips/kernel/syscalls/syscall_n.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n.tbl
@@ -133,14 +133,14 @@
 123    common  capget                          sys_capget
 124    common  capset                          sys_capset
 125    common  rt_sigpending                   sys_rt_sigpending       =
compat_sys_rt_sigpending
-126    common  rt_sigtimedwait                 sys_rt_sigtimedwait_time=
        compat_sys_rt_sigtimedwait_time32
+126    common  rt_sigtimedwait                 sys_rt_sigtimedwait     =
compat_sys_rt_sigtimedwait_time32
 127    common  rt_sigqueueinfo                 sys_rt_sigqueueinfo     =
compat_sys_rt_sigqueueinfo
 128    common  rt_sigsuspend                   sys_rt_sigsuspend       =
compat_sys_rt_sigsuspend
 129    common  sigaltstack                     sys_sigaltstack         =
compat_sys_sigaltstack
 130    common  utime                           sys_utime               =
sys_utime32
 131    common  mknod                           sys_mknod
 132    common  personality                     sys_personality         =
sys_32_personality
-133    common  ustat                           sys_usta                =
compat_sys_usta
+133    common  ustat                           sys_ustat               =
compat_sys_ustat
 134    common  statfs                          sys_statfs              =
compat_sys_statfs
 135    common  fstatfs                         sys_fstatfs             =
compat_sys_fstatfs
 136    common  sysfs                           sys_sysfs
