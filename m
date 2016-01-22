Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160122230605.22859608@tom-T450>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
	<56A14EE4.1020008@fb.com>
	<20160121225127.GA30993@localhost.localdomain>
	<CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
	<20160122032135.GA9244@localhost.localdomain>
	<CA+55aFwGRQb_2SUTj8A9MzTC4WCVC37p64t5obUfTvLNyctjKA@mail.gmail.com>
	<20160122230605.22859608@tom-T450>
Date: Fri, 22 Jan 2016 09:03:12 -0800
Message-ID: <CA+55aFzRWzc9YECcAf0OhQ2KJzsrbEuQCA2m=_RVO22++XDVBA@mail.gmail.com>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 22, 2016 at 7:06 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>
> Yes, it is one problem, something like below does fix my test
> with 4K block size.

It just doesn't look very legible.

Also, how could this

> -                       goto split;
> +                       if (sectors)
> +                               goto split;

ever matter? If sectors is 0, something is seriously wrong afaik.

              Linus
