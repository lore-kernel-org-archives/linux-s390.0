Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729519AbgAOKrj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jan 2020 05:47:39 -0500
Subject: Re: [kvm-unit-tests PATCH 0/4] s390x: smp: Improve smp code and reset
 checks
References: <20200114153054.77082-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd2fd0eb-13fa-ae3e-df3b-15131cc02df5@redhat.com>
Date: Wed, 15 Jan 2020 11:47:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200114153054.77082-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

On 14.01.20 16:30, Janosch Frank wrote:
> The first two patches are badly needed cleanup for smp.c.
> The last two improve initial reset testing.
> 
> Janosch Frank (4):
>   s390x: smp: Cleanup smp.c
>   s390x: smp: Only use smp_cpu_setup once
>   s390x: smp: Test all CRs on initial reset
>   s390x: smp: Dirty fpc before initial reset test
> 
>  s390x/smp.c | 84 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 26 deletions(-)
> 

I assume you will resend, right? So I'll wait with queuing.

-- 
Thanks,

David / dhildenb
