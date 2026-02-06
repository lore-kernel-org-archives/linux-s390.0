Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADB279DC0
	for <linux-s390@vger.kernel.org>; Fri,  6 Feb 2026 06:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359471; cv=pass; b=Ct6QZMNA+ZPSoa+xn9KzRcTasqrg3P5qcnvXwn2uJXmDVneHH0W9aiVUIUVnrlUHYQf1uzVCcuDJ28Anfw6BW7DeP1pxUdwl0E5AH/wT17Sa96UgZWd9w9anWUFqpDQ54s+mOGOQQBio51NZbAyhp155IJTmYBUBXfFNOT379kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359471; c=relaxed/simple;
	bh=EIIKhyUooX3r/PdbexoCYcF38HhO9Z8ryf5x/gXXUYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7MCDUS2kJd0FWgr5NWNacSs9e+iivf7BiVQVjXjlKymXMuD6Z4BR+jImqWuwYd2L7WqJLaVTgUaQZugorujfyyzsRjUhRcKCQPwP27Ux4gmBK4xl8w+hPjhtqk3rniDmUlxvHO/WNU/nzwLHXaGJU+7Ii97S/o0r4Xpjrc4hCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRndPdT/; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRndPdT/"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-385cfc572f1so18051191fa.3
        for <linux-s390@vger.kernel.org>; Thu, 05 Feb 2026 22:31:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770359469; cv=none;
        d=google.com; s=arc-20240605;
        b=jTewxa6HsmWctTLstB80SKZmrwbgce8UgfGQlpczJagf5iXq90x8I4+v/8jPyLUicJ
         b1QypQ0HSY8KD22462vqH+WFZi+0ziTz3ZwmKPr4OF4HsWuEKUIjtBGrde3+VXyWvU98
         d7eZ0HoXOzUtSB+CPYEgQ9VKxQuctVNrJq3kyrUJR4tflDkfBa+f/USKKHdcPk3lISwm
         ChDZXbvi8E2o52pgCcV9oAihUibUcGeK5VsVPVwLNEz2FXegxAidFAl4VdhQH418Uh9g
         QgE4wtKst5IhNgj6sCtTxBGlTt81i4qiT1idRhqjugkj3NrtOIGtQI//O+JhrbU8qMDv
         WATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        fh=9WlOZXV5nTAta5afaEby8ukBjK2dpd3pSXgBys1RvvA=;
        b=K4lstiqdWg8M4Be4JGQOa/BqiP/mlsbKpxTp5oem9UMhFO3SOjGsVFGjCaJ5LAZE29
         L87olVcoq6Q126KWd/u0sFAJVZl0oqLicREsfYGxvEP1z4ezmaohexqdwpl0GolaumHk
         m7W/O2bOA5ayyJIzNbNfL4mUYJnjFufCeO33KWMoDKtWf/QoaJrFqXdgqcsLmbxD++lx
         Fu+uMakdt6LShPFc5LF8YxNcaHZKjfgLaMdwgyIrx7ZW5Xr1I5cubFsZTaYO67eh6R1p
         bEb7a5jq9fUKcCfZ9nzc6rmisD+kBUXnYrCmOwLd/PYsoW9wMpu47nwEULNErWb4OmRx
         /xVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770359469; x=1770964269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        b=HRndPdT/yY6VRrBN5PXD3P4wuaqssnUl87jc9dQt3iGhs0FpRHEt6h4Ty+QL/77Qzm
         IMkAUJRIVwCFJpjmE49NT6/QPuLdLhN3WB+hR0k5fN1RJrOUxWN0Yp2iqCV+LquRSw37
         k9uXig1ZRFdekOnLZUNMfn2A9EcJCvkvcK7pJ12cFiW4VbDtdWWvK92aZTuv3IPrIlId
         b5HcY3Z1onQUPMnF+VWYomzl0ZoHrigJA58TJVutBhZL9+dVhZHB4nH18r4309g0U1V8
         naEqxZqNMjnb0uQJKYUu93FT7pulyywUY7wOieWFjaINgq4MNXxuhcx+sthOCZDVmLH4
         34rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770359469; x=1770964269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7YKNjA07d2mDbxaHmncYluZfOIRQwuYJydAZEyrOgc=;
        b=gdoXQkFtZrdFPeE5Tbc2J5E4M1zRlAdLi/rOL5d5J4K8zsyoDB7uXwkJMn/ND5XyG9
         ESjBH5YYGChe7dMQpVXSNhXM/cf8js3zKM1s+UNCQtJGuRTC9mAK0mFUgdza3utVaJss
         bpio3IULyoexL2ot9OaQJMhRasIFDXAP1enZ0HYIQg6gqNGZ+INBeUfOxuhZTuxugylu
         a8o8mpNa9uHLnBI/zByXWq2LY7PX6tzMcEyaPzeReCGiS3aVFrwTXea6jTpPmfAFizhQ
         HdqnTmtWuPEbyIcsNl31WuyggctGaLORkPpw3pj0DjymCDoHd7ijfgcCIrnyyb1mXWdD
         SBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtqVfval55cAP0RcDg5sWdgQA4CeMH2VsYlmLKYX/V1WUrgw+kJ7jFOcygNzS6+MbgcbpENMFN8F/z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++xtZBuzd7PpkS753BmDB3LCIHEj8cvUv1IXvBPvJeMSf4M/e
	yuHethPOn59tkSHW1/7ittRymnNaoO97VXyInLPHAVLjxs0pjgBDIUa3Gxn/KZ71/la7aSAqCva
	//FtwXRapEdqil1sCNkBZlnnhiVU9rox/rD/GZQ2Z
