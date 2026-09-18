Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B3471CE8;
	Fri, 18 Sep 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712574; cv=none; b=ZMZ3Qx72/BuiSGUpEwRhIQDYaewHM2N9K1VH+6XY1UTPnFGIBJg75HDUUtM8uy7JzwOV8IqMU193wnUrl6mysZk7PopgAXozs6OgfyKeZ8mk45+grUmO8Kraz3TQyFI8Qrf2X9W3lQPPLG3VimRze2syalHEX744yFcN1quEaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712574; c=relaxed/simple;
	bh=YMJr4VfHhly8SRzg4wWsaS0kIroHolXeWhClT2U0qm8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k3eOVpViBn0/3YxGQjT7FbNay/r0nPUbM9MRSwFhIvIlms2aa6UWHXCWASVa8taXwuOusT9PxJUBo4WJ0dKyCbkU0z8NLGXwQwxMPhtAOqd/tBhheCvY81pzL+G/lb+W1N6PSCVt/wRI9i6piIDV9QbJreg5JTSl7b/t9y3TbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KuGsUWhF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hecKULoF; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KuGsUWhF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hecKULoF"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52E757A00E8;
	Fri, 18 Sep 2026 02:22:50 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 02:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789712569;
	 x=1789798969; bh=kJRkH9y0iL21fiS3CIdzGL0TrDMTu7cAWMx2Tblk4Mw=; b=
	KuGsUWhFMeuW9g6yJPio9dJtFDd53WJUVuKXzHni9ASZoEBa7w3UdegqQavBrzSp
	FHhj1ntJTHJLf5kFeGch8P4TeIQHBqu8VXqMXvjP8OjY4zybZ3Rg/hkGwhBaijRj
	3CbHE7QjSuwIT/mKVRriIlAthkrkozi7xn+sHSC8SGMt6xzBnjMJiDxJgFpWrcRK
	XVAbZfNGnxV6W7bE9IRXOICx71YRbdHI19vs/ERn2RcgpSNXH3+hthBHDn84INzV
	wPXobz+8VSzg8YnmYDj7xK8QGTz18Ztcy8Iovqhhk7pp1exXFyQ9YnvHd3+vV44G
	/uB+WGD70lbUHPOQQzLAzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789712569; x=
	1789798969; bh=kJRkH9y0iL21fiS3CIdzGL0TrDMTu7cAWMx2Tblk4Mw=; b=h
	ecKULoFxbDXvLtzDUdWJZ4klvoKWbD0XRBPSqkAD2+8L0Y58nNL4zKDQF8+3/NfQ
	upT2/YeMW6yxggKS3IGmqBMh5WyyD5qi2hK+xLGk17GfY8+91mEPS0813mh34cKn
	zBM1Ku16Dgdg1dViUKrTCYcjJiT0y+U31ir0UxvC/Jzt3wg4Lfow/JZQQPbeIm//
	yD+kKxmQKj9SQirA2NBYbBH48rf4LpeXZd9f+aeHtP2PNpWsj5laM3tDFmz5GeRO
	X91RttRw7UE1lsUJSoQ7YzXG96g0yFEGu3Sa0VbpKIvCaM53Wu0m7JPgur7um33T
	t5iPrl3KPc7Hv6YaPHx+w==
X-ME-Sender: <xms:tdisarwmHHpdu8i3t4TkiPBBuLGV-drSoZa96TGnoF9z5ZVE-y9CwQ>
    <xme:tdisauE5qOH2Qyq5uiANm5XN7rQWI5-VO9ThNUnYicybMde8Nv1QN5_SD7zX6kmHM
    cz-05IUXenzxQtEfqbf4bKdicGRwI6lCN4KqNPc_kddwjQj0hmkqI8>
X-ME-Proxy-Cause: dmFkZTFEqTwzIprk1GtZpod+3Rl4MAua1izFjbVrb8H3Skw9dkRhugzxqCpAiUunM7SAJ1
    tzH+jABzo6ntMxneef+S1CTmpsAYV0v65Wd6jfWLEyz2Slhom95w2Rdk3fxJra7Mo/o4//
    bsG2AyDb/o92QNVOY1wHK2KdHaOXRlyq5ZayGSDksln3KeZ8XY4o43NOox8Ic2rB7qJ+dO
    TCcLbWjJwxEoHuNjaJkB5cr5Lx53s7OuYayv8/wGahLEx1b83hmoz1KreHBN/GcZUHiwAx
    Whr4/NoHuti+JIo673LXPUzJ8g4o+an8tlfo3jVblOp8K3Wp0873pDx3kIlB/PvO0BQdqv
    MhY5+Zio7jMkON6Dc4962pLR4jfgPcPlhrISNdKQ5rNMakuREPTq+44jdawHrsXnRn4y61
    0niKreB7mJV6p4gcFKBx/Q3f0QMSBU0NW5h3p+vWufkUuo9JRK2BgeyXULa14U07mKXMSV
    Bor+oAnAMkq9EJ7VUMMA0fqHjXQBDn3wlJIYjcYSLH9d5yMuBnYCedzXkl7VkJNC5FI+94
    tSoYV0RbgrH5uJ/Ya/wsrfzYc4hb/jwCGiNR7HYsNz2dKOwxBpTW31qXxZKsrLFZWsSPap
    cYCObrGDVDP6HwaGZPHjsSZ4tOZEjDUGEA+NHd614qsY5PSnB+NkmyOu8XvQ
