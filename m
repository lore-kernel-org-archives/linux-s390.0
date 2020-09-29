Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10423 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgI2ULe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Sep 2020 16:11:34 -0400
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
 <20200929175524.GX9916@ziepe.ca>
 <715c49ec-d2a8-45cb-8ace-c6b1b4b8f978@nvidia.com>
 <20200929190816.GY9916@ziepe.ca>
 <3022912c-f11b-f564-3a8a-f516ca259a37@nvidia.com>
 <20200929195356.GZ9916@ziepe.ca>
 <64bb5ba7-77f7-2f09-44f0-29ee9329b183@linuxfoundation.org>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <554699c6-cc01-4c3c-3ed5-26d22ac3bac0@nvidia.com>
Date: Tue, 29 Sep 2020 13:11:34 -0700
MIME-Version: 1.0
In-Reply-To: <64bb5ba7-77f7-2f09-44f0-29ee9329b183@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On 9/29/20 1:00 PM, Shuah Khan wrote:
> On 9/29/20 1:53 PM, Jason Gunthorpe wrote:
>> I only remarked because I didn't know it wasn't using kbuild. I
>> thought it would have used the existing HOSTCC stuff, not sure why it
>> is special.
>>
>> The only investment that seems worthwhile would be to switch it to use
>> the normal kbuild stuff??
>>
> 
> I explored switching to kbuild at the kernel summit last year during
> my kselftest where are we talk.
> 
> There was push back from several developers. We can definitely explore
> it as long as we can still support being able to build and run
> individual subsystem tests and doesn't break workflow for developers.
> 

Do you have a link or two for that? Especially about the pushback, and
conclusions reached, if any.



thanks,
-- 
John Hubbard
NVIDIA
