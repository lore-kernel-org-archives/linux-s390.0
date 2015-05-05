Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 May 2015 16:34:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC kgr on klp 4/9] livepatch: add kgr infrastructure
Message-ID: <20150505163450.425f6436@mschwide>
In-Reply-To: <5548C537.4050004@suse.cz>
References: <1430739625-4658-1-git-send-email-jslaby@suse.cz>
	<1430739625-4658-4-git-send-email-jslaby@suse.cz>
	<20150504142301.1405a5c0@mschwide>
	<5548C537.4050004@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: live-patching@vger.kernel.org, jpoimboe@redhat.com, sjenning@redhat.com, jkosina@suse.cz, vojtech@suse.cz, mingo@redhat.com, linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 05 May 2015 15:27:19 +0200
Jiri Slaby <jslaby@suse.cz> wrote:

> What I could do is to split them and make this setup:
> 
> _TIF_WORK:
> TIF_NOTIFY_RESUME       0
> TIF_SIGPENDING          1
> TIF_NEED_RESCHED        2
> TIF_KGR_IN_PROGRESS_W   3
> TIF_UPROBE              7
> 
> _TIF_TRACE:
> TIF_SYSCALL_TRACE       24
> TIF_SYSCALL_AUDIT       25
> TIF_SECCOMP             26
> TIF_SYSCALL_TRACEPOINT  27
> TIF_KGR_IN_PROGRESS_T   28
> 
> =====
> 
> Then make TIF_KGR_IN_PROGRESS_W fire when "tm"-ing _TIF_WORK in
> "__TI_flags+7". TIF_KGR_IN_PROGRESS_T will work along with _TIF_TRACE
> using "tm" on "__TI_flags+4".
> 
> What do you think?

Yes, that is what I had in mind. Feel free to reorder the TIF bits
in any way necessary. I have done that several times already.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
