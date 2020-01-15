Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgAOGSI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jan 2020 01:18:08 -0500
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial
 reset
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-4-frankja@linux.ibm.com>
 <2f190b0a-e403-51e6-27da-7f8f1f6289ac@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f120ad03-aab1-a863-636b-b11898d634f5@redhat.com>
Date: Wed, 15 Jan 2020 07:17:59 +0100
MIME-Version: 1.0
In-Reply-To: <2f190b0a-e403-51e6-27da-7f8f1f6289ac@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 14/01/2020 19.42, Christian Borntraeger wrote:
> 
> 
> On 14.01.20 16:30, Janosch Frank wrote:
>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>> so we also need to test 1-13 and 15 for 0.
>>
>> And while we're at it, let's also set some values to cr 1, 7 and 13, so
>> we can actually be sure that they will be zeroed.
> 
> While it does not hurt to have it here, I think the register check for the reset
> would be better in a kselftest. This allows to check userspace AND guest at the
> same time.

Agreed. Especially it also allows to test the kernel ioctl on its own,
without QEMU in between (which might also clear some registers), so for
getting the new reset ioctls right, the selftests are certainly the
better place.

 Thomas
