Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 05/15] livepatch/powerpc: add TIF_PATCH_PENDING thread
 flag
In-Reply-To: <69e7b24fd0bcf912aa1ea6071d0a345901b3c741.1487036215.git.jpoimboe@redhat.com>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <69e7b24fd0bcf912aa1ea6071d0a345901b3c741.1487036215.git.jpoimboe@redhat.com>
Date: Wed, 08 Mar 2017 15:02:54 +1100
Message-ID: <87d1dsjtzl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
> per-task consistency model for powerpc.  The bit getting set indicates
> the thread has a pending patch which needs to be applied when the thread
> exits the kernel.
>
> The bit is included in the _TIF_USER_WORK_MASK macro so that
> do_notify_resume() and klp_update_patch_state() get called when the bit
> is set.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/thread_info.h | 4 +++-
>  arch/powerpc/kernel/signal.c           | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

The arch changes here seem fine. I haven't tested the whole series
though.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
