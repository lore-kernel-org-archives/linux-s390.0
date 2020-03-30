Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28975 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730100AbgC3NOZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 09:14:25 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Add stsi 3.2.2 tests
References: <20200330122035.19607-1-frankja@linux.ibm.com>
 <860a5575-226a-9b6e-4db0-b1b9dc72b3ed@redhat.com>
 <e1bcfeda-c05d-712b-3c38-4c27188c33bf@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8ce6361f-bd16-9852-f53e-1048670f9b5e@redhat.com>
Date: Mon, 30 Mar 2020 15:14:17 +0200
MIME-Version: 1.0
In-Reply-To: <e1bcfeda-c05d-712b-3c38-4c27188c33bf@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com

On 30.03.20 15:00, Janosch Frank wrote:
> On 3/30/20 2:51 PM, David Hildenbrand wrote:
>> On 30.03.20 14:20, Janosch Frank wrote:
>>> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
>>> a bit more thorough.
>>>
>>> In this test we set a custom name and uuid through the QEMU command
>>> line. Both parameters will be passed to the guest on a stsi subcode
>>> 3.2.2 call and will then be checked.
>>>
>>> We also compare the total and configured cpu numbers against the smp
>>> reported numbers.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  s390x/stsi.c        | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>>  s390x/unittests.cfg |  1 +
>>>  2 files changed, 63 insertions(+)
>>>
>>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>>> index e9206bca137d2edb..10e588a78cc05186 100644
>>> --- a/s390x/stsi.c
>>> +++ b/s390x/stsi.c
>>> @@ -14,7 +14,28 @@
>>>  #include <asm/page.h>
>>>  #include <asm/asm-offsets.h>
>>>  #include <asm/interrupt.h>
>>> +#include <smp.h>
>>>  
>>> +struct stsi_322 {
>>> +    uint8_t  reserved[31];
>>> +    uint8_t  count;
>>> +    struct {
>>> +        uint8_t  reserved2[4];
>>> +        uint16_t total_cpus;
>>> +        uint16_t conf_cpus;
>>> +        uint16_t standby_cpus;
>>> +        uint16_t reserved_cpus;
>>> +        uint8_t  name[8];
>>> +        uint32_t caf;
>>> +        uint8_t  cpi[16];
>>> +        uint8_t reserved5[3];
>>> +        uint8_t ext_name_encoding;
>>> +        uint32_t reserved3;
>>> +        uint8_t uuid[16];
>>> +    } vm[8];
>>> +    uint8_t reserved4[1504];
>>> +    uint8_t ext_names[8][256];
>>> +};
>>>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
>>>  
>>>  static void test_specs(void)
>>> @@ -76,11 +97,52 @@ static void test_fc(void)
>>>  	report(stsi_get_fc(pagebuf) >= 2, "query fc >= 2");
>>>  }
>>>  
>>> +static void test_3_2_2(void)
>>> +{
>>> +	int rc;
>>> +	/* EBCDIC for "kvm-unit" */
>>> +	uint8_t vm_name[] = { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, 0x89, 0xa3 };
>>> +	uint8_t uuid[] = { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
>>> +			   0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
>>> +			   0x00, 0x03 };
>>> +	/* EBCDIC for "KVM/" */
>>> +	uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
>>> +	const char *vm_name_ext = "kvm-unit-test";
>>> +	struct stsi_322 *data = (void *)pagebuf;
>>> +
>>> +	/* Is the function code available at all? */
>>> +	if (stsi_get_fc(pagebuf) < 3)
>>> +		return;
>>> +
>>> +	report_prefix_push("3.2.2");
>>> +	rc = stsi(pagebuf, 3, 2, 2);
>>> +	report(!rc, "call");
>>> +
>>> +	/* For now we concentrate on KVM/QEMU */
>>> +	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm)))
>>> +		goto out;
>>> +
>>> +	report(data->vm[0].total_cpus == smp_query_num_cpus(), "cpu # total");
>>> +	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
>>> +	report(data->vm[0].standby_cpus == 0, "cpu # standby");
>>> +	report(data->vm[0].reserved_cpus == 0, "cpu # reserved");
>>> +	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)),
>>> +	       "VM name == kvm-unit-test");
>>> +	report(data->vm[0].ext_name_encoding == 2, "ext name encoding UTF-8");
>>
>> should you rather do
>>
>> if (data->vm[0].ext_name_encoding == 2) {
>> 	...
>> } else {
>> 	report_skip(...);
>> }
>>
>> to make this future-proof?
>>
> Do you expect UTF-16 or EBCDIC in the future? :)

Well, you never know :) If there is an option for other encodings ...


-- 
Thanks,

David / dhildenb
