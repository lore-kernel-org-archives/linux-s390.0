Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23104C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 12:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55AC6141E
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 12:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhD1MlU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 08:41:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235630AbhD1MlU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 08:41:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SCYFff187264;
        Wed, 28 Apr 2021 08:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=etEjbbGKn2hpHf6c3/y+kKqdCCQNX90zvsHG3RWd7B4=;
 b=cNsffSVEnFkc++NJQIp0dmvC1K9nwT9t17sHp9OLjTZbZU0CS0BvN8Lo/BbqG7QSLkvh
 rIAqirmiTC88/bimrVzHe3R0XqL3QqGJ1AVcJVsawbeuw1ZzLLKAB0sO0zupPKvLzx/s
 JgrylGIY/kGn9AXJ8sdnXO53kHv5dHDYkcnvq040iOsKF3S1RK9buRlld1nCI3aXYrgp
 ddrOqUF2H9vqiChnuK2c/V0Ycu7C0Ml13j1wFN13ESiwv954sOxssJ8jQDw7PJHgP37v
 EDE19Hj+pSd3c+zNTNLsbbIFkKfRZuIp5P+/uSk6TqO529gSaTLfjk5doSReQoKleezZ Xw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38767tu925-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 08:39:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SCReCO032532;
        Wed, 28 Apr 2021 12:39:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 384akh9vpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 12:39:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SCdOGx37093778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 12:39:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1A8AA4040;
        Wed, 28 Apr 2021 12:39:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD21A4053;
        Wed, 28 Apr 2021 12:39:24 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.77.184])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Apr 2021 12:39:24 +0000 (GMT)
Subject: Re: [PATCH v2] s390/sclp_vt220: Fix console name to match device
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philipp Kern <pkern@debian.org>,
        Benjamin Zimmermann <dave@oss.volkswagen.com>,
        debian-s390@lists.debian.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <3bfd4202-5c04-8ec7-94dc-8b60e7d73bca@de.ibm.com>
Date:   Wed, 28 Apr 2021 14:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210427194010.9330-1-vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sit4_sRX9MqvpxcdYTSGjmn0-fay0Nui
X-Proofpoint-ORIG-GUID: sit4_sRX9MqvpxcdYTSGjmn0-fay0Nui
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_06:2021-04-27,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 27.04.21 21:40, Valentin Vidic wrote:
> Console name reported in /proc/consoles:
> 
>    ttyS1                -W- (EC p  )    4:65
> 
> does not match the char device name:
> 
>    crw--w----    1 root     root        4,  65 May 17 12:18 /dev/ttysclp0
> 
> so debian-installer inside a QEMU s390x instance gets confused and fails
> to start with the following error:
> 
>    steal-ctty: No such file or directory
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>

Ok, I will apply this internally for a while to give it some test coverage.
I also think that I found a potential statement for the documentation issue.

The tty will simply continue to work (as tty and console are not connected),
but for the console on LPAR you usually do things like
"console=ttyS0 console=ttyS1" to get console output on both (sclp line mode and
sclp full screen AKA ascii console).

When we now change the documentation to
"console=ttyS0 console=ttyS1 console=ttysclp0" the kernel will ignore the missing
console.


> ---
>   v2: also update preferred console for VT220 case
> 
>   arch/s390/kernel/setup.c       | 2 +-
>   drivers/s390/char/sclp_vt220.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 72134f9f6ff5..3ec6ca9c26c0 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -165,7 +165,7 @@ static void __init set_preferred_console(void)
>   	else if (CONSOLE_IS_3270)
>   		add_preferred_console("tty3270", 0, NULL);
>   	else if (CONSOLE_IS_VT220)
> -		add_preferred_console("ttyS", 1, NULL);
> +		add_preferred_console("ttysclp", 0, NULL);
>   	else if (CONSOLE_IS_HVC)
>   		add_preferred_console("hvc", 0, NULL);
>   }
> diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
> index 047f812d1a1c..71ed1bf15598 100644
> --- a/drivers/s390/char/sclp_vt220.c
> +++ b/drivers/s390/char/sclp_vt220.c
> @@ -35,8 +35,8 @@
>   #define SCLP_VT220_MINOR		65
>   #define SCLP_VT220_DRIVER_NAME		"sclp_vt220"
>   #define SCLP_VT220_DEVICE_NAME		"ttysclp"
> -#define SCLP_VT220_CONSOLE_NAME		"ttyS"
> -#define SCLP_VT220_CONSOLE_INDEX	1	/* console=ttyS1 */
> +#define SCLP_VT220_CONSOLE_NAME		"ttysclp"
> +#define SCLP_VT220_CONSOLE_INDEX	0	/* console=ttysclp0 */
>   
>   /* Representation of a single write request */
>   struct sclp_vt220_request {
> 
