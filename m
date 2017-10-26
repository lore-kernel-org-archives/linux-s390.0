Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Oct 2017 08:38:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/ap_bus: Convert timers to use timer_setup()
In-Reply-To: <20171025102737.GA145851@beast>
References: <20171025102737.GA145851@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171026083842.5ca46b2f@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Harald Freudenberger <freude@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 25 Oct 2017 03:27:37 -0700
Kees Cook <keescook@chromium.org> wrote:

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Harald Freudenberger <freude@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/crypto/ap_bus.c   | 10 +++++-----
>  drivers/s390/crypto/ap_bus.h   |  2 +-
>  drivers/s390/crypto/ap_queue.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

Parked for the second part of the s390 updates for the next merge window.
Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
