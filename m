Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB45C433ED
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 06:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C0161026
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 06:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhDZGEh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:04:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhDZGEh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 02:04:37 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13Q63SIK137845;
        Mon, 26 Apr 2021 02:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HTTPuLIzS6tfb0w9Po25G9DkhvUT8UnrhUtjGtHQF/U=;
 b=hE3S7up/MeMv7iYVVnmtfWlBNmDYui4qrFzCGzsgKI1pGfVzQd7syb6Tu15IV9tXeL1q
 OmqNY0aUcMZL4TJIQzyUni/L21jwAiy8q/2igRwOoghvjLpfGQvz1swsI9LAchY842rM
 5EdSn/rk79AcTH7dOo+pEBEF6qRl6FHr2dWjVVsLy/3gxKthAoRm5fwvhrdpBqMa8eb5
 PUkulOKZUpeuFrCQnxgEV8Mfl++HD/DJY5C0wwiwyamDClGypmtiQKh5+98ffsQPQK2t
 vk2WEDGouwLNif/XWOm1kX/3Rg2oe6aeZqPh9EAQYOtJPDQZTTsZNZVZ1zv8UDiOqZ83 Ww== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385hwn6fn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 02:03:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13Q63qX1021634;
        Mon, 26 Apr 2021 06:03:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 384ay8gkff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 06:03:52 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13Q63PrR23724376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 06:03:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AB4DAE04D;
        Mon, 26 Apr 2021 06:03:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDCBDAE055;
        Mon, 26 Apr 2021 06:03:48 +0000 (GMT)
Received: from [9.145.191.176] (unknown [9.145.191.176])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 06:03:48 +0000 (GMT)
Subject: Re: [PATCH] s390/cio: Remove the invalid condition on IO_SCH_UNREG
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, oberpar@linux.ibm.com,
        christian.ehrhardt@canonical.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org
References: <20210423100843.2230969-1-vneethv@linux.ibm.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <b3d64246-2e61-1c08-1374-bea71c4dbbc2@linux.ibm.com>
Date:   Mon, 26 Apr 2021 09:03:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423100843.2230969-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0yjW2mjHiuYAHwE1TrNaULrkBkMrfdjh
X-Proofpoint-GUID: 0yjW2mjHiuYAHwE1TrNaULrkBkMrfdjh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_11:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260043
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.04.21 12:08, Vineeth Vijayan wrote:
> The condition to check the cdev pointer validity on
> css_sch_device_unregister() is a leftover from the 'commit c97cd8c81d4a
> ("s390/cio: Remove pm support from ccw bus driver")'. This could lead to a
> situation, where detaching the disk is not happening completely. Remove

s/disk/device

> this invalid condition in the IO_SCH_UNREG case.
> 
> Fixes: 8cc0dcfdc1c0 ("s390/cio: remove pm support from ccw bus driver")
> Reported-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> Suggested-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>

Thanks! This seems to fix the hot-unplug troubles with qeth devices.

Tested-by: Julian Wiedmann <jwi@linux.ibm.com>

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>  drivers/s390/cio/device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> index 3f026021e95e..84f659cafe76 100644
> --- a/drivers/s390/cio/device.c
> +++ b/drivers/s390/cio/device.c
> @@ -1532,8 +1532,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
>  	switch (action) {
>  	case IO_SCH_ORPH_UNREG:
>  	case IO_SCH_UNREG:
> -		if (!cdev)
> -			css_sch_device_unregister(sch);
> +		css_sch_device_unregister(sch);
>  		break;
>  	case IO_SCH_ORPH_ATTACH:
>  	case IO_SCH_UNREG_ATTACH:
> 

