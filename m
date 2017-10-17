Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 10:59:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/sclp: Convert timers to use timer_setup()
In-Reply-To: <20171016234430.GA102114@beast>
References: <20171016234430.GA102114@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171017105910.5735a5b9@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Oct 2017 16:44:30 -0700
Kees Cook <keescook@chromium.org> wrote:

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. Instead of creating an external static
> data variable, just define a separate callback which encodes the "force
> restart" desire.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/char/con3215.c    |  6 +++---
>  drivers/s390/char/con3270.c    | 10 +++++-----
>  drivers/s390/char/sclp.c       | 45 ++++++++++++++++++++++++------------------
>  drivers/s390/char/sclp_con.c   |  5 ++---
>  drivers/s390/char/sclp_tty.c   |  5 ++---
>  drivers/s390/char/sclp_vt220.c |  6 ++----
>  drivers/s390/char/tape_core.c  | 14 ++++---------
>  drivers/s390/char/tty3270.c    |  8 ++++----
>  8 files changed, 48 insertions(+), 51 deletions(-)

Applied to s390/linux:feature branch. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
