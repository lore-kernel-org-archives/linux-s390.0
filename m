Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729992AbgJHOQt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:16:49 -0400
Date: Thu, 8 Oct 2020 16:16:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 05/10] s390/dasd: Move duplicate code to separate
 function
Message-ID: <20201008161637.2dbb321c.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-6-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-6-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  8 Oct 2020 15:13:31 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> For storing retrieved path information both the if and else block in
> dasd_eckd_read_conf() use the same code. To avoid duplicate code this
> should be done after the if/else block. To further increase readability,
> move the code to a new function, dasd_eckd_store_conf_data().
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 42 ++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
