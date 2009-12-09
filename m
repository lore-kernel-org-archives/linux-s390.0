Return-Path: <linux-kernel-owner+w=401wt.eu-S1757998AbZLIUva@vger.kernel.org>
Date: Wed, 9 Dec 2009 21:51:12 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: ptrace: don't abuse PT_PTRACED
Message-ID: <20091209205112.GB4351@osiris.boeblingen.de.ibm.com>
References: <20091209194651.GA24919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091209194651.GA24919@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Dec 09, 2009 at 08:46:51PM +0100, Oleg Nesterov wrote:
> Untested, but hopefully trivial enough and should't change the
> compiled code.
> 
> Nobody except ptrace itself should use task->ptrace or PT_PTRACED
> directly, change arch/s390/kernel/traps.c to use the helper.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Roland McGrath <roland@redhat.com>

> -	if ((current->ptrace & PT_PTRACED) != 0)
> +	if (tracehook_consider_fatal_signal(current, SIGTRAP))
>  		force_sig(SIGTRAP, current);

Thanks, applied. Even though I'm wondering why tracehook_consider_fatal_signal
has a signal parameter and doesn't do anything with it.
Is that something that will change with utrace?
