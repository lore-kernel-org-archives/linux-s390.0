Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0B1CABA;
	Tue, 13 Aug 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723522012; cv=none; b=U+wjHZeQ6MADCRXkQjAbFZRAc3GSDUm8GH6LbHtmLIF4LLkMI0aeHOZ5UeoykBwP7aiJVaIItaY1BGmUO43lGjHu+SwIN0aynOd88w7egzS7dQF7rhldfPwuAwUitdd80lkvuobpjfaSmYe+vz2uNf8b/VX4GSFsL6UbfvJNOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723522012; c=relaxed/simple;
	bh=roCIEbH2gg3+xLljjbam2KFELuB6WIlssj8o5JNoK+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD1kFTtIQtBnnYcip6SjFP0Lha4k48DYpTi8IA3d4y/NtexnW4mEyiB0lza57R2i7PbsURqGx/7Nd9aionW46ZPVgcVvnQ7/koyt02fPNPSHIaA99sxqSUStyz9cOHYstqDatJOsiiB8kWimqxrxsrfCIQI2k7QDVL2jdhzIo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLeDPZK5; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLeDPZK5"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1270da60so3938496b6e.2;
        Mon, 12 Aug 2024 21:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723522010; x=1724126810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roCIEbH2gg3+xLljjbam2KFELuB6WIlssj8o5JNoK+o=;
        b=LLeDPZK5kJlMJ3LUbMseyyCjciAuRknq1Y+jE/BbZfcbolHEgC8d98CdHLpNNaZsuH
         v5wdkzSW6jydhpKIIlHLXGWIsm9QU3t7HQ3zTB1RnKW9afDlbZjAeoSoJ6sd3l4oPNdf
         3UVvfFWYpMxXzephVidn4bAtOcJJQvz9AzDbreOSkTa5R/s0aqDqMdjN0RDZufHAtdCk
         pxIU44uoW4tK7JLSLh8FcZhG4tWj0LRlgHFcViO351or7HNJRu+XKy4M0TZhaz8JAmce
         XpCJGlbmMz3fmc4QKbAX4zKS2dgs3BnU8xybhVZf/gJCq0j1kARmL6n/ASsDiG1TmdwF
         HjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723522010; x=1724126810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roCIEbH2gg3+xLljjbam2KFELuB6WIlssj8o5JNoK+o=;
        b=sot3/2UQs8P5Un1RB0O4mh99CCDQjGKvfBxLxk5VOdkTq6NEULHfB6N5bFvQYKcQIg
         D06ak4XWBn5/sk2wh+zE+66QOJKlIEIZKyCGURbByGImiLwJsmc6fiG3qFudj06nYdSB
         14r32Lf1BRvJhypL619Y14v69eZ6t/50kGSs+3/LG8TPiamol4VRTtXk7kFHJ+e5EW0H
         G8Hn1Km41494LQfKGKKGvW+3jqTLMpx+2od6InYuGLZrFoKctKODp71mLmoVZIqcM/yG
         XLPYAlX5HPJ4+Hskvvg60yhytfB1kuOi2p2MMF7Njh3YJw7oRPflzaTImt2PrdCGQSWI
         B6fw==
X-Forwarded-Encrypted: i=1; AJvYcCWlm7TWi4rusSmm6iy8UrEya6vIdrN+6clZtFkCHr5pUi+2SgRbfUB/plEXhecAyLi88VOtt3t79iOY3X4Vl+QkzvVErXPk7/E3G0Qzpr/bKeNt/ieofe5MJPTH4/7gFgZN2hEMcw2AHorVHqdxBTigWk2QNhfrfVG59gEGTVe+KQ==
X-Gm-Message-State: AOJu0Yx9xmFcxNlfa6fC7oxSDdFsnxVpdA/FBr/piliMk754mkJP29mt
	ra+eDNL7kIPJ150oZvsmqJQHp/Oa323k2XhDUITT13N6TE4lvT3y
X-Google-Smtp-Source: AGHT+IH91Xu9KMJ5r/KHKbHXr1AGQ+WdR4LqNy4MduV4YAd5dGO45jJhMvli73ULT3Z6BNlCu3YieA==
X-Received: by 2002:a05:6871:5cf:b0:261:1f7d:cf6e with SMTP id 586e51a60fabf-26fcb891fc3mr2475842fac.41.1723522009786;
        Mon, 12 Aug 2024 21:06:49 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979d60a9sm471894a12.10.2024.08.12.21.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 21:06:49 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: aha310510@gmail.com
