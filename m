Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2631 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgI2Ugc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Sep 2020 16:36:32 -0400
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
 <554699c6-cc01-4c3c-3ed5-26d22ac3bac0@nvidia.com>
 <9372727e-1a79-913b-5391-e0c4a85bf5a7@linuxfoundation.org>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <da9047fa-d1f8-9710-04a3-0308606bb1e9@nvidia.com>
Date: Tue, 29 Sep 2020 13:36:31 -0700
MIME-Version: 1.0
In-Reply-To: <9372727e-1a79-913b-5391-e0c4a85bf5a7@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On 9/29/20 1:20 PM, Shuah Khan wrote:
> On 9/29/20 2:11 PM, John Hubbard wrote:
...
>> Do you have a link or two for that? Especially about the pushback, and
>> conclusions reached, if any.
>>
> 
> Unfortunately no. A I recall it was workflow related issues and ease of
> running individual subsystem tests and backwards compatibility with
> stables.
> 
> Let's start a new discussion and see where we land.
> 
OK, sure. I can take a quick pass at converting just the selftests/vm
directory to kbuild, and post that as an RFC to start the discussion.


thanks,
-- 
John Hubbard
NVIDIA
