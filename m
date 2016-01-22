Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+55aFzRWzc9YECcAf0OhQ2KJzsrbEuQCA2m=_RVO22++XDVBA@mail.gmail.com>
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
	<56A14EE4.1020008@fb.com>
	<20160121225127.GA30993@localhost.localdomain>
	<CA+55aFxbYLEj=aQtEu3X92m44dbREssAQeSG8ZfoLT_WL5_fkQ@mail.gmail.com>
	<20160122032135.GA9244@localhost.localdomain>
	<CA+55aFwGRQb_2SUTj8A9MzTC4WCVC37p64t5obUfTvLNyctjKA@mail.gmail.com>
	<20160122230605.22859608@tom-T450>
	<CA+55aFzRWzc9YECcAf0OhQ2KJzsrbEuQCA2m=_RVO22++XDVBA@mail.gmail.com>
Date: Sat, 23 Jan 2016 01:48:05 +0800
Message-ID: <CACVXFVOjqWqVyO-KbZ1TcWOBSwT=nG4onSuQHW7BOwKKjWGnKQ@mail.gmail.com>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
From: Ming Lei <tom.leiming@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Jan 23, 2016 at 1:03 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 22, 2016 at 7:06 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>>
>> Yes, it is one problem, something like below does fix my test
>> with 4K block size.
>
> It just doesn't look very legible.

OK, I will try to make it better.

>
> Also, how could this
>
>> -                       goto split;
>> +                       if (sectors)
>> +                               goto split;
>
> ever matter? If sectors is 0, something is seriously wrong afaik.

I guess that is possible because blk_max_size_offset() depends on
offset and may return a small size which is less than logical
block size.

--
Ming Lei
