Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30584 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726120AbfKMSGj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Nov 2019 13:06:39 -0500
Subject: Re: [kvm-unit-tests PATCH v4] s390x: Load reset psw on diag308 reset
References: <e54ce8f8-7ed5-3eee-6715-8b5051cb49fb@redhat.com>
 <20191113112403.7664-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f8393e14-79a3-694e-d457-dff20b28f62a@redhat.com>
Date: Wed, 13 Nov 2019 19:06:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191113112403.7664-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 13.11.19 12:24, Janosch Frank wrote:
> On a diag308 subcode 0 CRs will be reset, so we need a PSW mask
> without DAT. Also we need to set the short psw indication to be
> compliant with the architecture.
>=20
> Let's therefore define a reset PSW mask with 64 bit addressing and
> short PSW indication that is compliant with architecture and use it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

I'll most probably wait a bit for the SCLP stuff to settle to send a=20
pull request!

--=20

Thanks,

David / dhildenb
