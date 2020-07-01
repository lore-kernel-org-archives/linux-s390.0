Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731672AbgGAQDw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 12:03:52 -0400
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
References: <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
 <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
 <20200701153859.GT4332@42.do-not-panic.com>
 <f9f0f868-e511-990a-2a74-1806ac0cb7ac@de.ibm.com>
 <20200701155819.GU4332@42.do-not-panic.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <eb0b2ec2-52db-81a4-11b0-c0112b39a7aa@de.ibm.com>
Date: Wed, 1 Jul 2020 18:01:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200701155819.GU4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 01.07.20 17:58, Luis Chamberlain wrote:
[...]

>>>
>>> Ah, well that would be a different fix required, becuase again,
>>> br_stp_start() does not untangle the correct error today really.
>>> I also I think it would be odd odd that SIGSEGV or another signal 
>>> is what was terminating Christian's bridge stp call, but let's
>>> find out!
>>>
>>> Note we pass 0 to the options to wait so the mistake here could indeed
>>> be that we did not need KWIFSIGNALED(). I was afraid of this prospect...
>>> as it other implications.
>>>
>>> It means we either *open code* all callers, or we handle this in a
>>> unified way on the umh. And if we do handle this in a unified way, it
>>> then begs the question as to *what* do we pass for the signals case and
>>> continued case. Below we just pass the signal, and treat continued as
>>> OK, but treating continued as OK would also be a *new* change as well.
>>>
>>> For instance (this goes just boot tested, but Christian if you can
>>> try this as well that would be appreciated):
>>
>>
>> Does not help, the bridge stays in DOWN state. 
> 
> OK thanks for testing, that was fast! Does your code go through the
> STP kernel path or userpath? If it is taking the STP kernel path
> then this is not the real culprit to your issue then.

I have no idea and I cannot look into this right now. I can test
patches as compile,reboot and test is almost no effort.

FWIW, this is just the network of a KVM guest of libvirts default network
no longer working, maybe you can reproduce this on x86 as well?
