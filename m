Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhBAMKn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Feb 2021 07:10:43 -0500
Subject: Re: [kvm-unit-tests PATCH v1 1/5] s390x: css: Store CSS
 Characteristics
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-2-git-send-email-pmorel@linux.ibm.com>
 <04f837d1-b389-9c51-a876-233c70c86999@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <ab568f10-549c-e2d0-94be-8de4458a30ca@linux.ibm.com>
Date: Mon, 1 Feb 2021 13:09:39 +0100
MIME-Version: 1.0
In-Reply-To: <04f837d1-b389-9c51-a876-233c70c86999@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com



On 2/1/21 11:01 AM, Janosch Frank wrote:
> On 1/29/21 3:34 PM, Pierre Morel wrote:
>> CSS characteristics exposes the features of the Channel SubSystem.

...

>> +/* Store Channel Subsystem Characteristics */
>> +struct chsc_scsc {
>> +	struct chsc_header req;
>> +	u32 reserved1;
>> +	u32 reserved2;
>> +	u32 reserved3;
> 
> Array?

OK

...snip...

>> +int get_chsc_scsc(void)
>> +{
>> +	int i, n;
>> +	int ret = 0;
>> +	char buffer[510];
>> +	char *p;
>> +
>> +	report_prefix_push("Channel Subsystem Call");
>> +
>> +	if (chsc_scsc) {
>> +		report_info("chsc_scsc already initialized");
>> +		goto end;
>> +	}
>> +
>> +	chsc_scsc = alloc_pages(0);
> 
> alloc_page() ?

OK too


Thanks for the comments,
Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