X-ME-Proxy: <xmx:t9isar2jwiZMxB-smgPoh66sJGOMJEjtanEKsscpOSVx2qNqcqLNgA>
    <xmx:t9isaqj44Wtn_bxQumxtokd4ObqSfW6xjRAXndfpogwwqOWZpKOUyw>
    <xmx:t9isaro_YUBrFWR1Ia7BmHXoEYf4ZOPCptMHSu_bQ6VkjCrHNRwkDg>
    <xmx:t9isatMNsypAxfiPU-KUMbtELH-qgANjXD42PQijVhkNxqAhRQY67g>
    <xmx:udisah909h-WXrwp5hXuF3jPfIRYCd59Fj8tcjOp91qea-A4DVa-q6mX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id F17DB32A0084; Fri, 18 Sep 2026 02:22:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AytAa-GFwSww
Date: Fri, 18 Sep 2026 08:22:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <4fa47186-08b3-4b2a-bbcc-16b14a50ee21@app.fastmail.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-4-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-4-f4cd8f8e3265@igalia.com>
Subject: Re: [PATCH v7 04/13] arm: Use the common syscall table
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026, at 01:46, Andr=C3=A9 Almeida wrote:
> Remove some of the duplicated code by using the common syscall number
> table.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v6:
> - Added back syscalls from 403 to 423 to local table. arm32 can't use =
the
> common table for those syscalls, because arm doesn't implements compat_
> entry points for syscalls like pselect6, ppoll, etc., and OABI uses co=
mpat_
> entry points when it's available, so this would cause a build error.

That's too bad, especially if this is only needed for OABI, which
nobody should be using any more. I had hoped we could kill off OABI
soonish, but that is currently blocked on the discussion about keeping
RiscPC alive.

One possible idea would be to rework the table to differentiate
the cases using separate ABI tags for the three cases (EABI native,
OABI native, OABI on EABI), instead of using the compat column:

--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -115,7 +115,8 @@
 99     common  statfs                  sys_statfs
 100    common  fstatfs                 sys_fstatfs
 # 101 was sys_ioperm
-102    oabi    socketcall              sys_socketcall          sys_oabi=
_socketcall
+102    oabi    socketcall              sys_socketcall
+102    oabic   socketcall              sys_oabi_socketcall
 103    common  syslog                  sys_syslog
 104    common  setitimer               sys_setitimer
 105    common  getitimer               sys_getitimer
@@ -131,7 +132,8 @@
 114    common  wait4                   sys_wait4
 115    common  swapoff                 sys_swapoff
 116    common  sysinfo                 sys_sysinfo
-117    oabi    ipc                     sys_ipc                 sys_oabi=
_ipc
+117    oabi    ipc                     sys_ipc
+117    oabic   ipc                     sys_oabi_ipc
 118    common  fsync                   sys_fsync
 119    common  sigreturn               sys_sigreturn_wrapper
 120    common  clone                   sys_clone
@@ -194,8 +196,12 @@
 177    common  rt_sigtimedwait         sys_rt_sigtimedwait_time32
 178    common  rt_sigqueueinfo         sys_rt_sigqueueinfo
 179    common  rt_sigsuspend           sys_rt_sigsuspend
-180    common  pread64                 sys_pread64             sys_oabi=
_pread64
-181    common  pwrite64                sys_pwrite64            sys_oabi=
_pwrite64
+180    eabi    pread64                 sys_pread64
+180    oabi    pread64                 sys_pread64
+180    oabic   pread64                 sys_oabi_pread64
+181    eabi    pwrite64                sys_pwrite64
+181    oabi    pwrite64                sys_pwrite64
+181    oabic   pwrite64                sys_oabi_pwrite64
 182    common  chown                   sys_chown16
 183    common  getcwd                  sys_getcwd
 184    common  capget                  sys_capget
...


Not great, but it has the additional advantage of finally being able
to share the table file with the arm64 copy.

Another idea would be to actually add the six compat_sys_
entry points for OABI from the common table, or redirect
them like

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd=
.h
index 9fb00973c608..1ff4b6579ba1 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -33,6 +33,15 @@
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_SOCKETCALL
+
+/* allow using compat column from shared syscall table */
+#define compat_sys_pselect6_time64 sys_pselect6_time64
+#define compat_sys_ppoll_time64 sys_ppoll_time64
+#define compat_sys_io_pgetevents_time64 sys_io_pgetevents_time64
+#define compat_sys_recvmmsg_time64 sys_recvmmsg_time64
+#define compat_sys_rt_sigtimedwait_time64 sys_rt_sigtimedwait_time64
+#define compat_sys_epoll_pwait2 sys_epoll_pwait2
+
 #endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK

This would be the least invasive here, but also the least intuitive.

        Arnd
