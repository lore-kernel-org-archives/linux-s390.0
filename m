Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 Oct 2017 11:13:53 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390: qdio: Convert timers to use timer_setup()
In-Reply-To: <20171005005435.GA23979@beast>
References: <20171005005435.GA23979@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1710051107190.1796@schleppi>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 Oct 2017, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.

> -void qdio_outbound_timer(unsigned long data)
> +void qdio_outbound_timer(struct timer_list *t)
>  {
> -	struct qdio_q *q = (struct qdio_q *)data;
> +	struct qdio_q *q = from_timer(q, t, o.out.timer);
                                            ^
                             this should be u.out.timer

Will be applied to s390/linux.git

Thanks,
Sebastian
