From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 11:14:25 +0000
Subject: Re: [PATCH] [PATCH v2] perf test: add platform dependency to test 15
Message-Id: <42b0bda9-a515-ec22-ef8d-879d80b774dd@linux.vnet.ibm.com>
In-Reply-To: <4ca2d2ae-6046-65f9-ca51-7cd84b2c1a2f@linux.vnet.ibm.com>
References: <4ca2d2ae-6046-65f9-ca51-7cd84b2c1a2f@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/29/2017 02:30 PM, Jiri Olsa wrote:
> On Thu, Jun 29, 2017 at 02:27:43PM +0200, Thomas-Mich Richter wrote:
> 
> SNIP
> 
>>>> Did I miss something?
>>>
>>> no, my bad.. it's the perf/attr_test branch, sry
>>>
>>> jirka
>>>
>>
>> Ok, I will rework my patch to work with your perf/attr_test branch
>> and I will resent it to you. 
>> This patch will then be part of your patch series (which is fine
>> with)?
>> And you will submit upstream to the perf tool repository?
> 
> sure np.. does it work for you?
> 
> thanks,
> jirka
> 

I have cloned your perf/attr_test branch today and added my
patch on top of it. I have then tested it and all went well.

I will send you the patch in a seperate mail. Please
put it into your patch set and when it gets into mainline
kernel, I will start working on the s390x test cases.
(Hopefully soon...)

BTY: I run into a subtle issue with your new result testing.
I run a perf stat -e cycles test on a simulation for s390x
with out any hardware.
When there is no event-xx-yy-zz file in the /tmp directory
at all there is no result value in function compare and I
get this call stack from python2

  ... 
  loading result events
  compare
    matching [event:base-stat]
        match: [event:base-stat] matches []
Traceback (most recent call last):
  File "./tests/attr.py", line 345, in <module>
    main()
  File "./tests/attr.py", line 336, in main
    run_tests(options)
  File "./tests/attr.py", line 279, in run_tests
    Test(f, options).run()
  File "./tests/attr.py", line 269, in run
    self.compare(self.expect, self.result)
  File "./tests/attr.py", line 213, in compare
    exp_event.diff(res_event)
UnboundLocalError: local variable 'res_event' referenced before assignment

Hope this helps
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
