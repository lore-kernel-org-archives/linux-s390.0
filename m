Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3D344D95
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268804; cv=pass; b=NzmCXMDX6nz/RWreazdvdazwvVFSbon/dKt3GZRE/l6H0EJW9Jth80WcqUbXkGQAKQeBqh8GX+YYQbuyP0h+C0TTnIIkwIUtXor0i1vRr18jzsyWj7jPwh9jeHd2bO/58/4FIefU5Oadxt3oyLbIrm1ttZ5PfwuTTcqLKKElhvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268804; c=relaxed/simple;
	bh=KOz2CthW9DZTi9DtDOS4s6UwKiyzP3Sh6aGujr/riF4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ipRl6JophdGQwdREHLXYJd/J7KKK/bZ3mYg8hYn95wcdQZUWU/I21XpZeMkIj5UkEHk7yu7D6Wkb3JdC3jzJb1ENJrjvXTxYjrmszdwlF2xD/fy1E5boAKz2g8q+2k1Xz8jFF9XnJCFwchHdC9BmluWYu/Kl5yRbYXXuraRgkkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boZEVMj8; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boZEVMj8"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bf0b47d2f1so21811877b3.3
        for <linux-s390@vger.kernel.org>; Fri, 08 May 2026 12:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778268801; cv=none;
        d=google.com; s=arc-20240605;
        b=CECQK7ePdh5moFqLjbGdxuVUapRXDQWJw8jMNqitAJDpWBb1e5sBiHKfUsp7Q8ms7h
         SNSnbzcAeG14qIx8M8+OZl4Hp4qcQstJlaR09lZuQeTXzFUbmBxKypLtWvnX2CcigA4/
         u+w/g2Il6RjLamn3s+6nOUbOKV7v8SHBMNGRLdQyQaqagOM9tiRYIZ+jMehuRF68Uge0
         +RRBqtCO6dHnVN0wFX7IPyhVbu31wPhy6YrLzHn3gcXZh/Oa0hPwqVv/I9Hs0dRfBP6/
         eovmIfouHAIShFdl2xMdaKX1IAulaaZ7I3jmwLbGf67MFaVC/ZqPfaMqMH2KRAIMlTCR
         dIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        fh=eYGltH7CNUnPJsy/xdIcRe+qXBrkJuiXI5seROeLxec=;
        b=CyZOBuZVWJ10IGscBra0sYF0KexBFL0F7icvW11L730hmvMxcLmwfc08jz/Xx3m5Y9
         gCccdpd5tlSs3E00I7hWOpbY7Unk9vB3zLITzLHu0UDXyMxIG6jdtGQiNT6eVuzHcWZ2
         eLc3XbxNz9cNdxkPBUzd15Yu33YfFjyLkjKXssGL6j6O4InPDEROzSj+yUyEqO/TXHS9
         gQ1YbAklri6hK/bAVV1Edj/oQ37zL/9H5FTvwV+KUN/b2ZMUhaIgNfN72IBARbU2c/ZH
         YxzpRCUv5MRRh/tE3QmpyLcdKSulvgshWsThS9qyKuvbwaRUHUrqXfeC4QjJq9eqOF7x
         F8MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778268801; x=1778873601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        b=boZEVMj8RhGvjAkdwEjwq5DtKyLdb9sXKJONA4I5PbKTihIXgsrRXpNDO8d5NtFw/5
         hlrNB7nLNpOzjtWGfzvMjznhLPmDGL2sRWh3gMOrWgWser5ZBcsI5vUJ0rBok96sFnSH
         AyShRTK0PZxIy5aKMQetKrJ23HQjckcDYNwtOkXbRt3nuBIPLh/U1TgEwZ10aMXTusK4
         YNr2sEBFvgLlNSXvACQCrA6OlSh8PaASTxrZSGA+2dsA7PDOqGba7h0qv/gDyHMJ/wA+
         kcvJ1ZA84TT0HTIihx8m9tcA6/7AboezqcaLjtmCiyubuBEYOCTszGtDeyBhkTDMjvuc
         ETYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268801; x=1778873601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WbqQFwC9sQ1kT2Ez9037TuxaYTirplDCZyYgdcthAE=;
        b=NvdzzpN/gbpeF7+kRha7kmy62w5cJAfkGXR4wOsNaROQec7z/S9JAteVM7xpmXjFMl
         ytqGosMEgVKl9GWbK48BJzkMME6c2RIQ+zfraIcDEccsYj7/N/ceAUy5MPzxctVHuAey
         Hvxkskwd42CrFd5WIIKgKUtU06R7viWEnUf98otoS16qjfd/6jy6R025EolvbYSoZfRd
         ku+Py+MBzj+cRnFdpgy3so4Nf76u30M31zyPvHw7LdIKAm8YOpPnX9U8e9ycDH9AN6tc
         dYIJAgFzCdEVthQRGtl+ayP8VuRQVIMX4DlA8vMEcsZTAXxoSKdj3rfmch297WUpTzrF
         P6TA==
