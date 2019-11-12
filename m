Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725865AbfKLMKo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 07:10:44 -0500
Subject: Re: [kvm-unit-tests PATCH v2 0/3] s390x: Improve architectural
 compliance for diag308
References: <20191111153345.22505-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1dacfdb6-26bd-3575-cf92-09f81c8dc2f2@redhat.com>
Date: Tue, 12 Nov 2019 13:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <20191111153345.22505-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 11.11.19 16:33, Janosch Frank wrote:
> When testing diag308 subcodes 0/1 on lpar with virtual mem set up, I
> experienced spec PGMs and addressing PGMs due to the tests not setting
> short psw bit 12 and leaving the DAT bit on. The problem was not found
> under KVM/QEMU, because Qemu just ignores all cpu mask bits.
>=20
> v1 -> v2:
>    * Fixed comment in extra patch
>    * Now using pre-defined reset psw
>    * Fixed some comments
>=20
> Janosch Frank (3):
>   s390x: Fix initial cr0 load comments
>   s390x: Add CR save area
>   s390x: Load reset psw on diag308 reset
>=20
>  lib/s390x/asm-offsets.c  |  3 ++-
>  lib/s390x/asm/arch_def.h |  5 +++--
>  lib/s390x/interrupt.c    |  4 ++--
>  lib/s390x/smp.c          |  2 +-
>  s390x/cstart64.S         | 38 ++++++++++++++++++++++++--------------
>  5 files changed, 32 insertions(+), 20 deletions(-)
>=20

I'll queue the first two patches for now to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

And wait with the first until we know if it's a TCG or a kvm-unit-tests
bug that makes the SMP test fail.

--=20

Thanks,

David / dhildenb
