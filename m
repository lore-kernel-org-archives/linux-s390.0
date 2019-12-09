Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbfLIQn0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 11:43:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GMTij036948
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 11:43:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2d0ru8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 11:43:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Dec 2019 16:43:23 -0000
Subject: Re: [kvm-unit-tests PATCH v3 5/9] s390x: Library resources for CSS
 tests
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-6-git-send-email-pmorel@linux.ibm.com>
 <66233a15-7cc4-45b5-d930-abbedbd0729d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Mon, 9 Dec 2019 17:43:18 +0100
MIME-Version: 1.0
In-Reply-To: <66233a15-7cc4-45b5-d930-abbedbd0729d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bd5b7fd3-aa52-cb57-d0f3-5052a83dedcf@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2019-12-09 12:49, Thomas Huth wrote:
> On 06/12/2019 17.26, Pierre Morel wrote:
>> These are the include and library utilities for the css tests patch
>> series.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h      | 259 +++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/css_dump.c | 156 ++++++++++++++++++++++++++
>>   2 files changed, 415 insertions(+)
>>   create mode 100644 lib/s390x/css.h
>>   create mode 100644 lib/s390x/css_dump.c
>>
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> new file mode 100644
>> index 0000000..6f19bb5
>> --- /dev/null
>> +++ b/lib/s390x/css.h
> [...]
>> +/* Debug functions */
>> +char *dump_pmcw_flags(uint16_t f);
>> +char *dump_scsw_flags(uint32_t f);
>> +#undef DEBUG
>> +#ifdef DEBUG
>> +void dump_scsw(struct scsw *);
>> +void dump_irb(struct irb *irbp);
>> +void dump_schib(struct schib *sch);
>> +struct ccw *dump_ccw(struct ccw *cp);
>> +#else
>> +static inline void dump_scsw(struct scsw *scsw) {}
>> +static inline void dump_irb(struct irb *irbp) {}
>> +static inline void dump_pmcw(struct pmcw *p) {}
>> +static inline void dump_schib(struct schib *sch) {}
>> +static inline void dump_orb(struct orb *op) {}
>> +static inline struct ccw *dump_ccw(struct ccw *cp)
>> +{
>> +	return NULL;
>> +}
>> +#endif
> 
> I'd prefer to not have a "#undef DEBUG" (or "#define DEBUG") statement
> in the header here - it could trigger unexpected behavior with other
> files that also use a DEBUG macro.
> 
> Could you please declare the prototypes here and move the "#else" part
> to the .c file instead? Thanks!
> 
>   Thomas
> 

Yes, I can do this.
Thanks
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
