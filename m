Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Dec 2016 12:09:45 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] s390/zcore: Remove unneeded linux/miscdevice.h
 include
References: <20161215141824.3297-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161215141824.3297-1-clabbe.montjoie@gmail.com>
Message-Id: <20161216110945.GA5591@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: maier@linux.vnet.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 15, 2016 at 03:18:23PM +0100, Corentin Labbe wrote:
> drivers/s390/char/zcore.c does not contain any miscdevice so the
> inclusion of linux/miscdevice.h is uncessary.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/s390/char/zcore.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
