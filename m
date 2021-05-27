Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D99C47082
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 00:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B146128D
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 00:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhE0AIe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 May 2021 20:08:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234930AbhE0AIa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 20:08:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R05eu4065320;
        Wed, 26 May 2021 20:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=u6hjFMW9TuMhe5YkAhMQg3fEC96Zzgog9npzUE1RTPo=;
 b=SQpO94vHOOjLLZDlJb4AHgwR3jRXwN3uYRhtinEOh4lWr5MZt8mmLsLCNbkocuimLkA7
 VOZXgElIT+TDYdYLXJFdKCKNHowdbEq3fGMGtVoaU1DwdAc595lejU8qFkMnTzFV8Uy/
 1NhwunsUhEiO9NyuUb5XDUBSYRizc/jUpqwygQW3bpxt8P+XooPvl5ExWnSNJePw9Aks
 2nNOawhc9013Io8fg7xFjRw5NhFZuYy8RAgQRqLQUtr7EvPRpizC6w+aUD3WwmcGafo3
 aT2VloIeEbc+UM1jeGSq39JeoJogaH1kvW9lvJSOTwFXbhvmRAUJ4UMeHrvNgfx1iU7A bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sxy2j1ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 20:06:31 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14R05sOc066176;
        Wed, 26 May 2021 20:06:30 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sxy2j1r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 20:06:30 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14R03RXC003950;
        Thu, 27 May 2021 00:06:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 38svvr015f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 00:06:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14R06PkA33620356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 00:06:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3631AE055;
        Thu, 27 May 2021 00:06:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C943AE056;
        Thu, 27 May 2021 00:06:24 +0000 (GMT)
Received: from localhost (unknown [9.171.70.203])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 27 May 2021 00:06:24 +0000 (GMT)
Date:   Thu, 27 May 2021 02:06:23 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     hca@linux.ibm.com, borntraeger@de.ibm.com, tglx@linutronix.de,
        keescook@chromium.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH] softirq/s390: Use the generic local_softirq_pending()
Message-ID: <your-ad-here.call-01622073983-ext-1568@work.hours>
References: <1621859957-4880-1-git-send-email-yejunedeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1621859957-4880-1-git-send-email-yejunedeng@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sr6KE_qrqYKe0z_kuv59WS1yp1W0y5qx
X-Proofpoint-ORIG-GUID: PV1CqHJdiWZAjrzfOC8WZsfeb7drC5nm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_13:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=792 lowpriorityscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260163
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 24, 2021 at 08:39:17PM +0800, Yejune Deng wrote:
> Defined local_softirq_pending_ref macro and get rid of {local, set, or}
> _softirq_pending macros. use {local, set, or}_softirq_pending
> in <linux/interrupt.h> that rely on per-CPU mutators.
> 
> Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
> ---
>  arch/s390/include/asm/hardirq.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
> index 58668ff..ea643d6 100644
> --- a/arch/s390/include/asm/hardirq.h
> +++ b/arch/s390/include/asm/hardirq.h
> @@ -13,9 +13,7 @@
>  
>  #include <asm/lowcore.h>
>  
> -#define local_softirq_pending() (S390_lowcore.softirq_pending)
> -#define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
> -#define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
> +#define local_softirq_pending_ref  S390_lowcore.softirq_pending

S390_lowcore is not a per-CPU variable, so it cannot be accessed with
__this_cpu_read/write...

"lowcore" is a kind of hardware "per-CPU" area on s390. Each cpu accessing
first 2 pages at the real address 0 is actually touching pages at the
"absolute" address specified by prefix register of this cpu.

