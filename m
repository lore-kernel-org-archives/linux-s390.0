Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726633AbfKDKLE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 05:11:04 -0500
Subject: Re: [kvm-unit-tests PATCH v2 0/5] s390x: SCLP Unit test
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5aae4df3-e95b-d866-3eca-26b39df935bf@redhat.com>
Date: Mon, 4 Nov 2019 11:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 25.10.19 19:06, Claudio Imbrenda wrote:
> This patchset contains some minor cleanup, some preparatory work and
> then the SCLP unit test itself.
>=20
> The unit test checks the following:
>     =20
>      * Correctly ignoring instruction bits that should be ignored
>      * Privileged instruction check
>      * Check for addressing exceptions
>      * Specification exceptions:
>        - SCCB size less than 8
>        - SCCB unaligned
>        - SCCB overlaps prefix or lowcore
>        - SCCB address higher than 2GB
>      * Return codes for
>        - Invalid command
>        - SCCB too short (but at least 8)
>        - SCCB page boundary violation
>=20
> v1 -> v2
> * fix many small issues that came up during the first round of reviews
> * add comments to each function
> * use a static buffer for the SCCP template when used
>=20
> Claudio Imbrenda (5):
>    s390x: remove redundant defines
>    s390x: improve error reporting for interrupts
>    s390x: sclp: expose ram_size and max_ram_size
>    s390x: sclp: add service call instruction wrapper
>    s390x: SCLP unit test

Queued patch 1-3 to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

Thanks!

--=20

Thanks,

David / dhildenb
