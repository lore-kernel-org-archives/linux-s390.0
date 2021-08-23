Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B53EC4338F
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D2861361
	for <linux-s390@archiver.kernel.org>; Mon, 23 Aug 2021 17:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhHWR4f (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:56:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhHWR4f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Aug 2021 13:56:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17NHYFgw081407;
        Mon, 23 Aug 2021 13:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=E/U3GT4zEaId1u3JdWM2oKes3fR5OGvb/5Xh7FFBPlo=;
 b=MYyB/XZwQCsntkxrlTtpHO8NDoBBVN3gV02DeuxutCRDDHitPFdEYwZ/fsuRX1kyg+zC
 9wS14kThfdm/F1ieElClIY33CGeOjh7WR24I8qXvHFRxbFkXKV/kPb+kwbXfsJd6vZG9
 B3HsXEeb+/+JoiEjFgNbP+4pfyNfUbwy11QZzBtthpZzlesleHgC9wde7tOh3lOJ0GAc
 jv53Yyuqda7Po7sD2saNSreHzJMti04VOCAuAzp7t03seaxTB5wXdyAORhcFRppZkUkW
 W4e+CP4IqWhvTbqzU8jKMOyGx7G2Lc8cOLe8qVojHIRn2llUybulc8W4pAGDSNa4DQMr aA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3am1evgn69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 13:55:45 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17NHqmWu002746;
        Mon, 23 Aug 2021 17:55:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3ajs48b5ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Aug 2021 17:55:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17NHpwX959244950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 17:51:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F316A4040;
        Mon, 23 Aug 2021 17:55:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF932A4055;
        Mon, 23 Aug 2021 17:55:39 +0000 (GMT)
Received: from osiris (unknown [9.145.169.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Aug 2021 17:55:39 +0000 (GMT)
Date:   Mon, 23 Aug 2021 19:55:38 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/crypto: fix all kernel-doc warnings in vfio_ap_ops.c
Message-ID: <YSPhGvHfWILRqyCp@osiris>
References: <20210806050149.9614-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806050149.9614-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 19eRmgZpR8SJUOZ6etOVEVlTu2Kk1usg
X-Proofpoint-ORIG-GUID: 19eRmgZpR8SJUOZ6etOVEVlTu2Kk1usg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-23_04:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 05, 2021 at 10:01:49PM -0700, Randy Dunlap wrote:
> The 0day bot reported some kernel-doc warnings in this file so clean up
> all of the kernel-doc and use proper kernel-doc formatting.
> There are no more kernel-doc errors or warnings reported in this file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Jason Herne <jjherne@linux.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/crypto/vfio_ap_ops.c |  116 ++++++++++++----------------
>  1 file changed, 52 insertions(+), 64 deletions(-)

Applied, thanks.
