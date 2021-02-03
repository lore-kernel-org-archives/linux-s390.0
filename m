Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233584AbhBCKKk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Feb 2021 05:10:40 -0500
Subject: Re: [kvm-unit-tests PATCH v1 3/5] s390x: css: implementing Set
 CHannel Monitor
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-4-git-send-email-pmorel@linux.ibm.com>
 <3a0aade0-510b-adaa-e956-3dddc23388ba@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <a5e6072e-0154-b1ac-6967-6bed4e9c3d4d@linux.ibm.com>
Date: Wed, 3 Feb 2021 11:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <3a0aade0-510b-adaa-e956-3dddc23388ba@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com



On 2/2/21 6:32 PM, Thomas Huth wrote:
> On 29/01/2021 15.34, Pierre Morel wrote:
>> We implement the call of the Set CHannel Monitor instruction,
>> starting the monitoring of the all Channel Sub System, and
>> the initialization of the monitoring on a Sub Channel.
>>
>> An initial test reports the presence of the extended measurement
>> block feature.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     | 17 +++++++++-
>>   lib/s390x/css_lib.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>>   s390x/css.c         |  7 +++++
>>   3 files changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> index f8bfa37..938f0ab 100644
>> --- a/lib/s390x/css.h
>> +++ b/lib/s390x/css.h
>> @@ -82,6 +82,7 @@ struct pmcw {
>>       uint32_t intparm;
>>   #define PMCW_DNV    0x0001
>>   #define PMCW_ENABLE    0x0080
>> +#define PMCW_MBUE    0x0010
>>   #define PMCW_ISC_MASK    0x3800
>>   #define PMCW_ISC_SHIFT    11
>>       uint16_t flags;
>> @@ -94,6 +95,7 @@ struct pmcw {
>>       uint8_t  pom;
>>       uint8_t  pam;
>>       uint8_t  chpid[8];
>> +#define PMCW_MBF1    0x0004
>>       uint32_t flags2;
>>   };
>>   #define PMCW_CHANNEL_TYPE(pmcw) (pmcw->flags2 >> 21)
>> @@ -101,7 +103,8 @@ struct pmcw {
>>   struct schib {
>>       struct pmcw pmcw;
>>       struct scsw scsw;
>> -    uint8_t  md[12];
>> +    uint64_t mbo;
>> +    uint8_t  md[4];
>>   } __attribute__ ((aligned(4)));
>>   struct irb {
>> @@ -305,6 +308,7 @@ struct chsc_scsc {
>>       u32 reserved3;
>>       struct chsc_header res;
>>       u32 format;
>> +#define CSSC_EXTENDED_MEASUREMENT_BLOCK 48
>>       u64 general_char[255];
>>       u64 chsc_char[254];
>>   };
>> @@ -346,4 +350,15 @@ static inline int chsc(void *p, uint16_t code, 
>> uint16_t len)
>>   #define css_general_feature(bit) test_bit_inv(bit, 
>> chsc_scsc->general_char)
>>   #define css_chsc_feature(bit) test_bit_inv(bit, chsc_scsc->chsc_char)
>> +static inline void schm(void *mbo, unsigned int flags)
>> +{
>> +    register void *__gpr2 asm("2") = mbo;
>> +    register long __gpr1 asm("1") = flags;
>> +
>> +    asm("schm" : : "d" (__gpr2), "d" (__gpr1));
>> +}
>> +
>> +int css_enable_mb(int schid, uint64_t mb, int format1, uint16_t mbi,
>> +          uint16_t flags);
>> +
>>   #endif
>> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
>> index f300969..9e0f568 100644
>> --- a/lib/s390x/css_lib.c
>> +++ b/lib/s390x/css_lib.c
>> @@ -205,6 +205,83 @@ retry:
>>       return -1;
>>   }
>> +/*
>> + * css_enable_mb: enable the subchannel Mesurement Block
>> + * @schid: Subchannel Identifier
>> + * @mb   : 64bit address of the measurement block
>> + * @format1: set if format 1 is to be used
>> + * @mbi : the measurement block offset
>> + * @flags : PMCW_MBUE to enable measurement block update
>> + *        PMCW_DCTME to enable device connect time
>> + * Return value:
>> + *   On success: 0
>> + *   On error the CC of the faulty instruction
>> + *      or -1 if the retry count is exceeded.
>> + */
>> +int css_enable_mb(int schid, uint64_t mb, int format1, uint16_t mbi,
>> +          uint16_t flags)
>> +{
>> +    struct pmcw *pmcw = &schib.pmcw;
>> +    int retry_count = 0;
>> +    int cc;
>> +
>> +    /* Read the SCHIB for this subchannel */
>> +    cc = stsch(schid, &schib);
>> +    if (cc) {
>> +        report_info("stsch: sch %08x failed with cc=%d", schid, cc);
>> +        return cc;
>> +    }
>> +
>> +retry:
>> +    /* Update the SCHIB to enable the measurement block */
>> +    pmcw->flags |= flags;
>> +
>> +    if (format1)
>> +        pmcw->flags2 |= PMCW_MBF1;
>> +    else
>> +        pmcw->flags2 &= ~PMCW_MBF1;
>> +
>> +    pmcw->mbi = mbi;
>> +    schib.mbo = mb;
>> +
>> +    /* Tell the CSS we want to modify the subchannel */
>> +    cc = msch(schid, &schib);
>> +    if (cc) {
>> +        /*
>> +         * If the subchannel is status pending or
>> +         * if a function is in progress,
>> +         * we consider both cases as errors.
>> +         */
>> +        report_info("msch: sch %08x failed with cc=%d", schid, cc);
>> +        return cc;
>> +    }
>> +
>> +    /*
>> +     * Read the SCHIB again to verify the measurement block origin
>> +     */
>> +    cc = stsch(schid, &schib);
>> +    if (cc) {
>> +        report_info("stsch: updating sch %08x failed with cc=%d",
>> +                schid, cc);
>> +        return cc;
>> +    }
>> +
>> +    if (schib.mbo == mb) {
>> +        report_info("stsch: sch %08x successfully modified after %d 
>> retries",
>> +                schid, retry_count);
>> +        return 0;
>> +    }
>> +
>> +    if (retry_count++ < MAX_ENABLE_RETRIES) {
>> +        mdelay(10); /* the hardware was not ready, give it some time */
>> +        goto retry;
>> +    }
> 
> "goto retries" are always a good indication that you likely should use a 
> proper loop instead. And maybe put the code in the loop body into a 
> separate function?

Yes, thanks, I do so.

Regards,
Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
