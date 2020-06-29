Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Jun 2020 13:54:35 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] drivers/s390/char/tty3270: Remove function callback casts
Message-ID: <20200629115435.GB4468@osiris>
References: <20200627125417.18887-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627125417.18887-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oscar Carter <oscar.carter@gmx.com>
Cc: Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kernel-hardening@lists.openwall.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 02:54:17PM +0200, Oscar Carter wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, remove all the function callback
> casts.
> 
> To do this modify the function prototypes accordingly.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/s390/char/tty3270.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks!
