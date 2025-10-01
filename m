Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC73C2F;
	Wed,  1 Oct 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759358692; cv=none; b=a05jbbknxROzEBDLMS/+hasUldj2Pnc9/5ynYXR7z6mQCbMjZW930STYmeI1+tiUWWxHgEJNJR4J479l3bISKBlrHOLBGteJ12EWogkbgXuSzq4wrKYcaGq7XKQAcfFLSNGertlGRdIcJ/liD772cJOTl9dhtN4hiO8iY7Gd+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759358692; c=relaxed/simple;
	bh=s5kjNf2wXFmoDUpOn0w2FymRtMeZUwY78l6Vhxz6nvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC+r4ex+zcxZipmorpj4rPRlJj5sOsDY6LUjRmhb00wuyuU2xVF1VmyAlNkHwIvG7fI+4vFGOHp4h7AFCrVV56YaIN6eD6ukn69NTZhoP+a+6hfze/lOwZwNgaNiIQgNg+4aMI83/CthPVGm9vtKnaBHTIsDtlwcosMLMWIeL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hpg8aH5z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hpg8aH5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1759358681;
	bh=s5kjNf2wXFmoDUpOn0w2FymRtMeZUwY78l6Vhxz6nvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpg8aH5zr968WgFC8Z9LLYSBJmW7FW7bz22DBY4xVS8gV5YTsM71M8r0TeSq8DnFa
	 TcrvkLL9O4YyKdgpo0xqBvTVhsU4Z8MojgHJsBoxZ6nl7j7a+k1oxwgyWwYdDineX8
	 bqLeT/62/tH5h4SIaB7S6nhSJXgDug9brf0IkCZ8=
Date: Thu, 2 Oct 2025 00:44:41 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.17-rc3
Message-ID: <ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de>
References: <20250822123608.142112A72-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822123608.142112A72-agordeev@linux.ibm.com>

Hi Alexander, Vasily and Heiko,

On 2025-08-22 14:36:08+0200, Alexander Gordeev wrote:
> please pull s390 fixes for 6.17-rc3.

(...)

>       s390/configs: Set HZ=1000

With this commit the nolibc testsuite for 32bit on QEMU 10.1.0 starts to
reliably crash. 64bit is fine. Actually I encountered the same problem
before this change, but it happened much less frequently.
Output below for a testrun that never got to print anything to stdout,
but the crashes can also happen later or sometimes not at all.

[    2.118473] Run /init as init process
[    2.142148] User process fault: interruption code 0006 ilc:0
[    2.142626] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2-00002-gfcc43a7e294f #24 NONE
[    2.142739] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    2.142822] User PSW : 0705200080000000 00000000804087b2
[    2.142911]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:1
[    2.142979] User GPRS: 0000000000000000 000000000040c060 ffffffffffffffff 0000000000000002
[    2.143022]            0000000000000800 00000000000007ff 0000000000000000 0000000000000000
[    2.143061]            0000000000000000 000003ff00000001 000000000040c000 000000007ff720ac
[    2.143106]            000000007ff720a4 0000000000409540 00000000804087b2 000000007ff71ec0
[    2.143406] User Code: Bad PSW.
[    2.143454] Last Breaking-Event-Address:
[    2.143483]  [<0000000000000001>]
[    2.144705] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
[    2.144875] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc2-00002-gfcc43a7e294f #24 NONE
[    2.144922] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    2.144989] Call Trace:
[    2.145292]  [<000003fffe657cf4>] vpanic+0x1dc/0x2f0
[    2.145535]  [<000003fffe657e4e>] panic+0x46/0x48
[    2.145586]  [<000003fffe65e4e2>] do_exit+0x3da/0x520
[    2.145634]  [<000003fffe65e820>] do_group_exit+0x40/0xb8
[    2.145683]  [<000003fffe66fc98>] copy_siginfo_to_user+0x0/0x60
[    2.145735]  [<000003fffe60614e>] arch_do_signal_or_restart+0x66/0x2b0
[    2.145787]  [<000003ffff42e2bc>] irqentry_exit_to_user_mode+0x174/0x1f8
[    2.145902]  [<000003ffff439d5c>] pgm_check_handler+0x114/0x160

You can run the testuite for yourself:
(run-tests.sh will download a cross toolchain)

$ cd tools/testing/selftests/nolibc
$ ./run-tests.sh -p s390
(Expected output, lower numbers mean failures)
s390:          228 test(s): 227 passed,   1 skipped,   0 failed => status: warning

The full test output will be in run.out.

This doesn't feel like an issue in nolibc to me.
Any ideas?


Thomas
