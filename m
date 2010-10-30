MIME-Version: 1.0
In-Reply-To: <AANLkTikXAde1yLZkB80GOjWu-sFZAvv0SL566rWssD1k@mail.gmail.com>
References: <4CCBC8B1.2080808@in.ibm.com> <AANLkTimE=uzwhDMz_-jVWKyb9NAONGuVvVo5KbjkkZVu@mail.gmail.com>
 <AANLkTikXAde1yLZkB80GOjWu-sFZAvv0SL566rWssD1k@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Oct 2010 08:17:41 -0700
Message-ID: <AANLkTinBNAUAh5uZ9V82zjv4uWH1UTXbUA2rPy1d2pCk@mail.gmail.com>
Subject: Re: [s390] 2.6.36-git14 build break - fs/compat.c :631
 (PAGE_CACHE_MASK undeclared)
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <torvalds@linux-foundation.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: wu zhangjin <wuzhangjin@gmail.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Oct 30, 2010 at 1:12 AM, wu zhangjin <wuzhangjin@gmail.com> wrote:
>
> (Seems Linus added that patch, add him in this loop)

My bad. It was such a totally obvious and trivial patch, and it
compiled for me on x86-64. Too bad our header include dependencies are
such a mess, and actually change from one architecture to another.

I'd love to fix up the header mess, but that's not going to happen. So
I'll take the <linux/filemap.h> addition.

Thanks,

                                  Linus
