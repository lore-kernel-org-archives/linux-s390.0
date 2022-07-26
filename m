Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B1BC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 26 Jul 2022 10:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiGZK60 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 26 Jul 2022 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiGZK6Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Jul 2022 06:58:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE630F56
        for <linux-s390@vger.kernel.org>; Tue, 26 Jul 2022 03:58:24 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QAlRiS038847;
        Tue, 26 Jul 2022 10:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V7mjGSckiGExXQcedoBaK3/QexJMigE3UGvHyT/2JMw=;
 b=WWkgV1wNNwuX9IUjWhJ7EoiyIK1yj0BnRAoWkR3YYK/z/S9nvS+re0ZI5/anobiBJO7O
 mgTzBjQiRlTLWrDo66aXwmz9jgc3yol/RuS2uqiwO8pYefcsMqwScfMyYIkve3/WlBVJ
 2ZxA94+0gfNW4/fM0frgzErnIRkTFTDnvemn9VVQLAABsLkbNRHyOpoMQXW5Pw1AO5wq
 azIoqQ4meNX/tRloRSowUqCqwLoHbtP/qxHrQfFxrdH05u/qAuCA5qh+aLFftun0eZRH
 qPUYcEs6vd2LYVAiYJVm8u7BlNDP7g6lt/ASF8oRx/fL9q6mLWpVrG+6VwMynL1Hj5ah Ew== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjetxr7dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:58:21 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QAp8ih013622;
        Tue, 26 Jul 2022 10:58:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3hg945jrb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:58:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QAwUkc32702864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 10:58:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE63DA4051;
        Tue, 26 Jul 2022 10:58:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87EA8A4040;
        Tue, 26 Jul 2022 10:58:16 +0000 (GMT)
Received: from [9.152.212.151] (unknown [9.152.212.151])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jul 2022 10:58:16 +0000 (GMT)
Message-ID: <244e66a5-2a81-2275-e97d-ebe3186ccebb@linux.ibm.com>
Date:   Tue, 26 Jul 2022 12:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RFC: dasd: use blk_mq_alloc_disk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
References: <20220721133251.1878402-1-hch@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20220721133251.1878402-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RmXpDEM0NHGsiB1Hz9jlIze9l-o6mstu
X-Proofpoint-GUID: RmXpDEM0NHGsiB1Hz9jlIze9l-o6mstu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_03,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=609
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260039
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 21.07.22 um 15:32 schrieb Christoph Hellwig:
> As far as I can tell there is no need for the staged setup in
> dasd, so allocate the tagset and the disk with the queue in
> dasd_gendisk_alloc.
>
> Warning: untested due to a lack of hardware.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for the patch. From a first quick look it looks reasonable.
I will give it a try on my test machine.

