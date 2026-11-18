Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002157;
	b=f3MnM4AhhM+qSedYMaKRhCB4UnmPeYatIBliP2IyuV90SNoVEKEOPhFAvE9X15Ea6iDw
	 yvEPcvoMel4JXCM7UahgT/w+T4F/4m/d0jNSphliDPYwZY03f2/7O6XnOyx+3W0x39IE8
	 5WpI/EZefu/gm3U1quy5AfQJSQJuocEnXr8Xd3rZgkF62KPGEcc120zC1aGNUiYU1T8RX
	 yi/cPj9O3GlOROKbfAzdHBImtazrJx86SZCUhapd1g05dpFQzk9/phCy5VJ5TpigUoxr3
	 d9kIFxicBWL8moMdJ9151mDqOewG2H5JTd4f5UUFi5b7F3GNil/YhqvgIlU9tzQV+6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002157;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=ts1zyYo+0tF/wBGQw87MWas4/lAsPLXenr9aSms+T5s=;
	b=m7wvpfJl0e9wHnMBfiRKpZW9gp/u3T6Q2eV33Qps2hunPPTVMoccwB4UwswmXBT5BF0z
	 6FYvV6umZbdXY5Aq0/plXTv5vlJn16acSiZ3VQwmWnHahgns3BDW8iYAwF4oGNSt9r3Ho
	 9VnxQ6R+uf5pO7Js4DlURahwx80YSf6cKHUeUWKnD2YSk014US6fznb0WwxSdMrj+M9Xj
	 FUy2DZUY1ckCC7RfN3oA4KXIdoqLpk+kcYTAe2Ynj8iqhw24AypqlwsXyxKl58xqgAQCD
	 9MElA1J/gXSa62roszv8a+QerM+JstPkYiQyZ5gQX4JK0JUKu2MEPaVIsjK1lYtLA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MJYbixBP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9F6yuFzm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tjvt0P+o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CHdKwqiP;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9A606A31C;
	Wed, 18 Nov 2026 11:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MJYbixBP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9F6yuFzm;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tjvt0P+o;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CHdKwqiP
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75CE21FB54;
	Wed, 18 Nov 2026 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795002154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts1zyYo+0tF/wBGQw87MWas4/lAsPLXenr9aSms+T5s=;
	b=MJYbixBPXebGghxcy9GLxNdpTxi5J1APSIVerzfUfFMu5GHAp6ZDY18IQ0C01KLofCsaQa
	iLxUfq3jL4ShHx2lhkaOkCZ85BgpCJXJU1fTSsvLK8p91QsPi3SvK+FreT3GMDVJegEjKy
	SFt6abukRfiGzU6B6i9o8L9x6ep+pq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795002154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts1zyYo+0tF/wBGQw87MWas4/lAsPLXenr9aSms+T5s=;
	b=9F6yuFzm2ea4WmMd6IJ9jyZSa5ej8Hb4wjPtUkxTeJon96jrG1bwsrXBETFDtvJqKOWof/
	VJosWdeZhIavdbCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tjvt0P+o;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CHdKwqiP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795002153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts1zyYo+0tF/wBGQw87MWas4/lAsPLXenr9aSms+T5s=;
	b=tjvt0P+oze6M+//BuxhCpozTK9biCEkeBlPm74JbxWXo1S7DXiXTvPmGRjRgwSTA/mlw0J
	xPoaJv0wpZN62UdqYZgwQkFlOwbOR23cp+NdBusnoTHVMHFaLu31XdrIPu7L/gExFC/tfN
	sGjATTjETAAp59VtWDPj3fvmh/NDidY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795002153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ts1zyYo+0tF/wBGQw87MWas4/lAsPLXenr9aSms+T5s=;
	b=CHdKwqiP9NqvC2rAs0raL9qkbYbZVNUZCscjq8BLFBo/z0i5yUzELG09kfz8HDsY45agAe
	5aIhSUfATZZXGVDQ==
