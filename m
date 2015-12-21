Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 21 Dec 2015 10:48:00 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: char: constify hmcdrv_ftp_ops structs
Message-ID: <20151221094800.GB4058@osiris>
References: <20151213185149.GA24510@waves>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151213185149.GA24510@waves>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Julia Lawall <julia.lawall@lip6.fr>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Dec 13, 2015 at 08:51:49PM +0200, Aya Mahfouz wrote:
> Constifies hmcdrv_ftp_ops structures in s390's char
> driver since they are not modified after their
> initialization.
> 
> Detected and found using Coccinelle.
> 
> Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
> ---
>  drivers/s390/char/hmcdrv_ftp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
