Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbfKNQvZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:51:25 -0500
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
 <db451544-fcb1-9d81-7042-ef91c8324204@linux.ibm.com>
 <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75b72389-eec5-200f-01af-512d1294f137@redhat.com>
Date: Thu, 14 Nov 2019 17:51:09 +0100
MIME-Version: 1.0
In-Reply-To: <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 14/11/2019 17.38, Pierre Morel wrote:
[...]
>>> +static char buffer[4096];
>>> +
>>> +static void delay(int d)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int i, j;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 while (d--)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 1000000; i; i--)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for=
 (j =3D 1000000; j; j--)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ;
>>> +}
>> You could set a timer.
>=20
> Hum, do we really want to do this?

I'm pretty sure that the compiler optimizes empty loops away. Maybe have
a look at the disassembly of your delay function...

Anyway, it's likely better to use STCK and friends to get a proper
timing. You could move get_clock_ms() from s390x/intercept.c to the
lib/s390x folder and then use that function here.

 Thomas