X-Gm-Gg: AZuq6aLjd3WfFTI9zZRQtPFNZCJgKcwDX5pDAUmTuevyawaHxSUuyGLQT5qGmo3rC70
	Isp6SIPnP38YZK8z4e/7tXyGgtvFxSojNijDViVbTmRpjj/IhE/AQXHxgTzqvqC/dFSVDFlNUEj
	QVRw29nSSUvMTr887yRiqBU4HttezsyBMCFHacYDEbMB/WqGPvEljziF4fVZBNNLK9x6sVGpem9
	CmSSOY2vKShp/428qxSIBCBHtjT5qXiWb9atKu2tJ25OTCtP3DSVZp3sq19PL1F/weHVUYWGe89
	c836rCyu5SK4BdYCnvWpRWi9iAap
X-Received: by 2002:a2e:a54e:0:b0:385:c10f:122 with SMTP id
 38308e7fff4ca-386b4ecab71mr6195491fa.3.1770359468625; Thu, 05 Feb 2026
 22:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69858738.050a0220.3b3015.002e.GAE@google.com>
In-Reply-To: <69858738.050a0220.3b3015.002e.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Feb 2026 07:30:57 +0100
X-Gm-Features: AZwV_QigtRwHzRcz_qBwbEDZvHBUNHfkbq78REtw9jaCSitdZoy6tbcP7YfM-7s
Message-ID: <CACT4Y+ZQh5AQo7UuAKUNdJWZMBjKi9VA8aNFnT21sq=3yyeGjg@mail.gmail.com>
Subject: Re: [syzbot] [smc?] KCSAN: data-race in smc_switch_to_fallback /
 sock_poll (2)
