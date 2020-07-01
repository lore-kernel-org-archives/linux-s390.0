Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731738AbgGAP1P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 11:27:15 -0400
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
References: <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <1bc537d4-59f7-b521-943f-307cec80e411@de.ibm.com>
Date: Wed, 1 Jul 2020 17:26:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200701135324.GS4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christoph Hellwig <hch@infradead.org>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 01.07.20 15:53, Luis Chamberlain wrote:
> On Wed, Jul 01, 2020 at 10:24:29PM +0900, Tetsuo Handa wrote:
>> On 2020/07/01 19:08, Christian Borntraeger wrote:
>>>
>>>
>>> On 30.06.20 19:57, Luis Chamberlain wrote:
>>>> On Fri, Jun 26, 2020 at 02:54:10AM +0000, Luis Chamberlain wrote:
>>>>> On Wed, Jun 24, 2020 at 08:37:55PM +0200, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 24.06.20 20:32, Christian Borntraeger wrote:
>>>>>> [...]> 
>>>>>>> So the translations look correct. But your change is actually a sematic change
>>>>>>> if(ret) will only trigger if there is an error
>>>>>>> if (KWIFEXITED(ret)) will always trigger when the process ends. So we will always overwrite -ECHILD
>>>>>>> and we did not do it before. 
>>>>>>>
>>>>>>
>>>>>> So the right fix is
>>>>>>
>>>>>> diff --git a/kernel/umh.c b/kernel/umh.c
>>>>>> index f81e8698e36e..a3a3196e84d1 100644
>>>>>> --- a/kernel/umh.c
>>>>>> +++ b/kernel/umh.c
>>>>>> @@ -154,7 +154,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
>>>>>>                  * the real error code is already in sub_info->retval or
>>>>>>                  * sub_info->retval is 0 anyway, so don't mess with it then.
>>>>>>                  */
>>>>>> -               if (KWIFEXITED(ret))
>>>>>> +               if (KWEXITSTATUS(ret))
>>>>>>                         sub_info->retval = KWEXITSTATUS(ret);
>>
>> Well, it is not br_stp_call_user() but br_stp_start() which is expecting
>> to set sub_info->retval for both KWIFEXITED() case and KWIFSIGNALED() case.
>> That is, sub_info->retval needs to carry raw value (i.e. without "umh: fix
>> processed error when UMH_WAIT_PROC is used" will be the correct behavior).
> 
> br_stp_start() doesn't check for the raw value, it just checks for err
> or !err. So the patch, "umh: fix processed error when UMH_WAIT_PROC is
> used" propagates the correct error now.
> 
> Christian, can you try removing the binary temporarily and seeing if
> you get your bridge working?

As I matter of fact I do NOT have /sbin/bridge-stp installed. 
