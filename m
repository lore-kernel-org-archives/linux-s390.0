Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27782 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728499AbgH1IKU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Aug 2020 04:10:20 -0400
Date: Fri, 28 Aug 2020 10:10:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 01/16] s390/vfio-ap: add version vfio_ap module
Message-ID: <20200828101002.57c0d81f.cohuck@redhat.com>
In-Reply-To: <8b3eb14e-c388-3025-1bfb-2dc7fb820de3@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-2-akrowiak@linux.ibm.com>
        <20200825120432.13a1b444.cohuck@redhat.com>
        <ca016eca-1ee7-2d0f-c2ec-3ef147b6216a@linux.ibm.com>
        <20200827123240.42e0c787.cohuck@redhat.com>
        <8b3eb14e-c388-3025-1bfb-2dc7fb820de3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

On Thu, 27 Aug 2020 10:39:07 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Currently there are two tools that probably need to be aware of
> the changes to these assignment interfaces:
> * The hades test framework has tests that will fail if run against
>  =C2=A0=C2=A0 these patches that should be skipped if over-provisioning is
>  =C2=A0=C2=A0 allowed. There are also tests under development to test the
>  =C2=A0=C2=A0 function introduced by these patches that will fail if run =
against
>  =C2=A0=C2=A0 an older version of the driver. These tests should be skipp=
ed in
>  =C2=A0=C2=A0 that case.
> * There is a tool under development for configuring AP matrix
>  =C2=A0=C2=A0 mediated devices that probably need to be aware of the chan=
ge
>  =C2=A0=C2=A0 introduced by this series.
>=20
> Since a tool would have to first determine whether a new sysfs
> interface documenting facilities is available and it would only
> expose one facility at this point, it seems reasonable for these tools
> to check for the sysfs guest_matrix attribute to discern whether
> over-provisioning is available or not. I'll go ahead and remove this
> patch from the series.

Thanks for the explanation, that seems reasonable to me.
