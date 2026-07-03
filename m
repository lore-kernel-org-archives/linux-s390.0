Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B83CB8F0;
	Fri,  3 Jul 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079053; cv=none; b=q+9GgPdYzB4nAfqQIEOGcTeX2WUnPALWD4bMg8kIoI1UuUxzA+bkn+4N8TMjJAhHRU3layVW6YikS2Oq1S2cAwktdVt/s59ANuHE/qWqqjAVK6t6zhQCu5Qu+H4U5OX8yPyNktTuQkD1BMk0rh9BKhS0fGYjxZNpg0b9zFXiK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079053; c=relaxed/simple;
	bh=yjxTmwclb3hfU2mfOCA6iAqyiIsDIQ8E66YWe/7bA68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5I0UhGg7RV2aO0iTLIFFPfaRRob1eRleS4N2nhrn9CJuUqAgot6GAC/ZHlUugD/WozA+IhjWXAawHSvgB6Xl8EMNZgGMTr6P47XXUgQc5QkAJZzXjro2HwborsT2ZfjqoMibyEVtkcJEcdnEJpZBFUdGxGhIA5IRtt1J0jHr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F5eEPxWp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F5eEPxWp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IOpE1869814;
	Fri, 3 Jul 2026 11:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VKMjfP
	0N5xi3r+lJU3RdsK97w5jZG0qi6qu/hb+QhMs=; b=F5eEPxWpDQh2qcO2g6isfy
	veDBv/kOgPlnaLQ5Ow0V/pB8CtMCqSFmwDPgEgxwOuX89HOPzPO4fKuhWmg4XLSn
	ZQ4Ew+2SL43Z1Iv+5o76OCn87upK/sRNbExQusZsVzS0JzVdj2SJwmRspiNE/0XQ
	7L78NY3myPrDew55u/TcRZhZ8ZuL/PeSzKmnwTA0xAr5FFbo9EftvPoV/4R3L0r6
	G+HcJVM2mMlkCtOcJNjGzPgWrx0BrUykw2L8IHYspmaNVG9Q9Qom6GAGmeCjkiK9
	BL7Yy4AJFNWMFMMtzRyAkVroQLwmh3CS6usm1LzQmqXBODr6EODzQ3+bb6B71Y5g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n6728k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:44:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663BYfSP016681;
	Fri, 3 Jul 2026 11:44:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukgm99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 11:44:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663Bi2C445416884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 11:44:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1BC52004D;
	Fri,  3 Jul 2026 11:44:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C1852004B;
	Fri,  3 Jul 2026 11:44:02 +0000 (GMT)
Received: from [9.111.31.165] (unknown [9.111.31.165])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 11:44:02 +0000 (GMT)
Message-ID: <1dc3df72-830b-42ee-9cf5-8e3f164bdf8c@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:44:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: stsi: regression test for the STSI 3.2.2 count
 clamp
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?UTF-8?Q?Nico_B=C3=B6hr?=
 <nrb@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
References: <20260629091921.710920-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260629091921.710920-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX9CQwzjf1/963
 eohmsBvF/nJfT3EN3HQGuftiwj4Nu9PDXfaN/Zx6i2eHEFX0zQp5YY5TX+0c2b16RoZE2FDJQ6U
 No/4H0RiytF36whVt4M5fFmPtwATj1mE6v0ayDISAGTSHdq99ac2UwvH3ZAEM1LyqglrDwwM3Ik
 PJ9vnqF9psvpT9H8J6eMaogBpiY3lf403BlWSnuUgM6Rj3yTyTG590g0mE3U7u9q1JA36thdpjJ
 ogtzxvQ3/MqKl9LqaY4ORqRhppvbJyc4Ef4Cj2jxC5w/UoSXrsupc1Ldn1m5iUj8a/jYYJlccev
 RM7sSQDccuSwNV/9MHRG4uvFQ8RCqc0a7en/fk7qvtiM5zcsTqRgVTVfA+vozAG5gBQUoNIShAM
 TV19LGz0raNGj21hSU9h1t/85unbkR7aleD2d7pj9F4EYqaPKIIgLRcxaDFBOCglhqvV1THLUe/
 PpYmhxEaYkVwt2Vj2Jg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a47a088 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VQUzZYM2PMThu4dLP_4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: u3zYoLrrolYw3YBub26t0LK9m-VZiiZj
X-Proofpoint-GUID: u3zYoLrrolYw3YBub26t0LK9m-VZiiZj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMCBTYWx0ZWRfX8ctOCEahz2Wz
 rNdLw7J4mLZGriN686+K5aGouL6q/OFnq0Aw1as26zaahEFxKI5glXj4A1aKVKkawTGpu28zGym
 1rtM+WMOOkd4TTDwElF1yVHpW+Y2joA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030110

