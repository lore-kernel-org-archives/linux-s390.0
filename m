Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160331145724.13258ddb@mschwide>
References: <20160331145724.13258ddb@mschwide>
Date: Thu, 31 Mar 2016 07:59:56 -0500
Message-ID: <CA+55aFyEDjfDd_Ni3ZUcf4jkwBYvuLZOdmWP-FnRgchW1hj5OQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 4.6-rc2
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 31, 2016 at 7:57 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> to receive the following updates:
>
> * An interface for dasd driver to query if a volume is online to
>   another operating system
> * A proper fix for the lcu locking issue in the dasd driver
> * Add the new preadv2 and pwritev2 system calls
> * Define the mark_rodata_ro function and set DEBUG_RODATA=y
> * A few more bug fixes.

I'm not seeing that the dasd changes are bugfixes.

Not pulled. You can try to explain more, but on the whole this looks
more like a new feature than anything else.

             Linus
