Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0C199385;
	Thu, 28 Nov 2024 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794332; cv=none; b=Qb/UUKGbZz+BmvoPKOUw5gtK+44VMmKhhbaSPpcpVB9dAVk69H2e1o+bAzgc2ImZY10Q30g7nn7JCFnJFkeOfxlZ6X1I9e+1vnt9HgxwRc0GxJSqJpcnlCDQMPlNKFq3ReFFR9gLLcGqHAOAx+OATrGUMDbFhEdd9y042zWBF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794332; c=relaxed/simple;
	bh=UbFqEHszhOJc/zW99AyYdYtb9W7H15irjg6dg+DLI9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKU2dZHhyHPh2btjvGSqLjouipQmx5TvKUAAlSWI3N99a4tKxfnIFJjYbRAGFs+pF0e3mggTY38fEEoWspnOvKiLiXrNOLDhUpGnDMWhw392cxrA9fRATDEjO5nInD0a0xcu7r3hMLjJFqnmHXVTBmI8dugOk035xmiad49hJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3CnLGrC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3CnLGrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AD0C4CECE;
	Thu, 28 Nov 2024 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732794332;
	bh=UbFqEHszhOJc/zW99AyYdYtb9W7H15irjg6dg+DLI9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3CnLGrCdAlpH/XW/GJUghKkohbwV9u4m9DtavnRfHf+DEDCQ1lv8MX/QDgnwMu9J
	 YKVoxdfV2K+8CcXcv+GIPXfF6KkbvTCnxSyca235ywDfsBvYNNEWlRcg41bAbpwo6v
	 wyQEttMOc4r+K4o7UblZIiMu0IknE7mkjJap0/YQ=
Date: Thu, 28 Nov 2024 12:45:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5rGf5LiW5piK?= <sh.jiang@zju.edu.cn>
Cc: security@kernel.org, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: [bug report] smc: possible deadlock in smc_switch_to_fallback
Message-ID: <2024112820-vehicular-unsocial-ccdf@gregkh>
References: <4224f194.3c7a6.193720afd34.Coremail.sh.jiang@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4224f194.3c7a6.193720afd34.Coremail.sh.jiang@zju.edu.cn>

On Thu, Nov 28, 2024 at 05:12:23PM +0800, 江世昊 wrote:
> Hi developers:
> 
> We may found a bug in smc module which can lead to deadlock recently.
> 
> HEAD commit: 819837584309 6.12.0-rc5
> git tree: upstream
> kernel config: https://drive.google.com/file/d/1-9pltE-1CMgGgNFu9o5l0BlCHk3Rnzb_/view?usp=sharing
> console output: https://drive.google.com/file/d/1uH0RDdftVIq_Boa6YWowLj3WujqVBuL7/view?usp=sharing
> syz repro: https://drive.google.com/file/d/1WUjiYSMebSZ7fR0uxrGx-kDLrf1v_Nra/view?usp=sharing
> C reproducer: https://drive.google.com/file/d/1_lB5_uacVnfDNE8VpuiY-NxEtDdzJ0Z8/view?usp=sharing
> 
> Environment:
> Ubuntu 22.04 on Linux 5.15
> QEMU emulator version 6.2.0
> qemu-system-x86_64 \
> -m 2G \
> -smp 2 \
> -kernel /home/wd/bzImage \
> -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> -drive file=/home/wd/bullseye.img,format=raw \
> -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> -net nic,model=e1000 \
> -enable-kvm \
> -nographic \
> -pidfile vm.pid \
> 2>&1 | tee vm.log
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Shihao Jiang<sh.jiang@zju.edu.cn>
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc5 #1 Tainted: G        W         
> ------------------------------------------------------
> syz-executor351/9413 is trying to acquire lock:
> ffff88804bd68aa8 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:902
> 
> but task is already holding lock:
> ffff88804bd68258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1611 [inline]
> ffff88804bd68258 (sk_lock-AF_INET6){+.+.}-{0:0}, at: smc_setsockopt+0x323/0xc10 net/smc/af_smc.c:3077
> 
> which lock already depends on the new lock.

Please submit a fix for this issue as you have a test-case for it.  It's
just a "normal" lockdep warning, not a "security" issue.

thanks,

greg k-h
