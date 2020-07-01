Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbgGAPtX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 11:49:23 -0400
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
References: <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
 <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
 <20200701153859.GT4332@42.do-not-panic.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <f9f0f868-e511-990a-2a74-1806ac0cb7ac@de.ibm.com>
Date: Wed, 1 Jul 2020 17:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200701153859.GT4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 01.07.20 17:38, Luis Chamberlain wrote:
> On Wed, Jul 01, 2020 at 11:08:57PM +0900, Tetsuo Handa wrote:
>> On 2020/07/01 22:53, Luis Chamberlain wrote:
>>>> Well, it is not br_stp_call_user() but br_stp_start() which is expecting
>>>> to set sub_info->retval for both KWIFEXITED() case and KWIFSIGNALED() case.
>>>> That is, sub_info->retval needs to carry raw value (i.e. without "umh: fix
>>>> processed error when UMH_WAIT_PROC is used" will be the correct behavior).
>>>
>>> br_stp_start() doesn't check for the raw value, it just checks for err
>>> or !err. So the patch, "umh: fix processed error when UMH_WAIT_PROC is
>>> used" propagates the correct error now.
>>
>> No. If "/sbin/bridge-stp virbr0 start" terminated due to e.g. SIGSEGV
>> (for example, by inserting "kill -SEGV $$" into right after "#!/bin/sh" line),
>> br_stp_start() needs to select BR_KERNEL_STP path. We can't assume that
>> /sbin/bridge-stp is always terminated by exit() syscall (and hence we can't
>> ignore KWIFSIGNALED() case in call_usermodehelper_exec_sync()).
> 
> Ah, well that would be a different fix required, becuase again,
> br_stp_start() does not untangle the correct error today really.
> I also I think it would be odd odd that SIGSEGV or another signal 
> is what was terminating Christian's bridge stp call, but let's
> find out!
> 
> Note we pass 0 to the options to wait so the mistake here could indeed
> be that we did not need KWIFSIGNALED(). I was afraid of this prospect...
> as it other implications.
> 
> It means we either *open code* all callers, or we handle this in a
> unified way on the umh. And if we do handle this in a unified way, it
> then begs the question as to *what* do we pass for the signals case and
> continued case. Below we just pass the signal, and treat continued as
> OK, but treating continued as OK would also be a *new* change as well.
> 
> For instance (this goes just boot tested, but Christian if you can
> try this as well that would be appreciated):


Does not help, the bridge stays in DOWN state. 
