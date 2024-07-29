Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D476214D
	for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236453; cv=none; b=YHto/CwHB/UtIkebm+x5/0Wmx4xnLX0Ze39fOme09H8RAbKbvQmrUNYoHlVrgZTaJDPwKLo+YN/dys/Y2t1FCzEMTy+Dtt5ouDRaXnOnMNz+kRQurxuxno3t/VgVgHdpE8wNawUQGbjVWwxLHotitHYhxXVtMvXr53dwW+AYzqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236453; c=relaxed/simple;
	bh=QC2zEFhg/lyU6R8nhPbQFI4czkLYimOe833OUC3aBR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXWQ4iR1BoF/hAdbzsbVAvkOAz4idnLOmqyu2QLbH0n7pYN65MwBmOBO4+C3SgtLgdAPooDcLbCRwf78aYmyXH3UOEOwKmqnqWFKBmxaGuMstOSw7hQ3jwKW+jdzHiQlL8atxxeFnKe7K16vYDRkxtRCUXqE/n3sB1Iro2YQPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SNZx4Ay; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SNZx4Ay"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc9834deso41425e9.0
        for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2024 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722236449; x=1722841249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyT10splMgtMw/AFP/gfQzuxNIy03OHVny+AJXPnBKs=;
        b=3SNZx4AytHU2UXj0sZd1RneFp7fMYKJAbDg0nncFpMhokgCPZxqezQBUC567B5I14T
         oZb15w1WI1wljq+x3xqxp3tI6CksW4mhPXWSR6OETSZSa7H6LeeUCzx+N5FJC5jH+nHt
         7Ia8C+EE3A84mFcMzlYJV6ziC9zsPLW0oti17EqsNNWqZRUCuhB5gcD/8CYQla5D4bOn
         IDE9MyT90ErvuxdDDgS+VxB5W6/IRKgiWPKUC6WLwPsJgfFX2gFSS004lQAikjNBfm3c
         XXhgWnsv0eCPK0vkBVYqV6C93t+W1MOX2TWSnv0qmijwVWBgAdLqrM0/jIGVJmVj+rdz
         arOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722236449; x=1722841249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyT10splMgtMw/AFP/gfQzuxNIy03OHVny+AJXPnBKs=;
        b=qIhRTPZCfzrpG8/wRGizkOAUVqFclKQwYKMDVT+fjL0fCXhEXDElVPxNrPb6wR2Op0
         LW4d9pWvK2cIK+2Oi8P0U96prxUOzxwExeifxL6oKW4MsBCURSjBd0oOISQNrkpTe2QB
         UXf3QvMsoehchTnvsnQ0S3FAtINdhDzO5W34feFSfnRkj84OuDIMp3BGDUexb+vwaLu1
         qv6HVGgUsUH3bry4cpthl1B+hg5AMmqFYFBiUGJnD79bHrAE+TWnV2lN8OB6A/sNmiBg
         0i0lloSSlosbsjCV5CnNPd1MiL7b1bczBP4iwgJ6rB4zLRCxoYVb8cuxofyWLObxSIJt
         eWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIoYLLQHdgX5pD2Ir7CP6AT9zITALV1jkqcsHNSpuInpV38qWlK+/H7XoAhj01EHDiuYDFjL4dlZhfetfeG2IpaGRMoCd7yRP/0Q==
X-Gm-Message-State: AOJu0Yydqq1YlGte1sj4Rn4DO/UliuDxDR1QtX8z4rw5hWqiUBWFBS/W
	rJEcGg+XrKmmftJ4IVq9rvAqwyXIFGcd6OdyHUO+n7bCdJJYHCh6mznGz3cCoOGHlN753b+5UFT
	ZLKwU9kKcA/OltUdUDaSTudB2mkYesEVvR1A/
X-Google-Smtp-Source: AGHT+IHvsSzJz9EtBDktbI85ocx6MHTolOoKpJRvV8XQ287h4mh4kZ99zdHYDANoZv/yOMcrJWWuHK8UYNNGMaDsEy8=
X-Received: by 2002:a05:600c:3542:b0:426:66fd:5fac with SMTP id
 5b1f17b1804b1-4280b0f0565mr4648255e9.2.1722236448699; Mon, 29 Jul 2024
 00:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1722224415-30999-1-git-send-email-alibuda@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 09:00:37 +0200
Message-ID: <CANn89iLrazeVmu+vN8o8+kPoY0+Yf032G_J7GcfufUTRhyng2Q@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: prevent UAF in inet_create()
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:40=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> Following syzbot repro crashes the kernel:
>
> socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)
>
> Fix this by not calling sk_common_release() from smc_create_clcsk().
>
> Stack trace:
> socket: no more sockets
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
>  WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28
> refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Modules linked in:
> CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted
> 6.10.0-syzkaller-04483-g0be9ae5486cd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 06/27/2024
>  RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6
> 05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90
> 90 e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
> RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
> RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
> R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
> R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
> FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  inet_create+0xbaf/0xe70
>   __sock_create+0x490/0x920 net/socket.c:1571
>   sock_create net/socket.c:1622 [inline]
>   __sys_socketpair+0x2ca/0x720 net/socket.c:1769
>   __do_sys_socketpair net/socket.c:1822 [inline]
>   __se_sys_socketpair net/socket.c:1819 [inline]
>   __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbcb9259669
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
> RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
> RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
> R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
> Link: https://lore.kernel.org/r/20240723175809.537291-1-edumazet@google.c=
om/
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
