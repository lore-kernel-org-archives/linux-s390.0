Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 10:58:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/cio: Convert timers to use timer_setup()
In-Reply-To: <20171016234325.GA102019@beast>
References: <20171016234325.GA102019@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171017105847.2dbd7be7@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Oct 2017 16:43:25 -0700
Kees Cook <keescook@chromium.org> wrote:

> In preparation for unconditionally passing the struct timer_list
> pointer to all timer callbacks, switch to using the new timer_setup()
> and from_timer() to pass the timer pointer explicitly.
> 
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/cio/device.c     |  8 ++++----
>  drivers/s390/cio/device.h     |  2 ++
>  drivers/s390/cio/device_fsm.c | 10 ++++------
>  drivers/s390/cio/eadm_sch.c   |  9 ++++-----
>  4 files changed, 14 insertions(+), 15 deletions(-)

Applied to s390/linux:feature branch. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
