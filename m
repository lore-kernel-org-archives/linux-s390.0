Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbfKSMdo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 07:33:44 -0500
Date: Tue, 19 Nov 2019 13:33:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 01/10] vfio-ccw: Introduce new helper functions
 to free/destroy regions
Message-ID: <20191119133335.6cfff081.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-2-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-2-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:11 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> Consolidate some of the cleanup code for the regions, so that
> as more are added we reduce code duplication.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - Commit message
>=20
>  drivers/s390/cio/vfio_ccw_drv.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)

Makes sense.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
