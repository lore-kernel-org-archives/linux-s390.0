Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 09:03:07 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 08/12] s390/sclp: Use DECLARE_BITMAP
Message-ID: <20150520070307.GB3977@osiris>
References: <cover.1432085659.git.joe@perches.com>
 <2b099ee415c01294fdcf57393b2ee0c7a53860fe.1432085659.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b099ee415c01294fdcf57393b2ee0c7a53860fe.1432085659.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 19, 2015 at 06:37:56PM -0700, Joe Perches wrote:
> Use the generic mechanism to declare a bitmap instead of unsigned long.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/s390/char/sclp_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
