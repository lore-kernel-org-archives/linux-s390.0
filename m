Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726952AbfKLJx7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Nov 2019 04:53:59 -0500
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Load reset psw on diag308
 reset
References: <20191111153345.22505-1-frankja@linux.ibm.com>
 <20191111153345.22505-4-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32a85325-26d7-71b1-7ade-9e1cc0c5938d@redhat.com>
Date: Tue, 12 Nov 2019 10:53:47 +0100
MIME-Version: 1.0
In-Reply-To: <20191111153345.22505-4-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

On 11/11/2019 16.33, Janosch Frank wrote:
> On a diag308 subcode 0 CRs will be reset, so we need a PSW mask
> without DAT. Also we need to set the short psw indication to be
> compliant with the architecture.
>=20
> Let's therefore define a reset PSW mask with 64 bit addressing and
> short PSW indication that is compliant with architecture and use it.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm-offsets.c  |  1 +
>  lib/s390x/asm/arch_def.h |  3 ++-
>  s390x/cstart64.S         | 24 +++++++++++++++++-------
>  3 files changed, 20 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
