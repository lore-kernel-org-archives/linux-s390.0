Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730939AbgFWHMM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 03:12:12 -0400
Subject: Re: [PATCH v9 2/2] s390/kvm: diagnose 0x318 sync and reset
References: <20200622154636.5499-1-walling@linux.ibm.com>
 <20200622154636.5499-3-walling@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9ac1d372-0de2-6eb0-c3b1-594e70512ab0@redhat.com>
Date: Tue, 23 Jun 2020 09:12:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200622154636.5499-3-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

On 22.06.20 17:46, Collin Walling wrote:
> DIAGNOSE 0x318 (diag318) sets information regarding the environment
> the VM is running in (Linux, z/VM, etc) and is observed via
> firmware/service events.
> 
> This is a privileged s390x instruction that must be intercepted by
> SIE. Userspace handles the instruction as well as migration. Data
> is communicated via VCPU register synchronization.
> 
> The Control Program Name Code (CPNC) is stored in the SIE block. The
> CPNC along with the Control Program Version Code (CPVC) are stored
> in the kvm_vcpu_arch struct.
> 
> This data is reset on load normal and clear resets.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