On 6/29/26 11:19, Christian Borntraeger wrote:
> See https://lore.kernel.org/qemu-devel/20260622092035.400959-1-borntraeger@linux.ibm.com/
> for the QEMU fix.
> Add a regression test that races STSI 3.2.2 on one CPU against a second CPU
> that continuously forces an out-of-range count value.
> The out of bound access usually crashes/asserts QEMU with any sane
> distribution build of QEMU, so its more or less guest root can kill itself.
> We should test and fix nevertheless.
> Testcase piggybacks on the existing stsi test, so some cases will be
> tested twice. (with smp 1 and smp 2)
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> ---
> If wanted we could split this into a separate file or always run the
> test with smp=2 to avoid the duplication

Make it smp = 2.
And next time please add the kvm-unit-test patch prefix.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> 
>   s390x/stsi.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++-
>   s390x/unittests.cfg |  9 ++++++
>   2 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/s390x/stsi.c b/s390x/stsi.c
> index 94a579dc..96361143 100644
> --- a/s390x/stsi.c
> +++ b/s390x/stsi.c
> @@ -2,7 +2,7 @@
>   /*
>    * Store System Information tests
>    *
> - * Copyright (c) 2019 IBM Corp
> + * Copyright IBM Corp. 2019,2026
>    *
>    * Authors:
>    *  Janosch Frank <frankja@linux.ibm.com>
> @@ -133,6 +133,79 @@ out:
>   	report_prefix_pop();
>   }
>   
> +/*
> + * Number of STSI 3.2.2 calls raced against the count corruptor below.
> + * A memory write should be faster than an kvm->qemu exit, so 100 is
> + * good enough.
> + */
> +#define RACE_ITERATIONS 100
> +static u8 corrupt_count_value;
> +
> +static void count_corruptor(void)
> +{
> +	struct sysinfo_3_2_2 *data = (void *)pagebuf;
> +
> +	for (;;)
> +		*(volatile u8 *)&data->count = corrupt_count_value;
> +}
> +
> +/*
> + * Race STSI 3.2.2 on the boot CPU against a secondary CPU that continuously
> + * forces the given out-of-range value into the "count" field. Returns true
> + * if every STSI returned cc == 0, false on an unexpected condition code.
> + */
> +static bool race_count_value(uint8_t value)
> +{
> +	int i, cc;
> +
> +	corrupt_count_value = value;
> +	smp_cpu_setup(1, PSW_WITH_CUR_MASK(count_corruptor));
> +
> +	for (i = 0; i < RACE_ITERATIONS; i++) {
> +		cc = stsi(pagebuf, 3, 2, 2);
> +		if (cc) {
> +			report_fail("count 0x%02x: unexpected cc %d on iteration %d",
> +				    value, cc, i);
> +			break;
> +		}
> +	}
> +
> +	smp_cpu_stop(1);
> +	smp_cpu_destroy(1);
> +
> +	return i == RACE_ITERATIONS;
> +}
> +
> +/*
> + * The count value is 8 bit and valid values are 1-8 if stsi 3.2.2 is present.
> + * We test 0,9 as off-by-one, and 0xff as maximum value.
> + */
> +static void test_3_2_2_race(void)
> +{
> +	report_prefix_push("3.2.2 count race");
> +
> +	if (stsi_get_fc() < 3) {
> +		report_skip("Running under lpar, no level 3 to test.");
> +		goto out;
> +	}
> +
> +	if (smp_query_num_cpus() < 2) {
> +		report_skip("Need at least 2 CPUs to race the count field.");
> +		goto out;
> +	}
> +
> +	if (race_count_value(0x0))
> +		report_pass("host survived racing STSI 3.2.2 count 0x00");
> +
> +	if (race_count_value(0x9))
> +		report_pass("host survived racing STSI 3.2.2 count 0x09");
> +
> +	if (race_count_value(0xff))
> +		report_pass("host survived racing STSI 3.2.2 count 0xff");
> +out:
> +	report_prefix_pop();
> +}
> +
>   int main(void)
>   {
>   	report_prefix_push("stsi");
> @@ -140,5 +213,6 @@ int main(void)
>   	test_specs();
>   	test_fc();
>   	test_3_2_2();
> +	test_3_2_2_race();
>   	return report_summary();
>   }
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index ed4d069e..c1462506 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -81,6 +81,15 @@ qemu_params=-device diag288,id=watchdog0 --watchdog-action inject-nmi
>   file = stsi.elf
>   qemu_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003 -smp 1,maxcpus=8
>   
> +# Regression test for the QEMU STSI 3.2.2 count clamp. Needs a second CPU to
> +# race the guest-visible count field, and only applies to QEMU's KVM path.
> +[stsi-3-2-2-race]
> +file = stsi.elf
> +qemu_params=-name kvm-unit-test --uuid 0fb84a86-727c-11ea-bc55-0242ac130003
> +smp = 2
> +accel = kvm
> +timeout = 30
> +
>   [smp]
>   file = smp.elf
>   smp = 2

