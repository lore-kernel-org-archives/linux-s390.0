Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbgJGOYO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 10:24:14 -0400
Subject: Re: [PATCH 02/10] s390/cio: Provide Endpoint-Security Mode per CU
References: <20201002193940.24012-1-sth@linux.ibm.com>
 <20201002193940.24012-3-sth@linux.ibm.com>
 <20201006164646.5b586679.cohuck@redhat.com>
From: Stefan Haberland <sth@linux.ibm.com>
Message-ID: <3b721a6b-202e-d7e4-d4f2-2a3954f74609@linux.ibm.com>
Date: Wed, 7 Oct 2020 16:24:06 +0200
MIME-Version: 1.0
In-Reply-To: <20201006164646.5b586679.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, vneethv@linux.ibm.com

Am 06.10.20 um 16:46 schrieb Cornelia Huck:
> On Fri,  2 Oct 2020 21:39:32 +0200
> Stefan Haberland <sth@linux.ibm.com> wrote:
>
>> From: Vineeth Vijayan <vneethv@linux.ibm.com>
>>
>> Add an interface in the CIO layer to retrieve the information about the
>> Endpoint-Security Mode (ESM) of the specified CU. The ESM values are
>> defined as 0-None, 1-Authenticated or 2, 3-Encrypted.
>>
>> Reference-ID: IO1812
>> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
>> [vneethv@linux.ibm.com: cleaned-up and modified description]
>> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
>> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
>> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/cio.h |  1 +
>>  drivers/s390/cio/chsc.c     | 83 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 84 insertions(+)
>  
> (...)
>
>> +/**
>> + * chsc_scud() - Store control-unit description.
>> + * @cu:		number of the control-unit
>> + * @esm:	8 1-byte endpoint security mode values
>> + * @esm_valid:	validity mask for @esm
>> + *
>> + * Interface to retrieve information about the endpoint security
>> + * modes for up to 8 paths of a control unit.
>> + *
>> + * Returns 0 on success.
>> + */
>> +int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid)
>> +{
>> +	struct chsc_scud *scud = chsc_page;
>> +	int ret;
>> +
> I'm wondering if it would make sense to check in the chsc
> characteristics whether that chsc is actually installed (if there's
> actually a bit for it, although I'd expect so). Some existing chscs
> check for bits in the characteristics, others don't. (Don't know
> whether QEMU is the only platform that doesn't provide this chsc.)

I don't see any benefit in checking upfront if the CHSC is supported -
we'll get
a corresponding CHSC response code and since no error message is logged
for this
case, the outcome would be the same as if we checked for the
characteristics bit
beforehand.


>> +	spin_lock_irq(&chsc_page_lock);
>> +	memset(chsc_page, 0, PAGE_SIZE);
>> +	scud->request.length = SCUD_REQ_LEN;
>> +	scud->request.code = SCUD_REQ_CMD;
>> +	scud->fmt = 0;
>> +	scud->cssid = 0;
>> +	scud->first_cu = cu;
>> +	scud->last_cu = cu;
>> +
>> +	ret = chsc(scud);
>> +	if (!ret)
>> +		ret = chsc_error_from_response(scud->response.code);
>> +
>> +	if (!ret && (scud->response.length <= 8 || scud->fmt_resp != 0
>> +			|| !(scud->cudb[0].flags & 0x80)
>> +			|| scud->cudb[0].cu != cu)) {
>> +
>> +		CIO_MSG_EVENT(2, "chsc: scud failed rc=%04x, L2=%04x "
>> +			"FMT=%04x, cudb.flags=%02x, cudb.cu=%04x",
>> +			scud->response.code, scud->response.length,
>> +			scud->fmt_resp, scud->cudb[0].flags, scud->cudb[0].cu);
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	if (ret)
>> +		goto out;
>> +
>> +	memcpy(esm, scud->cudb[0].esm, sizeof(*esm));
>> +	*esm_valid = scud->cudb[0].esm_valid;
>> +out:
>> +	spin_unlock_irq(&chsc_page_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(chsc_scud);
