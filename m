Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 21 Jan 2019 14:12:10 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190121122131.GG4020@osiris>
Message-ID: <alpine.DEB.2.21.1901211411290.1582@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190121122131.GG4020@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Jan 2019, Heiko Carstens wrote:

> Hi Thomas,
> 
> [full quote below]
> 
> Did you have any time to look into this yet? :)
> 
> The warning is still reproducible.

Yeah, it's on my list of stuff which I need to take care of urgently. In
the next couple of days I hope...

Thanks,

	tglx
