Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009BC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B6561002
	for <linux-s390@archiver.kernel.org>; Mon, 18 Oct 2021 10:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJRKoj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:44:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9620 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231156AbhJRKog (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Oct 2021 06:44:36 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I8Gl99022664;
        Mon, 18 Oct 2021 06:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PrssSw8/E4DBlFjrjDZTjl3wj9emXrUBewYnwq5hZtY=;
 b=i0gJ6/gd3HLhUKc1iOR1NKUQUXlr/tVhcaR09bNTaha0UrcZExUZ2lo3hn7rUWK8dayJ
 mRl0Pa9CMVMyLBuLj5/z5h9Hk0iYiohzdEoNa+Hr6LMJJx0/CgpDSDwmplOZYpylokBH
 uUEjiWPhD96xp0MVvAVg0ZB/ot8suuKcGZbnUFM8iBJjYJIm4okJU+jN9cPsIO+nyQLQ
 bUukE9MQVNl/aqAIKjspjECuKUz3kQfi+t5eAy3WwV9Nv8PW7TVJBwxe4Z0PuqO2sylT
 58f2jGVt9k9aBTDQRh35p+NufjygaP4CN7RyamYd/lERQwVo8peVaih9fraXOc7Qi3fZ ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs59b2v5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 06:42:17 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19IA1fX9038956;
        Mon, 18 Oct 2021 06:42:17 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bs59b2v51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 06:42:17 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19IAXJQv014186;
        Mon, 18 Oct 2021 10:42:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bqpc93x2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 10:42:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19IAaO2256557872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 10:36:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2882D42061;
        Mon, 18 Oct 2021 10:42:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFFFF42057;
        Mon, 18 Oct 2021 10:42:12 +0000 (GMT)
Received: from osiris (unknown [9.145.168.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Oct 2021 10:42:12 +0000 (GMT)
Date:   Mon, 18 Oct 2021 12:42:11 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Huilong Deng <denghuilong@cdjrlc.com>
Cc:     borntraeger@de.ibm.com, yury.norov@gmail.com, geert@linux-m68k.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/bitops: Return true/false (not 1/0) from bool
 functions
Message-ID: <YW1PgzE2w/8Qg5Eb@osiris>
References: <20211017092057.24179-1-denghuilong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017092057.24179-1-denghuilong@cdjrlc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ScNiDq2ZyLiHcgEJ_g-6h6J6hrWMRzBV
X-Proofpoint-GUID: tZ5B0pz88oACRe6yNvDpdyybKS8E_mzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_02,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 mlxlogscore=-1000
 mlxscore=100 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=100 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110180065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Oct 17, 2021 at 05:20:57PM +0800, Huilong Deng wrote:
> Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
> ---
>  arch/s390/include/asm/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
