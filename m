Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Sep 2017 16:22:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390/char: Fix cdev_add usage
References: <20170918111313.1fc7126e@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918111313.1fc7126e@endymion>
Message-Id: <20170918142240.GF4649@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Sep 18, 2017 at 11:13:13AM +0200, Jean Delvare wrote:
> Function cdev_add does set cdev->dev, so there is no point in setting
> it prior to calling this function.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> Untested. Changes since v1 (2016-07-13):
>  * Improved description
>  * Added a few blank lines to make the code more readable
> 
>  drivers/s390/char/tape_class.c |    3 +--
>  drivers/s390/char/vmlogrdr.c   |    4 ++--
>  drivers/s390/char/vmur.c       |    4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)

Applied, however without the extra blank lines ;)
Thanks!
