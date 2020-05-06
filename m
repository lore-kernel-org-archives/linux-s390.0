Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFMMj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 08:12:39 -0400
Received: by mail-wm1-f71.google.com with SMTP id h184so1119727wmf.5
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 05:12:35 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
 <20200506115945.13132-2-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcd98cbd-1e28-47a2-6cbd-668da4ddb9f5@redhat.com>
Date: Wed, 6 May 2020 14:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <20200506115945.13132-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Qian Cai <cailca@icloud.com>

On 06/05/20 13:59, Christian Borntraeger wrote:
> Running nested under z/VM can result in other intercepts as
> well as ECA_APIE is an effective bit: If one hypervisor layer has
> turned this bit off, the end result will be that we will get intercepts for
> all function codes. Usually the first one will be a query like PQAP(QCI).
> So the WARN_ON_ONCE is not right. Let us simply remove it.

Possibly stupid question since I can only recognize some words here. :)
But anyway... shouldn't z/VM trap this intercept when the guest has
turned off the bit, and only reflect the SIE exit based on the function
code?

Thanks,

Paolo
