Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E982C031E;
	Wed, 22 Oct 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103852; cv=none; b=U3L9HYSDUiKIIDjEL6xA8JIE6idZXc8VIR4+OFm7TSCTb2RhFH/xJ2UP5OVj7dKwtGNovTr8qrZC8+1Vu4TQZCVKBiDvfByo7jjIkVfVy379O1qfIt3Ffu5CrSJnNccWyuGL6Xhl4HRQhXFZq4I66wl31D6FiyBVNCkC/fghqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103852; c=relaxed/simple;
	bh=ducze3nGeZREphipJ3iARNN/jJ73rKoDI+2MDBX6cfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frTN3VkweYAYGE276Z5P+E7O4cA3bfTxL5nLfVwDuxgCy9c5W1lbUPjTh+zmO8gG6mjJopy/gs8JMThMOzzOEUCfpRkvcWR3kFhHZPixbJ071RBuOefEY4mvCRo12xUS1fEUrphyFpkxoH9x350UhYQ1tHWEGuiykhCcr/LzhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFuCA/I9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFuCA/I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF1C4CEE7;
	Wed, 22 Oct 2025 03:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761103851;
	bh=ducze3nGeZREphipJ3iARNN/jJ73rKoDI+2MDBX6cfA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UFuCA/I9zxQjih/rTdbzDsO8WcLu4sCdPVQ6JvMFv9uMClCWRjdSgBAEX4L0aiChS
	 n/6YG75859ud3HlZSbpgPz63w+y79CmGMjeBCq0BpkpgrVUJpLpLudwCbOHMQDr8LA
	 8Z0MF0N+qAVeZn9q4/bGeann1UvSlw9oF3kj1nha7JKSXcJPe7VAYK/ob6kvBdAPOW
	 Ck3Lyb23sBZoK5mvCXZqzn7o4f2J6zKGCcqm1du63olSYxv2G0cIZkX477OTXCn4xI
	 jQ7eozoRqK7pDZuN71ySTsvKT4ZplDg+onMh6keeaTOJ7F+Uqt/YWVkAhTGBG2cVmq
	 tb6q6IDw0PlUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E50FCE0CFD; Tue, 21 Oct 2025 20:30:51 -0700 (PDT)
Date: Tue, 21 Oct 2025 20:30:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Andrew Chant <achant@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Francesco Valla <francesco@valla.it>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v2] init/main.c: Wrap long kernel cmdline when printing
 to logs
Message-ID: <0d528748-7a55-4de8-af95-d8a197548fb7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251021173939.v2.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <8bc35675-13ab-4444-ba45-be910ebc4ff4@paulmck-laptop>
 <CAD=FV=WFbH6kBMcoHNwQzsay6ecQQ2sZ3qc-=XTboFXK+RSspA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WFbH6kBMcoHNwQzsay6ecQQ2sZ3qc-=XTboFXK+RSspA@mail.gmail.com>