Date: Wed, 18 Nov 2026 12:42:32 +0100
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
Message-ID: <av2PKIf8YsEPro8O@kunlun.suse.cz>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
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
In-Reply-To: <20261114181923.370930-1-renzo@cs.unibo.it>
X-Rspamd-Queue-Id: 75CE21FB54
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.01 / 50.00];
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
	NEURAL_HAM_SHORT(-0.20)[-0.975];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[21];
	URIBL_BLOCKED(0.00)[sashiko.dev:url,suse.de:dkim,kunlun.suse.cz:helo];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,amacapital.net,chromium.org,linux-foundation.org,strace.io,gmail.com,alpha.franken.de,linux.ibm.com,lists.ozlabs.org,lists.strace.io];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:helo,suse.de:dkim,sashiko.dev:url]
X-Spam-Score: -6.01

On Sat, Nov 14, 2026 at 07:19:19PM +0100, Renzo Davoli wrote:
> PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> PTRACE_GET_SYSCALL_INFO by allowing a tracer to modify details of a
> system call in which the tracee is currently blocked.
> 
> This patch set extends PTRACE_SET_SYSCALL_INFO with support for
> skipping a system call at a PTRACE_EVENT_SECCOMP stop and setting its
> return value.  To do this, the tracer changes 'op' from
> PTRACE_SYSCALL_INFO_SECCOMP to PTRACE_SYSCALL_INFO_EXIT and fills in the
> exit union fields (rval and is_error).

Hello,

from a user point of view it is not clear to me why this would be done
at the seccomp event when seccomp is not used.

> 
> Michal pointed out in the review of v7 [1] that the register state alone
> cannot tell whether a syscall has to be executed or skipped with a
> preset return value, since on some architectures the return value
> shares a register with the syscall number or the arguments, and that
> the "already dispatched" information should be architecture
> independent rather than an architecture-specific thread flag.

On s390 the removal of such architecture-specific flag is proposed here:

https://lore.kernel.org/linux-s390/890e50e0-77f7-43f3-b1b9-f8e7302aa3db-agordeev@linux.ibm.com/T/#m04254224bb28b747314346153629207c5acca6f9

While that shows a way to address this problem not all affected
architectures implement it.

Thanks

Michal

