Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 7/8] selftests/vm: run_vmtest.sh: update and clean up
 gup_test invocation
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-8-jhubbard@nvidia.com>
 <20200928192619.GF458519@iweiny-DESK2.sc.intel.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <176baf45-d2c7-0c74-f552-22361866d365@nvidia.com>
Date: Mon, 28 Sep 2020 12:58:55 -0700
MIME-Version: 1.0
In-Reply-To: <20200928192619.GF458519@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

On 9/28/20 12:26 PM, Ira Weiny wrote:
> On Sun, Sep 27, 2020 at 11:21:58PM -0700, John Hubbard wrote:
...
>> +echo "--------------------------------------------------------------"
>> +echo "running gup_test -ct -F 0x1 0 19 0x1000"
>> +echo "   Dumps pages 0, 19, and 4096, using pin_user_pages (-F 0x1)"
>> +echo "--------------------------------------------------------------"
>> +./gup_test -ct -F 0x1 0 19 0x1000
> 
> Ah here it is...  Maybe just remove that from the previous commit message.
> 
> Ira

Yes, will do, thanks for spotting that.

thanks,
-- 
John Hubbard
NVIDIA
