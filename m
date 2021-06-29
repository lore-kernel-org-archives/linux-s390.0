Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9804C11F69
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EE661DC4
	for <linux-s390@archiver.kernel.org>; Tue, 29 Jun 2021 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhF2PW1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:22:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234627AbhF2PW0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Jun 2021 11:22:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TFGU8u127585;
        Tue, 29 Jun 2021 11:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nt6UfoynStPcV8jN7cA0MSyEzY53XaQqnWLlG2qopuw=;
 b=WRgOMlavSr8JvIfcDyO2r70u4REXwqZCL1H8d/Pavt2x1cSi5vaDaOvtyiwJcH2UQnsP
 Lq9OyvDpisIEwX+pGmgCX7AVDceyx8tYNbZvNGOHpPpXFlPsxkN/uLYihx7qNeR7ZwCX
 IyKXTRZScZJosHJIqZkG3JnL6u6doCQGZ86kSahAYVs9GPaxIDE6PEGvlmK79+xzYSOJ
 fT5OgV9P+ZLJExnkxCZPpxZiHJxHplspNPp6Zxpil48v9P9/9fdZxx9CG9fIWr6odl3o
 3ZsJOcX+Q+mmCtdQ9srDkZLC8TwNflnP8yPL0a8GX1NaHbEQKbne4xVK/q3LYkHjQ4J4 3g== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39g59usne7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 11:19:55 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15TFHt1R015237;
        Tue, 29 Jun 2021 15:19:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 39fv59r4w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 15:19:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15TFJoAR34406670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 15:19:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A83594D2E5;
        Tue, 29 Jun 2021 15:19:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40BAE4D357;
        Tue, 29 Jun 2021 15:19:50 +0000 (GMT)
Received: from [9.171.42.4] (unknown [9.171.42.4])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 15:19:50 +0000 (GMT)
Subject: Re: [PATCH] s390: iucv: Avoid field over-reading memcpy()
To:     Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210616201942.1246211-1-keescook@chromium.org>
From:   Karsten Graul <kgraul@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
Message-ID: <614191b7-6b5f-75f3-7490-62505970ceb5@linux.ibm.com>
Date:   Tue, 29 Jun 2021 17:19:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616201942.1246211-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W3SLJvF0rvehUukSmZQlB4n5y5wA6zcF
X-Proofpoint-ORIG-GUID: W3SLJvF0rvehUukSmZQlB4n5y5wA6zcF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_07:2021-06-29,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=968
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/06/2021 22:19, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally reading across neighboring array fields.
> 
> Add a wrapping struct to serve as the memcpy() source so the compiler
> can perform appropriate bounds checking, avoiding this future warning:
> 
> In function '__fortify_memcpy',
>     inlined from 'iucv_message_pending' at net/iucv/iucv.c:1663:4:
> ./include/linux/fortify-string.h:246:4: error: call to '__read_overflow2_field' declared with attribute error: detected read beyond size of field (2nd parameter)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good, thanks for taking care of that change.

Acked-by: Karsten Graul <kgraul@linux.ibm.com>

> ---
>  net/iucv/iucv.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 349c6ac3313f..e6795d5a546a 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -1635,14 +1635,16 @@ struct iucv_message_pending {
>  	u8  iptype;
>  	u32 ipmsgid;
>  	u32 iptrgcls;
> -	union {
> -		u32 iprmmsg1_u32;
> -		u8  iprmmsg1[4];
> -	} ln1msg1;
> -	union {
> -		u32 ipbfln1f;
> -		u8  iprmmsg2[4];
> -	} ln1msg2;
> +	struct {
> +		union {
> +			u32 iprmmsg1_u32;
> +			u8  iprmmsg1[4];
> +		} ln1msg1;
> +		union {
> +			u32 ipbfln1f;
> +			u8  iprmmsg2[4];
> +		} ln1msg2;
> +	} rmmsg;
>  	u32 res1[3];
>  	u32 ipbfln2f;
>  	u8  ippollfg;
> @@ -1660,10 +1662,10 @@ static void iucv_message_pending(struct iucv_irq_data *data)
>  		msg.id = imp->ipmsgid;
>  		msg.class = imp->iptrgcls;
>  		if (imp->ipflags1 & IUCV_IPRMDATA) {
> -			memcpy(msg.rmmsg, imp->ln1msg1.iprmmsg1, 8);
> +			memcpy(msg.rmmsg, &imp->rmmsg, 8);
>  			msg.length = 8;
>  		} else
> -			msg.length = imp->ln1msg2.ipbfln1f;
> +			msg.length = imp->rmmsg.ln1msg2.ipbfln1f;
>  		msg.reply_size = imp->ipbfln2f;
>  		path->handler->message_pending(path, &msg);
>  	}
> 

-- 
Karsten

(I'm a dude)
