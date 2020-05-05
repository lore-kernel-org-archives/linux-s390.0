Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730258AbgEESXj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 14:23:39 -0400
Subject: Re: [PATCH net-next 10/11] s390/qeth: allow reset via ethtool
References: <20200505162559.14138-1-jwi@linux.ibm.com>
 <20200505162559.14138-11-jwi@linux.ibm.com>
 <20200505102149.1fd5b9ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <a19ccf27-2280-036c-057f-8e6d2319bb28@linux.ibm.com>
Date: Tue, 5 May 2020 20:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200505102149.1fd5b9ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>

On 05.05.20 19:21, Jakub Kicinski wrote:
> On Tue,  5 May 2020 18:25:58 +0200 Julian Wiedmann wrote:
>> Implement the .reset callback. Only a full reset is supported.
>>
>> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>> ---
>>  drivers/s390/net/qeth_ethtool.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
>> index ebdc03210608..0d12002d0615 100644
>> --- a/drivers/s390/net/qeth_ethtool.c
>> +++ b/drivers/s390/net/qeth_ethtool.c
>> @@ -193,6 +193,21 @@ static void qeth_get_drvinfo(struct net_device *dev,
>>  		 CARD_RDEV_ID(card), CARD_WDEV_ID(card), CARD_DDEV_ID(card));
>>  }
>>  
>> +static int qeth_reset(struct net_device *dev, u32 *flags)
>> +{
>> +	struct qeth_card *card = dev->ml_priv;
>> +	int rc;
>> +
>> +	if (*flags != ETH_RESET_ALL)
>> +		return -EINVAL;
>> +
>> +	rc = qeth_schedule_recovery(card);
>> +	if (!rc)
>> +		*flags = 0;
> 
> I think it's better if you only clear the flags for things you actually
> reset. See the commit message for 7a13240e3718 ("bnxt_en: fix
> ethtool_reset_flags ABI violations").
> 

Not sure I understand - you mean *flags &= ~ETH_RESET_ALL ?

Since we're effectively managing a virtual device, those individual
ETH_RESET_* flags just don't map very well...
This _is_ a full-blown reset, I don't see how we could provide any finer
granularity.
