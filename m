Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBD49DB8A;
	Tue,  6 Oct 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300921; cv=none; b=QpEYUDAH8bzdKNjOR749NjciELGRzsfG1FqcptidpWYRAD4SRBrBQZdMjOMK/JnAde0IempY+9UgZZsZ91VJTdOOJ7IF1vkrAftTNkxthJTXgDd/q6P2aTiGVH//M8g8TaturWusJg6sE7kttmanoAQxif0Y7BraydgDANyvJLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300921; c=relaxed/simple;
	bh=9ARFsmwZTIPJdrSoDAkmFdmpRtHaGnhxlyYz6ry0pT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvNqQJAWXs3oAJDTnwJeOqlXb3vs7UQbuZfLeU7TSaksPiof+qe/OO2dMGD96g36vnuRsTxq4KtGrQvTEhtRigMAewemZUrIZsKNPegVS7+GS7XOkQtoVPJBo0bAyasawiev2KUff91QrFlWlFxIPWP8t467CHEWQDNh/fJGVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qcSwlb5D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PnwecC3+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nIstQG35; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T6ew+NHs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qcSwlb5D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PnwecC3+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nIstQG35";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T6ew+NHs"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9EA41F7AF;
	Tue,  6 Oct 2026 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791300912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lS2Oh85feGBABDtJnF9Irz1qcx8rcV4kKh2BKf2dTs=;
	b=qcSwlb5D0ecD6Zsvc5tf3Ybz3+DqYnY9E863dhUfQmjDSQYnHorYa48jpHOR32JsEpC0OU
	QjXZIveAk/Jywud1t8iQf/pXGi52+FBmYm7vayu8ardBIyFjP+4a0bPM8+qTb9EIGStb1x
	gWOWy45Mbo8RSluEtd6jnyU9mr0U5d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791300912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lS2Oh85feGBABDtJnF9Irz1qcx8rcV4kKh2BKf2dTs=;
	b=PnwecC3+PlUm3lPxzE7xLnNpRB3n8W/fC353cYH2NHMehlH6AQForVOQ/lpfFCDWslh85M
	usxvxhNk8rol6oAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nIstQG35;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T6ew+NHs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791300908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lS2Oh85feGBABDtJnF9Irz1qcx8rcV4kKh2BKf2dTs=;
	b=nIstQG359rwssueMFo1sDLwolS3Zis/9mntEKGlWymsXGarNt6gToNA/+n6FzvLAk3esW1
	2Sbyx0IxnI5y6gRJKCg0ThvfOhzKP+IOPED0LIiBdcUFm4gPreH6tHkZ2VHuAxo7Ebm1WN
	DbZ68FVSeZIozqApNHkVDDjyrMi9jtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791300908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lS2Oh85feGBABDtJnF9Irz1qcx8rcV4kKh2BKf2dTs=;
	b=T6ew+NHs8PkfE0wvUI3EPvPT8kIkbbml70l/+IC1VtcjOwhSfCJvbEdToqI2KPih36XQqX
	Ky3dJGxlaEoErcBA==
Date: Tue, 6 Oct 2026 17:35:06 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org, x86@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>,
	Renzo Davoli <renzo@cs.unibo.it>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] seccomp: Fix syscall skip logic on ptrace
Message-ID: <asUVKrMQR_U2ySRp@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <al9NlZi20xHMvla2@kunlun.suse.cz>
 <202609011132.F4A3EB7103@keescook>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609011132.F4A3EB7103@keescook>
X-Rspamd-Action: add header
X-Spamd-Result: default: False [15.05 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.86)[0.953];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amacapital.net,chromium.org,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,lists.linux.dev,arm.com,huawei.com,gmail.com,lwn.net,rendec.net,cs.unibo.it,redhat.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Spam-Score: 15.05
X-Spam-Level: ***************
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: E9EA41F7AF
X-Spam-Flag: YES
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam: Yes