X-Forwarded-Encrypted: i=1; AFNElJ84RF0DllxP3IcF+SGwyHMRpTFuZocMvE4ct/HhKAamsSj3hGiF/ZPdc+48xyAAMxYlCP2yQW6mf+Bb@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWMYl2x6lPwZo0m1GxfSDsqPPwr8AMhjvUPF2I+oVLBfOtnq/
	D5tKAmvRjoXC5O2kCduBDErKP2Q0qxMR13m6vY4BNQSQWjLNUKQjnSUxcDdT7yqMu1U7X8oOXcU
	ZTbYcmxCON+OcFkoOqJz+jFqH3GGRjZ0iMxupqdI=
X-Gm-Gg: Acq92OEoa6oZNCuBsFtQSrhXDbIvpyBgJXk4YUsuuZn4mRUeHultAZtAa7k/YngiZa8
	mhf1AsufKqXOv0agP45hxDsGxpRZZPDsr4EfZ6TpE9+Dr8sjpXIRD4kcxcD7039PImVfEDqGAIf
	ve8nVSUmxiru9NibHOGbwVNC0yPSHWYfCGmzL6XvuMxMqz9l4+3sSEBIuKqh0ZoLQQ8SYqff2gW
	K1YrlRHi0aprxRPwpPZF7342ibD8Wfyl3v9q7ywwQ6wJ0K4HvZ9jKh5aePGTqB8E6oxXubEKPAd
	R1EAtqQSR6QxPeIdb95MaHPWbH0C4JqyK8n8HWkTfc1MjZrB8C5lmosoQr85cw==
X-Received: by 2002:a05:690c:3482:b0:7ba:eefe:9f9c with SMTP id
 00721157ae682-7bfb93b91bfmr36362517b3.23.1778268801312; Fri, 08 May 2026
 12:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Coccia?= <n.coccia96@gmail.com>
Date: Fri, 8 May 2026 21:33:10 +0200
X-Gm-Features: AVHnY4IhlBncjhRtEcRWNeScfK7pKvEfB82Sn4DdDRYZUjuTlbimERLOeRjk1Nw
Message-ID: <CALSA8UaEKUHRqYaYqKFYbUQb4KHipDBDHfgMZHj2Tq0D1Ah7zw@mail.gmail.com>
Subject: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mjambigi@linux.ibm.com, 
	=?UTF-8?Q?Nicol=C3=B2_Coccia?= <nicolo.coccia@leonardo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Signed-off-by: Nicol=C3=B2 Coccia nicolo.coccia@leonardo.com>
---
 net/smc/af_smc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -XXXX,X +XXXX,X @@ static int __smc_setsockopt(struct socket *sock,
int level, int optname,

  smc =3D smc_sk(sk);

+ /* pre-fetch user data outside the lock */
+ if (optname =3D=3D SMC_LIMIT_HS) {
+ if (optlen < sizeof(int))
+ return -EINVAL;
+ if (copy_from_sockptr(&val, optval, sizeof(int)))
+ return -EFAULT;
+ }
+
  lock_sock(sk);
  switch (optname) {
  case SMC_LIMIT_HS:
- if (optlen < sizeof(int)) {
- rc =3D -EINVAL;
- break;
- }
- if (copy_from_sockptr(&val, optval, sizeof(int))) {
- rc =3D -EFAULT;
- break;
- }
-
  smc->limit_smc_hs =3D !!val;
  rc =3D 0;
  break;
