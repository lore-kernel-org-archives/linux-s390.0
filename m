Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730538AbgJHOyh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:54:37 -0400
Date: Thu, 8 Oct 2020 16:54:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 10/10] s390/dasd: Process FCES path event
 notification
Message-ID: <20201008165428.40044398.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-11-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-11-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  8 Oct 2020 15:13:36 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> If the Fibre Channel Endpoint-Security status of a path changes, a
> corresponding path event is received from the CIO layer.
>=20
> Process this event by re-reading the FCES information.
>=20
> As the information is retrieved for all paths on a single CU in one
> call, the internal status can also be updated for all paths and no
> processing per path is necessary.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd.c      | 19 +++++++++++----
>  drivers/s390/block/dasd_eckd.c | 12 +++++++---
>  drivers/s390/block/dasd_int.h  | 42 +++++++++++++++++++++++++++++++++-
>  3 files changed, 64 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
