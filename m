From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
Date: Fri, 26 Apr 2019 15:45:55 -0400
Message-ID: <52c293e9-ddfa-426a-a8f1-2106e250e78d@redhat.com>
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris> <20190426160956.GA3827@linux-8ccs>
 <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Jessica Yu <jeyu@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Cathy Avery <cavery@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 4/26/19 2:10 PM, Prarit Bhargava wrote:
> 
> 
> On 4/26/19 12:09 PM, Jessica Yu wrote:
>> +++ Heiko Carstens [26/04/19 17:07 +0200]:
>>> On Fri, Apr 26, 2019 at 09:22:34AM -0400, Prarit Bhargava wrote:
>>>> On 4/26/19 9:07 AM, Heiko Carstens wrote:
>>>>> Hello Prarit,
>>>>>
>>>>> it looks like your commit f9a75c1d717f ("modules: Only return -EEXIST
>>>>> for modules that have finished loading") _sometimes_ causes hangs on
>>>>> s390. This is unfortunately not 100% reproducible, however the
>>>>> mentioned commit seems to be the only relevant one in modules.c.
>>>>>
>>>>> What I see is a hanging system with messages like this on the console:
>>>>>
>>>>> [   65.876040] rcu: INFO: rcu_sched self-detected stall on CPU
>>>>> [   65.876049] rcu:     7-....: (5999 ticks this GP)
>>>> idle=eae/1/0x4000000000000002 softirq=1181/1181 fqs=2729
>>>>> [   65.876078]  (t=6000 jiffies g=-471 q=17196)
>>>>> [   65.876084] Task dump for CPU 7:
>>>>> [   65.876088] systemd-udevd   R  running task        0   731    721
>>>> 0x06000004
>>>>> [   65.876097] Call Trace:
>>>>> [   65.876113] ([<0000000000abb264>] __schedule+0x2e4/0x6e0)
>>>>> [   65.876122]  [<00000000001ee486>] finished_loading+0x4e/0xb0
>>>>> [   65.876128]  [<00000000001f1ed6>] load_module+0xcce/0x27a0
>>>>> [   65.876134]  [<00000000001f3af0>] __s390x_sys_init_module+0x148/0x178
>>>>> [   65.876142]  [<0000000000ac0766>] system_call+0x2aa/0x2c8
>>>>> I did not look any further into the dump, however since the commit
>>>>> touches exactly the code path which seems to be looping... ;)
>>>>>
>>>>
>>>> Ouch :(  I wonder if I exposed a further race or another bug.  Heiko, can you
>>>> determine which module is stuck?  Warning: I have not compiled this code.
>>>
>>> Here we go:
>>>
>>> [   11.716866] PRARIT: waiting for module s390_trng to load.
>>> [   11.716867] PRARIT: waiting for module s390_trng to load.
>>> [   11.716868] PRARIT: waiting for module s390_trng to load.
>>> [   11.716870] PRARIT: waiting for module s390_trng to load.
>>> [   11.716871] PRARIT: waiting for module s390_trng to load.
>>> [   11.716872] PRARIT: waiting for module s390_trng to load.
>>> [   11.716874] PRARIT: waiting for module s390_trng to load.
>>> [   11.716875] PRARIT: waiting for module s390_trng to load.
>>> [   11.716876] PRARIT: waiting for module s390_trng to load.
>>> [   16.726850] add_unformed_module: 31403529 callbacks suppressed
>>> [   16.726853] PRARIT: waiting for module s390_trng to load.
>>> [   16.726862] PRARIT: waiting for module s390_trng to load.
>>> [   16.726865] PRARIT: waiting for module s390_trng to load.
>>> [   16.726867] PRARIT: waiting for module s390_trng to load.
>>> [   16.726869] PRARIT: waiting for module s390_trng to load.
>>>
>>> If I'm not mistaken then there was _no_ corresponding message on the
>>> console stating that the module already exists.
> 
> Heiko,
> 
> Where is the s390_trng module?  I can't seem to find it in the tree.
> 
> [02:06 PM root@ibm-z-108 linux-next]# find ./ -name *s390_trng*
> [02:06 PM root@ibm-z-108 linux-next]# git grep s390_trng
> [02:07 PM root@ibm-z-108 linux-next]#
> 

Never mind, I found it: s390-trng.c

P.

> P.
> 
>>
>> Hm, my current theory is that we have a module whose exit() function
>> is taking a while to run to completion. While it is doing so, the
>> module's state is already set to MODULE_STATE_GOING.
>>
>> With Prarit's patch, since this module is probably still in GOING,
>> add_unformed_module() will wait until the module is finally gone. If
>> this takes too long, we will keep trying to add ourselves to the
>> module list and hence stay in the loop in add_unformed_module().
>> According to Documentation/RCU/stallwarn.txt, this looping in the
>> kernel may trigger an rcu stall warning (see bullet point stating "a
>> CPU looping anywhere in the kernel without invoking schedule()".
>>
>> Heiko, could you modify the patch to print the module's state to
>> confirm?
>>
>> Thanks,
>>
>> Jessica
