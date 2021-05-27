Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B92C4707F
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B687B61005
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE0PGz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 May 2021 11:06:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235147AbhE0PGz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 May 2021 11:06:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RF3m0n125569;
        Thu, 27 May 2021 11:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : cc : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SrrbpRuTxYqVvaaA1Fgdcb2Cb+Y/HTfWm9/sNF8OXBg=;
 b=e4nID4nJo+CIWFSvpwPJ5+zUZteNtMG8hO+oNVWpx0mYlF8j4SS/DufNKS2Tj4I5xJIx
 7NS75+IbblypZVp2WfbOQIJy/tjp/lSHWkyMmZW9K1kbvjzlbyxCCYoKayLh2Tq6Z66J
 M1EUFGoGYxDBEKuApgzzwjxfPyo4nYKDQP7NXK1F/yVTWNALlZJUlIKecuyk3SNR2/OH
 Xkb+KTVHxxdDohq3aAK5tEnAvvhq9bP9RI6YucE5g054/RTxwAn+ex/n/PrHxIbRRKxi
 4gjH6AiNyazcw7bWGBeycylwZgjBoPXj0A52Q2imCCBC4VIFmQLk7zFPOm5LbFQwlgRD BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38tc4r3qgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 11:05:20 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14RF4mNl132626;
        Thu, 27 May 2021 11:05:20 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38tc4r3qfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 11:05:20 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14RF1uOU003417;
        Thu, 27 May 2021 15:05:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38s1ukh8r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 15:05:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14RF4jEn34079130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:04:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00186A405F;
        Thu, 27 May 2021 15:05:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF1D4A405B;
        Thu, 27 May 2021 15:05:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.160.76])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 May 2021 15:05:14 +0000 (GMT)
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210525125006.157531-1-sth@linux.ibm.com>
 <20210525125006.157531-2-sth@linux.ibm.com>
 <20210525162118.0f4e5b84.cohuck@redhat.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: add missing discipline function
Message-ID: <eef5a3e4-ea98-d766-fe72-e5275792f8a0@linux.ibm.com>
Date:   Thu, 27 May 2021 17:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525162118.0f4e5b84.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gORufMxW4-hcHo6J5oOFFNrC2Ex_GO5b
X-Proofpoint-GUID: uTYRneY25sotSs7G_WX5J8V7SkxIV3IX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_07:2021-05-27,2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


> [Just to satisfy my curiosity: are there still any FBA devices around,
> other than z/VM emulating a DASD frontend for FCP devices?]
>

Currently no, only emulated ones. So there are likely no "real" path
events for the virtual devices and the bug would not be triggered in the
wild.
But one could accidentally trigger it by explicitly doing a "chchp -v 1"
on the virtual path.



