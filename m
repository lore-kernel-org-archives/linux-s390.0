Return-Path: <mbenes@suse.cz>
Date: Wed, 21 Dec 2016 16:29:19 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 06/15] livepatch/s390: reorganize TIF thread flag bits
In-Reply-To: <f57460426b267792f44e9d11d6a95814e1af61fd.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1612211628310.14423@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <f57460426b267792f44e9d11d6a95814e1af61fd.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 8 Dec 2016, Josh Poimboeuf wrote:

> From: Jiri Slaby <jslaby@suse.cz>
> 
> Group the TIF thread flag bits by their inclusion in the _TIF_WORK and
> _TIF_TRACE macros.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

I believe there is no harm doing that and we need it for 
_TIF_PATCH_PENDING later.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
