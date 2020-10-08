Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729840AbgJHONp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:13:45 -0400
Date: Thu, 8 Oct 2020 16:13:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 04/10] s390/dasd: Remove unused parameter from
 dasd_generic_probe()
Message-ID: <20201008161336.4fd47919.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-5-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-5-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  8 Oct 2020 15:13:30 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> The discipline argument in dasd_generic_probe() isn't used and there is
> no history how it was used in the past. Remove it.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd.c      | 3 +--
>  drivers/s390/block/dasd_eckd.c | 2 +-
>  drivers/s390/block/dasd_fba.c  | 2 +-
>  drivers/s390/block/dasd_int.h  | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
