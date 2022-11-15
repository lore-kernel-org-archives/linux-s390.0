Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E966C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 15 Nov 2022 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiKOJqj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Nov 2022 04:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiKOJqM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Nov 2022 04:46:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E21FF8E
        for <linux-s390@vger.kernel.org>; Tue, 15 Nov 2022 01:46:10 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF9Bl9a007524;
        Tue, 15 Nov 2022 09:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=tRTUQ2tqwK9GjSbiy/onksTNa+EXYk8z12+lFyngXws=;
 b=OclBLJxKBFL9cqhmXsYCXN2bZQgDNHdr7JUF8ZH9KoP3ZGa5ju+gYj3ti+ZE1EtvlSwB
 yws9Qm85e/z1p8cI9KiY0jo3/03VB1pYKHIijmijJABzIZ3z54kckgqJJiePaE/Saymc
 3ELDAHGypQasvQooW0WESamXGtEkbxy0tWIkWsCaHN1iKLOkQrLhljSpNVaMSFezW5Y6
 xa3kUneFWPlbcePrYQAcWoQJVPo3r0xMr780SRowefCHeOJSfAydjVg2mdbDpMdRhuwX
 80DnBmi2ZpfwC9w1sNgbyyvtTZqEz7L72ST4llHEGlNKBcZSK1/c79ixo9nWfDL2TKLu 0Q== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kv7x1h3e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 09:45:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AF9aUcP032187;
        Tue, 15 Nov 2022 09:45:58 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3kt349g8yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 09:45:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AF9ju4L4784862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 09:45:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885C958059;
        Tue, 15 Nov 2022 09:45:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA2A95805B;
        Tue, 15 Nov 2022 09:45:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 15 Nov 2022 09:45:55 +0000 (GMT)
MIME-Version: 1.0
Date:   Tue, 15 Nov 2022 10:45:55 +0100
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/ap: fix memory leak in ap_init_qci_info()
Reply-To: freude@linux.ibm.com
In-Reply-To: <20221114110830.542246-1-weiyongjun@huaweicloud.com>
References: <20221114110830.542246-1-weiyongjun@huaweicloud.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5a73bccdfd2a3210dba0495a77a9ec1e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nv5FomgZeK921d9K24h2tkc22gVYwEpX
X-Proofpoint-GUID: Nv5FomgZeK921d9K24h2tkc22gVYwEpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_04,2022-11-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150067
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2022-11-14 12:08, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> If kzalloc() for 'ap_qci_info_old' failed, 'ap_qci_info' shold be
> freed before return. Otherwise it is a memory leak.
> 
> Fixes: 283915850a44 ("s390/ap: notify drivers on config changed and
> scan complete callbacks")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/ap_bus.c 
> b/drivers/s390/crypto/ap_bus.c
> index 59ac98f2bd27..6cbc5e5d2a0e 100644
> --- a/drivers/s390/crypto/ap_bus.c
> +++ b/drivers/s390/crypto/ap_bus.c
> @@ -233,8 +233,10 @@ static void __init ap_init_qci_info(void)
>  	if (!ap_qci_info)
>  		return;
>  	ap_qci_info_old = kzalloc(sizeof(*ap_qci_info_old), GFP_KERNEL);
> -	if (!ap_qci_info_old)
> +	if (!ap_qci_info_old) {
> +		kfree(ap_qci_info);
>  		return;
> +	}
>  	if (ap_fetch_qci_info(ap_qci_info) != 0) {
>  		kfree(ap_qci_info);
>  		kfree(ap_qci_info_old);
Thanks, I picked this and pushed it into the s390 subsystem repo.
Will be visible in the Linus' tree with the next merge window.