On Tue, Sep 01, 2026 at 11:34:31AM -0700, Kees Cook wrote:
> On Tue, Jul 21, 2026 at 12:44:37PM +0200, Michal Suchanek wrote:
> > seccomp takes a shortcut here. When the syscall number is re-read after
> > ptrace and the sign bit is set in the syscall number the syscall is
> > skipped right away.
> > 
> > This works fairly well on x86 where the return value of the syscall is
> > preset before seccomp is processed.
> > 
> > However, on some architectures the syscall return value overlaps with
> > the syscall number or syscall arguments, and as a result the return
> > value cannot be preset in advance.
> > 
> > For these architectures seccomp needs to exit without flagging the
> > syscall as skipped. Then processing of invalid syscall number in the
> > architecture code should set the return value to -ENOSYS and skip the
> > syscall.
> > 
> > This introduces a change: If the syscall number has the sign bit
> > set, such as -1, previously the filter re-check would not be done, not
> > applying the filter after trace. Now the re-check is done both for
> > syscall nubers with and without sign bit set. This would only make a
> > difference if the syscall number or the filter was changed by the
> > tracer. Otherwise the filter would be resolved the first time around.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  kernel/seccomp.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 066909393c38..9e40a38aaedf 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1318,11 +1318,8 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
> >  		 */
> >  		if (fatal_signal_pending(current))
> >  			goto skip;
> > -		/* Check if the tracer forced the syscall to be skipped. */
> > -		this_syscall = syscall_get_nr(current, current_pt_regs());
> > -		if (this_syscall < 0)
> > -			goto skip;
> >  
> > +		this_syscall = syscall_get_nr(current, current_pt_regs());
> >  		/*
> >  		 * Recheck the syscall, since it may have changed. This
> >  		 * intentionally uses a NULL struct seccomp_data to force
> 
> Does the seccomp selftest still pass with this change? I _think_ it's
> fine; this just induces more work on a tracer-induced skip path, which,
> in theory, shouldn't be fast-path: kicking out to the tracer is going to
> be the slowest part.

It does not pass without this change, either.

On 7.3-rc6 I get:

./seccomp_bpf 
TAP version 13
1..111
# Starting 111 tests from 11 test cases.
#  RUN           global.kcmp ...
#            OK  global.kcmp
ok 1 global.kcmp
#  RUN           global.mode_strict_support ...
#            OK  global.mode_strict_support
ok 2 global.mode_strict_support
#  RUN           global.mode_strict_cannot_call_prctl ...
#            OK  global.mode_strict_cannot_call_prctl
ok 3 global.mode_strict_cannot_call_prctl
#  RUN           global.no_new_privs_support ...
#            OK  global.no_new_privs_support
ok 4 global.no_new_privs_support
#  RUN           global.mode_filter_support ...
#            OK  global.mode_filter_support
ok 5 global.mode_filter_support
#  RUN           global.mode_filter_without_nnp ...
#            OK  global.mode_filter_without_nnp
ok 6 global.mode_filter_without_nnp
#  RUN           global.filter_size_limits ...
#            OK  global.filter_size_limits
ok 7 global.filter_size_limits
#  RUN           global.filter_chain_limits ...
#            OK  global.filter_chain_limits
ok 8 global.filter_chain_limits
#  RUN           global.mode_filter_cannot_move_to_strict ...
#            OK  global.mode_filter_cannot_move_to_strict
ok 9 global.mode_filter_cannot_move_to_strict
#  RUN           global.mode_filter_get_seccomp ...
#            OK  global.mode_filter_get_seccomp
ok 10 global.mode_filter_get_seccomp
#  RUN           global.ALLOW_all ...
#            OK  global.ALLOW_all
ok 11 global.ALLOW_all
#  RUN           global.empty_prog ...
#            OK  global.empty_prog
ok 12 global.empty_prog
#  RUN           global.log_all ...
#            OK  global.log_all
ok 13 global.log_all
#  RUN           global.unknown_ret_is_kill_inside ...
#            OK  global.unknown_ret_is_kill_inside
ok 14 global.unknown_ret_is_kill_inside
#  RUN           global.unknown_ret_is_kill_above_allow ...
#            OK  global.unknown_ret_is_kill_above_allow
ok 15 global.unknown_ret_is_kill_above_allow
#  RUN           global.KILL_all ...
#            OK  global.KILL_all
ok 16 global.KILL_all
#  RUN           global.KILL_one ...
#            OK  global.KILL_one
ok 17 global.KILL_one
#  RUN           global.KILL_one_arg_one ...
#            OK  global.KILL_one_arg_one
ok 18 global.KILL_one_arg_one
#  RUN           global.KILL_one_arg_six ...
#            OK  global.KILL_one_arg_six
ok 19 global.KILL_one_arg_six
#  RUN           global.KILL_thread ...
#            OK  global.KILL_thread
ok 20 global.KILL_thread
#  RUN           global.KILL_process ...
#            OK  global.KILL_process
ok 21 global.KILL_process
#  RUN           global.KILL_unknown ...
#            OK  global.KILL_unknown
ok 22 global.KILL_unknown
#  RUN           global.arg_out_of_range ...
#            OK  global.arg_out_of_range
ok 23 global.arg_out_of_range
#  RUN           global.ERRNO_valid ...
#            OK  global.ERRNO_valid
ok 24 global.ERRNO_valid
#  RUN           global.ERRNO_zero ...
#            OK  global.ERRNO_zero
ok 25 global.ERRNO_zero
#  RUN           global.ERRNO_capped ...
#            OK  global.ERRNO_capped
ok 26 global.ERRNO_capped
#  RUN           global.ERRNO_order ...
#            OK  global.ERRNO_order
ok 27 global.ERRNO_order
#  RUN           global.negative_ENOSYS ...
#            OK  global.negative_ENOSYS
ok 28 global.negative_ENOSYS
#  RUN           global.seccomp_syscall ...
#            OK  global.seccomp_syscall
ok 29 global.seccomp_syscall
#  RUN           global.seccomp_syscall_mode_lock ...
#            OK  global.seccomp_syscall_mode_lock
ok 30 global.seccomp_syscall_mode_lock
#  RUN           global.detect_seccomp_filter_flags ...
#            OK  global.detect_seccomp_filter_flags
ok 31 global.detect_seccomp_filter_flags
#  RUN           global.TSYNC_first ...
#            OK  global.TSYNC_first
ok 32 global.TSYNC_first
#  RUN           global.syscall_restart ...
#            OK  global.syscall_restart
ok 33 global.syscall_restart
#  RUN           global.filter_flag_log ...
#            OK  global.filter_flag_log
ok 34 global.filter_flag_log
#  RUN           global.get_action_avail ...
#            OK  global.get_action_avail
ok 35 global.get_action_avail
#  RUN           global.get_metadata ...
#            OK  global.get_metadata
ok 36 global.get_metadata
#  RUN           global.user_notification_basic ...
# seccomp_bpf.c:3488:user_notification_basic:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_basic: Test failed
#          FAIL  global.user_notification_basic
not ok 37 global.user_notification_basic
#  RUN           global.user_notification_with_tsync ...
#            OK  global.user_notification_with_tsync
ok 38 global.user_notification_with_tsync
#  RUN           global.user_notification_kill_in_middle ...
#            OK  global.user_notification_kill_in_middle
ok 39 global.user_notification_kill_in_middle
#  RUN           global.user_notification_signal ...
#            OK  global.user_notification_signal
ok 40 global.user_notification_signal
#  RUN           global.user_notification_closed_listener ...
#            OK  global.user_notification_closed_listener
ok 41 global.user_notification_closed_listener
#  RUN           global.user_notification_child_pid_ns ...
# seccomp_bpf.c:3713:user_notification_child_pid_ns:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_child_pid_ns: Test failed
#          FAIL  global.user_notification_child_pid_ns
not ok 42 global.user_notification_child_pid_ns
#  RUN           global.user_notification_sibling_pid_ns ...
# seccomp_bpf.c:3755:user_notification_sibling_pid_ns:Expected 0 (0) == WEXITSTATUS(status) (1)
# seccomp_bpf.c:3791:user_notification_sibling_pid_ns:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_sibling_pid_ns: Test failed
#          FAIL  global.user_notification_sibling_pid_ns
not ok 43 global.user_notification_sibling_pid_ns
#  RUN           global.user_notification_fault_recv ...
# seccomp_bpf.c:3836:user_notification_fault_recv:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_fault_recv: Test failed
#          FAIL  global.user_notification_fault_recv
not ok 44 global.user_notification_fault_recv
#  RUN           global.seccomp_get_notif_sizes ...
#            OK  global.seccomp_get_notif_sizes
ok 45 global.seccomp_get_notif_sizes
#  RUN           global.user_notification_continue ...
#            OK  global.user_notification_continue
ok 46 global.user_notification_continue
#  RUN           global.user_notification_filter_empty ...
#            OK  global.user_notification_filter_empty
ok 47 global.user_notification_filter_empty
#  RUN           global.user_ioctl_notification_filter_empty ...
#            OK  global.user_ioctl_notification_filter_empty
ok 48 global.user_ioctl_notification_filter_empty
#  RUN           global.user_notification_filter_empty_threaded ...
#            OK  global.user_notification_filter_empty_threaded
ok 49 global.user_notification_filter_empty_threaded
#  RUN           global.user_notification_addfd ...
# user_notification_addfd: Test terminated by timeout
#          FAIL  global.user_notification_addfd
not ok 50 global.user_notification_addfd
#  RUN           global.user_notification_addfd_rlimit ...
# seccomp_bpf.c:4366:user_notification_addfd_rlimit:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_addfd_rlimit: Test failed
#          FAIL  global.user_notification_addfd_rlimit
not ok 51 global.user_notification_addfd_rlimit
#  RUN           global.user_notification_sync ...
# seccomp_bpf.c:4404:user_notification_sync:Expected ret (0) == USER_NOTIF_MAGIC (2147483647)
# seccomp_bpf.c:4422:user_notification_sync:Expected status (256) == 0 (0)
# user_notification_sync: Test terminated by assertion
#          FAIL  global.user_notification_sync
not ok 52 global.user_notification_sync
#  RUN           global.user_notification_fifo ...
# seccomp_bpf.c:4581:user_notification_fifo:Expected 0 (0) == WEXITSTATUS(status) (1)
# seccomp_bpf.c:4615:user_notification_fifo:Expected 0 (0) == WEXITSTATUS(status) (1)
# seccomp_bpf.c:4615:user_notification_fifo:Expected 0 (0) == WEXITSTATUS(status) (1)
# seccomp_bpf.c:4615:user_notification_fifo:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_fifo: Test failed
#          FAIL  global.user_notification_fifo
not ok 53 global.user_notification_fifo
#  RUN           global.user_notification_wait_killable_pre_notification ...
#            OK  global.user_notification_wait_killable_pre_notification
ok 54 global.user_notification_wait_killable_pre_notification
#  RUN           global.user_notification_wait_killable ...
# seccomp_bpf.c:4788:user_notification_wait_killable:Expected 0 (0) == WEXITSTATUS(status) (1)
# user_notification_wait_killable: Test failed
#          FAIL  global.user_notification_wait_killable
not ok 55 global.user_notification_wait_killable
#  RUN           global.user_notification_wait_killable_fatal ...
#            OK  global.user_notification_wait_killable_fatal
ok 56 global.user_notification_wait_killable_fatal
#  RUN           global.user_notification_wait_killable_after_reply ...
#            OK  global.user_notification_wait_killable_after_reply
ok 57 global.user_notification_wait_killable_after_reply
#  RUN           global.tsync_vs_dead_thread_leader ...
#            OK  global.tsync_vs_dead_thread_leader
ok 58 global.tsync_vs_dead_thread_leader
#  RUN           TRAP.dfl ...
#            OK  TRAP.dfl
ok 59 TRAP.dfl
#  RUN           TRAP.ign ...
#            OK  TRAP.ign
ok 60 TRAP.ign
#  RUN           TRAP.handler ...
#            OK  TRAP.handler
ok 61 TRAP.handler
#  RUN           precedence.allow_ok ...
#            OK  precedence.allow_ok
ok 62 precedence.allow_ok
#  RUN           precedence.kill_is_highest ...
#            OK  precedence.kill_is_highest
ok 63 precedence.kill_is_highest
#  RUN           precedence.kill_is_highest_in_any_order ...
#            OK  precedence.kill_is_highest_in_any_order
ok 64 precedence.kill_is_highest_in_any_order
#  RUN           precedence.trap_is_second ...
#            OK  precedence.trap_is_second
ok 65 precedence.trap_is_second
#  RUN           precedence.trap_is_second_in_any_order ...
#            OK  precedence.trap_is_second_in_any_order
ok 66 precedence.trap_is_second_in_any_order
#  RUN           precedence.errno_is_third ...
#            OK  precedence.errno_is_third
ok 67 precedence.errno_is_third
#  RUN           precedence.errno_is_third_in_any_order ...
#            OK  precedence.errno_is_third_in_any_order
ok 68 precedence.errno_is_third_in_any_order
#  RUN           precedence.trace_is_fourth ...
#            OK  precedence.trace_is_fourth
ok 69 precedence.trace_is_fourth
#  RUN           precedence.trace_is_fourth_in_any_order ...
#            OK  precedence.trace_is_fourth_in_any_order
ok 70 precedence.trace_is_fourth_in_any_order
#  RUN           precedence.log_is_fifth ...
#            OK  precedence.log_is_fifth
ok 71 precedence.log_is_fifth
#  RUN           precedence.log_is_fifth_in_any_order ...
#            OK  precedence.log_is_fifth_in_any_order
ok 72 precedence.log_is_fifth_in_any_order
#  RUN           TRACE_poke.read_has_side_effects ...
#            OK  TRACE_poke.read_has_side_effects
ok 73 TRACE_poke.read_has_side_effects
#  RUN           TRACE_poke.getpid_runs_normally ...
#            OK  TRACE_poke.getpid_runs_normally
ok 74 TRACE_poke.getpid_runs_normally
#  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
#            OK  TRACE_syscall.ptrace.negative_ENOSYS
ok 75 TRACE_syscall.ptrace.negative_ENOSYS
#  RUN           TRACE_syscall.ptrace.syscall_allowed ...
#            OK  TRACE_syscall.ptrace.syscall_allowed
ok 76 TRACE_syscall.ptrace.syscall_allowed
#  RUN           TRACE_syscall.ptrace.syscall_redirected ...
#            OK  TRACE_syscall.ptrace.syscall_redirected
ok 77 TRACE_syscall.ptrace.syscall_redirected
#  RUN           TRACE_syscall.ptrace.syscall_errno ...
#            OK  TRACE_syscall.ptrace.syscall_errno
ok 78 TRACE_syscall.ptrace.syscall_errno
#  RUN           TRACE_syscall.ptrace.syscall_faked ...
#            OK  TRACE_syscall.ptrace.syscall_faked
ok 79 TRACE_syscall.ptrace.syscall_faked
#  RUN           TRACE_syscall.ptrace.kill_immediate ...
#            OK  TRACE_syscall.ptrace.kill_immediate
ok 80 TRACE_syscall.ptrace.kill_immediate
#  RUN           TRACE_syscall.ptrace.skip_after ...
#            OK  TRACE_syscall.ptrace.skip_after
ok 81 TRACE_syscall.ptrace.skip_after
#  RUN           TRACE_syscall.ptrace.kill_after ...
#            OK  TRACE_syscall.ptrace.kill_after
ok 82 TRACE_syscall.ptrace.kill_after
#  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
#            OK  TRACE_syscall.seccomp.negative_ENOSYS
ok 83 TRACE_syscall.seccomp.negative_ENOSYS
#  RUN           TRACE_syscall.seccomp.syscall_allowed ...
#            OK  TRACE_syscall.seccomp.syscall_allowed
ok 84 TRACE_syscall.seccomp.syscall_allowed
#  RUN           TRACE_syscall.seccomp.syscall_redirected ...
#            OK  TRACE_syscall.seccomp.syscall_redirected
ok 85 TRACE_syscall.seccomp.syscall_redirected
#  RUN           TRACE_syscall.seccomp.syscall_errno ...
#            OK  TRACE_syscall.seccomp.syscall_errno
ok 86 TRACE_syscall.seccomp.syscall_errno
#  RUN           TRACE_syscall.seccomp.syscall_faked ...
# seccomp_bpf.c:2253:syscall_faked:Expected 45000 (45000) == syscall(207) (0)
# syscall_faked: Test failed
#          FAIL  TRACE_syscall.seccomp.syscall_faked
not ok 87 TRACE_syscall.seccomp.syscall_faked
#  RUN           TRACE_syscall.seccomp.kill_immediate ...
#            OK  TRACE_syscall.seccomp.kill_immediate
ok 88 TRACE_syscall.seccomp.kill_immediate
#  RUN           TRACE_syscall.seccomp.skip_after ...
#            OK  TRACE_syscall.seccomp.skip_after
ok 89 TRACE_syscall.seccomp.skip_after
#  RUN           TRACE_syscall.seccomp.kill_after ...
#            OK  TRACE_syscall.seccomp.kill_after
ok 90 TRACE_syscall.seccomp.kill_after
#  RUN           TSYNC.siblings_fail_prctl ...
#            OK  TSYNC.siblings_fail_prctl
ok 91 TSYNC.siblings_fail_prctl
#  RUN           TSYNC.two_siblings_with_ancestor ...
#            OK  TSYNC.two_siblings_with_ancestor
ok 92 TSYNC.two_siblings_with_ancestor
#  RUN           TSYNC.two_sibling_want_nnp ...
#            OK  TSYNC.two_sibling_want_nnp
ok 93 TSYNC.two_sibling_want_nnp
#  RUN           TSYNC.two_siblings_with_no_filter ...
#            OK  TSYNC.two_siblings_with_no_filter
ok 94 TSYNC.two_siblings_with_no_filter
#  RUN           TSYNC.two_siblings_with_one_divergence ...
#            OK  TSYNC.two_siblings_with_one_divergence
ok 95 TSYNC.two_siblings_with_one_divergence
#  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
#            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
ok 96 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
#  RUN           TSYNC.two_siblings_not_under_filter ...
#            OK  TSYNC.two_siblings_not_under_filter
ok 97 TSYNC.two_siblings_not_under_filter
#  RUN           O_SUSPEND_SECCOMP.setoptions ...
#            OK  O_SUSPEND_SECCOMP.setoptions
ok 98 O_SUSPEND_SECCOMP.setoptions
#  RUN           O_SUSPEND_SECCOMP.seize ...
#            OK  O_SUSPEND_SECCOMP.seize
ok 99 O_SUSPEND_SECCOMP.seize
#  RUN           UPROBE.not_attached.uprobe_default_allow ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.not_attached.uprobe_default_allow
ok 100 UPROBE.not_attached.uprobe_default_allow # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.not_attached.uprobe_default_block ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.not_attached.uprobe_default_block
ok 101 UPROBE.not_attached.uprobe_default_block # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.not_attached.uprobe_block_syscall ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.not_attached.uprobe_block_syscall
ok 102 UPROBE.not_attached.uprobe_block_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.not_attached.uprobe_default_block_with_syscall ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.not_attached.uprobe_default_block_with_syscall
ok 103 UPROBE.not_attached.uprobe_default_block_with_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uprobe_attached.uprobe_default_allow ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uprobe_attached.uprobe_default_allow
ok 104 UPROBE.uprobe_attached.uprobe_default_allow # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uprobe_attached.uprobe_default_block ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uprobe_attached.uprobe_default_block
ok 105 UPROBE.uprobe_attached.uprobe_default_block # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uprobe_attached.uprobe_block_syscall ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uprobe_attached.uprobe_block_syscall
ok 106 UPROBE.uprobe_attached.uprobe_block_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uprobe_attached.uprobe_default_block_with_syscall ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uprobe_attached.uprobe_default_block_with_syscall
ok 107 UPROBE.uprobe_attached.uprobe_default_block_with_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uretprobe_attached.uprobe_default_allow ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uretprobe_attached.uprobe_default_allow
ok 108 UPROBE.uretprobe_attached.uprobe_default_allow # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uretprobe_attached.uprobe_default_block ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uretprobe_attached.uprobe_default_block
ok 109 UPROBE.uretprobe_attached.uprobe_default_block # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uretprobe_attached.uprobe_block_syscall ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uretprobe_attached.uprobe_block_syscall
ok 110 UPROBE.uretprobe_attached.uprobe_block_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
#  RUN           UPROBE.uretprobe_attached.uprobe_default_block_with_syscall ...
#      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
#            OK  UPROBE.uretprobe_attached.uprobe_default_block_with_syscall
ok 111 UPROBE.uretprobe_attached.uprobe_default_block_with_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
# FAILED: 101 / 111 tests passed.
# 12 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:89 fail:10 xfail:0 xpass:0 skip:12 error:0

but it does have an additional failure:

--- test-base.log	2026-10-06 15:18:02.387213018 +0000
+++ test-patched.log	2026-10-06 15:32:06.286523030 +0000
@@ -279,10 +279,12 @@
 #            OK  TRACE_syscall.seccomp.syscall_redirected
 ok 85 TRACE_syscall.seccomp.syscall_redirected
 #  RUN           TRACE_syscall.seccomp.syscall_errno ...
-#            OK  TRACE_syscall.seccomp.syscall_errno
-ok 86 TRACE_syscall.seccomp.syscall_errno
+# seccomp_bpf.c:2247:syscall_errno:Expected -(-3) (3) == errno (38)
+# syscall_errno: Test failed
+#          FAIL  TRACE_syscall.seccomp.syscall_errno
+not ok 86 TRACE_syscall.seccomp.syscall_errno
 #  RUN           TRACE_syscall.seccomp.syscall_faked ...
-# seccomp_bpf.c:2253:syscall_faked:Expected 45000 (45000) == syscall(207) (0)
+# seccomp_bpf.c:2253:syscall_faked:Expected 45000 (45000) == syscall(207) (-1)
 # syscall_faked: Test failed
 #          FAIL  TRACE_syscall.seccomp.syscall_faked
 not ok 87 TRACE_syscall.seccomp.syscall_faked
@@ -370,6 +372,6 @@
 #      SKIP      __NR_uprobe ot __NR_uretprobe syscalls not defined
 #            OK  UPROBE.uretprobe_attached.uprobe_default_block_with_syscall
 ok 111 UPROBE.uretprobe_attached.uprobe_default_block_with_syscall # SKIP __NR_uprobe ot __NR_uretprobe syscalls not defined
-# FAILED: 101 / 111 tests passed.
+# FAILED: 100 / 111 tests passed.
 # 12 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
-# Totals: pass:89 fail:10 xfail:0 xpass:0 skip:12 error:0
+# Totals: pass:88 fail:11 xfail:0 xpass:0 skip:12 error:0

Thanks

Michal
