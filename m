Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55347 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfLMJoG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Dec 2019 04:44:06 -0500
Date: Fri, 13 Dec 2019 10:43:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 8/9] s390x: css: ssch/tsch with sense
 and interrupt
Message-ID: <20191213104350.6ebe4aa6.cohuck@redhat.com>
In-Reply-To: <96034dbc-489a-7f76-0402-d5c0c42d20b3@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
        <1576079170-7244-9-git-send-email-pmorel@linux.ibm.com>
        <20191212132634.3a16a389.cohuck@redhat.com>
        <1ea58644-9f24-f547-92d5-a99dcb041502@linux.ibm.com>
        <96034dbc-489a-7f76-0402-d5c0c42d20b3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 12 Dec 2019 19:20:07 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2019-12-12 15:10, Pierre Morel wrote:
> >=20
> >=20
> > On 2019-12-12 13:26, Cornelia Huck wrote: =20
> >> On Wed, 11 Dec 2019 16:46:09 +0100
> >> Pierre Morel <pmorel@linux.ibm.com> wrote:

> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 senseid.cu_type =3D buffer[2] | (buffer[1] << 8);=
 =20
> >>
> >> This still looks odd; why not have the ccw fill out the senseid
> >> structure directly? =20
> >=20
> > Oh sorry, you already said and I forgot to modify this.
> > thanks =20
>=20
> hum, sorry, I forgot, the sense structure is not padded so I need this.

Very confused; I see padding in the senseid structure? (And what does
padding have to do with it?)

Also, you only copy the cu type... it would really be much better if
you looked at the whole structure you got back from the hypervisor;
that would also allow you to do some more sanity checks etc. If you
really can't pass in a senseid structure directly, just copy everything
you got?
