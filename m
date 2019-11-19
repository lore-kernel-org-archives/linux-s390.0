Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727805AbfKSRTA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 12:19:00 -0500
Date: Tue, 19 Nov 2019 18:18:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 07/10] vfio-ccw: Refactor IRQ handlers
Message-ID: <20191119181852.33c84c40.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-8-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-8-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:17 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> To simplify future expansion.
>=20
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_ops.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
