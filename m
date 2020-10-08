Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730538AbgJHOtT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:49:19 -0400
Date: Thu, 8 Oct 2020 16:48:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 09/10] s390/dasd: Prepare for additional path event
 handling
Message-ID: <20201008164856.6b61f2ba.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-10-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-10-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  8 Oct 2020 15:13:35 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> As more path events need to be handled for ECKD the current path
> verification infrastructure can be reused. Rename all path verifcation
> code to fit the more broadly based task of path event handling and put
> the path verification in a new separate function.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd.c      |  4 +-
>  drivers/s390/block/dasd_eckd.c | 78 +++++++++++++++++++---------------
>  drivers/s390/block/dasd_int.h  |  1 +
>  3 files changed, 47 insertions(+), 36 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
