Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29671 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727456AbfKSQVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 11:21:20 -0500
Date: Tue, 19 Nov 2019 17:21:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 04/10] vfio-ccw: Refactor the unregister of the
 async regions
Message-ID: <20191119172110.54ef5cda.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-5-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:14 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> This is mostly for the purposes of a later patch, since
> we'll need to do the same thing later.
>=20
> While we are at it, move the resulting function call to ahead
> of the unregistering of the IOMMU notifier, so that it's done
> in the reverse order of how it was created.
>=20
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_ops.c     | 20 ++++++++++++--------
>  drivers/s390/cio/vfio_ccw_private.h |  1 +
>  2 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
