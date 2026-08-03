Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC3345EC8;
	Mon,  3 Aug 2026 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785730673; cv=none; b=Y3sZJwQunM89rxrTRlEt62SuWrRLg9JaPNYlBwsDaTifkTel9pBoOCE1uLllA0aQppqFbtPw3eiAMmfa1X0OhKz2dckaayNNGy1KxGo3aeZ2msZeygpexpC3CmTJ+wT70SsNFT0AbegVjuEZWgGqOKDFvnM0w9NRI5RUT16P9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785730673; c=relaxed/simple;
	bh=I4Fj0pUI/dUFPgy9v4dJBSGl46oZA5/ehJskVjzQe2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qozXr+roL/jJ6gwDWrNkljvA29tYparDeKix6D323iUilgFzSnnFNjL/f1aOXBrQnlnO/UtjqVgkLbYQyCPuwVA61YLSNpFOXrCDFtogFYvahIF8jnhnsmIJ6Uh0nX40PliLoYBeVyuS38XmjM2tC3LychKWrosAHW1Mp+CaqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TW0tWd5D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TW0tWd5D"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlwKs2564518;
	Mon, 3 Aug 2026 04:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c5Pwdy
	SlydojW+EvhZ0kXizBA3kv7sqqZ5P+YBN6Z4Y=; b=TW0tWd5Dr7u9kmBnFEK2YX
	BTxaNhbr96yAd/Fg9INy5OZju3m9yJRSbzF7LCohiqgJ1XJjkdlK1f9Krbqq05/H
	V3G4KXmVqwbQAY+iZiHexlSXvkbSGcHK/PrsxtRLm1GKfGofOxI9zLUuzoS8jgG6
	kkxL4nqEmoh+5kXe32YvxnmbjHC++y9bm1Iol/X/2PHjAyHp7pfmdHoQhgMu9nkt
	ZdNeH8/pke/GHHL1etYYqrd+LtYHPI1SO3QQ4eK2r5AGqA1M0zEgxiMe9dXDDE0h
	oUczUliy2OB9S59srcBQjMaSCv4zXm0ELu67g3qwL/T3RsQBBNJa/+JfCpJWaM3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqeqtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:17:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6734BCK1022748;
	Mon, 3 Aug 2026 04:17:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg3fy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 04:17:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6734HdlA25887450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 04:17:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7CD65805B;
	Mon,  3 Aug 2026 04:17:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 176BF5805C;
	Mon,  3 Aug 2026 04:17:34 +0000 (GMT)
Received: from [9.39.26.221] (unknown [9.39.26.221])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 04:17:33 +0000 (GMT)
Message-ID: <f4ccbdc8-5a69-435d-b5e0-0d913c07a5bc@linux.ibm.com>
Date: Mon, 3 Aug 2026 09:47:32 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix qentry overwrite for CONFIRM_LINK and
 ADD_LINK_CONT in smc_llc_event_handler()
To: dust.li@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
        hidayath@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260729130153.970800-1-mjambigi@linux.ibm.com>
 <amxLpKV3OBZ3rxus@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <amxLpKV3OBZ3rxus@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: abmZ_Zmx4OEbYSXjem4sKNIr6R62--de
X-Proofpoint-ORIG-GUID: ShsnzuUXLWQVHUjjfNqyzFABqTZX2Mfz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAzNCBTYWx0ZWRfX7lv0nKH0uI04
 aV4ZJykZv2Fsvfln/IEIYMeeIkvvZuMSq+idWrpCIy350k+Tiw+xqVvhJsIiDd6eRd9J1dGZDhG
 OtJdELDS9kiVJp0msPU8R3+dlbEJx6Q=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a701667 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=zlnZt1FpZ-lonQPLk2EA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAzNCBTYWx0ZWRfX2WVcSD4A9Bnn
 ebGwfSLaR4NbtEkD70Wv8zCGrpG9lXEET0R4zyvK8h/PQIlhd9IWKXRY1RMbavC4ZYT8CwhIcJV
 W/erbqJ7mBg+lq4US2E8t938htR87qnyWMfPu1Q/TwAcOFzMnTkzeWbynW77SFAFEgesZPGXOOw
 71rbxXYdwLeIqnuLj5WHGBRIvTS5zDeRk4ZyLcqmljCSB2vHfX0o04f4YTX1DiLB+suxkInqCKQ
 U6WrpODoD8FfQa59XYarIox2oh6VIqDcpHfztMAeCvbvN5nTgalPXAtgtmPmoqdC0Y5+AcM7VNt
 H5WKT1MCUlWHGEMFPLGO0dNbJfDEgV50+vE3/2tLX0mAfYqgReulyaIrus4HdlQyPypdJtocFMx
 Zhy5tM5Io280+xiXXKSmzLEQciGWnzdsgWp6M7qMqUrf+VDdAF5twC5q+LS7qiFoiJAXhamQnAf
 w5IzC1Q5jvKvrjwNB/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030034



On 31/07/26 12:45 pm, Dust Li wrote:
> On 2026-07-29 15:01:53, Mahanta Jambigi wrote:
>> The SMC_LLC_CONFIRM_LINK / SMC_LLC_ADD_LINK_CONT branch in
>> smc_llc_event_handler() stores an incoming qentry into the local LLC flow
>> without first checking whether a qentry is already pending. If a malicious or
>> buggy peer sends a second CONFIRM_LINK or ADD_LINK_CONT request while a flow is
>> active and flow->qentry is already set, smc_llc_flow_qentry_set() overwrites the
>> pointer without freeing the previous allocation, leaking one kmalloc-96 object
>> per spurious message.
>>
>> The sibling SMC_LLC_DELETE_LINK branch already has the correct !flow->qentry
>> guard. Apply the same guard to the CONFIRM_LINK/ADD_LINK_CONT branch so that a
>> duplicate message when qentry is already occupied falls through to break and is
>> freed by the kfree(qentry) at the out: label, rather than silently leaking the
>> existing allocation.
>>
>> The response direction (smc_llc_rx_response()) is unaffected: it already guards
>> with flow->qentry at the equivalent site and drops duplicate responses
>> correctly.
>>
>> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
>> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>> Reviewed-by: Hidayath Khan <hidayath@linux.ibm.com>
>> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>> ---
>> net/smc/smc_llc.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
>> index 954b2ff1815c..aa6d83af55ed 100644
>> --- a/net/smc/smc_llc.c
>> +++ b/net/smc/smc_llc.c
>> @@ -1927,7 +1927,8 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
>> 		return;
>> 	case SMC_LLC_CONFIRM_LINK:
>> 	case SMC_LLC_ADD_LINK_CONT:
>> -		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE) {
>> +		if (lgr->llc_flow_lcl.type != SMC_LLC_FLOW_NONE &&
>> +		    !lgr->llc_flow_lcl.qentry) {
> 
> 
> I read sashiko's review comments, and I think both of them make sense, but
> they were pre-existing issues. So I think we can solve them in the future
> patches.

That's right! I'll address them in separate patches. Thanks for the R-b.

> 
> https://sashiko.dev/#/patchset/20260729130153.970800-1-mjambigi@linux.ibm.com
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> Best regards,
> Dust
> 
> 

