Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393605AbhARRbr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 12:31:47 -0500
Date: Mon, 18 Jan 2021 18:30:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/1] s390/dasd: Fix inconsistent kobject removal
Message-ID: <20210118183009.43f5c037.cohuck@redhat.com>
In-Reply-To: <20210118165518.14578-2-sth@linux.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
        <20210118165518.14578-2-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, 18 Jan 2021 17:55:18 +0100
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> Our intention was to only remove path kobjects whenever a device is
> being set offline. However, one corner case was missing.
>=20
> If a device is disabled and enabled (using the IOCTLs BIODASDDISABLE and
> BIODASDENABLE respectively), the enabling process will call
> dasd_eckd_reload_device() which itself calls dasd_eckd_read_conf() in
> order to update path information. During that update,
> dasd_eckd_clear_conf_data() clears all old data and also removes all
> kobjects. This will leave us with an inconsistent state of path kobjects
> and a subsequent path verification leads to a failing kobject creation.
>=20
> Fix this by removing kobjects only in the context of offlining a device
> as initially intended.
>=20
> Fixes: 19508b204740 ("s390/dasd: Display FC Endpoint Security information=
 via sysfs")
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
>  drivers/s390/block/dasd_eckd.c   |  3 ++-
>  drivers/s390/block/dasd_int.h    |  2 +-
>  3 files changed, 17 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
