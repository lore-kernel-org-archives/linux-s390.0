Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF5C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12778613DA
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 08:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhD1Ics (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:32:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237513AbhD1Icq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 04:32:46 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13S8E8tU061098;
        Wed, 28 Apr 2021 04:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kmjMErMBHeBNL2bcbe2uefJYtZjeT6aqWNd0NuLNPyY=;
 b=HxmxAyTBZMh3/x7/CjwqtbLnJsGw3N38EJwQ78c/0qW3/ufOMaM+a8fPRNMIpUPI+iiN
 XejLIDYkm+Q28THkI/c88c7e8lZk/WZa3p3Ntni+j1ZEKLqh4c+llyNkI/PS2WwgddPq
 /Wn3dX//DDYVg/7RAba0vWMVaELISvzA+KAajIMW/lbk08YmlSKtAPjdy/ma8U29tHE6
 MSkx2dME/RFQ3vQD3ne00pKTIsU425bOZBAMazqti6eU5Sg3fJwbqJ9q0Ia3HP4nX1JS
 hr+9MHaX5R8cVTrRt8Bk7jS9ON1MBoYzmQOmQxcfiFTU+lIeei+cFgJSDldHYrmpjc9K wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38740t8euu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 04:32:01 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13S8FjcA066976;
        Wed, 28 Apr 2021 04:32:01 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38740t8eu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 04:32:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13S8NSbj028649;
        Wed, 28 Apr 2021 08:31:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 384ay8hrsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 08:31:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13S8Vtc229753828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 08:31:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A1DA405C;
        Wed, 28 Apr 2021 08:31:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4D5A405B;
        Wed, 28 Apr 2021 08:31:54 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.77.184])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Apr 2021 08:31:54 +0000 (GMT)
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, cohuck@redhat.com
References: <20210428082442.321327-1-thuth@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
Date:   Wed, 28 Apr 2021 10:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210428082442.321327-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ogGB98aZagDvQsl3heFp72alFwTow7FH
X-Proofpoint-ORIG-GUID: rF2pyNc-wbqrMTt0cQIPd54tnRiYGOYA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_03:2021-04-27,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280054
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28.04.21 10:24, Thomas Huth wrote:
> In former times, the virtio-console code had to be compiled into
> the kernel since the old guest virtio transport had some hard de-
> pendencies. But since the old virtio transport has been removed in
> commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
> we do not have this limitation anymore.
> Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
> Kconfig") then also lifted the hard setting in the Kconfig system, so
> we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
> driver as a module now, making it more flexible for the user to only
> load it if it is really required.

Isnt that a distro specific decision? I would be perfectly fine to have
this change in Fedora, Redhat and co. Not so sure about defconfig.
We often use the defconfig in our CI and development things to have a
kernel config that boots up fine, even without a ramdisk. I agree that
virtio console is no longer really the most important console but does
it really hurt? Is any distro using the defconfig unmodified?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/s390/configs/debug_defconfig | 2 +-
>   arch/s390/configs/defconfig       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index dc0b69058ac4..04ce0edd0b31 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -548,7 +548,7 @@ CONFIG_INPUT_EVDEV=y
>   # CONFIG_INPUT_MOUSE is not set
>   # CONFIG_SERIO is not set
>   CONFIG_LEGACY_PTY_COUNT=0
> -CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_VIRTIO_CONSOLE=m
>   CONFIG_HW_RANDOM_VIRTIO=m
>   CONFIG_RAW_DRIVER=m
>   CONFIG_HANGCHECK_TIMER=m
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 320379da96d9..e448711eff8d 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -540,7 +540,7 @@ CONFIG_INPUT_EVDEV=y
>   # CONFIG_INPUT_MOUSE is not set
>   # CONFIG_SERIO is not set
>   CONFIG_LEGACY_PTY_COUNT=0
> -CONFIG_VIRTIO_CONSOLE=y
> +CONFIG_VIRTIO_CONSOLE=m
>   CONFIG_HW_RANDOM_VIRTIO=m
>   CONFIG_RAW_DRIVER=m
>   CONFIG_HANGCHECK_TIMER=m
> 
