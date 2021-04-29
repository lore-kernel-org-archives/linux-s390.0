Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA13C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 29 Apr 2021 06:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B384E61446
	for <linux-s390@archiver.kernel.org>; Thu, 29 Apr 2021 06:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhD2GsV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Apr 2021 02:48:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhD2GsV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Apr 2021 02:48:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13T6XGnW080735;
        Thu, 29 Apr 2021 02:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vM5+vU/Z6Lm6XndWosoUTktdcsBjZ50Ncx13JytSvQg=;
 b=VuVrqF+ZOrsBfoXBuIk7fe2kfOh2er+uRCuUBxCUKj/hOMhnzIq39zNRKDFWCuY4e5gJ
 6eTCOAKOEGBCcYGVuzo9CTnutgeCFE5YgywjzPn5OADiK6NHF4mHzlNnQoWLX+xoz7i0
 CMMgut5Zf9MYvW6U3SSgCma11bekBnmsTiz7z2Yn2Y0f4gzueQbPsZ5e79TX/v23J1Nd
 JhkuaSeo2mM5OcqOuQWoVPbVawr43pfDMahyg+OSYye4Or+7CsA9qhvintuzAImWI2zv
 TO0WkXtbeS4eILaNYS8l2c/rQvai42ApMsP63joZPNigJwDttBZaYIB3mBa8+omhjDfJ nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387pafacyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 02:47:34 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13T6XbYW084891;
        Thu, 29 Apr 2021 02:47:34 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387pafacxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 02:47:34 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13T6cEjT025759;
        Thu, 29 Apr 2021 06:47:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 384ay898h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 06:47:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13T6l3NN24248592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 06:47:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1708152052;
        Thu, 29 Apr 2021 06:47:28 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.65.86])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA65652050;
        Thu, 29 Apr 2021 06:47:26 +0000 (GMT)
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, cohuck@redhat.com
References: <20210428082442.321327-1-thuth@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <6e6a8f49-4af7-1411-0aa8-a40641812d37@de.ibm.com>
Date:   Thu, 29 Apr 2021 08:47:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210428082442.321327-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 55u7eIB2L9pWBeQeuQM1mkk_0NwwuiUH
X-Proofpoint-ORIG-GUID: YhH2_gDE6ErZXwuzpsbJqlZQ1KlyoFt9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_03:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104290050
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
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

applied, thanks.
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
