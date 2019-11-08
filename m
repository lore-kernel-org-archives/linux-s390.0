Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728513AbfKHJfn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Nov 2019 04:35:43 -0500
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: SCLP unit test
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
 <1572023194-14370-6-git-send-email-imbrenda@linux.ibm.com>
 <191dbc7f-74b2-6f78-a721-aaac49895948@linux.ibm.com>
 <20191104121901.3b3ab68b@p-imbrenda.boeblingen.de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4344967-54d2-5b57-8d36-dd1361654c8e@redhat.com>
Date: Fri, 8 Nov 2019 10:35:32 +0100
MIME-Version: 1.0
In-Reply-To: <20191104121901.3b3ab68b@p-imbrenda.boeblingen.de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com

On 04/11/2019 12.19, Claudio Imbrenda wrote:
> On Mon, 4 Nov 2019 10:45:07 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
[...]
>>> +static void test_toolong(void)
>>> +{
>>> +=09uint32_t cmd =3D SCLP_CMD_WRITE_EVENT_DATA;
>>> +=09uint16_t res =3D SCLP_RC_SCCB_BOUNDARY_VIOLATION;
>>
>> Why use variables for constants that are never touched?
>=20
> readability mostly. the names of the constants are rather long.
> the compiler will notice it and do the Right Thing=E2=84=A2

I'd like to suggest to add the "const" keyword to both variables in that=20
case, then it's clear that they are not used to be modified.

>>> +=09=09h->length =3D 4096;
>>> +
>>> +=09=09valid_code =3D commands[i];
>>> +=09=09cc =3D sclp_service_call(commands[i], h);
>>> +=09=09if (cc)
>>> +=09=09=09break;
>>> +=09=09if (h->response_code =3D=3D
>>> SCLP_RC_NORMAL_READ_COMPLETION)
>>> +=09=09=09return;
>>> +=09=09if (h->response_code !=3D
>>> SCLP_RC_INVALID_SCLP_COMMAND)
>>> +=09=09=09break;
>>
>> Depending on line length you could add that to the cc check.
>> Maybe you could also group the error conditions before the success
>> conditions or the other way around.
>=20
> yeah it woud fit, but I'm not sure it would be more readable:
>=20
> if (cc || (h->response_code !=3D SCLP_RC_INVALID_SCLP_COMMAND))
>                          break;

In case you go with that solution, please drop the innermost parentheses.

  Thomas
