Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727148AbgCXKJe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 06:09:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OA4Dft102667
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 06:09:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywfe899td-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 06:09:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 24 Mar 2020 10:09:29 -0000
Subject: Re: [kvm-unit-tests PATCH 01/10] s390x: smp: Test all CRs on initial
 reset
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-2-frankja@linux.ibm.com>
 <fb384a50-6c38-b636-ecde-ad220aad950c@de.ibm.com>
 <c1f01ea5-219e-4680-72bd-56f68270bf9b@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 24 Mar 2020 11:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <c1f01ea5-219e-4680-72bd-56f68270bf9b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5be194c7-924d-df25-2c21-f5d3195236b3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com



On 24.03.20 11:08, Janosch Frank wrote:
> On 3/24/20 10:52 AM, Christian Borntraeger wrote:
>>
>>
>> On 24.03.20 09:12, Janosch Frank wrote:
>>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>>> so we also need to test 1-13 and 15 for 0.
>>>
>>> And while we're at it, let's also set some values to cr 1, 7 and 13, so
>>> we can actually be sure that they will be zeroed.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  s390x/smp.c | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>> index fa40753524f321d4..8c9b98aabd9e8222 100644
>>> --- a/s390x/smp.c
>>> +++ b/s390x/smp.c
>>> @@ -182,16 +182,28 @@ static void test_emcall(void)
>>>  	report_prefix_pop();
>>>  }
>>>
>>> +/* Used to dirty registers of cpu #1 before it is reset */
>>> +static void test_func_initial(void)
>>> +{
>>> +	lctlg(1, 0x42000UL);
>>> +	lctlg(7, 0x43000UL);
>>> +	lctlg(13, 0x44000UL);
>>> +	set_flag(1);
>>> +}
>>> +
>>>  static void test_reset_initial(void)
>>>  {
>>>  	struct cpu_status *status = alloc_pages(0);
>>> +	uint64_t nullp[12] = {};
>>>  	struct psw psw;
>>>
>>>  	psw.mask = extract_psw_mask();
>>> -	psw.addr = (unsigned long)test_func;
>>> +	psw.addr = (unsigned long)test_func_initial;
>>>
>>>  	report_prefix_push("reset initial");
>>> +	set_flag(0);
>>>  	smp_cpu_start(1, psw);
>>> +	wait_for_flag();
>>>
>>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>>> @@ -202,6 +214,8 @@ static void test_reset_initial(void)
>>>  	report(!status->fpc, "fpc");
>>>  	report(!status->cputm, "cpu timer");
>>>  	report(!status->todpr, "todpr");
>>> +	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12), "cr1-13 == 0");
>>> +	report(status->crs[15] == 0, "cr15 == 0");
>>>  	report_prefix_pop();
>>
>> Why not add a check for crs[0] == 0xe0 
>> and crs[14] = 0xc2000000
> 
> You mean the checks which are done a few lines below this?
> This patch just actually dirties registers which should be set to 0 so
> we can really be sure that they have been touched.

Right. So feel free to add my RB. 
