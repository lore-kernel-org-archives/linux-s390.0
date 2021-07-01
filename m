Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4371EC11F64
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 16:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1654361002
	for <linux-s390@archiver.kernel.org>; Thu,  1 Jul 2021 16:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGAQaq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:30:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229978AbhGAQaq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jul 2021 12:30:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161G3DtM135217;
        Thu, 1 Jul 2021 12:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TKlIvddeAkn3PHTy1AkK3hb1uaXCNaLkqTEERtnGJN8=;
 b=CkKELmfaAOuh6t6agdwsXJTThr8IYx8f7sJW17NM4JFFxYv6nN8l5nsMPCVVL1VGmOqf
 ZD/bKM373tLuLKr/98/yn0vkYOIQxICQeNLSlsRaluTdSHU6tOCYZ8J9ojXFC72eB9W5
 gZ2aCd/UF/9fwIqxsZZ5ZOWg8AL6IBnwSMtgP56AQ9Q3A1vTb1AgSA6aX0V7ljomLpOD
 DC5ZHgAE/ZHCfgPUGFlMr/JL5yzmy2EYvUp8QZTmvVOTEJKC/eSZxRqwI96JNqVnBPk2
 VqcwEI1UchRHDx2Ja8zjQf1GSNjmE7NBLR47jOpPuU+Ia8gNYcUaIlLQxZe69LQoQRNd wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hcn8s2nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 12:28:14 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161G3Epc136445;
        Thu, 1 Jul 2021 12:28:13 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hcn8s2md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 12:28:13 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161GRmK7011854;
        Thu, 1 Jul 2021 16:28:11 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 39duve5k54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 16:28:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161GSAeg34275788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 16:28:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4065B7806E;
        Thu,  1 Jul 2021 16:28:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B7C478060;
        Thu,  1 Jul 2021 16:28:09 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.163.230])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 16:28:09 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390/vfio-ap: r/w lock for PQAP interception
 handler function pointer
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210621155714.1198545-1-akrowiak@linux.ibm.com>
 <20210621155714.1198545-3-akrowiak@linux.ibm.com>
 <8936a637-68cd-91f0-85da-f0fce99315cf@linux.ibm.com>
 <53181dcb-cabc-d6a1-3bbe-7eba298f06fe@de.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <c19442b4-8e8f-0cea-c47b-af62226022f2@linux.ibm.com>
Date:   Thu, 1 Jul 2021 12:28:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <53181dcb-cabc-d6a1-3bbe-7eba298f06fe@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7JIC4gLV1idhGRks0cnhc3XUsDK6qGZk
X-Proofpoint-ORIG-GUID: ackSi3_TZlur4vOPEHXe6Ne5SB9w_M8E
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/1/21 11:25 AM, Christian Borntraeger wrote:
> On 30.06.21 17:18, Tony Krowiak wrote:
>> I assumed that this patch would get queued along with the other one 
>> in this series,
>> but it looks like that was an erroneous assumption. Should this also 
>> be queued?
>
> Sorry, this is on my todo list.

That's fine, it is probably a good thing it wasn't merged. I found a 
problem with the patch and am working on a replacement. I'll be posting 
it soon.

