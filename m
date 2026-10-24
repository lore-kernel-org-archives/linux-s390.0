Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861562;
	b=IWLI+DAAGyDaEdS6honyNK3/m3plZbDimiyzkg4ahCnIklW5yez7fdeT/9vnK/ARXDMn
	 lMHCYgi5Bmo4QeCQy6AFsUEyLu+VjBcpUCILtjs0JbIblLhIXLzjmLR3QNqmd4SoVxB0g
	 0uiRMq26dpxHqYkVPcS+CNmNLxVIgIDAcpxWNFR36YVFx87/J4wRHWmVRft3nlpMHhQcn
	 +yRhMhyhBr4Y/9yvzDA9BOkYABc22qS3ncwXuc8BDA3hQtw6UD+fwLPbsw/Sfbb4wmH6j
	 M5dE9FdbTMAjTPfzs1ETh5OMAO9lnBg/ZhQRZ6W/0r2Y/sFn5iVmEdoem4VtBHNcAIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861562;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ejcHXbbMJpCzIhflciAk29KX5ss42MtWupq3XSWtgN0=;
	b=Zw2ITwdiLOzTeKmVKslUG535F82kudl5I/L+FOd3te1C+7Lg7LXVY2SYG4Nx35rB3VPY
	 869HBIPon99xAiK3B6qBylqSRBoMX8POzan5B+WmQr6wnXbj87KWRvll8m0o7j1li2CU0
	 MkWxW6/mIdFS6IZ4/jUNE2b4FmiWpf1c3eqY+ushvoC5hIuMchyzyfgvleXLzj+WqO0Gk
	 PLhpnwKkRNhxlV+lqI/jTOAJNeP+S5le4D8HTFTm06T31nurv+ff20X+e43w4sVJgZjpm
	 jq801jLgu4deyXW1ykN+SoFrWp56Or6oGju9UNmIGHyezLhqnzejTiXFFZ06knNXlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=F8syek8F;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0706606A31A;
	Sat, 24 Oct 2026 17:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0706606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=F8syek8F
Received: from cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id CD1DE1C006E;
	Sat, 24 Oct 2026 19:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792861557;
	bh=ZNWhMp3SkHo6YJhNGOOEGIApQhV+Rkfdv5zH7iaEACA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8syek8FAyg2mpNsahUjsU2e4w0/y1pXgpffdoHwil2Ufr6PQNhTG6hvlZNky+nfC
	 ONuMffhuWP3gfrUWLj+/Zs4GuGLfj7sNxBOUdTPaGEUh/yuUkWOWNNmhdy/D6OnG5O
	 Vm3yiOpbLLvjQ5UvOB/hIZJe0IHV/0a1NfZobC1M=
Date: Sat, 24 Oct 2026 19:05:55 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v9 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <atzlc9tg2MTdnRtj@cs.unibo.it>
References: <20261020152945.575664-1-renzo@cs.unibo.it>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020152945.575664-1-renzo@cs.unibo.it>

On Tue, Oct 20, 2026 at 05:29:40PM +0200, Renzo Davoli wrote:
> prerequisite-patch-id: abdd0fc0973bc3845ae7bfe84d855a7213ccd3d7

This prerequisite-patch-id is no longer valid.

The prerequisite patch "powerpc/syscall: Return the preset value of
skipped syscalls" is now at v2:
https://lore.kernel.org/lkml/20261023180735.853655-1-renzo@cs.unibo.it/

Its new patch-id is 3d8d8f9a79821bdeb7e155201b85417e9137256d.
This series still applies and builds on top of it, so no new
version is needed.

Best regards
  renzo
