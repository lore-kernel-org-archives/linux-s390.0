Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25028 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgKFGiU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Nov 2020 01:38:20 -0500
Subject: Re: [PATCH net-next v2 12/15] net/smc: Add support for obtaining SMCD
 device list
References: <20201103102531.91710-1-kgraul@linux.ibm.com>
 <20201103102531.91710-13-kgraul@linux.ibm.com>
 <eca09b4aee1d4526e1ee772adbfaafab2afa1f20.camel@kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Message-ID: <0c656b51-cd05-33a0-9bb7-cdfc21131132@linux.ibm.com>
Date: Fri, 6 Nov 2020 07:38:10 +0100
MIME-Version: 1.0
In-Reply-To: <eca09b4aee1d4526e1ee772adbfaafab2afa1f20.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Saeed Mahameed <saeed@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com, Guevenc Guelce <guvenc@linux.ibm.com>

On 04/11/2020 02:31, Saeed Mahameed wrote:
> On Tue, 2020-11-03 at 11:25 +0100, Karsten Graul wrote:
>> From: Guvenc Gulce <guvenc@linux.ibm.com>
>>
>> Deliver SMCD device information via netlink based
>> diagnostic interface.
>>
>> Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
>> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
>> ---
>>  include/uapi/linux/smc.h      |  2 +
>>  include/uapi/linux/smc_diag.h | 20 +++++++++
>>  net/smc/smc_core.h            | 27 +++++++++++++
>>  net/smc/smc_diag.c            | 76
>> +++++++++++++++++++++++++++++++++++
>>  net/smc/smc_ib.h              |  1 -
>>  5 files changed, 125 insertions(+), 1 deletion(-)
>>
> 
>> +
>> +static int smc_diag_prep_smcd_dev(struct smcd_dev_list *dev_list,
>> +				  struct sk_buff *skb,
>> +				  struct netlink_callback *cb,
>> +				  struct smc_diag_req_v2 *req)
>> +{
>> +	struct smc_diag_dump_ctx *cb_ctx = smc_dump_context(cb);
>> +	int snum = cb_ctx->pos[0];
>> +	struct smcd_dev *smcd;
>> +	int rc = 0, num = 0;
>> +
>> +	mutex_lock(&dev_list->mutex);
>> +	list_for_each_entry(smcd, &dev_list->list, list) {
>> +		if (num < snum)
>> +			goto next;
>> +		rc = smc_diag_handle_smcd_dev(smcd, skb, cb, req);
>> +		if (rc < 0)
>> +			goto errout;
>> +next:
>> +		num++;
>> +	}
>> +errout:
>> +	mutex_unlock(&dev_list->mutex);
>> +	cb_ctx->pos[0] = num;
>> +	return rc;
>> +}
>> +
> 
> this function pattern repeats at least 4 times in this series and the
> only difference is the diag handler function, just abstract this
> function out and pass a function pointer as handler to reduce code
> repetition. 
> 

Thank you for your review. We will come up with a v3 to address the comments.

We plan to eliminate additional EXPORTs using an ops array that allows smc_diag to 
retrieve the needed information from the smc module.

We discussed the above comment as well, but there is no clean and easy way to change
it because (nearly) all places iterate over different lists that have different types.
It might be not a good idea to loose type safety here by calling different handlers 
with a void pointer as parameter. Additionally some lists require specific locks.

-- 
Karsten

(I'm a dude)
