Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDAC4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7616103B
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 19:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhG1Tna (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 15:43:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229542AbhG1Tna (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 15:43:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SJXL8v135379;
        Wed, 28 Jul 2021 15:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GoXuoq2mA3sKhgm96U5WuGuFVJDzX6OL+WJU8a8uc9U=;
 b=O4uA/gjOHNN4MlTuzm1PJtNxUl1w1NXKS58xmQJSx3Yd5+UoQfjb2BLMDtmeTp3KFgWl
 prWcEXXwLyj4XBidjt0HPJKBEJGe/9FA3fLPxGsmQ1Tz8JfySzXzFRcGiC6db4mUO8fH
 joZ6CfegHjqOEUpwQt1LpXx1Arxv+kG+fNbktaNaOVr3oNOTrLJi3sXpWPyVBvQwmW3l
 3HQXa5EwP1Hlgz26BKLiQ9uoyFA/A66r2OD8jtRGeuuD4KgK1zBinGjf5tVdcp9MJaEw
 SBnZvvDG+l2yrfV8k9V9lhb+uLbyTImBmKEtOyTKVORj/0hT2IIzYNPjlr2QwwXYqLsx JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3970qrym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:43:25 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SJYokC140683;
        Wed, 28 Jul 2021 15:43:25 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3970qrxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:43:25 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJh4Vk006950;
        Wed, 28 Jul 2021 19:43:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3a235yh98a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:43:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJedXM29098344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:40:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF74AE055;
        Wed, 28 Jul 2021 19:43:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 089CDAE045;
        Wed, 28 Jul 2021 19:43:17 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.11.188])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 28 Jul 2021 19:43:16 +0000 (GMT)
Date:   Wed, 28 Jul 2021 21:42:57 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: Re: [PATCH 2/2] s390/vfio-ap: replace open coded locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210728214257.5e5c28c4.pasic@linux.ibm.com>
In-Reply-To: <a5eeac87-069d-171b-5558-3e99e7bda539@linux.ibm.com>
References: <20210719193503.793910-1-akrowiak@linux.ibm.com>
        <20210719193503.793910-3-akrowiak@linux.ibm.com>
        <20210721164550.5402fe1c.pasic@linux.ibm.com>
        <c3b80f79-6795-61ce-2dd1-f4cc7110e417@linux.ibm.com>
        <20210723162625.59cead27.pasic@linux.ibm.com>
        <5380652f-e68f-bbd0-10c0-c7d541065843@linux.ibm.com>
        <20210726223628.4d7759bf.pasic@linux.ibm.com>
        <20210726220317.GA1721383@nvidia.com>
        <20210727004329.3bcc7d4f.pasic@linux.ibm.com>
        <a5eeac87-069d-171b-5558-3e99e7bda539@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aooRiaCtOkcPwVC3Nnn44YdLxZExvwQA
X-Proofpoint-ORIG-GUID: obFqS2X69t7N59FQd1Uei-Pacax93ZNz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280112
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 28 Jul 2021 09:43:03 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> This solution was suggested by Jason G and it does in fact resolve
> the lockdep splat encountered when starting an SE guest with
> access to crypto resources. There is a chance that the KVM lock
> can get held while waiting for the lock on the matrix_dev->mutex,
> but this does not seem like a grave concern to me. 

Yes I agree. I was thinking along the lines: matrix modifications
via the sysfs take the matrix_dev->lock so the level of contention
may depend on what userspace is doing...

Regards,
Halil
