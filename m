Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FCC433ED
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 21:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A4461447
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhD1VES (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 17:04:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231218AbhD1VEQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 17:04:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SL25L3153792;
        Wed, 28 Apr 2021 17:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LFvpvudi6cDDlcXBX0V6icMIFr+fBvs03XaEAwnJV7o=;
 b=ppNbP1aP0yLbvbiJYNv5UaOgvXip5nFwsslq04kQulGTbj3y5zvwM9Gy4HRpenM8BHqf
 dVbQSRx2Dlj69tUdQq0cVQhUxihE7PSUR62RJkk2UHKsD6dYJRzWQ1dvEUzSdd9VX/PO
 Wb2mf0XinmQSjM0Daql1+AGrXm2vVJixB5Yyyp3CDH3jJInCuLOQ5w/r73fbBdPrdCnw
 niLjT889ev/HK5x8jlRwpWGR4t3vTlPk+FE3HNvjPrw5IZM3uggXl5r1TZNmhalbLko7
 XaJcbDl3TBiOJqswHvAETDVSKKIQ0C3BC9szKHLIYU30HSJHWi1w6okcczxsnhzlhO5H ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 387f92g0jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 17:03:29 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13SL2HNa154082;
        Wed, 28 Apr 2021 17:03:29 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 387f92g0j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 17:03:29 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SL3RVb007431;
        Wed, 28 Apr 2021 21:03:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 384ay8j2kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 21:03:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SL2x6j34472426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 21:02:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B1DCAE04D;
        Wed, 28 Apr 2021 21:03:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EE1BAE045;
        Wed, 28 Apr 2021 21:03:23 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.77.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Apr 2021 21:03:22 +0000 (GMT)
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, cohuck@redhat.com
References: <20210428082442.321327-1-thuth@redhat.com>
 <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
 <6e44cc81-fe19-f75b-972f-5c4707f2410f@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <b75f0447-55d4-09b8-8f3e-d0d54471cac1@de.ibm.com>
Date:   Wed, 28 Apr 2021 23:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <6e44cc81-fe19-f75b-972f-5c4707f2410f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QNP59KlRt9igWLM2dHCx1bg1I6Dp0_d8
X-Proofpoint-ORIG-GUID: kV9X_M9nncp7xe9HpMK5wN6i2wB46icx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_16:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280133
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 28.04.21 11:30, Thomas Huth wrote:
> On 28/04/2021 10.31, Christian Borntraeger wrote:
>> On 28.04.21 10:24, Thomas Huth wrote:
>>> In former times, the virtio-console code had to be compiled into
>>> the kernel since the old guest virtio transport had some hard de-
>>> pendencies. But since the old virtio transport has been removed in
>>> commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
>>> we do not have this limitation anymore.
>>> Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
>>> Kconfig") then also lifted the hard setting in the Kconfig system, so
>>> we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
>>> driver as a module now, making it more flexible for the user to only
>>> load it if it is really required.
>>
>> Isnt that a distro specific decision? I would be perfectly fine to have
>> this change in Fedora, Redhat and co.
> 
> Sure, I'll try to get it changed there, too.
> 
>> Not so sure about defconfig.
>> We often use the defconfig in our CI and development things to have a
>> kernel config that boots up fine, even without a ramdisk. I agree that
>> virtio console is no longer really the most important console but does
>> it really hurt?
> 
> Well, it's about a default configuration that should be fine for most users. I don't think that anybody really uses virtio-console in a ramdisk already ... or are you really doing that in your CI? If so, then please disregard my patch.

I think anybody uses the sclp console nowadays. The only question is, do
we care about manual configs with virtio-console?
