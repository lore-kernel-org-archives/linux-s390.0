Return-Path: <pmladek@suse.com>
Date: Tue, 3 May 2016 11:39:11 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v2 15/18] livepatch: move patching functions into
 patch.c
Message-ID: <20160503093911.GP2749@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <845d0955aafe642e33e1bb9f1dbc5819d0f926f3.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <845d0955aafe642e33e1bb9f1dbc5819d0f926f3.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-04-28 15:44:46, Josh Poimboeuf wrote:
> Move functions related to the actual patching of functions and objects
> into a new patch.c file.
> 
> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> new file mode 100644
> index 0000000..782fbb5
> --- /dev/null
> +++ b/kernel/livepatch/patch.c
> @@ -0,0 +1,213 @@
> +/*
> + * patch.c - livepatch patching functions
> + *
> + * Copyright (C) 2014 Seth Jennings <sjenning@redhat.com>
> + * Copyright (C) 2014 SUSE
> + * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com
                                                         ^^^^^^

Missing '>' ;-)

Best Regards,
Petr