To: syzbot <syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com>
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 07:16, syzbot
<syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5fd0a1df5d05 Merge tag 'v6.19rc8-smb3-client-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1070aa5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
> dashboard link: https://syzkaller.appspot.com/bug?extid=198c20fde37cb9f6b0ac
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a09cd69509c3/disk-5fd0a1df.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f218ec1eb157/vmlinux-5fd0a1df.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8549229eee91/bzImage-5fd0a1df.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in smc_switch_to_fallback / sock_poll
>
> write to 0xffff888127398c18 of 8 bytes by task 14369 on cpu 1:
>  smc_switch_to_fallback+0x4ea/0x7e0 net/smc/af_smc.c:933
>  smc_sendmsg+0xce/0x2f0 net/smc/af_smc.c:2797
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  ____sys_sendmsg+0x5af/0x600 net/socket.c:2592
>  ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
>  __sys_sendmsg net/socket.c:2678 [inline]
>  __do_sys_sendmsg net/socket.c:2683 [inline]
>  __se_sys_sendmsg net/socket.c:2681 [inline]
>  __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
>  x64_sys_call+0x17ba/0x3000 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888127398c18 of 8 bytes by task 14367 on cpu 0:
>  sock_poll+0x27/0x240 net/socket.c:1427
>  vfs_poll include/linux/poll.h:82 [inline]
>  __io_arm_poll_handler+0x1ee/0xb80 io_uring/poll.c:581
>  io_poll_add+0x69/0xf0 io_uring/poll.c:899
>  __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
>  io_issue_sqe+0x20b/0xc20 io_uring/io_uring.c:1816
>  io_queue_sqe io_uring/io_uring.c:2043 [inline]
>  io_submit_sqe io_uring/io_uring.c:2321 [inline]
>  io_submit_sqes+0x78a/0x11b0 io_uring/io_uring.c:2435
>  __do_sys_io_uring_enter io_uring/io_uring.c:3285 [inline]
>  __se_sys_io_uring_enter+0x1bf/0x1c70 io_uring/io_uring.c:3224
>  __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3224
>  x64_sys_call+0x27e4/0x3000 arch/x86/include/generated/asm/syscalls_64.h:427
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff88811a6056c0 -> 0xffff88811a606080
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 14367 Comm: syz.8.3658 Not tainted syzkaller #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> ==================================================================

Here is what LLM said re harmfull-ness of this data race.
It does not look totally bogus to me. At least the read of
file->private_data in sock_poll() needs to be done with READ_ONCE to
avoid the harmful scenario. I don't know if changing the fundamental
socket function because of this it's the best solution, though.

========

The data race occurs on the `file->private_data` field of a socket
file descriptor. This field is being updated in
`smc_switch_to_fallback()` (to point to the underlying TCP/CLC socket
instead of the SMC socket) while concurrently being read in
`sock_poll()`.

### Analysis of the Race

1.  **Nature of the Access**: `smc_switch_to_fallback()` is performing
a plain write to `file->private_data`, and `sock_poll()` is performing
a plain read. There is no mutual exclusion (like a lock) or memory
barrier protecting this transition.
2.  **Type Confusion Risk**: In `sock_poll()`, the code first reads
`file->private_data` into a local variable `sock`, then reads
`sock->ops`, and finally calls `ops->poll(file, sock, wait)`. If the
compiler reloads `sock` from `file->private_data` between these steps
(which is permitted under the C memory model for non-volatile
accesses), it could fetch the `ops` from the SMC socket but then call
that `ops->poll` function (i.e., `smc_poll`) passing the TCP socket as
the `sock` argument.
3.  **Consequences of Type Confusion**: `smc_poll()` casts the `struct
socket *sock` to a `struct smc_sock *`. A TCP socket (`struct
tcp_sock`) is not compatible with `struct smc_sock`. Accessing
SMC-specific fields (like `smc->use_fallback` or `smc->conn`) on a TCP
socket object would result in reading random memory, leading to
undefined behavior, logic errors, or a kernel crash.
4.  **Inconsistent State**: Even if the compiler does not reload the
pointer, the race between setting `smc->use_fallback = true` and
updating `file->private_data` means that `sock_poll()` might see an
inconsistent state where it enters `smc_poll()` but the fallback is
already partially complete, potentially accessing uninitialized or
transitioning connection state.
5.  **Violation of Invariants**: In the Linux kernel,
`file->private_data` for a socket is generally expected to be constant
for the lifetime of the `file` object. SMC's "fallback" mechanism
violates this invariant. While the mechanism is intended to be a
performance optimization, doing so without proper synchronization
(like `READ_ONCE`/`WRITE_ONCE` or a lock) makes it unsafe.

### Conclusion
This data race is **harmful** because it can lead to type confusion
and memory corruption. It is not a simple statistics counter or a
benign flag race; it involves the fundamental identity of the socket
object being operated on.

The fix for this would typically involve using `READ_ONCE` and
`WRITE_ONCE` to prevent compiler reloads and ensure atomicity, or
better yet, avoiding the mid-flight change of `file->private_data`
altogether.