Cc: alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	jaka@linux.ibm.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	wenjia@linux.ibm.com,
	syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/smc: prevent NULL pointer dereference in txopt_get
Date: Tue, 13 Aug 2024 13:06:41 +0900
Message-Id: <20240813040641.163841-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810172259.621270-1-aha310510@gmail.com>
References: <20240810172259.621270-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit

Jeongjun Park wrote:
>
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
>
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this, we need to add a smc6_sock structure for ipv6_pinfo_offset
> initialization and modify the smc_sock structure.
>
> [  278.629552][T28696] ==================================================================
> [  278.631367][T28696] BUG: KASAN: null-ptr-deref in txopt_get+0x102/0x430
> [  278.632724][T28696] Read of size 4 at addr 0000000000000200 by task syz.0.2965/28696
> [  278.634802][T28696]
> [  278.635236][T28696] CPU: 0 UID: 0 PID: 28696 Comm: syz.0.2965 Not tainted 6.11.0-rc2 #3
> [  278.637458][T28696] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  278.639426][T28696] Call Trace:
> [  278.639833][T28696]  <TASK>
> [  278.640190][T28696]  dump_stack_lvl+0x116/0x1b0
> [  278.640844][T28696]  ? txopt_get+0x102/0x430
> [  278.641620][T28696]  kasan_report+0xbd/0xf0
> [  278.642440][T28696]  ? txopt_get+0x102/0x430
> [  278.643291][T28696]  kasan_check_range+0xf4/0x1a0
> [  278.644163][T28696]  txopt_get+0x102/0x430
> [  278.644940][T28696]  ? __pfx_txopt_get+0x10/0x10
> [  278.645877][T28696]  ? selinux_netlbl_socket_setsockopt+0x1d0/0x420
> [  278.646972][T28696]  calipso_sock_getattr+0xc6/0x3e0
> [  278.647630][T28696]  calipso_sock_getattr+0x4b/0x80
> [  278.648349][T28696]  netlbl_sock_getattr+0x63/0xc0
> [  278.649318][T28696]  selinux_netlbl_socket_setsockopt+0x1db/0x420
> [  278.650471][T28696]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
> [  278.652217][T28696]  ? find_held_lock+0x2d/0x120
> [  278.652231][T28696]  selinux_socket_setsockopt+0x66/0x90
> [  278.652247][T28696]  security_socket_setsockopt+0x57/0xb0
> [  278.652278][T28696]  do_sock_setsockopt+0xf2/0x480
> [  278.652289][T28696]  ? __pfx_do_sock_setsockopt+0x10/0x10
> [  278.652298][T28696]  ? __fget_files+0x24b/0x4a0
> [  278.652308][T28696]  ? __fget_light+0x177/0x210
> [  278.652316][T28696]  __sys_setsockopt+0x1a6/0x270
> [  278.652328][T28696]  ? __pfx___sys_setsockopt+0x10/0x10
> [  278.661787][T28696]  ? xfd_validate_state+0x5d/0x180
> [  278.662821][T28696]  __x64_sys_setsockopt+0xbd/0x160
> [  278.663719][T28696]  ? lockdep_hardirqs_on+0x7c/0x110
> [  278.664690][T28696]  do_syscall_64+0xcb/0x250
> [  278.665507][T28696]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  278.666618][T28696] RIP: 0033:0x7fe87ed9712d
> [  278.667236][T28696] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> [  278.670801][T28696] RSP: 002b:00007fe87faa4fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> [  278.671832][T28696] RAX: ffffffffffffffda RBX: 00007fe87ef35f80 RCX: 00007fe87ed9712d
> [  278.672806][T28696] RDX: 0000000000000036 RSI: 0000000000000029 RDI: 0000000000000003
> [  278.674263][T28696] RBP: 00007fe87ee1bd8a R08: 0000000000000018 R09: 0000000000000000
> [  278.675967][T28696] R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
> [  278.677953][T28696] R13: 000000000000000b R14: 00007fe87ef35f80 R15: 00007fe87fa85000
> [  278.679321][T28696]  </TASK>
> [  278.679917][T28696] ==================================================================
>

Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Tested-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com

I think the root cause of this syzbot report and the above bug report is the same.
