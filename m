Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC186C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 06:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91DD603E9
	for <linux-s390@archiver.kernel.org>; Tue, 31 Aug 2021 06:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhHaGQv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 31 Aug 2021 02:16:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbhHaGQv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Aug 2021 02:16:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17V63qcE020813;
        Tue, 31 Aug 2021 02:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uLipEFd8kNOzLcifOAUEDmxkp7kk2e/f6vgLeAIed3U=;
 b=YmMgVuTEmR4gRB4hRwqZSphifNnbwHzRrI5U8cQvO49GZWzVi7KSijmwtVPbwUjU0Dhh
 JNzPaYX16z+AalqIl1XAff6bkoTQIm02gyak93LEn+F6k2VYNgx//md1oChgIcuDYaWj
 3Rwj4bUd3fcLMX3R+kIxLx2nA+SzIShVWmrAQ6V5fYWW1JvE7D7vkJtbrumAQhmr3FId
 gXdTR7/YZv13cMEHaLf+AyKMY/XHgF0/gY+evcqMjKi+rdkQCN99JMvR9r3ylfa+AyZO
 YyXzZ/beGumxEwGlI8Wdf0987tPBNrpiI/EwvXJadU+FAKFVdTkwi1AVT6unrZgMcaAz YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asert0ffc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 02:15:56 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17V64GLA022819;
        Tue, 31 Aug 2021 02:15:55 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3asert0fen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 02:15:55 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17V6CvKd003209;
        Tue, 31 Aug 2021 06:15:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3aqcs8kg82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 06:15:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17V6Fnls20185352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:15:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AF2852145;
        Tue, 31 Aug 2021 06:15:49 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.184.25])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2640D52126;
        Tue, 31 Aug 2021 06:15:49 +0000 (GMT)
Subject: Re: [PATCH linux-next] s390:fix Coccinelle warnings
To:     Heiko Carstens <hca@linux.ibm.com>,
        jing yangyang <cgel.zte@gmail.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210820025159.11914-1-jing.yangyang@zte.com.cn>
 <YSPj/YRDlGqoVu26@osiris>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <afd3887e-11e2-1f03-4d40-bae38b28991f@linux.ibm.com>
Date:   Tue, 31 Aug 2021 08:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSPj/YRDlGqoVu26@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0TcdjAuOb1buvV6CJ_tF7iPMJEhhyMP9
X-Proofpoint-GUID: DxL2Wx0LVWL8F3zNVLDYLNFpGJprc1RA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_03:2021-08-30,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310035
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I am a fan of Coccinelle fixes. But, here i think we need to do more 
work than just fixing it to
get rid of the warnings. I agree with Heiko. May be we should re-write 
this entire function and
make it readable.

Nack.


On 8/23/21 8:07 PM, Heiko Carstens wrote:
> On Thu, Aug 19, 2021 at 07:51:59PM -0700, jing yangyang wrote:
>> WARNING !A || A && B is equivalent to !A || B
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
>> ---
>>   arch/s390/include/asm/scsw.h | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
>> index a7c3ccf..754122d 100644
>> --- a/arch/s390/include/asm/scsw.h
>> +++ b/arch/s390/include/asm/scsw.h
>> @@ -691,9 +691,8 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
>>   {
>>   	return (scsw->tm.fctl != 0) &&
>>   	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
>> -	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
>> -		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
>> -		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
>> +		(!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
>> +		(scsw->tm.actl & SCSW_ACTL_SUSPENDED));
> This turns something unreadable into something else which is
> unreadable. It's up to Vineeth to decide what to do with this.
>
> However I'd prefer if this would be changed into something readable,
> maybe as addon patch, like e.g.:
>
> static inline bool scsw_tm_is_valid_pno(union scsw *scsw)
> {
> 	if (scsw->tm.fctl == 0)
> 		return false;
> 	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
> 		return false;
> 	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
> 		return false;
> 	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
> 		return false;
> 	return true;
> }
>
> Chances are that the above is wrong... it's just to illustrate ;)
