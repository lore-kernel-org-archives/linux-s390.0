Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A662C48BE5
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE58A6113E
	for <linux-s390@archiver.kernel.org>; Thu, 17 Jun 2021 12:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFQMmY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Jun 2021 08:42:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230523AbhFQMmX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Jun 2021 08:42:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HCXU9n093017;
        Thu, 17 Jun 2021 08:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iYgJhMOAFlkqFNIuTA32LQCOLbZbDmFpPb8yb4A8FTU=;
 b=V0KdfimsjFYFxXmu6YFgZnuEQ+2SGq8sXWfglkv99uXsAaOTI6PLxOMozDCxIydMAyYs
 6MAXEgHH5KN7lU2XwjxdMmhbRQyjGz5RFxqaEcMADqDuIgSTJhEMVsO+97nxPh0vxClV
 nI0J/j442DmUxop/j03rnH7vWHJ9l5Y84CrZVIQndjddPIfDTBIZ71zq8MUS6q3iMK6V
 j0eV8m6QfakB9VRzMUWS3LXyZsmEDfvgU7zagiEqXnTHEG4Dp99Ap5N+2aTLUBGLDwN5
 NbzCGMabUR/rpblkDylhpcTtEhVLPifHlFTG26ETRj8LiMRZCj7rlkmPsYS7/EVRf1dE Cw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3985y19d5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 08:40:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15HCWctb032170;
        Thu, 17 Jun 2021 12:40:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8tq7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 12:40:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15HCcwYT34865660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 12:38:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE8242057;
        Thu, 17 Jun 2021 12:40:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F1814204D;
        Thu, 17 Jun 2021 12:40:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.2.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Jun 2021 12:40:07 +0000 (GMT)
Subject: Re: [PATCH] dasd: unexport dasd_set_target_state
To:     Christoph Hellwig <hch@lst.de>, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
References: <20210614060440.3965603-1-hch@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
Message-ID: <4e202558-05b4-9c63-f08e-a5762b93c9ce@linux.ibm.com>
Date:   Thu, 17 Jun 2021 14:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614060440.3965603-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gg9x-Wc-V1Bib5E9dIQp8vyjSqrrINHp
X-Proofpoint-GUID: Gg9x-Wc-V1Bib5E9dIQp8vyjSqrrINHp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_10:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am 14.06.21 um 08:04 schrieb Christoph Hellwig:
> dasd_set_target_state is only used inside of dasd_mod.ko, so don't
> export it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Acked-by: Stefan Haberland <sth@linux.ibm.com>

Thanks,
Stefan

