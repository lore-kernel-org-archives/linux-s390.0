Return-Path: <brgerst@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9268772b31cc7bc4dc40c617e3baf45e07322145.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <9268772b31cc7bc4dc40c617e3baf45e07322145.1461875890.git.jpoimboe@redhat.com>
Date: Fri, 29 Apr 2016 14:46:10 -0400
Message-ID: <CAMzpN2hLWx4pp7_TwZ_KBStS7T7_Nvxjtf0k3679gq8VAh33uA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/18] x86/asm/head: standardize the bottom of the
 stack for idle tasks
From: Brian Gerst <brgerst@gmail.com>
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
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 28, 2016 at 4:44 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> Thanks to all the recent x86 entry code refactoring, most tasks' kernel
> stacks start at the same offset right above their saved pt_regs,
> regardless of which syscall was used to enter the kernel.  That creates
> a nice convention which makes it straightforward to identify the
> "bottom" of the stack, which can be useful for stack walking code which
> needs to verify the stack is sane.
>
> However there are still a few types of tasks which don't yet follow that
> convention:
>
> 1) CPU idle tasks, aka the "swapper" tasks
>
> 2) freshly forked TIF_FORK tasks which don't have a stack at all
>
> Make the idle tasks conform to the new stack bottom convention by
> starting their stack at a sizeof(pt_regs) offset from the end of the
> stack page.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kernel/head_64.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 6dbd2c0..0b12311 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -296,8 +296,9 @@ ENTRY(start_cpu)
>          *      REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
>          *              address given in m16:64.
>          */
> -       movq    initial_code(%rip),%rax
> -       pushq   $0              # fake return address to stop unwinder
> +       call    1f              # put return address on stack for unwinder
> +1:     xorq    %rbp, %rbp      # clear frame pointer
> +       movq    initial_code(%rip), %rax
>         pushq   $__KERNEL_CS    # set correct cs
>         pushq   %rax            # target address in negative space
>         lretq

This chunk looks like it should be a separate patch.

--
Brian Gerst
