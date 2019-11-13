Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29858 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726949AbfKMLtB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 06:49:01 -0500
Date: Wed, 13 Nov 2019 12:48:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
Message-ID: <20191113124849.316a7b3b.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-5-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-5-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:26 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> +/*
> + * Generic cmd executor for calls that only transport the cpu or guest
> + * handle and the command.
> + */
> +static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret)
> +{
> +=09int rc;
> +=09struct uv_cb_nodata uvcb =3D {
> +=09=09.header.cmd =3D cmd,
> +=09=09.header.len =3D sizeof(uvcb),
> +=09=09.handle =3D handle,
> +=09};
> +
> +=09WARN(!handle, "No handle provided to Ultravisor call cmd %x\n", cmd);
> +=09rc =3D uv_call(0, (u64)&uvcb);
> +=09if (ret)
> +=09=09*ret =3D *(u32 *)&uvcb.header.rc;
> +=09return rc ? -EINVAL : 0;

Why go ahead with doing the uv call if it doesn't have a handle anyway?
Or why warn, if you already know it is going to fail? I assume this can
only happen if you have a logic error in the kvm code?

> +}
