Return-Path: <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 02/15] x86/entry: define _TIF_ALLWORK_MASK flags
 explicitly
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <b03212d03f5f112ffa778c30012c7f8301f64929.1481220077.git.jpoimboe@redhat.com>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:19:31 +0530
MIME-Version: 1.0
In-Reply-To: <b03212d03f5f112ffa778c30012c7f8301f64929.1481220077.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <7315bfd9-f6aa-9cf9-b262-da1a600a65be@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thursday 08 December 2016 11:38 PM, Josh Poimboeuf wrote:
> The _TIF_ALLWORK_MASK macro automatically includes the least-significant
> 16 bits of the thread_info flags, which is less than obvious and tends
> to create confusion and surprises when reading or modifying the code.
>
> Define the flags explicitly.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

For the version with swapped _TIF_SINGLESTEP and _TIF_NEED_RESCHED
flags.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
cheers,
Kamalesh.
