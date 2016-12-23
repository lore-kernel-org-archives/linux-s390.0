Return-Path: <mbenes@suse.cz>
Date: Fri, 23 Dec 2016 14:06:27 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 10/15] livepatch: move patching functions into patch.c
In-Reply-To: <e2886115107c9866221896574fa45fdd6e8b0f37.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1612231405520.5990@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <e2886115107c9866221896574fa45fdd6e8b0f37.1481220077.git.jpoimboe@redhat.com>
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

> Move functions related to the actual patching of functions and objects
> into a new patch.c file.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
