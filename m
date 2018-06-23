Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-3-pasha.tatashin@oracle.com> <20180623091648.GA29468@zn.tnic>
In-Reply-To: <20180623091648.GA29468@zn.tnic>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Sat, 23 Jun 2018 09:11:36 -0400
Message-ID: <CAGM2reYWb4bHzydh4PQj9vZfjaX+BQ_hTJiB3krJ-3AhC2MvuA@mail.gmail.com>
Subject: Re: [PATCH v12 02/11] x86: initialize static branching early
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: bp@alien8.de
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Borislav,

>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thank you.

>
> Also, please take the patch below into your queue and keep it a separate
> patch in case we have to revert it later. It should help in keeping the
> mess manageable and not let it go completely out of control before we've
> done the cleanup.

OK. I will include it into the next itiration. Once I get some more
feedback from Thomas and Peter.

Pavel