> 
> v8 does exactly that: the tracer no longer sets the syscall number to -1
> and relies on syscall_get_nr() reading it back as negative.  Instead,
> patch 1 adds a per-task flag owned by seccomp, which the tracer sets
> while the tracee is stopped.  When the tracee resumes, seccomp skips the
> system call just like for SECCOMP_RET_ERRNO, a path every architecture
> already handles without touching the return value.  This also fixes
> skipping on s390, where -1 is read back as syscall 65535.
> 
> On powerpc, a separate fix has been posted [2]:
> syscall_set_return_value() currently sets TIF_SYSCALL_RET on the
> *caller*, i.e. on the tracer when called from PTRACE_SET_SYSCALL_INFO,
> and skipped system calls lose non-error return values.  These problems
> are already present in the source tree and break the existing
> set_syscall_info selftest and seccomp_bpf user_notification_basic on
> ppc64le independently of this series, which therefore no longer
> depends on [2].
> 
> [1] https://lore.kernel.org/lkml/apWFHkZnCMfxQCEk@kunlun.suse.cz/
> [2] https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/
> [3] https://sashiko.dev/#/patchset/20261113165509.229869-1-renzo@cs.unibo.it?part=2
> 
> Testing (tools/testing/selftests/ptrace/set_syscall_info and
> tools/testing/selftests/seccomp/seccomp_bpf):
> 
> v11, QEMU, v7.4-rc2:
> 
>                                x86_64 (KVM)
>   ptrace/set_syscall_info      2/2
>   seccomp/seccomp_bpf          142/142
> 
> v9, QEMU, v7.3-rc6 (the v11 change is architecture independent):
> 
>                                x86_64 (KVM)   ppc64le (TCG)   s390x (TCG)
>   ptrace/set_syscall_info      2/2            2/2             2/2
>   seccomp/seccomp_bpf          111/111        111/111         110/111 (*)
> 
>   Build-tested also with CONFIG_SECCOMP=n and CONFIG_SECCOMP_FILTER=n.
> 
>   Skipping getpid() at a PTRACE_EVENT_SECCOMP stop, with a filter that
>   kills the process on unknown syscall numbers:
> 
>   op=SECCOMP, nr=-1 (before)   error          r3 left as is   SIGSYS kill
>   op=SECCOMP->EXIT (this)      -ESRCH         -ESRCH          -ESRCH
> 
>   (*) user_notification_wait_killable_after_reply timed out under TCG
>       while another VM was running; it passes 5/5 both with and without
>       this series on an idle x86_64 KVM guest.
> 
>   ppc64le results were obtained with an earlier version of the powerpc
>   fix [2] applied.
> 
>   Not tested: MIPS, arm64, riscv, loongarch, real hardware.
> 
> Changes in v11:
> * once the system call is skipped, PTRACE_GET_SYSCALL_INFO reports the
>   stop as a PTRACE_SYSCALL_INFO_EXIT one, as the syscall number and
>   arguments may have been overwritten by the return value (reported by
>   Sashiko [3]); a later PTRACE_SYSCALL_INFO_SECCOMP update is still
>   rejected, now by the generic check on the stop type
> * selftests/ptrace/set_syscall_info.c: check PTRACE_GET_SYSCALL_INFO
>   after the system call is skipped
> 
> Changes in v10:
> * rebased to Linux 7.4-rc2
> * no longer depends on the powerpc fix [2], which addresses a bug
>   already present in the source tree
> 
> Changes in v9:
> * selftests/ptrace/set_syscall_info.c: check for seccomp filter support,
>   fix failure report
> * rebased to Linux 7.3
> 
> Changes in v8:
> * skip the system call via a seccomp per-task flag instead of
>   syscall_set_nr(-1), as suggested by Michal Suchánek
> * new helper ptrace_set_syscall_info_seccomp_skip() instead of a bool
>   argument to ptrace_set_syscall_info_exit() (Michal Suchánek)
> * once the system call is skipped, reject further
>   PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop
> * selftest: also test an error return value and the above
> * dropped the Reviewed-by tags of Oleg and Dmitry, as patch 2 changed
>   significantly
> 
> Changes in v7:
> * rebased to Linux 7.3-rc1
> 
> Changes in v6:
> * selftests/ptrace/set_syscall_info.c: improve messages in case of failure.
> 
> Changes in v5:
> * reworded the explanation for not supporting PTRACE_SYSCALL_INFO_ENTRY yet.
> * selftests/ptrace: removed a redundant check.
> 
> Changes in v4:
> * Reworded the commit messages for clarity.
> * Renamed the local variable child_op to op in ptrace_set_syscall_info()
> * Clean up and improve the coding style of selftests/ptrace/set_syscall_info.c
>   (suggested by Dmitry V. Levin)
> 
> Changes in v3:
> * restrict the syscall skipping feature to PTRACE_SYSCALL_INFO_SECCOMP
> 
> Changes in v2:
> bugfix: _NONE -> _EXIT transition was erroneously permitted
> 
> Davide Berardi (1):
>   seccomp: let the tracer skip a syscall independently of its number
> 
> Renzo Davoli (2):
>   ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
>   selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO syscall
>     skipping
> 
>  include/linux/seccomp.h                       |  33 +++
>  include/linux/seccomp_types.h                 |   4 +
>  kernel/ptrace.c                               |  49 +++-
>  kernel/seccomp.c                              |  11 +-
>  .../selftests/ptrace/set_syscall_info.c       | 249 +++++++++++++++++-
>  5 files changed, 342 insertions(+), 4 deletions(-)
> 
> base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
> -- 
> 2.55.0
> 
