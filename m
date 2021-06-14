Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05264C2B9F4
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C878861246
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 17:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhFNRb4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:31:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235578AbhFNRbz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 13:31:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EH3v9T092828;
        Mon, 14 Jun 2021 13:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aND35PJ8MHGJdRYQIgpzffcskjOGhU3VFMYNJ/krR20=;
 b=kFp5OUI8vTxhFGF1wwhqRRBy9LdDW8SCFmHYI0Oqbomb5UV4PSmGdoMjjnvZU1+hpPn3
 SwcAN+Hy5acFMkWeyPrBz0qssXPnTHaLOuwe35KcDSG+UmkYfhF2V9jB/uppvL501dWZ
 ya5KjSAyT8twORFNSD5R8N8iBu09UAfDIKr6E7hYbrpTT6gUZ9jURIEfAvsMsaHf25XJ
 bdRbUc/xIsGGs2DeCP3PFyjOAI5JUiE2r5Bs+h6/0CUw4lC5fTrBtDVOkHaXu0UG+RER
 FV+8sNAoSZUY4UtKEJ3IsFwbg4bTTcWgCclsszBtDFQjbfzZQz9VfWmeBkLNNGWsrjKL 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3969qq3qqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 13:29:49 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15EH4HKR095953;
        Mon, 14 Jun 2021 13:29:49 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3969qq3qpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 13:29:49 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15EHDL7v016359;
        Mon, 14 Jun 2021 17:29:48 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 394mj91ee5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 17:29:48 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15EHTle39634686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 17:29:47 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CEC8AE076;
        Mon, 14 Jun 2021 17:29:46 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBDDAE064;
        Mon, 14 Jun 2021 17:29:45 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.128.252])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 17:29:45 +0000 (GMT)
Subject: Re: [PATCH 1/3] s390/vfio-ap: clean up mdev resources when remove
 callback invoked
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210609224634.575156-1-akrowiak@linux.ibm.com>
 <20210609224634.575156-2-akrowiak@linux.ibm.com>
 <20210611164854.GT1002214@nvidia.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <2e16ab9c-8954-c598-e66a-6531538fefad@linux.ibm.com>
Date:   Mon, 14 Jun 2021 13:29:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611164854.GT1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V0ERs9jfOIjSaN6tFkao2x7AhQTu782C
X-Proofpoint-GUID: rQ0ieAAtuRcv5OzsYiaI23XDxShI4Uao
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_10:2021-06-14,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=963 adultscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140108
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/11/21 12:48 PM, Jason Gunthorpe wrote:
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Thanks for the review.

