Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59767 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbgC3QT7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 12:19:59 -0400
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Add stsi 3.2.2 tests
References: <20200330153359.2386-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
Date: Mon, 30 Mar 2020 18:19:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200330153359.2386-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

On 30.03.20 17:33, Janosch Frank wrote:
> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
> a bit more thorough.
> 
> In this test we set a custom name and uuid through the QEMU command
> line. Both parameters will be passed to the guest on a stsi subcode
> 3.2.2 call and will then be checked.
> 
> We also compare the configured cpu numbers against the smp reported
> numbers and if the reserved + configured add up to the total number
> reported.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/stsi.c        | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  1 +
>  2 files changed, 73 insertions(+)
> 
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> index e9206bca137d2edb..a291fd828347018a 100644
> --- a/s390x/stsi.c
> +++ b/s390x/stsi.c
> @@ -14,7 +14,28 @@
>  #include <asm/page.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/interrupt.h>
> +#include <smp.h>
>  
> +struct stsi_322 {
> +    uint8_t reserved[31];
> +    uint8_t count;
> +    struct {
> +        uint8_t reserved2[4];
> +        uint16_t total_cpus;
> +        uint16_t conf_cpus;
> +        uint16_t standby_cpus;
> +        uint16_t reserved_cpus;
> +        uint8_t name[8];
> +        uint32_t caf;
> +        uint8_t cpi[16];
> +        uint8_t reserved5[3];
> +        uint8_t ext_name_encoding;
> +        uint32_t reserved3;
> +        uint8_t uuid[16];
> +    } vm[8];
> +    uint8_t reserved4[1504];
> +    uint8_t ext_names[8][256];

Just notices that all these spaces should be converted to tabs.


-- 
Thanks,

David / dhildenb
