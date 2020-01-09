Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36152 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727701AbgAIMzm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 07:55:42 -0500
Subject: Re: [kvm-unit-tests PATCH v5 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
References: <20200108161317.268928-1-imbrenda@linux.ibm.com>
 <20200108161317.268928-4-imbrenda@linux.ibm.com>
 <ff1041f2-0262-ed89-4c5e-386f69d21cd0@redhat.com>
 <20200109123646.6b79194e@p-imbrenda>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d01f734d-46b0-df9f-99b9-0f75338747b5@redhat.com>
Date: Thu, 9 Jan 2020 13:55:31 +0100
MIME-Version: 1.0
In-Reply-To: <20200109123646.6b79194e@p-imbrenda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 09/01/2020 12.36, Claudio Imbrenda wrote:
> On Wed, 8 Jan 2020 19:58:27 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 08/01/2020 17.13, Claudio Imbrenda wrote:
>>> Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
>>> use it instead of using inline assembly everywhere.  
>>
>> Either some hunks are missing in this patch, or you should update the
>> patch description and remove the second part of the sentence ? ... at
>> least I did not spot the changes where you "use it instead of using
>> inline assembly everywhere".
> 
> 
> oops sorry, the description is a little misleading. I meant
> everywhere in the specific unit test, not everywhere in the whole
> source tree. 
> 
> I should either change the description or actually patch the remaining
> users of inline assembly to use the wrappers instead. (any preference?)

No preferences from my side. If you don't want/have to respin, the patch
description could be fixed when picking up the patch, otherwise simply
do whatever you prefer in v6.

 Thomas
