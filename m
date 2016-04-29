Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <6360fe5cab85aad424600518f645a9ac773cc72e.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <6360fe5cab85aad424600518f645a9ac773cc72e.1461875890.git.jpoimboe@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 29 Apr 2016 11:08:04 -0700
Message-ID: <CALCETrWj8doini-xtONoRX0=OzQL=HFxnPKrEL_7kdoZZT-Uug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/18] livepatch/x86: add TIF_PATCH_PENDING thread
 flag
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 28, 2016 at 1:44 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
> per-task consistency model for x86_64.  The bit getting set indicates
> the thread has a pending patch which needs to be applied when the thread
> exits the kernel.
>
> The bit is placed in the least-significant word of the thread_info flags

NAK to that part.

The least-significant word thing is a huge hack that has gotten out of
control.  Please add the thing explicitly to all relevant masks.

--Andy
