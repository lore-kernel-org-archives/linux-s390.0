Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 23 Jul 2018 10:28:41 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
Message-ID: <20180723102841.58ea373b@alans-desktop>
In-Reply-To: <ae3e5320-b389-e8af-2905-1ccc37953da3@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
        <20180718022211.6259-21-pasha.tatashin@oracle.com>
        <20180719103340.GA2494@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1807191300150.1602@nanos.tec.linutronix.de>
        <4295075b-8a0f-1723-2e80-1bbd2f038846@oracle.com>
        <alpine.DEB.2.21.1807191817080.1693@nanos.tec.linutronix.de>
        <CAGM2reYpApca9v-2qpVbTGXGVWiEEL5mkEWzTAvXFiztmtkh1Q@mail.gmail.com>
        <CAGM2rebBN0v0epfTssM=ShiWZ4GTDaN_cgGWdKE4+k+jV6CxyA@mail.gmail.com>
        <alpine.DEB.2.21.1807192240260.1693@nanos.tec.linutronix.de>
        <ae3e5320-b389-e8af-2905-1ccc37953da3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> >> If we determined tsc early in boot using one of the quick methods:
> >> from cpuid/msr/quick_pit, can we assume that frequencies of all other
> >> CPUs will be determined the same way? Or do we still have to fallback

Not on 32bit at least. You can have a mixed slot 1 SMP system such as
an ASUS BP6 with cores at say 300 and 450MHz.

Now whether you'll find any such system in the world today is another
question.

Alan
