Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Jun 2014 09:13:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: avoid format strings leaking into names
Message-ID: <20140611071303.GA4296@osiris>
References: <20140610174620.GA30139@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140610174620.GA30139@www.outflux.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kent Overstreet <kmo@daterainc.com>, Tejun Heo <tj@kernel.org>, Geoff Levand <geoff@infradead.org>, Stefan Weinhuber <wein@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 10, 2014 at 10:46:20AM -0700, Kees Cook wrote:
> This makes sure format strings can't accidentally leak into kernel
> interface names.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/s390/block/dcssblk.c     |    2 +-
>  drivers/s390/char/vmlogrdr.c     |    2 +-
>  drivers/s390/crypto/zcrypt_api.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks!
