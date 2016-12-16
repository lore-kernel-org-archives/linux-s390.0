Return-Path: <pmladek@suse.com>
Date: Fri, 16 Dec 2016 17:00:57 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 05/15] livepatch/powerpc: add TIF_PATCH_PENDING thread
 flag
Message-ID: <20161216160057.GG393@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <e675e8f368e7d580d7dc0fb7022fea49e55eb1cf.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e675e8f368e7d580d7dc0fb7022fea49e55eb1cf.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-12-08 12:08:30, Josh Poimboeuf wrote:
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

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
