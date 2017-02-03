Return-Path: <mbenes@suse.cz>
Date: Fri, 3 Feb 2017 17:41:28 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1702031724040.28531@pobox.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
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
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


Petr has already mentioned majority of things I too found out, so only 
couple of nits...

> diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
> index da87f43..24b6570 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-livepatch
> +++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
> @@ -25,6 +25,14 @@ Description:
>  		code is currently applied.  Writing 0 will disable the patch
>  		while writing 1 will re-enable the patch.
>  
> +What:		/sys/kernel/livepatch/<patch>/transition
> +Date:		May 2016

'May 2016' looks strange, but maybe nobody cares about it...

> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> index 7f04e13..fb00d66 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
>  4. Livepatch module
> @@ -134,7 +242,7 @@ Documentation/livepatch/module-elf-format.txt for more details.
>  
>  
>  4.2. Metadata
> -------------
> +-------------

klp_func and klp_patch have new members - immediate. Should be documented 
here in "4.2. Metadata" section.

The section also contains this text under klp_patch bullet. It seems 
oudated:

"Also if a more complex consistency model is supported then a selected 
unit (thread, kernel as a whole) will see the new code from the entire 
patch only when it is in a safe state."

We now have a more complex consistency model.

And finally, the section "Limitations" has this text under the first 
bullet:

  + The patch must not change the semantic of the patched functions.

    The current implementation guarantees only that either the old
    or the new function is called. The functions are patched one
    by one. It means that the patch must _not_ change the semantic
    of the function.

I think it is confusing. The consistency model allows us to change the 
semantic of a function. To certain degree. Of course, there are cases that 
cannot be patched, or have to be patched carefully. For example if a 
function takes a lock by calling foo_lock(), foo_lock() is not on a stack 
afterwards. Then the locking semantics may be changed with a livepatch. 
One has to make sure to patch also the caller foo_lock() to enforce the 
consistency. And so on... But I do not consider a limitation of livepatch. 
It is a feature of the consistency model, which is weaker than kGraft's or 
kpatch's (or stronger. It depends on your point of view.)

So, I propose to remove this text and better describe the properties of 
the consistency model above in the section 3. Maybe a quote from an old 
mail thread (Nov 2014) would be sufficient. I don't remember what was 
mentioned and what not.

What do you think?

> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 6602b34..ed90ad1 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -68,7 +92,7 @@ struct klp_func {
>   * @funcs:	function entries for functions to be patched in the object
>   * @kobj:	kobject for sysfs resources
>   * @mod:	kernel module associated with the patched object
> - * 		(NULL for vmlinux)
> + *		(NULL for vmlinux)

This looks superfluous.

(checking my notes)... and that's it. Aside from the discussion in Petr's 
subthread it looks good to me. Great job.

Thanks,
Miroslav
