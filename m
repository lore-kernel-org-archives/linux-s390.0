Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727287AbgKFNZJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Nov 2020 08:25:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id h11so459129wrq.20
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2020 05:25:06 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH v2 1/4] memory: allocation in low memory
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
 <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
 <20200928173147.750e7358.cohuck@redhat.com>
 <136e1860-ddbc-edc0-7e67-fdbd8112a01e@linux.ibm.com>
 <f2ff3ddd-c70e-b2cc-b58f-bbcb1e4684d6@linux.ibm.com>
 <63ac15b1-b4fe-b1b5-700f-ae403ce7fb85@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc553f1a-8ddd-59b0-9dec-8bdddfb5483d@redhat.com>
Date: Fri, 6 Nov 2020 14:25:00 +0100
MIME-Version: 1.0
In-Reply-To: <63ac15b1-b4fe-b1b5-700f-ae403ce7fb85@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com

On 05/11/20 15:15, Janosch Frank wrote:
>> Isn't it possible to go on with this patch series.
>> It can be adapted later to the changes that will be introduced by
>> Claudio when it is final.
>>
>>
> Pierre, that's outside of my jurisdiction, you're adding code to the
> common code library.
> 
> I've set Paolo CC, let's see if he finds this thread:)
> 

I have queued Claudio's series already, so let's start from there.

Paolo
