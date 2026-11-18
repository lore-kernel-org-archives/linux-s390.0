Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008840;
	b=K1RcYLrSOfuhCnkckJd2RILNHYJmQ1ZEJoYedF3UwvXWOybjnEvPBeOlXG46ItWZE7JK
	 aB8jANxC9Eou2wfSp4nFrJtgdM+/yvPsOSBXTDnYT7LC4srgV8PfPIPeGDU38ND/Png42
	 tGd4lNpk7G6MfF5EbaH5IJJePIcID7wNSx0XoI5DE63Qe7N0eFCj57i3/1J+mIbq7uM6q
	 JhoVIJfiX7fT28ASkxYYDvYtoIQxVxfN48qBCa1I0jPYcAW4PAySnIKYfC1EipibQmONB
	 IJxU7i+lDxGrS4n1Gv4VyMKEI62oXha9Sayvqy04Cxur4TyaAvavVUK5LNeBBJPLkqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008840;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=zyvEZY3QllRneJ0JgvTvRfvRpCowMyMY1L5TNBcJGbblmkr33xtGxVA0sc9TGqQPyvgw
	 XbL0UZX+P6tSJlpuIddEFjAQiC3WREo6ASz7av5Iu3ITzPV9DoUomRxPSg4UxhOwAET3I
	 6rxU2LZ2JNQfNX8X/BFXUT6F1+s9KIzBxblyNNfsgEQx+dZsBj+VZO9w3jSUeplONhryA
	 BmgG6Oob+d/N3fQj1jOzePZiU1Z6jyMc7S42wdpsirI+4XsXi7RHG5j+z5Y44leu6in68
	 eJMdRtirDp+iUT1EuWH8FAhaOVLjUHl85abDtEiWnYmQRbdIDWWJw5/NXuIgntF9CXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="JDx/rGU0";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="JDx/rGU0";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5E606A320;
	Wed, 18 Nov 2026 13:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65B5E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D37C1F76B;
	Wed, 18 Nov 2026 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795008837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=JDx/rGU0HCc6Ed7gNE8IdTlpVzFAkXIp6dQOuhaLkI4aMqIeZLdi9NuqD6TWvANeQ2yCKK
	B8dN8XDfVBaOzO/CRhgJtQwBigE5LoTdDj+YGomQSUFoJ2iqej0avIAAIiMIPndkaqXi57
	cWNqwc0h27kfVcYcK/V1MDi2E7amH4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795008837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=TEdd3r0nHiekiQs2TDHnWWl2Ub5x6e0ph8fykDPRx0Bc83uNWG+VbMJmhVD/RluGPR4cOH
	8xCFIYgDT7aEtHAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="JDx/rGU0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TEdd3r0n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795008837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=JDx/rGU0HCc6Ed7gNE8IdTlpVzFAkXIp6dQOuhaLkI4aMqIeZLdi9NuqD6TWvANeQ2yCKK
	B8dN8XDfVBaOzO/CRhgJtQwBigE5LoTdDj+YGomQSUFoJ2iqej0avIAAIiMIPndkaqXi57
	cWNqwc0h27kfVcYcK/V1MDi2E7amH4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795008837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=TEdd3r0nHiekiQs2TDHnWWl2Ub5x6e0ph8fykDPRx0Bc83uNWG+VbMJmhVD/RluGPR4cOH
	8xCFIYgDT7aEtHAg==
Date: Wed, 18 Nov 2026 14:33:56 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Renzo Davoli <renzo@cs.unibo.it>
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
Message-ID: <av2pRG1JT9te8IiM@kunlun.suse.cz>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
 <av2i9kbZyMRJE9D6@cs.unibo.it>
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
In-Reply-To: <av2i9kbZyMRJE9D6@cs.unibo.it>
X-Spamd-Result: default: False [-6.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.958];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,amacapital.net,chromium.org,linux-foundation.org,strace.io,gmail.com,alpha.franken.de,linux.ibm.com,lists.ozlabs.org,lists.strace.io];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -6.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 2D37C1F76B

On Wed, Nov 18, 2026 at 02:07:02PM +0100, Renzo Davoli wrote:
> On Wed, Nov 18, 2026 at 12:42:32PM +0100, Michal Suchánek wrote:
> > from a user point of view it is not clear to me why this would be done
> > at the seccomp event when seccomp is not used.
>  
> Hi Michal,
>  
> thank you for the review.
>  
> You are right, and the cover letter does not explain it (only patch 2
> does, briefly). The series is limited to the PTRACE_EVENT_SECCOMP stop
> because that is the only stop where a syscall can currently be skipped
> with a preset return value in an architecture independent way: the
> tracer's request goes through the same path as SECCOMP_RET_ERRNO,
> which every architecture already handles.
> 
> At the syscall entry stop this depends on the architecture's entry
> code. On some architectures (e.g. MIPS) the entry path overwrites the
> return value with -ENOSYS when the syscall is skipped, so the value set
> by the tracer is lost. A tracer that does not otherwise use seccomp
> has to install a SECCOMP_RET_TRACE filter to use this feature.
> 
> > On s390 the removal of such architecture-specific flag is proposed here:
> > [...]
> > While that shows a way to address this problem not all affected
> > architectures implement it.
> 
> Thanks for the pointer. With 05c033db7e9a ("entry, treewide: Make
> syscall_enter_from_user_mode[_work]() indicate syscall execution") and
> Heiko's s390 fix, the architectures using the generic entry code
> preset -ENOSYS and leave the return value alone when the syscall is
> skipped, so skipping at the entry stop could be supported there. As
> in patch 1, a per-task flag checked right after the ptrace entry
> report could be used, so that it does not depend on the syscall
> number.

As I understand it the new s390 code resolves the problem by storing the
syscall number outside of the registers. Then the return value can be
set directly. It does not depend on using the generic entry but on the
architecture adding storage for the syscall number in struct pt_regs,
and implementing the code to determine where to get/set the syscall
value depending on the syscall stage.

However, it seems that extending struct pt_regs breaks userspace ABI
(probably because kernel refuses to transfer partial pt_regs to/fom
userspace) which makes it unclear how the int_code that is used by this
new code could be added to the s390 struct pt_regs in the first place.

Thanks

Michal
