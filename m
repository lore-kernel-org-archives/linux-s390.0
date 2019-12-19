Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60638 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfLSJah (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 04:30:37 -0500
Date: Thu, 19 Dec 2019 10:30:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/3] s390/dasd: fix typo in copyright statement
Message-ID: <20191219103026.75037abe.cohuck@redhat.com>
In-Reply-To: <20191219084352.75114-4-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
        <20191219084352.75114-4-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On Thu, 19 Dec 2019 09:43:52 +0100
Stefan Haberland <sth@linux.ibm.com> wrote:

> coypright -> copyright
> 
> Reported-by: Kate Stewart <kstewart@linuxfoundation.org>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_fba.h  | 2 +-
>  drivers/s390/block/dasd_proc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_fba.h b/drivers/s390/block/dasd_fba.h
> index 8f75df06e893..45ddabec4017 100644
> --- a/drivers/s390/block/dasd_fba.h
> +++ b/drivers/s390/block/dasd_fba.h
> @@ -2,7 +2,7 @@
>  /*
>   * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
>   * Bugreports.to..: <Linux390@de.ibm.com>

No comment on the actual patch; but do you really still want people to
send bug reports to that address?

(A quick grep shows that it is mostly present in the dasd code, but also
in some other code parts.)

> - * Coypright IBM Corp. 1999, 2000
> + * Copyright IBM Corp. 1999, 2000
>   *
>   */
>  
> diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
> index 1770b99f607e..8d4d69ea5baf 100644
> --- a/drivers/s390/block/dasd_proc.c
> +++ b/drivers/s390/block/dasd_proc.c
> @@ -5,7 +5,7 @@
>   *		    Carsten Otte <Cotte@de.ibm.com>
>   *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
>   * Bugreports.to..: <Linux390@de.ibm.com>
> - * Coypright IBM Corp. 1999, 2002
> + * Copyright IBM Corp. 1999, 2002
>   *
>   * /proc interface for the dasd driver.
>   *
