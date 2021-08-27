Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00481C432BE
	for <linux-s390@archiver.kernel.org>; Fri, 27 Aug 2021 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22FD60ED5
	for <linux-s390@archiver.kernel.org>; Fri, 27 Aug 2021 13:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhH0NoD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 27 Aug 2021 09:44:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21000 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232312AbhH0NoB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Aug 2021 09:44:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RDYK2V058958;
        Fri, 27 Aug 2021 09:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NcyAFygEloHrzR2BPB+9hg/HsZPI/Rn5It99jayT6Wk=;
 b=dvQi3upwvYdkY8+ANukCwYkeTIJMPwT/ac6B3Bw833ZNxCBUo9OYIYVyEMOrJshdfUfJ
 H3ShzgysMJw2zQAamdPDySh5C3nyTeXQJrXjCt0pQlLou8fS28wUS4QY/+TJaR58y8MH
 qaZ+FIrvn7G+KlAAM+X0W7MBtTAqRzVHBbatRsXFE1nryunuGSRSovs+c9dIBSn0KkmI
 b6cdTyUS8u2794XBqBCZvxSb1BA7UQrbaDXaGVsjvMY4/Jg1pnXEcK5qn+rwcN3btSTS
 A1ma0m/0LAs3Pj2Qv5uIqRktEpxMv2f7aUqFHPelQV1KssBxGwon/LnUW84hWKOulsso 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aq0bhhfvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 09:43:09 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17RDYU7R060115;
        Fri, 27 Aug 2021 09:43:09 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aq0bhhfv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 09:43:09 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17RDbWOb025595;
        Fri, 27 Aug 2021 13:43:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3anhsqkeum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 13:43:08 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17RDh6d052625894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 13:43:07 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DED6EBE054;
        Fri, 27 Aug 2021 13:43:06 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD8DBE061;
        Fri, 27 Aug 2021 13:43:05 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com (unknown [9.160.142.168])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Aug 2021 13:43:05 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] s390/vfio-ap: do not open code locks for
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        kwankhede@nvidia.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
References: <20210823212047.1476436-1-akrowiak@linux.ibm.com>
 <20210826162056.304eb7ca.alex.williamson@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <a0839835-3259-301d-7aee-beff17ed3c7d@linux.ibm.com>
Date:   Fri, 27 Aug 2021 09:43:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210826162056.304eb7ca.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5lCPac_bntS9CcVyktmYRt6Xa-nZRPNM
X-Proofpoint-GUID: fippi_uHSUhVSqfoM4pSyEii4TrrgS-3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_04:2021-08-26,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 8/26/21 6:20 PM, Alex Williamson wrote:
> On Mon, 23 Aug 2021 17:20:45 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> The subject line does not necessarily encompass both patches of this
>> two-patch series, but I left it as versions 1 and 2 used this subject
>> line and I didn't want to confuse those who reviewed those patches.
>>
>> Change log v1->v2:
>> -----------------
>> * Both of these patches were rebased on Alex's linux-vfio-next tree taken
>>    from https://github.com/awilliam/linux-vfio.git.
>>    
>> * Replaced kvm_s390_module_hook structure with a function pointer to the
>>    interception handler for the PQAP(AQIC) instruction.
>>
>> Tony Krowiak (2):
>>    s390/vfio-ap: r/w lock for PQAP interception handler function pointer
>>    s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM
>>      notification
>>
>>   arch/s390/include/asm/kvm_host.h      |   8 +-
>>   arch/s390/kvm/kvm-s390.c              |  32 ++++++-
>>   arch/s390/kvm/priv.c                  |  15 +--
>>   drivers/s390/crypto/vfio_ap_ops.c     | 127 +++++++++-----------------
>>   drivers/s390/crypto/vfio_ap_private.h |   4 +-
>>   5 files changed, 84 insertions(+), 102 deletions(-)
> Applied to vfio next branch for v5.15.  Thanks,
>
> Alex

Thank you Alex.

>

