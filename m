Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbfKLJlX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Nov 2019 04:41:23 -0500
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: Add CR save area
References: <20191111153345.22505-1-frankja@linux.ibm.com>
 <20191111153345.22505-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b57dc6f5-76ba-8d7b-cae1-0437cfe410ab@redhat.com>
Date: Tue, 12 Nov 2019 10:41:14 +0100
MIME-Version: 1.0
In-Reply-To: <20191111153345.22505-3-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 11/11/2019 16.33, Janosch Frank wrote:
> If we run with DAT enabled and do a reset, we need to save the CRs to
> backup our ASCEs on a diag308 for example.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm-offsets.c  |  2 +-
>  lib/s390x/asm/arch_def.h |  4 ++--
>  lib/s390x/interrupt.c    |  4 ++--
>  lib/s390x/smp.c          |  2 +-
>  s390x/cstart64.S         | 10 +++++-----
>  5 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