On Tue, Oct 21, 2025 at 07:51:49PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Oct 21, 2025 at 7:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Oct 21, 2025 at 05:39:48PM -0700, Douglas Anderson wrote:
> > > The kernel cmdline length is allowed to be longer than what printk can
> > > handle. When this happens the cmdline that's printed to the kernel
> > > ring buffer at bootup is cutoff and some kernel cmdline options are
> > > "hidden" from the logs. This undercuts the usefulness of the log
> > > message.
> > >
> > > Specifically, grepping for COMMAND_LINE_SIZE shows that 2048 is common
> > > and some architectures even define it as 4096. s390 allows a
> > > CONFIG-based maximum up to 1MB (though it's not expected that anyone
> > > will go over the default max of 4096 [1]).
> > >
> > > The maximum message pr_notice() seems to be able to handle (based on
> > > experiment) is 1021 characters. This appears to be based on the
> > > current value of PRINTKRB_RECORD_MAX as 1024 and the fact that
> > > pr_notice() spends 2 characters on the loglevel prefix and we have a
> > > '\n' at the end.
> > >
> > > While it would be possible to increase the limits of printk() (and
> > > therefore pr_notice()) somewhat, it doesn't appear possible to
> > > increase it enough to fully include a 2048-character cmdline without
> > > breaking userspace. Specifically on at least two tested userspaces
> > > (ChromeOS plus the Debian-based distro I'm typing this message on) the
> > > `dmesg` tool reads lines from `/dev/kmsg` in 2047-byte chunks. As per
> > > `Documentation/ABI/testing/dev-kmsg`:
> > >
> > >   Every read() from the opened device node receives one record
> > >   of the kernel's printk buffer.
> > >   ...
> > >   Messages in the record ring buffer get overwritten as whole,
> > >   there are never partial messages received by read().
> > >
> > > We simply can't fit a 2048-byte cmdline plus the "Kernel command
> > > line:" prefix plus info about time/log_level/etc in a 2047-byte read.
> > >
> > > The above means that if we want to avoid the truncation we need to do
> > > some type of wrapping of the cmdline when printing.
> > >
> > > Add wrapping to the printout of the kernel command line. By default,
> > > the wrapping is set to 1021 characters to avoid breaking anyone, but
> > > allow wrapping to be set lower by a Kconfig knob
> > > "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". Any tools that are correctly
> > > parsing the cmdline today (because it is less than 1021 characters)
> > > will see no difference in their behavior. The format of wrapped output
> > > is designed to be matched by anyone using "grep" to search for the
> > > cmdline and also to be easy for tools to handle. Anyone who is sure
> > > their tools (if any) handle the wrapped format can choose a lower
> > > wrapping value and have prettier output.
> > >
> > > Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> > > with "Kernel command line: " and lines that are not the last line have
> > > a " \" suffix added to them. The prefix and suffix count towards the
> > > line length for wrapping purposes. The ideal length will be exceeded
> > > if no appropriate place to wrap is found.
> > >
> > > The wrapping function added here is fairly generic and could be made a
> > > library function (somewhat like print_hex_dump()) if it's needed
> > > elsewhere in the kernel. However, having printk() directly incorporate
> > > this wrapping would be unlikely to be a good idea since it would break
> > > printouts into more than one record without any obvious common line
> > > prefix to tie lines together. It would also be extra overhead when, in
> > > general, kernel log message should simply be kept smaller than 1021
> > > bytes. For some discussion on this topic, see responses to the v1
> > > posting of this patch [2].
> > >
> > > [1] https://lore.kernel.org/r/20251021131633.26700Dd6-hca@linux.ibm.com
> > > [2] https://lore.kernel.org/r/CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Nice!!!
> >
> > However, there is tooling that will choke on the line-wrapping.  :-(
> 
> Ah, so you're saying that you know of a tool that will behave better
> if an overflowing cmdline is truncated (like the current behavior)
> instead of an overflowing cmdline suddenly starting to wrap. OK,
> that's fair. Any chance you could provide any more details about the
> tool?

The tools are nothing special and again I will be pushing to get the
ones I know about fixed.  One concern is that losing the beginning of
the command line can be quite a bit more painful than losing the end.

> > So would it be possible to have a Kconfig option (or a special value for
> > your new CMDLINE_LOG_WRAP_IDEAL_LEN Kconfig option) that preserves the
> > old behavior?  (Yes, I am of course looking into making things line-wrap
> > tolerant here, but...)
> 
> Seems like a valid request. I'd rather not add yet another Kconfig
> option, but how about if I allow CMDLINE_LOG_WRAP_IDEAL_LEN to go from
> -1 to 1021. Any time that the value is a nonnegative value less than
> the length of the prefix ("Kernel command line: ") we'll basically
> just always wrap at the first space. If the config is the special
> value of -1 then it will totally disable the new behavior. Does that
> seem reasonable?

That sounds eminently reasonable, thank you very much!

> Do you have any preference about what the default should be? If the
> tool you're aware of is something that's common and lots of people use
> it, then it seems like -1 should be the default. If your tool is
> something that's just on a special / custom linux distro then maybe
> you'd be OK with the default of 1021.

We will be keeping track and setting the value we need, so I would
recommend keeping your current default.  Unless or until reviews or
experience proves otherwise.

							Thanx, Paul
