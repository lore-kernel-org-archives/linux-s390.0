Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8048D2D5937;
	Tue, 18 Aug 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073688; cv=none; b=hzl8fLKcJNGCc4a7d5lu0t6+gKl0uCskLr8SKeyP3SjeSl0p0WgVTt1LTxM3jXdAg9LBaRgKgmszf4woDZsq6CpupB2QzWL1YclH965vGOLeBqcoQVCMs2ZV4ltpdYVIeTw6A5ZPivKYSucRdkjeS6EtwRJFbISp81gz/TJ2Dik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073688; c=relaxed/simple;
	bh=BS7AOgET/NP5fpMGyWv4w+AOlUrbEN5MOZ8ka/fitbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY9tbwqrZ4HCyUchWF9721A+p41sQSdD2nOA+GKzjOgjkamHF+oaubOf5/ndCvnSWOZ1aK6zADMQzCEZBi9tsJHC5VbElufC3dnYOAJ6ut3hjwfp4+w2MOF5PZvLdVUrESNfuTw3y2iQN1MAILaj7mZx45ESahebSW8M/Or5jEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxQZZmpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxQZZmpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0811F00A3F;
	Tue, 18 Aug 2026 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787073687;
	bh=y5Yb++33b8ghE+kes/926rAcD97Zm6TWSQybOrauAyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dxQZZmpCgXN97d4UAVf/T5UjgyfH7SLWk0tPtrxMI8YaR6YDpUnqPCXHKmS2VW7Yu
	 h01tgrEm1ycQwz8S+hBxsR2H3Sv/K1E7a5/i6dzaxOAoHCRndsDUvjLCdN+BR5vT8q
	 lju+2Rp/XjMG3K9OA0SdoCaji1thLYo+SfKKQVnFoOkYGMaZDfoVqnXrR71Ol8GV2W
	 SgwVVP6+kPGU/DKnIcrWaW0ez8Hjpt+2NBfCH8iBVzOx6bDJuJRm6GhV1c7kBCsIyZ
	 AK7qiyG0OLkEEtJnsoAXv/qNqr4mlyD31eb8t7W/4ScKUIA3FQRfruSt8fAg6wSfR1
	 ccBzPN5V6qUIA==
Date: Tue, 18 Aug 2026 13:21:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Indu Bhagat
 <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Namhyung
 Kim <namhyung@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kees Cook
 <kees@kernel.org>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 00/25] unwind_user: Implement .eh_frame handling
Message-ID: <20260818132113.737ae646@robin>
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 16:49:29 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> This series adds support for parsing DWARF Call Frame Information (CFI)
> from the .eh_frame_hdr and .eh_frame sections of user space ELF files.

Very nice! I don't have time this week to look at it, but I just
applied the series and tried it out with:

  perf record --call-graph fp,defer trace-cmd report ~/trace.dat

And did a: perf -D script

And found this:

264990534603 0x19370 [0x78]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 1165/1165: 0x105700000005
... FP chain: nr:10
.....  0: 00007f5feafd362a
.....  1: 00007f5feb249781
.....  2: 00007f5feb2498de
.....  3: 000055935526fbdc
.....  4: 00005593552649e6
.....  5: 000055935523c2d0
.....  6: 000055935523d24c
.....  7: 0000559355227bfe
.....  8: 00007f5feaef9f75
.....  9: 00007ffdaf879d38
 ... thread: trace-cmd:1165
 ...... dso: /proc/kcore
trace-cmd    1165   264.990473:     395990 cpu/cycles/P: 
        ffffffff8477d8d3 check_preemption_disabled+0x13 ([kernel.kallsyms])
        ffffffff819aa495 rcu_is_watching+0x15 ([kernel.kallsyms])
        ffffffff816dbcff unwind_next_frame+0x45f ([kernel.kallsyms])
        ffffffff81642e91 arch_stack_walk+0xa1 ([kernel.kallsyms])
        ffffffff81a2e633 stack_trace_save+0x93 ([kernel.kallsyms])
        ffffffff82251210 kasan_save_stack+0x30 ([kernel.kallsyms])
        ffffffff822541b0 kasan_record_aux_stack+0xb0 ([kernel.kallsyms])
        ffffffff819c1e2a __call_rcu_common+0xca ([kernel.kallsyms])
        ffffffff821be05f kmem_cache_free+0x2ef ([kernel.kallsyms])
        ffffffff8233e4a7 vfs_fstatat+0x57 ([kernel.kallsyms])
        ffffffff8233e573 __do_sys_newfstatat+0x83 ([kernel.kallsyms])
        ffffffff84772a8e do_syscall_64+0x7e ([kernel.kallsyms])
        ffffffff8100012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
            7f5feafd362a __GI___fstatat64+0xa (/usr/lib/x86_64-linux-gnu/libc.so.6)
            7f5feb249781 tep_load_plugins_hook+0xd1 (/usr/local/lib64/libtraceevent.so.1.9.0)
            7f5feb2498de tep_load_plugins+0x35 (/usr/local/lib64/libtraceevent.so.1.9.0)
            55935526fbdc tcmd_load_plugins+0x85 (/usr/local/bin/trace-cmd)
            5593552649e6 tracecmd_alloc_fd+0x2da (/usr/local/bin/trace-cmd)
            55935523c2d0 read_trace_header+0x62 (/usr/local/bin/trace-cmd)
            55935523d24c trace_report+0x869 (/usr/local/bin/trace-cmd)
            559355227bfe main+0x90 (/usr/local/bin/trace-cmd)
            7f5feaef9f75 __libc_start_call_main+0x75 (/usr/lib/x86_64-linux-gnu/libc.so.6)
            7ffdaf879d38 [unknown] ([unknown])

I injected trace_printk() into the code to make sure it was using the
eh_frame unwinding:

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 85fc82252af1..585f022bcabe 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -200,6 +200,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 		case UNWIND_USER_TYPE_EH_FRAME:
 			switch (unwind_user_next_eh_frame(state)) {
 			case 0:
+				trace_printk("USE EH_FRAME\n");
 				return 0;
 			case -ENOENT:
 				continue;	/* Try next method. */
@@ -208,8 +209,9 @@ static int unwind_user_next(struct unwind_user_state *state)
 			}
 			break;
 		case UNWIND_USER_TYPE_FP:
-			if (!unwind_user_next_fp(state))
-				return 0;
+			if (!unwind_user_next_fp(state)) {
+				trace_printk("USE FRAME POINTER\n");
+				return 0; }
 			continue;
 		default:
 			WARN_ONCE(1, "Undefined unwind bit %d", bit);

And have this:

# trace-cmd show
[..]
       trace-cmd-1136    [001] .....   239.482498: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482501: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482504: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482507: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482821: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482825: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482828: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482831: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.482834: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483004: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483007: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483010: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483013: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483016: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483230: unwind_user: USE FRAME POINTER
       trace-cmd-1136    [001] .....   239.483234: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483238: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483240: unwind_user: USE EH_FRAME
       trace-cmd-1136    [001] .....   239.483243: unwind_user: USE EH_FRAME
[..]

Note, the compile had one warning (with all patches applied):

  vmlinux.o: warning: objtool: eh_frame_find+0x270c: call to eh_frame_do_expression.isra.0() with UACCESS enabled

I'll try to get time when I get back from my travels next week to look
at each of the patches.

I also do not think this makes sframe obsolete. I believe there's holes
with eh_frame and some may not like the complexity of it. But this
gives us an honest look at what options are available to us.

Thanks for doing this!

-- Steve
