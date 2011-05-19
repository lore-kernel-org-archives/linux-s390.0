Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1305824936.1465.4.camel@gandalf.stny.rr.com>
References: <1305824936.1465.4.camel@gandalf.stny.rr.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 19 May 2011 15:18:08 -0400
Message-ID: <BANLkTinj5BbdKUun4ne9sY-5vE=0ZoLciQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] maccess,probe_kernel: Make write/read src const void *
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 19, 2011 at 13:08, Steven Rostedt <rostedt@goodmis.org> wrote:
> maccess,probe_kernel: Make src const void *
>
> The functions probe_kernel_write() and probe_kernel_read() do not modify
> the src pointer. Allow const pointers to be passed in without the need
> of a typecast.
>
>  arch/blackfin/mm/maccess.c |    4 ++--

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
