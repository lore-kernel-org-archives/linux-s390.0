Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726684AbfK2MDv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 Nov 2019 07:03:51 -0500
Subject: Re: [kvm-unit-tests PATCH v2 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-5-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <442f3d30-e61f-e884-096e-6ed47b4c6d7e@redhat.com>
Date: Fri, 29 Nov 2019 13:03:45 +0100
MIME-Version: 1.0
In-Reply-To: <1574945167-29677-5-git-send-email-pmorel@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 28.11.19 13:46, Pierre Morel wrote:
> To serve multiple times, the function get_clock_ms() is moved
> from intercept.c test to the new file asm/clock.h.

I'd probably call this "tod.h" instead. Nevermind.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb
