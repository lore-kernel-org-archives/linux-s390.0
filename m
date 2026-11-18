Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011090;
	b=yvGdOKrhoVXcd6TNNZ2SMaORcWixLPQOhkvmpx8KqLf47Nfzq7Rji18hgeEZWihpOkCd
	 oQOg4bP0j9LmcRVk4O3lAjw3ZzH03d3ZnagAm/C9zc8njoVmNQHo197antNVn9Ffdm6kU
	 vWwqilQKOFhlKlWt1jymMVcY3aooTS46Ax0NgR+fcXPj1pNZRW8ykj1fq0UEOTKvTLDw1
	 LcZdksNFpavrLAia5lxDw4VpT90RGcqyG5yqvLu7ot+pQMpUDF4He9IbjYoPPca3HJJS4
	 JlrLw7dhVB0L1TS7R3M/IDf+/E0JvewDJR0BnbZQjzSJeqLa1xJpyQtbR2z/POa6HJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011090;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=uppGZWqUpokKoo1jmO3Dq98VgoH2LDRH/n9DuWrt6hE=;
	b=dxDVqiFvH7QdD0b8/JGGc4jg6Ai8TjoGiHs+rCsIXSQkTal0yEA4na5R9gnJQ0XiI7QZ
	 qjvtxq1U4gntMId6BvSpqg+3VHgTjNSS42NVs1h1x/T5iFCs6wDD2ipXnxY+ePuYuEyaF
	 dvlX+2U1bVE7rkQdoHy49WIJ4KMsv52evZ/2VhvnTaMaq6PkXY6No0ecAdxbPTfj92Dcc
	 cA4rDpJs5FuDFIJsuaZOp+6ChLMUa0Q2omgwXtMKmVT17PRgw9BMo2RGIjm2JIU8V/NQZ
	 rHplpVEnhod5XtFFzKnkzT47/unFcVM+lwUikQyeqYDjVMfhRSACFATF87/yjiERslQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=G8JQznDc;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5A60A260A;
	Wed, 18 Nov 2026 14:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F5A60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=G8JQznDc
Received: from cs.unibo.it (renzopb-wl.cs.unibo.it [130.136.2.252])
	by mail.virtlab.unibo.it (Postfix) with ESMTPSA id A67461C024A;
	Wed, 18 Nov 2026 15:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1795011087;
	bh=uppGZWqUpokKoo1jmO3Dq98VgoH2LDRH/n9DuWrt6hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8JQznDcAi0F1lVC50abvb7msa0LG9JGhM+KxWxPVZ90g6TJ9alof/ZC98RbeZsjo
	 MOaJ2F3LGzkJRFRpMd9Gj8SiNPfhaAz0sjsI+9vrDg6WHqPFXuh5NGBGMGFlFC0rCy
	 NlLTKtoNFZhcJmW3BL4DgeGufyo+iZWVEoHaRHcc=
Date: Wed, 18 Nov 2026 15:11:26 +0100
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
Message-ID: <av2yDgdBWfTxvZca@cs.unibo.it>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
 <av2i9kbZyMRJE9D6@cs.unibo.it>
 <av2pRG1JT9te8IiM@kunlun.suse.cz>
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
In-Reply-To: <av2pRG1JT9te8IiM@kunlun.suse.cz>

On Wed, Nov 18, 2026 at 02:33:56PM +0100, Michal Suchánek wrote:
> As I understand it the new s390 code resolves the problem by storing the
> syscall number outside of the registers. Then the return value can be
> set directly. It does not depend on using the generic entry but on the
> architecture adding storage for the syscall number in struct pt_regs,
> and implementing the code to determine where to get/set the syscall
> value depending on the syscall stage.

Right, thanks for the correction: what matters is a separate storage
for the syscall number on the architectures where it shares a register
with the return value, not the generic entry code.

> However, it seems that extending struct pt_regs breaks userspace ABI
> (probably because kernel refuses to transfer partial pt_regs to/fom
> userspace) which makes it unclear how the int_code that is used by this
> new code could be added to the s390 struct pt_regs in the first place.

On s390 int_code is not new: it has been in the kernel-only part of
struct pt_regs, after user_pt_regs, since aa33c8cbbae2 ("[S390] cleanup
trap handling"), and the user ABI (s390_regs, user_regs_struct) does
not include it. Heiko's patch only redirects the ptrace accesses to
gpr2.

On architectures where struct pt_regs is itself the user ABI (e.g.
alpha), the storage does not need to be in pt_regs: MIPS already keeps
the syscall number in thread_info.

This is also why this series uses a per-task flag at the seccomp stop:
it does not depend on where the architecture stores the syscall
number.

Thanks,
renzo
