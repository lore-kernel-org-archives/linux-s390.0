Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 10:59:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/scsi: Convert timers to use timer_setup()
In-Reply-To: <20171016234434.GA102128@beast>
References: <20171016234434.GA102128@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20171017105942.2a231cdd@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Oct 2017 16:44:34 -0700
Kees Cook <keescook@chromium.org> wrote:

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Steffen Maier <maier@linux.vnet.ibm.com>
> Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/scsi/zfcp_erp.c | 16 ++++++++++------
>  drivers/s390/scsi/zfcp_ext.h |  2 +-
>  drivers/s390/scsi/zfcp_fsf.c | 13 ++++++-------
>  3 files changed, 17 insertions(+), 14 deletions(-)

I have applied this to our internal git tree for Steffen to pick up.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
