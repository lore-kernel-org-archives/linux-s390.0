Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007235;
	b=CDvqLwSdj+NVmeitABm4Dgt0jYUtS/a2y2Ffhv/JMILnPQDz9i+2ysoDV3Dmg3d8HjZ0
	 qtbBj2L71kHneRMjqyWDjhvn1T4hpgIa2L19Y4s8LriBuMrJok2EDOMEoM6NmQBGE/qHT
	 gMAnO1FhI8nRSLiYfy18thkKh8nSAMhLifZn7cb9dT42eAy8hjhUAqIcFeyXvjL5v/Kmu
	 vaXsiWBrz73kzLRweHjtVLx2tgxO7ODROofMTg4SCdKYLKv1qufB6Uq7wcWn2PU6QYOG2
	 vkHfPa4izM3FL/uttRS2bG3iClOBF5Cy2gtKNVkTMcTSbFAIvLGY+G/tt6PWCNrBHnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007235;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wcQud4TjvAnhIm8lhxRx5VZLJFGXhPtPHhfm5f/gKq0=;
	b=zfV8dRqQ6scBMVvCMpldzhEuK10r9I102YfA2AUqwPmZTjehkm4Fmc7jb+dlNhZfUAcS
	 PJr49FqQZ5JajIB+oflxwpP2kDCggeXjZPQDEy63lc8vBxbdcIVpO9Mnhjl6XrPtAkX1M
	 k2/6EWb438ttwesFao0QcAbpR4wsBy5sVsuNaI2UOHwuj/3IIapTu/LZs0MAoy4vSLCTE
	 OK+Y3FTy4BuAehKyPB9IrdTuUJNWYGEhB2GXzVz0/xYzObdEUyaFeh+jjPo4DOTgu605n
	 fyS87cs7TR/hvIi+7wHJSMcSOLG+MBpoaXB6qaDRh2qUgwrMFZFRV7Kf8j1M8ej2S7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b="jaJ/iyiX";
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D76606A320;
	Wed, 18 Nov 2026 13:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D76606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=jaJ/iyiX
Received: from cs.unibo.it (renzopb-wl.cs.unibo.it [130.136.2.252])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id 184BA1C024A;
	Wed, 18 Nov 2026 14:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1795007224;
	bh=lb0XMELlXwhZyPpxWvURW3p1in9nS5q+dLi6aSu9rQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaJ/iyiXBY+Y4jYCYhlt5rkdRaZ0t6Gbdrnf33D7e7U//d7upt8gr4XSiHgoPzEyH
	 lakYksP8Sjnn6WqSVmC/d7K7jvdcpKTjwjF8IHU0huSQ0Ip+FazYU7PtmTQPNM8f+G
	 T8BxdetVC4nyBkGpt04dMXXUfbCznRdfgozDpKBk=
Date: Wed, 18 Nov 2026 14:07:02 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
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
Subject: Re: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <av2i9kbZyMRJE9D6@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av2PKIf8YsEPro8O@kunlun.suse.cz>

On Wed, Nov 18, 2026 at 12:42:32PM +0100, Michal Suchánek wrote:
> from a user point of view it is not clear to me why this would be done
> at the seccomp event when seccomp is not used.
 
Hi Michal,
 
thank you for the review.
 
You are right, and the cover letter does not explain it (only patch 2
does, briefly). The series is limited to the PTRACE_EVENT_SECCOMP stop
because that is the only stop where a syscall can currently be skipped
with a preset return value in an architecture independent way: the
tracer's request goes through the same path as SECCOMP_RET_ERRNO,
which every architecture already handles.

At the syscall entry stop this depends on the architecture's entry
code. On some architectures (e.g. MIPS) the entry path overwrites the
return value with -ENOSYS when the syscall is skipped, so the value set
by the tracer is lost. A tracer that does not otherwise use seccomp
has to install a SECCOMP_RET_TRACE filter to use this feature.

> On s390 the removal of such architecture-specific flag is proposed here:
> [...]
> While that shows a way to address this problem not all affected
> architectures implement it.

Thanks for the pointer. With 05c033db7e9a ("entry, treewide: Make
syscall_enter_from_user_mode[_work]() indicate syscall execution") and
Heiko's s390 fix, the architectures using the generic entry code
preset -ENOSYS and leave the return value alone when the syscall is
skipped, so skipping at the entry stop could be supported there. As
in patch 1, a per-task flag checked right after the ptrace entry
report could be used, so that it does not depend on the syscall
number.
 
This series stays limited to the seccomp stop, which works on all
architectures; support for the entry stop on the generic entry
architectures can follow as a separate series. If a new version is
needed, I will also explain the restriction in the cover letter.

Thanks,
renzo
