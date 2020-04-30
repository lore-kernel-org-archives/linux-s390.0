Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgD3PBC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 11:01:02 -0400
Subject: Re: [PATCH v3 00/10] s390x: smp: Improve smp code part 2
References: <20200429143518.1360468-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bfececd9-e66d-46db-e3ed-7d5a07a6c35d@redhat.com>
Date: Thu, 30 Apr 2020 17:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200429143518.1360468-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 29.04.20 16:35, Janosch Frank wrote:
> Let's continue cleaning up the smp test and smp related functions.
>=20
> We add:
>    * Test for external/emergency calls after reset
>    * Test SIGP restart while running
>    * SIGP stop and store status while running
>    * CR testing on reset
>=20
> We fix:
>    * Proper check for sigp completion
>    * smp_cpu_setup_state() loop and return address in r14
>=20
> v3:
> 	* Added some rev-bys and acks
> 	* Add a workaround for stop and store status
> 	* Beautified cr checking with loop
>=20
> v2:
> 	* Added some rev-bys and acks
> 	* Explicitly stop and start cpu before hot restart test
>=20
> GIT: https://github.com/frankjaa/kvm-unit-tests/tree/smp_cleanup2
>=20
> Janosch Frank (10):
>   s390x: smp: Test all CRs on initial reset
>   s390x: smp: Dirty fpc before initial reset test
>   s390x: smp: Test stop and store status on a running and stopped cpu
>   s390x: smp: Test local interrupts after cpu reset
>   s390x: smp: Loop if secondary cpu returns into cpu setup again
>   s390x: smp: Remove unneeded cpu loops
>   s390x: smp: Use full PSW to bringup new cpu
>   s390x: smp: Wait for sigp completion
>   s390x: smp: Add restart when running test
>   s390x: Fix library constant definitions
>=20
>  lib/s390x/asm/arch_def.h |   8 ++--
>  lib/s390x/smp.c          |  11 +++++
>  lib/s390x/smp.h          |   1 +
>  s390x/cstart64.S         |   5 +-
>  s390x/smp.c              | 101 +++++++++++++++++++++++++++++++++++----
>  5 files changed, 112 insertions(+), 14 deletions(-)
>=20

I already had #1 applied. Applied everything else except #8, that might
require more thought. Gave it a test under z/VM and TCG.

Under z/VM I get:

ABORT: smp: cpu reset: Unexpected external call interrupt (code 0x1201):
on cpu 1 at 0x110f4

Which - I think - is expected with older kernels (on 5.4.13) that miss
the reset of local interrupts via the new kernel interface

https://github.com/davidhildenbrand/qemu.git s390-tcg-next

Thanks!

--=20
Thanks,

David / dhildenb
