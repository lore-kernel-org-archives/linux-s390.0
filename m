Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59354 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgJaR7U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Oct 2020 13:59:20 -0400
Subject: Re: [PATCH net-next] net/smc: improve return codes for SMC-Dv2
References: <20201028110039.33645-1-kgraul@linux.ibm.com>
 <20201030201845.6be9722e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From: Karsten Graul <kgraul@linux.ibm.com>
Message-ID: <de52a36a-e45f-c731-29e7-8689ad93bca3@linux.ibm.com>
Date: Sat, 31 Oct 2020 18:59:09 +0100
MIME-Version: 1.0
In-Reply-To: <20201030201845.6be9722e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

On 31/10/2020 04:18, Jakub Kicinski wrote:
> On Wed, 28 Oct 2020 12:00:39 +0100 Karsten Graul wrote:
>> To allow better problem diagnosis the return codes for SMC-Dv2 are
>> improved by this patch. A few more CLC DECLINE codes are defined and
>> sent to the peer when an SMC connection cannot be established.
>> There are now multiple SMC variations that are offered by the client and
>> the server may encounter problems to initialize all of them.
>> Because only one diagnosis code can be sent to the client the decision
>> was made to send the first code that was encountered. Because the server
>> tries the variations in the order of importance (SMC-Dv2, SMC-D, SMC-R)
>> this makes sure that the diagnosis code of the most important variation
>> is sent.
>>
>> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
>> ---
>>  net/smc/af_smc.c   | 61 +++++++++++++++++++++++++++++++---------------
>>  net/smc/smc_clc.h  |  5 ++++
>>  net/smc/smc_core.h |  1 +
>>  3 files changed, 47 insertions(+), 20 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 82be0bd0f6e8..5414704f4cac 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1346,6 +1346,7 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
>>  {
>>  	struct smc_clc_smcd_v2_extension *pclc_smcd_v2_ext;
>>  	struct smc_clc_v2_extension *pclc_v2_ext;
>> +	int rc;
>>  
>>  	ini->smc_type_v1 = pclc->hdr.typev1;
>>  	ini->smc_type_v2 = pclc->hdr.typev2;
>> @@ -1353,29 +1354,30 @@ static int smc_listen_v2_check(struct smc_sock *new_smc,
>>  	if (pclc->hdr.version > SMC_V1)
>>  		ini->smcd_version |=
>>  				ini->smc_type_v2 != SMC_TYPE_N ? SMC_V2 : 0;
>> +	if (!(ini->smcd_version & SMC_V2)) {
>> +		rc = SMC_CLC_DECL_PEERNOSMC;
>> +		goto out;
>> +	}
>>  	if (!smc_ism_v2_capable) {
>>  		ini->smcd_version &= ~SMC_V2;
>> +		rc = SMC_CLC_DECL_NOISM2SUPP;
>>  		goto out;
>>  	}
>>  	pclc_v2_ext = smc_get_clc_v2_ext(pclc);
>>  	if (!pclc_v2_ext) {
>>  		ini->smcd_version &= ~SMC_V2;
>> +		rc = SMC_CLC_DECL_NOV2EXT;
>>  		goto out;
>>  	}
>>  	pclc_smcd_v2_ext = smc_get_clc_smcd_v2_ext(pclc_v2_ext);
>> -	if (!pclc_smcd_v2_ext)
>> +	if (!pclc_smcd_v2_ext) {
>>  		ini->smcd_version &= ~SMC_V2;
>> +		rc = SMC_CLC_DECL_NOV2DEXT;
>> +	}
>>  
>>  out:
>> -	if (!ini->smcd_version) {
>> -		if (pclc->hdr.typev1 == SMC_TYPE_B ||
>> -		    pclc->hdr.typev2 == SMC_TYPE_B)
>> -			return SMC_CLC_DECL_NOSMCDEV;
>> -		if (pclc->hdr.typev1 == SMC_TYPE_D ||
>> -		    pclc->hdr.typev2 == SMC_TYPE_D)
>> -			return SMC_CLC_DECL_NOSMCDDEV;
>> -		return SMC_CLC_DECL_NOSMCRDEV;
>> -	}
>> +	if (!ini->smcd_version)
>> +		return rc;
> 
> Is rc guaranteed to be initialized? Looks like ini->smcd_version could
> possibly start out as 0, no?
> 

Per protocol it should not happen that neither v1 nor v2 is set, but its good
to harden the code so initializing the rc really makes sense, thank you.
I will send a v2 with such a change.

>>  
>>  	return 0;
>>  }
>> @@ -1473,6 +1475,12 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
>>  	}
>>  }
> 
>> @@ -1630,10 +1647,14 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>>  		return 0;
>>  
>>  	if (pclc->hdr.typev1 == SMC_TYPE_D)
>> -		return SMC_CLC_DECL_NOSMCDDEV; /* skip RDMA and decline */
>> +		/* skip RDMA and decline */
>> +		return ini->rc ?: SMC_CLC_DECL_NOSMCDDEV;
>>  
>>  	/* check if RDMA is available */
>> -	return smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
>> +	rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
>> +	smc_find_ism_store_rc(rc, ini);
>> +
>> +	return (!rc) ? 0 : ini->rc;
> 
> Since I'm asking questions anyway - isn't this equivalent to 
> 
> 	return ini->rc; 
> 
> since there's call to
> 
> 	smc_find_ism_store_rc(rc, ini);
> 
> right above?
> 

ini->rc could be set due to a previous error in a called function, 
but finally another initialization was successful when rc == 0, 
so ignore ini->rc in that case.

-- 
Karsten

(I'm a dude)
