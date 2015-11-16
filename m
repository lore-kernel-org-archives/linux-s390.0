Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Nov 2015 16:30:19 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: Delete unnecessary checks before the function call
 "debug_unregister"
Message-ID: <20151116153019.GD4069@osiris>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <5649E4F5.5060604@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5649E4F5.5060604@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 16, 2015 at 03:15:17PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 16 Nov 2015 14:45:40 +0100
> 
> The debug_unregister() function performs also input parameter validation.
> Thus the test around the calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/s390/cio/chsc_sch.c      | 3 +--
>  drivers/s390/cio/cio.c           | 9 +++------
>  drivers/s390/cio/qdio_debug.c    | 6 ++----
>  drivers/s390/crypto/zcrypt_api.c | 6 ++----
>  4 files changed, 8 insertions(+), 16 deletions(-)

Applied, thanks!
