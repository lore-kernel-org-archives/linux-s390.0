Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405077AbgFXSPw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 14:15:52 -0400
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
Message-ID: <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
Date: Wed, 24 Jun 2020 20:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 24.06.20 19:58, Christian Borntraeger wrote:
> 
> 
> On 24.06.20 18:09, Luis Chamberlain wrote:
>> On Wed, Jun 24, 2020 at 05:54:46PM +0200, Christian Borntraeger wrote:
>>>
>>>
>>> On 24.06.20 16:43, Christoph Hellwig wrote:
>>>> On Wed, Jun 24, 2020 at 01:11:54PM +0200, Christian Borntraeger wrote:
>>>>> Does anyone have an idea why "umh: fix processed error when UMH_WAIT_PROC is used" breaks the
>>>>> linux-bridge on s390?
>>>>
>>>> Are we even sure this is s390 specific and doesn't happen on other
>>>> architectures with the same bridge setup?
>>>
>>> Fair point. AFAIK nobody has tested this yet on x86.
>>
>> Regardless, can you enable dynamic debug prints, to see if the kernel
>> reveals anything on the bridge code which may be relevant:
>>
>> echo "file net/bridge/* +p" > /sys/kernel/debug/dynamic_debug/control
>>
>>   Luis
> 
> When I start a guest the following happens with the patch:
> 
> [   47.420237] virbr0: port 2(vnet0) entered blocking state
> [   47.420242] virbr0: port 2(vnet0) entered disabled state
> [   47.420315] device vnet0 entered promiscuous mode
> [   47.420365] virbr0: port 2(vnet0) event 16
> [   47.420366] virbr0: br_fill_info event 16 port vnet0 master virbr0
> [   47.420373] virbr0: toggle option: 12 state: 0 -> 0
> [   47.420536] virbr0: port 2(vnet0) entered blocking state
> [   47.420538] virbr0: port 2(vnet0) event 16
> [   47.420539] virbr0: br_fill_info event 16 port vnet0 master virbr0
> 
> and the nothing happens.
> 
> 
> without the patch
> [   33.805410] virbr0: hello timer expired
> [   35.805413] virbr0: hello timer expired
> [   36.184349] virbr0: port 2(vnet0) entered blocking state
> [   36.184353] virbr0: port 2(vnet0) entered disabled state
> [   36.184427] device vnet0 entered promiscuous mode
> [   36.184479] virbr0: port 2(vnet0) event 16
> [   36.184480] virbr0: br_fill_info event 16 port vnet0 master virbr0
> [   36.184487] virbr0: toggle option: 12 state: 0 -> 0
> [   36.184636] virbr0: port 2(vnet0) entered blocking state
> [   36.184638] virbr0: port 2(vnet0) entered listening state
> [   36.184639] virbr0: port 2(vnet0) event 16
> [   36.184640] virbr0: br_fill_info event 16 port vnet0 master virbr0
> [   36.184645] virbr0: port 2(vnet0) event 16
> [   36.184646] virbr0: br_fill_info event 16 port vnet0 master virbr0
> [   37.805478] virbr0: hello timer expired
> [   38.205413] virbr0: port 2(vnet0) forward delay timer
> [   38.205414] virbr0: port 2(vnet0) entered learning state
> [   38.205427] virbr0: port 2(vnet0) event 16
> [   38.205430] virbr0: br_fill_info event 16 port vnet0 master virbr0
> [   38.765414] virbr0: port 2(vnet0) hold timer expired
> [   39.805415] virbr0: hello timer expired
> [   40.285410] virbr0: port 2(vnet0) forward delay timer
> [   40.285411] virbr0: port 2(vnet0) entered forwarding state
> [   40.285418] virbr0: topology change detected, propagating
> [   40.285420] virbr0: decreasing ageing time to 400
> [   40.285427] virbr0: port 2(vnet0) event 16
> [   40.285432] virbr0: br_fill_info event 16 port vnet0 master virbr0
> [   40.765408] virbr0: port 2(vnet0) hold timer expired
> [   41.805415] virbr0: hello timer expired
> [   42.765426] virbr0: port 2(vnet0) hold timer expired
> [   43.805425] virbr0: hello timer expired
> [   44.765426] virbr0: port 2(vnet0) hold timer expired
> [   45.805418] virbr0: hello timer expired
> 
> and continuing....

Just reverting the umh.c parts like this makes the problem go away.

diff --git a/kernel/umh.c b/kernel/umh.c
index f81e8698e36e..79f139a7ca03 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -154,8 +154,8 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
                 * the real error code is already in sub_info->retval or
                 * sub_info->retval is 0 anyway, so don't mess with it then.
                 */
-               if (KWIFEXITED(ret))
-                       sub_info->retval = KWEXITSTATUS(ret);
+               if (ret)
+                       sub_info->retval = ret;
        }
 
        /* Restore default kernel sig handler */
