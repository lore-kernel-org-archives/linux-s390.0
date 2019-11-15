Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727036AbfKOKII (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:08:08 -0500
Subject: Re: [RFC 32/37] KVM: s390: protvirt: UV calls diag308 0, 1
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-33-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6fb6b03f-5a33-34ec-53e6-d960ac7bbae6@redhat.com>
Date: Fri, 15 Nov 2019 11:07:52 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-33-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h | 25 +++++++++++++++++++++++++
>  arch/s390/kvm/diag.c       |  1 +
>  arch/s390/kvm/kvm-s390.c   | 20 ++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.h   |  2 ++
>  arch/s390/kvm/pv.c         | 19 +++++++++++++++++++
>  include/uapi/linux/kvm.h   |  2 ++
>  6 files changed, 69 insertions(+)

Add at least a short patch description what this patch is all about?

 Thomas
