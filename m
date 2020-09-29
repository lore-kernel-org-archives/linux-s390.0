Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13455 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgI2S75 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Sep 2020 14:59:57 -0400
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
 <20200929175524.GX9916@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <715c49ec-d2a8-45cb-8ace-c6b1b4b8f978@nvidia.com>
Date: Tue, 29 Sep 2020 11:59:55 -0700
MIME-Version: 1.0
In-Reply-To: <20200929175524.GX9916@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On 9/29/20 10:55 AM, Jason Gunthorpe wrote:
> On Tue, Sep 29, 2020 at 10:44:31AM -0700, John Hubbard wrote:
>> On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
>>> On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
>>>> On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
>>>>> On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
...
>> I don't see any "gcc -m" type of dependency generation pass happening
>> in this relatively simple Make system.
> 
> It happens with -MD, all the deps are stored in files like mm/.init-mm.o.cmd
> and sucked into the build.

You are thinking of kbuild. This is not kbuild. There are no such artifacts
being generated.

>> And so, without including an explicit header file dependency (at
>> least, that's the simplest way), changes to gup_test.h are not
>> detected.
> 
> Shouldn't be
> 
>> Both the Makefile code and the observed behavior back this up. (I
>> expect that this is because there is less use of header files in
>> this area, because most unit tests are self-contained within a
>> single .c file.)
> 
> Something else is very wrong then.
> 

Not really, it's just a less-cabable system than kbuild.

thanks,
-- 
John Hubbard
NVIDIA
