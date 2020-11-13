Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57958 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbgKMPIq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Nov 2020 10:08:46 -0500
Subject: Re: [PATCH net-next v4 09/15] net/smc: Introduce SMCR get linkgroup
 command
References: <20201109151814.15040-1-kgraul@linux.ibm.com>
 <20201109151814.15040-10-kgraul@linux.ibm.com>
 <20201111143405.7f5fb92f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Karsten Graul <kgraul@linux.ibm.com>
Message-ID: <3be40d64-3952-3de9-559b-2ee55449b54c@linux.ibm.com>
Date: Fri, 13 Nov 2020 16:08:39 +0100
MIME-Version: 1.0
In-Reply-To: <20201111143405.7f5fb92f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

On 11/11/2020 23:34, Jakub Kicinski wrote:
> On Mon,  9 Nov 2020 16:18:08 +0100 Karsten Graul wrote:
>> @@ -295,6 +377,14 @@ static int smc_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>  
>>  static int smc_diag_dump_ext(struct sk_buff *skb, struct netlink_callback *cb)
>>  {
>> +	struct smc_diag_req_v2 *req = nlmsg_data(cb->nlh);
>> +
>> +	if (req->cmd == SMC_DIAG_GET_LGR_INFO) {
>> +		if ((req->cmd_ext & (1 << (SMC_DIAG_LGR_INFO_SMCR - 1))))
>> +			smc_diag_fill_lgr_list(smc_diag_ops->get_lgr_list(),
>> +					       skb, cb, req);
>> +	}
>> +
>>  	return skb->len;
>>  }
> 
> IDK if this is appropriate for socket diag handler.
> 
> Is there precedent for funneling commands through socket diag instead
> of just creating a genetlink family?
> 

Thank you for your valuable comments. We are looking into a better way
to retrieve the various information from the kernel into user space, 
and we will come up with a v5 for that.

-- 
Karsten
