Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9414DC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 19:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiCPTCm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 15:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356983AbiCPTCm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 15:02:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CC26E4D2
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 12:01:27 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GIhcXA013047;
        Wed, 16 Mar 2022 19:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jhdO4SfBUO/WxBeowfzG5hfDWEnRGw4o/DxcGGUtckg=;
 b=sShL1x2gastXEvL0NPCNjZkfECbwzDLDHIp3c9d8uqp1I4WZ5Fq9K9fmyf2lnnjTfbzM
 4faZr6sVDL36KBFRcTQZM/xiNNWDfFb0g2eLpcTerxzOFCmcibyvJvrc4af5PlOt2QJN
 j/80SmIXxUHdFfmVBN66ctEer0XFmuUnh9vS8ha5cQvz1GWBLm9svR+JeNu2BnSo9ze2
 4Eg4SBmXIsnCGuaRWj7owI++OKN1UuROZ4v2tigQnfs+wCZGuLMymXk5gpf+3lLZnrNW
 Ry11E5IeCvvIW+1lLOuIZ1O76/V9NewQKI2eLO9DRwDsedKL7Cg8rxBb/NSIO3HzqaAU 5w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eune5rayp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 19:01:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22GIxY7P003946;
        Wed, 16 Mar 2022 19:01:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3et95ww01r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 19:01:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22GJ178l53346800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 19:01:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A3C65204E;
        Wed, 16 Mar 2022 19:01:07 +0000 (GMT)
Received: from osiris (unknown [9.145.69.99])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 581F752051;
        Wed, 16 Mar 2022 19:01:07 +0000 (GMT)
Date:   Wed, 16 Mar 2022 20:01:05 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Russell Currey <ruscur@russell.cc>
Cc:     linux-s390@vger.kernel.org, svens@linux.ibm.com
Subject: Re: [PATCH] s390: Fix typo in syscall_wrapper.h
Message-ID: <YjIz8ViNjEnbwdxg@osiris>
References: <20220304090109.29386-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304090109.29386-1-ruscur@russell.cc>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NphSfWkFX4Zyt13JyMe4Bd8oOgawuQrM
X-Proofpoint-ORIG-GUID: NphSfWkFX4Zyt13JyMe4Bd8oOgawuQrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_09,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=729 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Mar 04, 2022 at 07:01:09PM +1000, Russell Currey wrote:
> Looks like this endif comment was erroneously unchanged when copied over
> from the x86 version.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/s390/include/asm/syscall_wrapper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
