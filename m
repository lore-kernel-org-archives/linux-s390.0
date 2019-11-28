Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32131 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726731AbfK1Ogg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Nov 2019 09:36:36 -0500
Subject: Re: [kvm-unit-tests PATCH v2 2/9] s390x: Define the PSW bits
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-3-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <489b43a4-6f71-71bf-b936-e4c94e52387b@redhat.com>
Date: Thu, 28 Nov 2019 15:36:28 +0100
MIME-Version: 1.0
In-Reply-To: <1574945167-29677-3-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 28.11.19 13:46, Pierre Morel wrote:
> Let's define the PSW bits  explicitly, it will clarify their
> usage.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_bits.h | 20 ++++++++++++++++++++
>  lib/s390x/asm/arch_def.h  |  6 ++----

I'm sorry, but I don't really see a reason to move these 4/5 defines to
a separate header. Can you just keep them in arch_def.h and extend?

(none of your other patches touch arch_bits.h - and it is somewhat a
weird name. Where to put something new: arch_def.h or arch_bits.h? I
would have understood "psw.h", but even that, I don't consider necessary)

-- 
Thanks,

David / dhildenb
