Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729908AbgEFQch (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 12:32:37 -0400
Received: by mail-wr1-f70.google.com with SMTP id v17so1595639wrq.8
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 09:32:34 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
 <20200506115945.13132-2-borntraeger@de.ibm.com>
 <bcd98cbd-1e28-47a2-6cbd-668da4ddb9f5@redhat.com>
 <fe991071-25d0-3842-73cc-23cb365850f3@de.ibm.com>
 <a8688ff1-edc6-fdd8-9575-adbf726f9f06@redhat.com>
 <328f4d06-5c1e-5255-cb4f-e8534f2171bf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e955f2f0-904b-394e-fa19-e3a461ecc92f@redhat.com>
Date: Wed, 6 May 2020 18:32:32 +0200
MIME-Version: 1.0
In-Reply-To: <328f4d06-5c1e-5255-cb4f-e8534f2171bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Qian Cai <cailca@icloud.com>

On 06/05/20 15:09, David Hildenbrand wrote:
> IIRC, it's perfectly valid - according to the documentation - to ignore
> ECA_APIE. That's the weird thing about effective controls. You don't
> really know what you get in the end.

Ah okay, then yeah it could be considered a quality of implementation
issue but not a bug.  Thanks for the lecture! :)

Paolo
