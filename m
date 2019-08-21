Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHUIxz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 04:53:55 -0400
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
 <35c4aa37-c0c8-4f27-66e0-23145fe48182@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6addbd2b-435b-9367-8a13-152b094707ac@redhat.com>
Date: Wed, 21 Aug 2019 10:53:52 +0200
MIME-Version: 1.0
In-Reply-To: <35c4aa37-c0c8-4f27-66e0-23145fe48182@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 21.08.19 10:48, Janosch Frank wrote:
> On 8/20/19 9:04 PM, David Hildenbrand wrote:
>> On 20.08.19 12:55, Janosch Frank wrote:
>>> The first patch allows for CECSIM booting via PSW restart.
>>> The other ones add diag288 and STSI tests.
>>>
>>> I chose to start with these since they are low controversy. My queue
>>> still contains the sclp patches and a simple smp library with
>>> tests. They will follow later.
>>
>> On which branch do these patches apply? I fail to am 2+3 on master (well
>> I didn't try too hard to resolve ;) ). Do you have a branch somewhere?
>>
> 
> That is currently on top of master (24efc22), the only merge conflicts
> might be s390x/Makefile or unittests.conf if your branch is not clean.
> I'm trying to get a public github account for that and qemu.
> 

t460s: ~/git/kvm-unit-tests master $ git fetch origin
t460s: ~/git/kvm-unit-tests master $ git reset --hard origin/master
HEAD is now at 03b1e45 x86: Support environments without test-devices
t460s: ~/git/kvm-unit-tests master $ git am \[kvm-unit-tests\ PATCH\ *
Applying: s390x: Support PSW restart boot
Applying: s390x: Diag288 test
error: patch failed: s390x/Makefile:11
error: s390x/Makefile: patch does not apply
error: patch failed: s390x/unittests.cfg:61
error: s390x/unittests.cfg: patch does not apply
Patch failed at 0002 s390x: Diag288 test
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Are you sure?

-- 

Thanks,

David / dhildenb
