Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23179 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbgITNQV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 20 Sep 2020 09:16:21 -0400
Received: by mail-wm1-f72.google.com with SMTP id t8so2008131wmj.6
        for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2020 06:16:17 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 0/3] s390x skrf and ultravisor patches
References: <20200901091823.14477-1-frankja@linux.ibm.com>
 <34c80837-208f-bb29-cb0b-b9029fdad29d@redhat.com>
 <71b38000-70ee-f45a-b80d-95f42dbcc497@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c48075c-a922-6155-ff59-8ffa100cd209@redhat.com>
Date: Sun, 20 Sep 2020 15:16:15 +0200
MIME-Version: 1.0
In-Reply-To: <71b38000-70ee-f45a-b80d-95f42dbcc497@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

On 14/09/20 18:24, Thomas Huth wrote:
> On 02/09/2020 19.41, Paolo Bonzini wrote:
>> On 01/09/20 11:18, Janosch Frank wrote:
>>>   git@gitlab.com:frankja/kvm-unit-tests.git tags/s390x-2020-01-09
>>
>> Pulled, thanks.
>>
>> (Yes, I am alive).
> 
>  Hi Paolo,
> 
> I don't see the patches in the master branch - could you please push
> them to the repo?

Oops, pulling had failed because Janosch used an ssh reference to the
repo.  Fixed and pushed.

Paolo
